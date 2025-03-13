AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

if SERVER then
	function ENT:Initialize()  
		 self.FILTER = {}
		 self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
		 self:SetSolid( SOLID_NONE )
		 self:SetMoveType( MOVETYPE_NONE )
		 self:SetUseType( ONOFF_USE ) 
		 self.Bursts = 0
		 self.CURRENTRANGE = 0
		 self.GMISSILE = self:GetVar("GMISSILE")
		 self.SOUND = self:GetVar("SOUND")
		 self.MAX_RANGE = self:GetVar("MAX_RANGE")
		 self.DEFAULT_PHYSFORCE  = self:GetVar("DEFAULT_PHYSFORCE")
		 self.DEFAULT_PHYSFORCE_PLYAIR  = self:GetVar("DEFAULT_PHYSFORCE_PLYAIR")
		 self.DEFAULT_PHYSFORCE_PLYGROUND = self:GetVar("DEFAULT_PHYSFORCE_PLYGROUND")
		 self.SHOCKWAVEDAMAGE = self:GetVar("SHOCKWAVE_DAMAGE")
		 self.ExplosionDamage = self:GetVar("EXPLOSION_DMG")
		 self.allowtrace=true
	end
end
function ENT:Trace()
	if SERVER then
		if not self:IsValid() then return end
		if(GetConVar("Gmissiles_decals"):GetInt() >= 1) then
			local pos = self:GetPos()
			local tracedata    = {}
			tracedata.start    = pos
			tracedata.endpos   = tracedata.start - Vector(0, 0, self.trace)
			tracedata.filter   = self.Entity
			local trace = util.TraceLine(tracedata)
			if self.decal==nil then 
				self.decal="scorch_medium"
			end

			util.Decal( self.decal, tracedata.start, tracedata.endpos )
		end
	end
end
function ENT:Think()		
     if (SERVER) then
     if not self:IsValid() then return end
	 local pos = self:GetPos()
	 self.CURRENTRANGE = self.CURRENTRANGE+(self.SHOCKWAVE_INCREMENT*10)
	 if self.allowtrace then
		self:Trace()
		self.allowtrace=false
	 end
	 for k, v in pairs(ents.FindInSphere(pos,self.MAX_RANGE)) do
		 if (v:IsValid() or v:IsPlayer()) then
		 	if v:IsNextBot() then
				v:TakeDamage(1500)
			end
			 local i = 0
			 while i < v:GetPhysicsObjectCount() do
				 local dmg = DamageInfo()
				-- local Vdmg = DamageInfo()
				 dmg:SetDamage(math.random(50,100))
				 dmg:SetDamageType(DMG_BLAST)
				-- Vdmg:SetDamage(math.random(500,1000))
				-- Vdmg:SetDamageType(DMG_VEHICLE)
				 if self.GMISSILE == nil then
					self.GMISSILE = table.Random(player.GetAll())
				 end
				 if not self.GMISSILE:IsValid() then
					self.GMISSILE = table.Random(player.GetAll())
				 end
				 dmg:SetAttacker(self.GMISSILE)
				 phys = v:GetPhysicsObjectNum(i)
				 if (phys:IsValid()) then
					 local mass = phys:GetMass()
					 local F_ang = self.DEFAULT_PHYSFORCE
					 local dist = (pos - v:GetPos()):Length()
			
					 local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
					 local F_dir = (v:GetPos() - pos):GetNormal() * self.DEFAULT_PHYSFORCE 
					 phys:AddAngleVelocity(Vector(F_ang, F_ang, F_ang) * relation)
					 phys:AddVelocity(F_dir)
					 if(GetConVar("GMissiles_shockwave_unfreeze"):GetInt() >= 1) then
						-- if not v:GetClass()=="IR_Target" then
						 	phys:Wake()
						    phys:EnableMotion(true)
							constraint.RemoveAll(v)
						-- end
					 end
					 if (v:GetClass()=="func_breakable" or class=="func_breakable_surf" or class=="func_physbox") then
						v:Fire("Break", 0)
					 end
				 end
				 if (v:IsPlayer()) then
					
					 v:SetMoveType( MOVETYPE_WALK )
				     v:TakeDamageInfo(dmg)
					 local mass = phys:GetMass()
					 local F_ang = self.DEFAULT_PHYSFORCE_PLYAIR
					 local dist = (pos - v:GetPos()):Length()
					 local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
					 local F_dir = (v:GetPos() - pos):GetNormal() * self.DEFAULT_PHYSFORCE_PLYAIR
					 v:SetVelocity( F_dir )		
				 end

				 if (v:IsPlayer()) and v:IsOnGround() then
					 v:SetMoveType( MOVETYPE_WALK )
				     v:TakeDamageInfo(dmg)
					 local mass = phys:GetMass()
					 local F_ang = self.DEFAULT_PHYSFORCE_PLYGROUND
					 local dist = (pos - v:GetPos()):Length()
					 local relation = math.Clamp((self.CURRENTRANGE - dist) / self.CURRENTRANGE, 0, 1)
					 local F_dir = (v:GetPos() - pos):GetNormal() * self.DEFAULT_PHYSFORCE_PLYGROUND	 
					 v:SetVelocity( F_dir )		
				 end
				 if (v:IsNPC()) then
					 v:TakeDamageInfo(dmg)
				 end

				 if  v:IsVehicle() or v.isWacAircraft or v:IsSolid() and not v:IsNPC() and not v:IsPlayer() then
					-- v:TakeDamageInfo(Vdmg)
					 v:TakeDamage(500)
				 end
			 i = i + 1
			 end
		 end
 	 end
	 self.Bursts = self.Bursts + 1
	 if (self.CURRENTRANGE >= self.MAX_RANGE) then
	     self:Remove()
	 end
	 self:NextThink(CurTime() + (self.DELAY*10))
	 return true
	 end
end

