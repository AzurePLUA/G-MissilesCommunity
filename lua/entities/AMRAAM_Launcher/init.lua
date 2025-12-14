 
AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
							        --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--


function ENT:Initialize()
 if (SERVER) then
	self:SetModel( "models/props_phx/box_amraam.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(MOVETYPE_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
		self:SetTrigger(true)
		self.Reloaded = false
	 
	 if not (WireAddon == nil) then self.Inputs = Wire_CreateInputs(self, { "Fire Dumb","Fire Guided"}) end -- wiremod Inputs
	 end
end

function ENT:TriggerInput(iname, value)-- Tells launcher to spawn missile and launch it
     if (not self:IsValid()) then return end
	 if (iname == "Fire Dumb") then				
         if (value >= 1) then
				if not (self.Reloaded)  then
				self:Reload()
				end
             end 
         end

				if (iname == "Fire Guided") then				
					if (value >= 1) then
						if not (self.Reloaded)  then
						self:ReloadGuided()
						end
					end 
				end			 
end
        
function ENT:Use( activator, caller )-- When I press E on the launcher, Activate, and launch
         if(self:IsValid()) then
	             if (activator:IsPlayer()) then
                     if not (self.Reloaded)  then
                     self:Reload()
					 end
		         end
	         end
end

function ENT:Reload()--Simple missile launcher function
		
			Amraam = ents.Create( "AIM_120D_AMRAAM_Dumb" )-- Create missile
			-- Prevent freezing on spawn for this missile
			Amraam.ShouldFreezeOnSpawn = function() return false end
			Amraam:SetPos( self:GetPos() )
			Amraam:SetAngles(Angle(self:GetAngles()))
			Amraam:Spawn()
			Amraam:Launch()
			local phys = Amraam:GetPhysicsObject()
			phys:SetVelocity(Amraam:GetForward()*900  )
			self:EmitSound( "GMissiles/Launch/LaunchPuff.wav",75,100,1,CHAN_AUTO )
			
			--Amraam:SetParent(self, 1)---Fucks up physics
			self.Reloaded = true
			
			timer.Simple( 3, function()---Delay between rounds
				self.Reloaded = false
			end)
			
end

function ENT:ReloadGuided()
			AmraamG = ents.Create( "AIM_120D_AMRAAM_Guided" )-- Create missile
			-- Prevent freezing on spawn for this missile
			AmraamG.ShouldFreezeOnSpawn = function() return false end
			AmraamG:SetPos( self:GetPos() )
			AmraamG:SetAngles(Angle(self:GetAngles()))
			AmraamG:Spawn()
			AmraamG:Launch()
			local phys = AmraamG:GetPhysicsObject()
			phys:SetVelocity(AmraamG:GetForward()*900  )
			self:EmitSound( "GMissiles/Launch/LaunchPuff.wav",75,100,1,CHAN_AUTO )
			
			--Amraam:SetParent(self, 1)---Fucks up physics
			self.Reloaded = true
			
			timer.Simple( 3, function()---Delay between rounds
				self.Reloaded = false
			end)
end

function ENT:Fire()--Fires the missile--- NOT USED CURRENTLY
--Amraam:Launch()
--Amraam:SetParent(nil, 2)
end

function ENT:OnRemove()--Removes spawned missiles
	if self.Reloaded == true then
		if (not Amraam:IsValid()) then return end
		Amraam:Remove()
	end
end

function ENT:OnRestore()
     Wire_Restored(self.Entity)
end

function ENT:BuildDupeInfo()
     return WireLib.BuildDupeInfo(self.Entity)
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
     WireLib.ApplyDupeInfo( ply, ent, info, GetEntByID )
end

function ENT:PreEntityCopy()
     local DupeInfo = self:BuildDupeInfo()
     if(DupeInfo) then
         duplicator.StoreEntityModifier(self,"WireDupeInfo",DupeInfo)
     end
end

function ENT:PostEntityPaste(Player,Ent,CreatedEntities)
     if(Ent.EntityMods and Ent.EntityMods.WireDupeInfo) then
         Ent:ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, function(id) return CreatedEntities[id] end)
     end
end

function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 
     local ent = ents.Create( self.ClassName )
     ent:SetPos( tr.HitPos + tr.HitNormal * 15 ) -- Changing the right most number makes the entity spawn further up or down...
     ent:Spawn()
     ent:Activate()
	 
     return ent
	 
end