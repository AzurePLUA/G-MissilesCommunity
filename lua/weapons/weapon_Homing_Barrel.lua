if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "Homing Barrel Launcher"
SWEP.Author = "YourName"
SWEP.Instructions = "Left click to shoot a homing barrel."
SWEP.Category = "G-Missiles"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

function SWEP:PrimaryAttack()
    if CLIENT then return end

    local owner = self:GetOwner()
    local barrel = ents.Create("AGM_114_HellFire_Dumb")
    if not IsValid(barrel) then return end

    
    barrel:SetPos(owner:GetShootPos() + owner:GetAimVector() * 50)
    barrel:SetAngles(owner:EyeAngles())
    barrel:Spawn()
    barrel:Activate()
    barrel:Launch()

    local phys = barrel:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocity(owner:GetAimVector() * 1000)
    end

    timer.Simple( 5, function() 
        if not IsValid(barrel) then return end
        
    barrel:TakeDamage( 100)
    end )

    self:SetNextPrimaryFire(CurTime() + .1)
    self:HomingBarrel(barrel)
end
