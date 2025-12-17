DEFINE_BASECLASS( "base_anim" )


ENT.Type = "anim"
ENT.Base = "base_anim"
 

ENT.Category       		= "G-Missiles Guided"
ENT.PrintName			= "Base Missile"
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= ""
 
ENT.Spawnable 			= false 

ENT.MissileModel                    =  "models/props_c17/canister01a.mdl"
ENT.RocketTrail                      =  ""
ENT.RocketBurnoutTrail               =  ""
ENT.Effect                           =  ""
ENT.EffectAir                        =  "" 
ENT.EffectWater                      =  ""
ENT.ExplosionSound                   =  ""        
ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
ENT.ArmSound                         =  "Missile_ARMED"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "Phx.Afterburner5"  
ENT.EngineSound2                      =  ""

ENT.ShouldUnweld                     =  false          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  false  
ENT.Timed                            =  false 

ENT.Shocktime                        =  1
ENT.ExplosionDamage                  =  2000
ENT.ExplosionRadius                  =  900            
ENT.PhysForce                        =  1000             
ENT.SpecialRadius                    =  225           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  25            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  100           
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  500             
ENT.EnginePower                      =  80           
ENT.FuelBurnoutTime                  =  20 
ENT.FuelBurnoutDetonateTime          =  5
ENT.IgnitionDelay                    =  1.0            
ENT.ArmDelay                         =  0.8
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "NONE"       
ENT.Timer                            =  0
ENT.HomingAcc    = 0
ENT.HomingAccIncrease	= 0.005
ENT.HomingFlightSpeed = 20000
ENT.TargetAquireDelay = 1.4

ENT.MissileHasDrag = true
ENT.MissileDragAmmount = 1
ENT.DragAmountMultiplyer = 20
ENT.MissileMassCenter = Vector(0,0,0)
ENT.GuiOffset = 55

ENT.DEFAULT_PHYSFORCE = 255
ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
ENT.GMISSILE                         = nil
-- freeze behaviour: per-entity can override this in their files (e.g. `ENT.FreezeOnSpawn = true`)
ENT.FreezeOnSpawn = false