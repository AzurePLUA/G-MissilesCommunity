if SERVER then
    AddCSLuaFile()
end

if CLIENT then
    SWEP.PrintName = "Remote Launcher"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = true
end

SWEP.Author = "Forsomethings1"
SWEP.Purpose = "Remotely launch all G-Missiles in range"
SWEP.Instructions = "Left click: launch all _Guided/_Dumb missiles in range. Right click: set radius."
SWEP.Category = "G-Missiles"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/v_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ViewModelFOV = 60

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.LaunchRadius = 2000
SWEP.Cooldown = 1



function SWEP:Initialize()
    self:SetHoldType("slam")  -- Use "slam" hold type for this weapon
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE) -- Set initial animation to idle
end

function SWEP:Reload() end
function SWEP:Think() end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)
    
    return true
end

function SWEP:PrimaryAttack()
    if CLIENT then return end
    if not IsValid(self.Owner) then return end
    if self.NextLaunch and CurTime() < self.NextLaunch then return end

    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)  -- Use SLAM-specific detonate animation for button press
    self:EmitSound("weapons/slam/buttonclick.wav")  -- Play the SLAM button push sound

    timer.Simple(self:SequenceDuration() or 0.1, function()
        if not IsValid(self) then return end
        self:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)  -- Return to idle animation
        self:RemoteLaunch()
    end)
    self:SetNextPrimaryFire(CurTime() + (self.Cooldown or 1))
    self.NextLaunch = CurTime() + (self.Cooldown or 1)
end

function SWEP:RemoteLaunch()
    local ply = self.Owner
    if not IsValid(ply) then return end
    local origin = ply:GetPos()
    local found = 0
    for _, ent in ipairs(ents.FindInSphere(origin, self.LaunchRadius)) do
        if IsValid(ent) then
            local class = ent:GetClass()
            local baseTable = baseclass.Get(class)
            local baseName = baseTable and baseTable.ClassName or class  -- fallback to own class if no base

            -- Optional debug print
           -- ply:ChatPrint("Entity: " .. class .. " | Base: " .. baseName)

            -- Check if the base class name contains "_guided" or "_dumb"
            if string.find(baseName, "_guided") or string.find(baseName, "_dumb") then
                if not ent.Fired and type(ent.Launch) == "function" then
                    ent:Launch()
                    found = found + 1
                end
            end
        end
    end
    if found > 0 then
        ply:ChatPrint("Launched " .. found .. " missile(s).")
        --self:EmitSound("GMissiles/arm/hominglockaquired1.wav", 75, 100)
        sound.Play("GMissiles/arm/hominglockaquired1.wav",self:GetPos(),75, 100)
    else
        ply:ChatPrint("Remote Launcher: No launchable G-Missiles found in range.")
    end
end

function SWEP:SecondaryAttack()
    if CLIENT then return end
    
    if self.LaunchRadius == 500 then
        self.LaunchRadius = 1000
    elseif self.LaunchRadius == 1000 then
        self.LaunchRadius = 2000
    elseif self.LaunchRadius == 2000 then
        self.LaunchRadius = 3000
    elseif self.LaunchRadius == 3000 then
        self.LaunchRadius = 5000
    elseif self.LaunchRadius == 5000 then
        self.LaunchRadius = 20000
    else
        self.LaunchRadius = 500  -- Fallback to default
    end
    --self:EmitSound("Weapon_Pistol.Empty")
    sound.Play("Weapon_Pistol.Empty",self:GetPos(),75, 100)
    self.Owner:ChatPrint("Launch radius set to " .. self.LaunchRadius)
    
    self:SetNextSecondaryFire(CurTime() + 0.3)
end
