 
DEFINE_BASECLASS( "gmissile_base" )
ENT.Type = "anim"

 

ENT.Category       		= "G-Missiles Guided"
ENT.PrintName			= "MBDA Guided" 
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= "MBDA Meteor with guidance system installed"
 
ENT.Spawnable 			= true

ENT.MissileModel                    =   "models/GMissiles/mbda-meteor.mdl"
ENT.RocketTrail                      =  "HellFire_Thrust"
ENT.RocketBurnoutTrail               =  "generic_smoke"
ENT.Effect                           =  "high_explosive_air_2"
ENT.EffectAir                        =  "high_explosive_air_2" 
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "Explosion3"        
ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
ENT.ArmSound                         =  "Missile_ARMED"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "Phx.Rocket04"  
ENT.EngineSound2                      =  "GM.Turbine" 

ENT.ShouldUnweld                     =  false          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  false  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  2000
ENT.ExplosionRadius                  =  700            
ENT.PhysForce                        =  1000             
ENT.SpecialRadius                    =  225           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  25            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  100           
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  400             
ENT.EnginePower                      =  400           
ENT.FuelBurnoutTime                  =  1.5          
ENT.IgnitionDelay                    =  1.0            
ENT.ArmDelay                         =  0.8
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "NONE"       
ENT.Timer                            =  0
ENT.HomingAcc                        =  0      --The starting homing accuracy of the missile
ENT.HomingAccIncrease	             =  0.001  --Increases the homing accuracy of the missle over its tracking duration
ENT.HomingFlightSpeed                =  2000   --When Missile is tracking, this controls how fast it flys to its target
ENT.TargetAquireDelay                =  1
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