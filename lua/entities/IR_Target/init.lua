 
AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
							        --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--


function ENT:Initialize()
 if (SERVER) then
	self:SetModel( "models/props_c17/streetsign004e.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(MOVETYPE_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	
	self:AddEffects( EF_ITEM_BLINK )
	
	
	 
	 end
end


function ENT:Think()--emits sound loop
	if(GetConVar("ir_sound"):GetInt() >= 1) then
	self:EmitSound(self.ArmSound)
	end
	self:NextThink(CurTime() + 1.4)
	
	return true
end

function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 
     local ent = ents.Create( self.ClassName )
     ent:SetPos( tr.HitPos + tr.HitNormal * 5 ) -- Changing the right most number makes the entity spawn further up or down...
	 ent:SetAngles(Angle(0,0,90))
     ent:Spawn()
     ent:Activate()
	 
     return ent
	 
end