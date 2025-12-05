if SERVER then
    AddCSLuaFile()
end

if CLIENT then
    SWEP.PrintName     = "Targeting RPG"
    SWEP.Slot          = 2
    SWEP.SlotPos       = 1
    SWEP.DrawAmmo      = true
    SWEP.DrawCrosshair = true
end

SWEP.Author       = "Forsomethings"
SWEP.Contact      = ""
SWEP.Purpose      = ""
SWEP.Instructions = "Left click to set any entity, prop, or npc as a target that guided missiles will target"

SWEP.Category     = "G-Missiles"

SWEP.Spawnable    = true

SWEP.Base         = "weapon_base"
SWEP.HoldType     = "rpg"
SWEP.ViewModel    = "models/weapons/v_rpg.mdl"
SWEP.WorldModel   = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary = {
    ClipSize = -1,
    DefaultClip = -1,
    Automatic = false,
    Ammo = "none"
}

SWEP.Secondary = {
    ClipSize = -1,
    DefaultClip = 4,
    Automatic = false,
    Ammo = "smg1_grenade"
}

-- Server side only
function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.1)

    local trace = self.Owner:GetEyeTrace()
    self.Owner:SetNWEntity("MarkedTarget", trace.Entity)

    -- Play a brief confirmation sound and animation
    self:EmitSound("buttons/button14.wav")
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    if IsValid(self.Owner) then
        self.Owner:SetAnimation(PLAYER_ATTACK1)
    end
end

function SWEP:SecondaryAttack()
    -- Ammo handling: require at least 1 unit of the configured secondary ammo
    local ammoType = self.Secondary and self.Secondary.Ammo or "SMG1_Grenade"
    if ammoType and ammoType ~= "none" then
        local ownerAmmo = self.Owner:GetAmmoCount(ammoType)
        if ownerAmmo <= 0 then
            -- empty click
            self:EmitSound("Weapon_Pistol.Empty")
            self:SetNextSecondaryFire(CurTime() + 0.2)
            return
        end

        -- Play the viewmodel secondary attack animation and sound for both client and server
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self:EmitSound("Weapon_RPG.Single")
        if IsValid(self.Owner) then
            self.Owner:SetAnimation(PLAYER_ATTACK1)
        end

        -- consume one ammo
        self.Owner:RemoveAmmo(1, ammoType)
    end

    -- Server-only: spawn and launch the missile
    if SERVER then
        local owner = self:GetOwner()
        local Missile = ents.Create("TY_90_Guided")

        if not IsValid(Missile) then return end

        Missile:SetPos(owner:GetShootPos() + owner:GetAimVector() * 50)
        Missile:SetAngles(owner:EyeAngles())
        Missile:SetCreator(owner)
        Missile:Spawn()
        Missile:Launch()

        local phys = Missile:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetVelocity(owner:GetAimVector() * 1000)
        end
    end

    self:SetNextSecondaryFire(CurTime() + 2)
end

-- Client side only
if CLIENT then
    hook.Add("RenderScreenspaceEffects", "MarkTargetRed", function()
        local wep = LocalPlayer():GetActiveWeapon()
        if IsValid(wep) then
            local target = LocalPlayer():GetNWEntity("MarkedTarget")
            if IsValid(target) then
                halo.Add({ target }, Color(255, 0, 0, 255), 5, 5, 2, true, true)
            end
        end
    end)
end
