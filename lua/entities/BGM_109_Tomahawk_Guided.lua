AddCSLuaFile() -- Make sure clientside

									--If you are reading this--
				--What Are you doing here snooping around you dont belong here...--
						 --NAH just kidding, Feel free to have a snoop:P--
DEFINE_BASECLASS( "gmissile_base" )
ENT.Type = "anim"
ENT.Category = "G-Missiles Guided"
ENT.PrintName = "TBGM 109 Guided"
ENT.Author = "Forsomethings1"
ENT.Contact = "Don't"
ENT.Purpose = "Missiles can target this"
ENT.Instructions = ""
ENT.Spawnable = true

ENT.MissileModel = "models/GMissiles/bgm-109_tomahawk.mdl"
ENT.RocketTrail = "Thawk_Thrust"
ENT.RocketBurnoutTrail = "oxykerosine_burnout"
ENT.Effect = "1000lb_explosion"
ENT.EffectAir = "1000lb_explosion_air"
ENT.EffectWater = "water_medium"
ENT.ExplosionSound = "Explosion10"
ENT.StartSound = "GMissiles/launch/tow1.wav"
ENT.ArmSound = "Missile_ARMED"
ENT.ActivationSound = "Missile_ARMED"
ENT.EngineSound = "GM.Turbine"

ENT.ShouldUnweld = false
ENT.ShouldIgnite = false
ENT.UseRandomSounds = true
ENT.SmartLaunch = false
ENT.Timed = false

ENT.ExplosionDamage = 2000
ENT.ExplosionRadius = 2700
ENT.PhysForce = 1000
ENT.SpecialRadius = 225
ENT.MaxIgnitionTime = 0
ENT.Life = 25
ENT.MaxDelay = 0
ENT.TraceLength = 1000
ENT.ImpactSpeed = 100
ENT.Mass = 500
ENT.EnginePower = 80
ENT.FuelBurnoutTime = 3
ENT.IgnitionDelay = 0.3
ENT.ArmDelay = 0.8
ENT.RotationalForce = 0
ENT.ForceOrientation = "NONE"
ENT.Timer = 0
ENT.HomingAcc = 0 -- The starting homing accuracy of the missile
ENT.HomingAccIncrease = 0.001 -- Increases the homing accuracy of the missle over its tracking duration
ENT.HomingFlightSpeed = 2000 -- When Missile is tracking, this controls how fast it flys to its target
ENT.TargetAquireDelay = 4
ENT.GuiOffset = 25
ENT.FuelBurnoutDetonateTime = 20

function ENT:SpawnFunction( ply, tr ) -- Used so the ENT doesnt fucking spawn in the ground

	if ( not tr.Hit ) then return end

	 local ent = ents.Create( self.ClassName )
	 ent:SetPos( tr.HitPos + tr.HitNormal * .5 ) -- Changing the right most number makes the entity spawn further up or down...
	 ent:SetAngles(Angle(-90,0,0))
	 ent:Spawn()
	 ent:Activate()

	 return ent

end