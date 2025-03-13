AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

if (SERVER) then
	util.AddNetworkString( "Gmissiles_Expl_sound" )
end

ENT.Spawnable		            	 =  false
ENT.AdminSpawnable		             =  false     

ENT.PrintName		                 =  ""        
ENT.Author			                 =  ""      
ENT.Contact			                 =  ""      

ENT.GMISSILE                         =  nil            
ENT.MAX_RANGE                        = 0
ENT.SHOCKWAVE_INCREMENT              = 0
ENT.DELAY                            = 0
ENT.SOUND                            = ""

net.Receive( "Gmissiles_Expl_sound", function( len, pl )
	--print("Test, if you see this it SHOULD BE WORKING - Cat")
	local sound = net.ReadString()
	--LocalPlayer():EmitSound(sound, 100, 100, 1)
	
end );

function ENT:Initialize()
     if (SERVER) then
		 self.FILTER                           = {}
         self:SetModel("models/props_junk/watermelon01_chunk02c.mdl")
	     self:SetSolid( SOLID_NONE )
	     self:SetMoveType( MOVETYPE_NONE )
	     self:SetUseType( ONOFF_USE ) 
		 self.Bursts = 0
		 self.CURRENTRANGE = 0
		 --self.GMISSILE = self:GetVar("GMISSILE")
		 self.SOUND = self:GetVar("SOUND")
		 

     end
end

function ENT:Playsound()
	if not self:IsValid() then return end
	local LoadedSounds
	if CLIENT then
		LoadedSounds = {} -- this table caches existing CSoundPatches
	end
	
	local function ReadSound( FileName )
		local sound
		local filter
		if SERVER then
			filter = RecipientFilter()
			filter:AddAllPlayers()
		end
		if SERVER or !LoadedSounds[FileName] then
			-- The sound is always re-created serverside because of the RecipientFilter.
			sound = CreateSound( self, FileName, filter ) -- create the new sound, parented to the worldspawn (which always exists)
			if sound then
				sound:SetSoundLevel( 160 ) -- play everywhere
				if CLIENT then
					LoadedSounds[FileName] = { sound, filter } -- cache the CSoundPatch
				end
			end
		else
			sound = LoadedSounds[FileName][1]
			filter = LoadedSounds[FileName][2]
		end
		if sound then
			if CLIENT then
				sound:Stop() -- it won't play again otherwise
			end
			sound:Play()
		end
		return sound -- useful if you want to stop the sound yourself
	end
	
	-- When we are ready, we play the sound:
	ReadSound( self.SOUND )
end

function ENT:Think()		
     if (SERVER) then
     if !self:IsValid() then return end
	 local pos = self:GetPos()
	 self.CURRENTRANGE = self.CURRENTRANGE+(self.SHOCKWAVE_INCREMENT*10)
	 --if(GetConVar("GMissiles_realistic_sound"):GetInt() >= 1) then
		 for k, v in pairs(ents.FindInSphere(pos,self.CURRENTRANGE)) do
			 if v:IsPlayer() then
				 if !(table.HasValue(self.FILTER,v)) then
					
					self:Playsound()
					v:SetNWString("sound", self.SOUND)
					if self:GetVar("Shocktime") == nil then
						self.shocktime = 1
					else
						self.shocktime = self:GetVar("Shocktime")
					end
					--if GetConVar("hb_sound_shake"):GetInt()== 1 then
						util.ScreenShake( v:GetPos(), 5555, 555, self.shocktime, 500 )
					--end
					table.insert(self.FILTER, v)
					
				 end
			 end
		 end
	 --else
		if self:GetVar("Shocktime") == nil then
			self.shocktime = 1
		else
			self.shocktime = self:GetVar("Shocktime")
		end
	 	--local ent = ents.Create("hb_shockwave_sound_instant")
		--ent:SetPos( pos ) 
		--ent:Spawn()
		--ent:Activate()
		--ent:SetPhysicsAttacker(ply)
		--ent:SetVar("HBOWNER", self.HBOWNER)
		--ent:SetVar("MAX_RANGE",50000)
		--ent:SetVar("DELAY",0.01)
		--ent:SetVar("Shocktime",self.shocktime)
		--ent:SetVar("SOUND", self:GetVar("SOUND"))
		--self:Remove()
	 --end
	 self.Bursts = self.Bursts + 1
	 if (self.CURRENTRANGE >= self.MAX_RANGE) then
	     self:Remove()
	 end
	 self:NextThink(CurTime() + (self.DELAY*10))
	 return true
	 end
end
function ENT:OnRemove()
	if SERVER then
		if self.FILTER==nil then return end
		for k, v in pairs(self.FILTER) do
			if !v:IsValid() then return end
			v:SetNWBool("waiting", true)
		end
	end
end
function ENT:Draw()
     return false
end