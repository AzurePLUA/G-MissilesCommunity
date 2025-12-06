AddCSLuaFile()
DEFINE_BASECLASS( "gmissile_base" )
ENT.Type = "anim"
ENT.Category = "G-Missiles Guided"
ENT.PrintName = "Hellfire AGM-114R guided"
ENT.Author = "Forsomethings1"
ENT.Contact = "Don't"
ENT.Purpose = "Blow Shit Up"
ENT.Instructions = "Hellfire"
ENT.Spawnable = true
ENT.MissileModel = "models/GMissiles/AGM-114_Hellfire.mdl"
ENT.RocketTrail = "HellFire_Thrust"
ENT.RocketBurnoutTrail = "HellFire_burnout"
ENT.Effect = "50lb_main"
ENT.EffectAir = "50lb_air"
ENT.EffectWater = "water_medium"
ENT.ExplosionSound = "Explosion5"
ENT.StartSound = "GMissiles/launch/Missle_Launch.mp3"
ENT.ArmSound = "GMissiles/arm/hominglockaquired1.wav"
ENT.ActivationSound = "Missile_ARMED"
ENT.EngineSound = "GMissiles/launch/Missile_Launch1.wav"
ENT.ShouldUnweld = false
ENT.ShouldIgnite = false
ENT.UseRandomSounds = true
ENT.SmartLaunch = false
ENT.Timed = false
ENT.ExplosionDamage = 100
ENT.ExplosionRadius = 220
ENT.PhysForce = 1000
ENT.SpecialRadius = 255
ENT.MaxIgnitionTime = 0
ENT.Life = 25
ENT.MaxDelay = 0
ENT.TraceLength = 100
ENT.ImpactSpeed = 100
ENT.Mass = 500
ENT.EnginePower = 600
ENT.FuelBurnoutTime = 1.5
ENT.FuelBurnoutDetonateTime = 5
ENT.IgnitionDelay = 0.5
ENT.ArmDelay = 0.8
ENT.RotationalForce = 0
ENT.ForceOrientation = "NONE"
ENT.Timer = 0
ENT.HomingAcc = 0
ENT.HomingAccIncrease = 0.006
ENT.HomingFlightSpeed = 20000
ENT.TargetAquireDelay = 0.5
ENT.GuiOffset = 25
ENT.DEFAULT_PHYSFORCE = 255
ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
ENT.GMISSILE = nil

 function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 self.GBOWNER = ply
     local ent = ents.Create( self.ClassName )
	 ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 3 ) -- Changing the right most number makes the entity spawn further up or down...
     ent:Spawn()
	 ent:SetAngles(Angle(-90,90,0))
     ent:Activate()
	 
     return ent
	 
end