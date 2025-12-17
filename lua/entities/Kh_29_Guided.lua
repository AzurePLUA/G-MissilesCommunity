AddCSLuaFile()
DEFINE_BASECLASS( "gmissile_base" )
ENT.Type = "anim"
ENT.Category = "G-Missiles Guided"
ENT.PrintName = "Kh-29 Guided"
ENT.Author = "Forsomethings1"
ENT.Contact = "Don't"
ENT.Purpose = "Blow Shit Up"
ENT.Instructions = "Kh-29"
ENT.Spawnable = true
ENT.MissileModel = "models/GMissiles/Kh-29.mdl"
ENT.RocketTrail = "Rocket_Thrust"
ENT.RocketBurnoutTrail = "oxykerosine_burnout"
ENT.Effect = "cloudmaker_ground"
ENT.EffectAir = "cloudmaker_air"
ENT.EffectWater = "water_medium"
ENT.ExplosionSound = "Explosion2HE"
ENT.StartSound = "GMissiles/launch/Missle_Launch.mp3"
ENT.ArmSound = "Missile_ARMED"
ENT.ActivationSound = "Missile_ARMED"
ENT.EngineSound = "Phx.Afterburner5"
ENT.ShouldUnweld = false
ENT.ShouldIgnite = false
ENT.UseRandomSounds = true
ENT.SmartLaunch = false
ENT.Timed = false
ENT.ExplosionDamage = 4000
ENT.ExplosionRadius = 2900
ENT.PhysForce = 1000
ENT.SpecialRadius = 1225
ENT.MaxIgnitionTime = 0
ENT.Life = 25
ENT.MaxDelay = 0
ENT.TraceLength = 100
ENT.ImpactSpeed = 100
ENT.Mass = 500
ENT.EnginePower = 80
ENT.FuelBurnoutTime = 20
ENT.IgnitionDelay = 0.5
ENT.ArmDelay = 1
ENT.RotationalForce = 0
ENT.ForceOrientation = "NONE"
ENT.Timer = 0
ENT.FuelBurnoutDetonateTime = 10
ENT.HomingAcc = 0
ENT.HomingAccIncrease = 0.001
ENT.HomingFlightSpeed = 14000
ENT.TargetAquireDelay = 2.0
ENT.GuiOffset = 45
ENT.DEFAULT_PHYSFORCE = 255
ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
ENT.GMISSILE = nil
ENT.MissileDragAmmount = 6

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