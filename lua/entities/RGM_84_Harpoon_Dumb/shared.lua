 
ENT.Type = "anim"
ENT.Base = "base_anim"
 

ENT.Category       		= "G-Missiles"
ENT.PrintName			= "RGM-84 Harpoon" 
ENT.Author			= "Forsomethings1"
ENT.Contact			= "Don't"
ENT.Purpose			= "Blow Shit Up"
ENT.Instructions		= "RGM-84 Harpoon with no guidance system installed"
 
ENT.Spawnable 			= true

ENT.RocketTrail                      =  "Rocket_Thrust"
ENT.RocketBurnoutTrail               =  "oxykerosine_burnout"
ENT.Effect                           =  "500lb_ground"
ENT.EffectAir                        =  "500lb_air" 
ENT.EffectWater                      =  "water_medium"
ENT.ExplosionSound                   =  "Explo.MediumExplo"        
ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
ENT.ArmSound                         =  "Missile_ARMED"            
ENT.ActivationSound                  =  "Missile_ARMED"    
ENT.EngineSound                      =  "Phx.Afterburner5"  


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
ENT.Mass                             =  500             
ENT.EnginePower                      =  80           
ENT.FuelBurnoutTime                  =  20          
ENT.IgnitionDelay                    =  1.0            
ENT.ArmDelay                         =  0.8
ENT.RotationalForce                  =  0
ENT.ForceOrientation                 =  "NONE"       
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