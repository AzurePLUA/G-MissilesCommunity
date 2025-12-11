AddCSLuaFile()
DEFINE_BASECLASS("gmissile_base")
ENT.Type = "anim"
ENT.Category = "G-Missiles Guided"
ENT.PrintName = "TY-90 Guided"
ENT.Author = "Forsomethings1"
ENT.Contact = "Don't"
ENT.Purpose = "Blow Shit Up"
ENT.Instructions = "TY-90"
ENT.Spawnable = true

ENT.MissileModel = "models/GMissiles/TY-90.mdl"
ENT.RocketTrail = "Rocket_Thrust"
ENT.RocketBurnoutTrail = "Flame_burnout"
ENT.Effect = "100lb120D_air"
ENT.EffectAir = "100lb120D_air"
ENT.EffectWater = "water_medium"
ENT.ExplosionSound = "Explosion3"
ENT.StartSound = "GMissiles/launch/Missle_Launch.mp3"
ENT.ArmSound = "Missile_ARMED"
ENT.ActivationSound = "Missile_ARMED"
ENT.EngineSound = "Phx.Afterburner5"

ENT.ShouldUnweld = false
ENT.ShouldIgnite = false
ENT.UseRandomSounds = true
ENT.SmartLaunch = false

ENT.Timed = false
ENT.ExplosionDamage = 2000
ENT.ExplosionRadius = 900
ENT.PhysForce = 1000
ENT.SpecialRadius = 225
ENT.MaxIgnitionTime = 0
ENT.Life = 25
ENT.MaxDelay = 0
ENT.TraceLength = 100
ENT.ImpactSpeed = 100
ENT.Mass = 500
ENT.EnginePower = 280
ENT.FuelBurnoutTime = 1.5
ENT.IgnitionDelay = 0.1
ENT.ArmDelay = 0.1
ENT.RotationalForce = 0
ENT.ForceOrientation = "NONE"
ENT.Timer = 0
ENT.FuelBurnoutDetonateTime = 20
ENT.HomingAcc = 0.002
ENT.HomingAccIncrease = 0.004
ENT.HomingFlightSpeed = 4000
ENT.TargetAquireDelay = 0.3
ENT.GuiOffset = 15
ENT.DEFAULT_PHYSFORCE = 255
ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
ENT.GMISSILE = nil

function ENT:SpawnFunction(ply, tr) -- Used so the ENT doesnt fucking spawn in the ground
    if (not tr.Hit) then return end
    self.GBOWNER = ply
    local ent = ents.Create(self.ClassName)
    ent:SetPhysicsAttacker(ply)
    ent:SetPos(tr.HitPos + tr.HitNormal * 3) -- Changing the right most number makes the entity spawn further up or down...
    ent:Spawn()
    ent:SetAngles(Angle(-90, 90, 0))
    ent:Activate()

    return ent
end
