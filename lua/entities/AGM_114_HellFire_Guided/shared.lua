DEFINE_BASECLASS( "gmissile_base" )

ENT.Type = "anim"

 

ENT.Category       		= "G-Missiles Guided"
ENT.PrintName			= "AGM-114 Guided"
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= "AGM-114 HellFire"
 
ENT.Spawnable 			= true

ENT.MissileModel                    =   "models/GMissiles/hellfire missile.mdl"
ENT.RocketTrail                      =  "HellFire_Thrust"
ENT.RocketBurnoutTrail               =  "HellFire_burnout"
ENT.Effect                           =  "50lb_main"
ENT.EffectAir                        =  "50lb_air" 
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "Explosion5"        
ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
ENT.ArmSound                         =  "GMissiles/arm/hominglockaquired1.wav"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "GMissiles/launch/Missile_Launch1.wav"  

ENT.ShouldUnweld                     =  false          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  false  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  100
ENT.ExplosionRadius                  =  220           
ENT.PhysForce                        =  1000             
ENT.SpecialRadius                    =  255           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  25            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  100           
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  500             
ENT.EnginePower                      =  600           
ENT.FuelBurnoutTime                  =  1.5
ENT.FuelBurnoutDetonateTime          =  5          
ENT.IgnitionDelay                    =  0.5            
ENT.ArmDelay                         =  0.8
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "NONE"       
ENT.Timer                            =  0
ENT.HomingAcc                        =  0      --The starting homing accuracy of the missile
ENT.HomingAccIncrease	             =  0.006  --Increases the homing accuracy of the missle over its tracking duration
ENT.HomingFlightSpeed                =  20000   --When Missile is tracking, this controls how fast it flys to its target
ENT.TargetAquireDelay                =  .5
ENT.GuiOffset                        =  25

ENT.DEFAULT_PHYSFORCE = 255
ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
ENT.GMISSILE                         = nil

sound.Add({
	name =          "Explo.MediumExplo",
	pitch		=	{100, 100},
	volume		=	1,
	channel		=	CHAN_AUTO,
	level =   		160,
	sound  =		"^GMissiles/explosions/explosion_petrol_medium.wav"
	
})
sound.Add({
	name =          "Missile_ARMED",
	pitch		=	{100, 100},
	volume		=	1,
	channel		=	CHAN_AUTO,
	level =   		90,
	sound  =		"GMissiles/arm/Armed.wav"
	
})