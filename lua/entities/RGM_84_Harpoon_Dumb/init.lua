 
AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
							        --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--

 local ImpactSounds = {}
ImpactSounds[1]                      =  "chappi/imp0.wav"
ImpactSounds[2]                      =  "chappi/imp1.wav"
ImpactSounds[3]                      =  "chappi/imp2.wav"
ImpactSounds[4]                      =  "chappi/imp3.wav"
ImpactSounds[5]                      =  "chappi/imp4.wav"
ImpactSounds[6]                      =  "chappi/imp5.wav"
ImpactSounds[7]                      =  "chappi/imp6.wav"
ImpactSounds[8]                      =  "chappi/imp7.wav"
ImpactSounds[9]                      =  "chappi/imp8.wav"
ImpactSounds[10]                     =  "chappi/imp9.wav"

local damagesound                    =  "weapons/rpg/shotdown.wav"

function ENT:Initialize()
 if (SERVER) then
	self:SetModel( "models/GMissiles/rgm-84_harpoon.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(MOVETYPE_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:SetMass(self.Mass)
		phys:Wake()
	end
	
		self:SetTrigger(true)
		
	 self.Touched = false
	 self.Removed = false
	 self.Armed    = false
	 self.Exploded = false
	 self.Fired    = false
	 self.Burnt    = false
	 self.Ignition = false
	 self.Arming   = false
	 self.Power    = 0.5
	 
	MissileTailFin=ents.Create("prop_physics")
	MissileTailFin:SetModel("models/props_junk/cardboard_box001a.mdl")
	MissileTailFin:SetPos(self:GetPos()-self:GetForward()*15)
	MissileTailFin.HasTailFin=true
	MissileTailFin:Spawn()
	MissileTailFin:Activate()
	MissileTailFin:GetPhysicsObject():SetMass(2)
	MissileTailFin:SetNotSolid(true)
	MissileTailFin:SetNoDraw(true)
	self:DeleteOnRemove(MissileTailFin)
	constraint.Weld(self.Entity,MissileTailFin,0,0,0,true)
	
	 if not (WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Arm", "Detonate", "Launch" }) end -- wiremod Inputs
	 end
end

function ENT:TriggerInput(iname, value)
     if (not self:IsValid()) then return end
	 if (iname == "Detonate") then				--Detonate when detonate option selected via wiremod
         if (value >= 1) then
		     if (not self.Exploded and self.Armed) then
			     timer.Simple(math.Rand(0,self.MaxDelay),function()
				     if not self:IsValid() then return end
	                 self.Exploded = true
					 
			         self:Explode()
				 end)
		     end
		 end
	 end
	 if (iname == "Arm") then				--Arm when Arm option selected via wiremod
         if (value >= 1) then
             if (not self.Exploded and not self.Armed and not self.Arming) then
			     self:EmitSound(self.ActivationSound)
                 self:Arm()
             end 
         end
     end		 
	 if (iname == "Launch") then 			--Launch when Launch option selected via wiremod
	     if (value >= 1) then
		     if (not self.Exploded and not self.Burnt and not self.Ignition and not self.Fired) then
			     self:Launch()
		     end
	     end
     end
end          

function ENT:OnTakeDamage(dmginfo) ---ARM When hitting something
     if not self:IsValid() then return end
     if self.Exploded then return end
	 if (self.Life <= 0) then return end
	 self:TakePhysicsDamage(dmginfo)
     if(GetConVar("GMissiles_fragility"):GetInt() >= 1) then  
	     if(not self.Fired and not self.Burnt and not self.Arming and not self.Armed) then
	         if(math.random(0,9) == 1) then
		         self:Launch()
		     else
			     self:Arm()
			 end
	     end
	 end
	 if(self.Fired and not self.Burnt and self.Armed) then
	     if (dmginfo:GetDamage() >= 2) then
		     local phys = self:GetPhysicsObject()
		     self:EmitSound(damagesound)
	         phys:AddAngleVelocity(dmginfo:GetDamageForce()*0.1)
	     end
	 end
	 if(not self.Armed) then return end
	 self.Life = self.Life - dmginfo:GetDamage()
     if (self.Life <= 0) then 
		 timer.Simple(math.Rand(0,self.MaxDelay),function()
	         if not self:IsValid() then return end 
			 self.Exploded = true
			 self:Explode()
			
	     end)
	 end
end



function ENT:Explode() -- THE EXPLOSION FUNCTION
	 if self.Exploded ==true then self:EmitSound(self.ExplosionSound, 511, 100, 1, CHAN_WEAPON)end
     if not self.Exploded then return end
	 local pos = self:LocalToWorld(self:OBBCenter())
	 
	  	 local ent = ents.Create("shockwave")  --Create an ent that causes explosion damage and phys data at the location missile hit
	 ent:SetPos( pos ) 
	 ent:Spawn()
	 ent:Activate()
	 ent:SetVar("DEFAULT_PHYSFORCE", self.DEFAULT_PHYSFORCE)
	 ent:SetVar("DEFAULT_PHYSFORCE_PLYAIR", self.DEFAULT_PHYSFORCE_PLYAIR)
	 ent:SetVar("DEFAULT_PHYSFORCE_PLYGROUND", self.DEFAULT_PHYSFORCE_PLYGROUND)
	 ent:SetVar("GMISSILE", self.GMISSILE)
	 ent:SetVar("MAX_RANGE",self.ExplosionRadius)
	 ent:SetVar("SHOCKWAVE_INCREMENT",100)
	 ent:SetVar("DELAY",0.01)
	 ent.trace=self.TraceLength
	 ent.decal=self.Decal
	 
	 for k, v in pairs(ents.FindInSphere(pos,self.SpecialRadius)) do --If shit is within range then THROW SHIT EVERYWHERE!!
	     if v:IsValid() then
		     local phys = v:GetPhysicsObject()
			 local i = 0
		     while i < v:GetPhysicsObjectCount() do
			 phys = v:GetPhysicsObjectNum(i)	  
             if (phys:IsValid()) then		
		 	     local mass = phys:GetMass()
				 local F_ang = self.PhysForce
				 local dist = (pos - v:GetPos()):Length()
				 local relation = math.Clamp((self.SpecialRadius - dist) / self.SpecialRadius, 0, 1)
				 local F_dir = (v:GetPos() - pos):GetNormal() * self.PhysForce
				   
				 phys:AddAngleVelocity(Vector(F_ang, F_ang, F_ang) * relation)
				 phys:AddVelocity(F_dir)
		     end
			 i = i + 1
			 end
		 end
	 end
	 
     if(self:WaterLevel() >= 1) then -- Just changing the explosion effect if missile is under water, Complicated as fuck for something so simple....
		 local trdata   = {}
		 local trlength = Vector(0,0,9000)

		 trdata.start   = pos
		 trdata.endpos  = trdata.start + trlength
		 trdata.filter  = self
		 local tr = util.TraceLine(trdata) 

		 local trdat2   = {}
		 trdat2.start   = tr.HitPos
		 trdat2.endpos  = trdata.start - trlength
		 trdat2.filter  = self
		 trdat2.mask    = MASK_WATER + CONTENTS_TRANSLUCENT
			 
		 local tr2 = util.TraceLine(trdat2)
			 
	     if tr2.Hit then
		     ParticleEffect(self.EffectWater, tr2.HitPos, Angle(0,0,0), nil)   
		 end
     else
		 local tracedata    = {}
	     tracedata.start    = pos
		 tracedata.endpos   = tracedata.start - Vector(0, 0, self.TraceLength)
		 tracedata.filter   = self.Entity
				
		 local trace = util.TraceLine(tracedata)
	     
		 if trace.HitWorld then
		     ParticleEffect(self.Effect,pos,Angle(0,0,0),nil)
		 else 
			 ParticleEffect(self.EffectAir,pos,Angle(0,0,0),nil) 
		 end
     end
	 if self.IsNBC then
	     local nbc = ents.Create(self.NBCEntity)
		 nbc:SetVar("GMISSILE",self.GMISSILE)
		 nbc:SetPos(self:GetPos())
		 nbc:Spawn()
		 nbc:Activate()
	 end
	 self:Remove()
end

function ENT:PhysicsCollide( data, physobj )-- WERE HIT, ARM OR EXPLODE
     if(self.Exploded) then return end
     if(not self:IsValid()) then return end
	 if(self.Life <= 0) then return end
	 
	 if(GetConVar("GMissiles_fragility"):GetInt() >= 1) then
	     if(not self.Fired and not self.Burnt and not self.Arming and not self.Armed ) and (data.Speed > self.ImpactSpeed * 5) then --and not self.Arming and not self.Armed
		     if(math.random(0,9) == 1) then
			     self:Launch()
		         self:EmitSound(damagesound)
			 else
			     self:Arm()
				 self:EmitSound(damagesound)
			 end
	     end
	 end

	 if(not self.Armed) then return end
		
	 if (data.Speed > self.ImpactSpeed )then
		 self.Exploded = true
		 self:Explode()
	 end
	 
end

function ENT:Use( activator, caller )-- When I press E on the missile, Activate, and launch
   if(self.Exploded) then return end
	 if(self.Dumb) then return end
	 if(GetConVar("GMissiles_easyuse"):GetInt() >= 1) then
         if(self:IsValid()) then
             if (not self.Exploded) and (not self.Burnt) and (not self.Fired) then
	             if (activator:IsPlayer()) then
                     self:EmitSound(self.ActivationSound)
                     self:Launch()
					 
		         end
	         end
         end
	 end
end
 
 function ENT:Launch()-- The function says what to do when missile is launched and adds a fancy particle effect
     if(self.Exploded) then return end
	 if(self.Burned) then return end
	 --if(self.Armed) then return end
	 if(self.Fired) then return end
	 
	 local phys = self:GetPhysicsObject()
	 if not phys:IsValid() then return end
	 
	 self.Fired = true
	 if(self.SmartLaunch) then
		 constraint.RemoveAll(self)
	 end
	 timer.Simple(0.05,function()
	     if not self:IsValid() then return end
	     if(phys:IsValid()) then
             phys:Wake()
		     phys:EnableMotion(true)
	     end
	 end)
	 
	 timer.Simple(self.IgnitionDelay,function()-- Make a short ignition delay
	     if not self:IsValid() then return end  
		 local phys = self:GetPhysicsObject()
		 self.Ignition = true
		 self:Arm()
		 
		 local pos = self:GetPos()
		 self:EmitSound(self.StartSound, 511, 100, 1, CHAN_STATIC)
	     self:EmitSound(self.EngineSound)
		 self:SetNetworkedBool("EmitLight",true)
		 self:SetNetworkedBool("self.Ignition",true)
		 ParticleEffectAttach(self.RocketTrail,PATTACH_ABSORIGIN_FOLLOW,self,1)-- Main burn Particle effect
		 if(self.FuelBurnoutTime ~= 0) then 
	         timer.Simple(self.FuelBurnoutTime,function()
		         if not self:IsValid() then return end 
		         self.Burnt = true
		         self:StopParticles()
		         self:StopSound(self.EngineSound)
	           ParticleEffectAttach(self.RocketBurnoutTrail,PATTACH_ABSORIGIN_FOLLOW,self,1) --when out of fuel particle effect
			   self:SetMoveType(MOVETYPE_VPHYSICS) 
             end)	 
		 end
     end)		 
end

function ENT:Think()
    if(self.Burnt) then return end
     if(not self.Ignition) then return end -- if there wasn't ignition, we won't fly
	 if(self.Exploded) then return end -- if we exploded then what the fuck are we doing here
	 if (self.Removed) then return end-- if we were Removed then gtfo of think
	 if(not self:IsValid()) then return end -- if we aren't good then something fucked up
	 if self.Power <= 1.5 then
		self.Power = self.Power + 0.001
	 elseif self.Power >=1.5 then
		self.Power = 1.5
	 end
	 local phys = self:GetPhysicsObject()  
	 local thrustpos = self:GetPos()
	 if(self.ForceOrientation == "RIGHT") then
	     phys:AddVelocity(self:GetRight() * self.EnginePower) -- If we chose RIGHT in shared file then missile has thrust to the right...
	 elseif(self.ForceOrientation == "LEFT") then
	     phys:AddVelocity(self:GetRight() * -self.EnginePower) -- Same as above but left...
	 elseif(self.ForceOrientation == "UP") then
	     phys:AddVelocity(self:GetUp() * self.EnginePower) -- Same as above but... you get the point
	elseif(self.ForceOrientation == "DOWN") then 
	     phys:AddVelocity(self:GetUp() * -self.EnginePower) 
	 elseif(self.ForceOrientation == "INV") then
	     phys:AddVelocity(self:GetForward() * -self.EnginePower) 
	 else
		 phys:AddVelocity(self:GetForward() * (self.EnginePower*self.Power)) 
	 end
	 if (self.Armed) then
        phys:AddAngleVelocity(Vector(0,0,0)) -- Rotational force, we dont use this
	 end
	 
	 self:NextThink(CurTime() + 0.01)-- loop the think code
	 
	 return true
end

function ENT:Arm()--- function that says what arming the missile does
     if(not self:IsValid()) then return end
	 if(self.Armed) then return end
	 self.Arming = true
	 
	 timer.Simple(self.ArmDelay, function()
	     if not self:IsValid() then return end 
	     self.Armed = true
		 self.Arming = false
		 self:EmitSound(self.ArmSound)
		 if(self.Timed) then
	         timer.Simple(self.Timer, function()
	             if not self:IsValid() then return end 
			     self.Exploded = true
			     self:Explode()
				 self.EmitLight = true
	         end)
		 end
	 end)
end	 



function ENT:OnRemove() -- when removed do the shit inside me
     self:StopSound(self.EngineSound)
	 self:StopParticles()
	 self.Removed = true
end

function ENT:OnRestore()--MAKE DUPES WORK!!
     Wire_Restored(self.Entity)
end

function ENT:BuildDupeInfo()-- MAKE DUPES WORK!!
     return WireLib.BuildDupeInfo(self.Entity)
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)-- MAKE DUPES WORK!!
     WireLib.ApplyDupeInfo( ply, ent, info, GetEntByID )
end

function ENT:PrentityCopy()-- MAKE DUPES WORK!!
     local DupeInfo = self:BuildDupeInfo()
     if(DupeInfo) then
         duplicator.StorentityModifier(self.Entity,"WireDupeInfo",DupeInfo)
     end
end

function ENT:PostEntityPaste(Player,Ent,CreatedEntities)-- MAKE DUPES WORK!!
     if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
         Ent:ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
     end
end

 function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 self.GBOWNER = ply
     local ent = ents.Create( self.ClassName )
	 ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 0.01 ) -- Changing the right most number makes the entity spawn further up or down...
     ent:Spawn()
	 ent:SetAngles(Angle(-90,90,0))
     ent:Activate()
	 
     return ent
	 
end