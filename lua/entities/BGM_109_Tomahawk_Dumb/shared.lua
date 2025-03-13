 
ENT.Type = "anim"
ENT.Base = "base_anim"
 

ENT.Category       		= "G-Missiles"
ENT.PrintName			= "BGM 109 Tomahawk" 
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= "BGM 109 Tomahawk with no guidance system installed"
 
ENT.Spawnable 			= true

ENT.RocketTrail                      =  "Thawk_Thrust"
ENT.RocketBurnoutTrail               =  "oxykerosine_burnout"
ENT.Effect                           =  "1000lb_explosion"
ENT.EffectAir                        =  "1000lb_explosion_air" 
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "Explosion10"        
ENT.StartSound                       =  "GMissiles/launch/tow1.wav"         
ENT.ArmSound                         =  "Missile_ARMED"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "GM.Turbine"  
ENT.EngineSound2                      =  "Phx.Jet3"

ENT.ShouldUnweld                     =  false          
ENT.ShouldIgnite                     =  false         
ENT.UseRandomSounds                  =  true                  
ENT.SmartLaunch                      =  false  
ENT.Timed                            =  false 

ENT.ExplosionDamage                  =  2000
ENT.ExplosionRadius                  =  2700            
ENT.PhysForce                        =  1000             
ENT.SpecialRadius                    =  225           
ENT.MaxIgnitionTime                  =  0           
ENT.Life                             =  25            
ENT.MaxDelay                         =  0           
ENT.TraceLength                      =  1000           
ENT.ImpactSpeed                      =  100         
ENT.Mass                             =  500             
ENT.EnginePower                      =  40           
ENT.FuelBurnoutTime                  =  3          
ENT.IgnitionDelay                    =  0.3            
ENT.ArmDelay                         =  0.8
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "UP"      
ENT.Timer                            =  0

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