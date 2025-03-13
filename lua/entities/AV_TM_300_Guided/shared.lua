 
DEFINE_BASECLASS( "gmissile_base" )
ENT.Type = "anim"

 

ENT.Category       		= "G-Missiles Guided"
ENT.PrintName			= "AV/TM 300 Guided"
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= "AV/TM 300"
 
ENT.Spawnable 			= true

ENT.MissileModel                    =   "models/GMissiles/av-tm300.mdl"
ENT.RocketTrail                      =  "AGM300_trail"
ENT.RocketBurnoutTrail               =  "AGM300_burnout"
ENT.Effect                           =  "Missile_HE_Ground"
ENT.EffectAir                        =  "Missile_HE" 
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "Explosion1"        
ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
ENT.ArmSound                         =  "Missile_ARMED"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "Phx.Afterburner5"  

ENT.ShouldUnweld                     =  false          
ENT.ShouldIgnite                     =  true         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  false  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  2000
ENT.ExplosionRadius                  =  1000            
ENT.PhysForce                        =  1000             
ENT.SpecialRadius                    =  225           
ENT.MaxIgnitionTime                  =  10          
ENT.Life                             =  25            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  100           
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  500             
ENT.EnginePower                      =  80           
ENT.FuelBurnoutTime                  =  20          
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

