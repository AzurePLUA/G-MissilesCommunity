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
		
			HAmraam = ents.Create( "RGM_84_Harpoon_Dumb" )-- Create missile
			HAmraam:SetPos( self:GetPos() )
			HAmraam:SetAngles(Angle(self:GetAngles()))
			HAmraam:Spawn()
			constraint.NoCollide( self, HAmraam, 0, 0 )
			HAmraam:Launch()
			local phys = HAmraam:GetPhysicsObject()
			phys:SetVelocity(HAmraam:GetForward()*900  )
			self:EmitSound( "GMissiles/Launch/LaunchPuff.wav",75,100,1,CHAN_AUTO )
			
			-- Rotate the missile by 90 degrees over 2 seconds with a delay
			local startTime = CurTime()
			local duration = 2
			local delay = 1.5 -- adjustable delay in seconds
			local startAngle = phys:GetAngles()
			local endAngle = startAngle + Angle(90, 0, 0)
			local initialVelocity = (HAmraam:GetForward()*900)
			
			timer.Simple(delay, function()
				timer.Create("RotateMissile", 0.01, duration * 100, function()
					if not IsValid(phys) then return end
					local elapsed = CurTime() - (startTime + delay)
					local progress = math.Clamp(elapsed / duration, 0, 1)
					local newAngle = LerpAngle(progress, startAngle, endAngle)
					phys:SetAngles(newAngle)
					phys:SetVelocity(initialVelocity) -- Maintain initial velocity
					-- Apply a small force to ensure physics interactions
					phys:ApplyForceCenter(Vector(0, 0, 1))
					if progress >= 1 then
						timer.Remove("RotateMissile")
					end
				end)
			end)
			
			--Amraam:SetParent(self, 1)---Fucks up physics
			self.Reloaded = true
			
			timer.Simple( 3, function()---Delay between rounds
				self.Reloaded = false
			end)
			
end

function ENT:ReloadGuided()
			HAmraamG = ents.Create( "RGM_84_Harpoon_Guided" )-- Create missile
			HAmraamG:SetPos( self:GetPos() )
			HAmraamG:SetAngles(Angle(self:GetAngles()))
			HAmraamG:Spawn()
			constraint.NoCollide( self, HAmraamG, 0, 0 )
			HAmraamG:Launch()
			local phys = HAmraamG:GetPhysicsObject()
			phys:SetVelocity(HAmraamG:GetForward()*900  )
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
		if (not HAmraam:IsValid()) then return end
		HAmraam:Remove()
	end
end

function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 
     local ent = ents.Create( self.ClassName )
     ent:SetPos( tr.HitPos + tr.HitNormal * 80 ) -- Changing the right most number makes the entity spawn further up or down...
	 ent:SetAngles(Angle(-90,0,0))
     ent:Spawn()
     ent:Activate()
	 
     return ent
	 
end