if SERVER then
    AddCSLuaFile()
end

if CLIENT then
   SWEP.PrintName = "Targeting RPG"
   SWEP.Slot      = 2
   SWEP.SlotPos   = 1
   SWEP.DrawAmmo  = true
   SWEP.DrawCrosshair = true
end

SWEP.Author     = "Forsomethings"
SWEP.Contact    = ""
SWEP.Purpose    = ""
SWEP.Instructions = ""

SWEP.Category   = "G-Missiles"

SWEP.Spawnable = true

SWEP.Base               = "weapon_base"
SWEP.HoldType           = "rpg"
SWEP.ViewModel           = "models/weapons/v_rpg.mdl"
SWEP.WorldModel          = "models/weapons/w_rocket_launcher.mdl"

-- Server side only
if SERVER then
    function SWEP:PrimaryAttack()
        self:SetNextPrimaryFire( CurTime() + 0.1 )
        local target = self.Owner:GetNWEntity("MarkedTarget")
 
            local trace = self.Owner:GetEyeTrace()
            self.Owner:SetNWEntity("MarkedTarget", trace.Entity)
        
    end

    function SWEP:SecondaryAttack()
        self:SetNextSecondaryFire( CurTime() + 1 )
        local trace = self.Owner:GetEyeTrace()
        self.Owner:SetNWEntity("MarkedTarget", trace.Entity)
    end
end

-- Client side only
if CLIENT then
    hook.Add("RenderScreenspaceEffects", "MarkTargetRed", function()
        local wep = LocalPlayer():GetActiveWeapon()
        if IsValid(wep) then
            local target = LocalPlayer():GetNWEntity("MarkedTarget")
            if IsValid(target) then
                halo.Add({target}, Color(255, 0, 0, 255), 5, 5, 2, true, true)
            end
        end
    end)
end