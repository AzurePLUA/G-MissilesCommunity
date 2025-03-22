 AddCSLuaFile() -- Make sure clientside

							        --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--
    DEFINE_BASECLASS( "gmissile_base" )
    ENT.Type = "anim"
    ENT.Category       		= "G-Missiles Guided"
    ENT.PrintName			= "GMissileTestMissile" 
    ENT.Author			= "Forsomethings1"
    ENT.Contact			= "Don't"
    ENT.Purpose			= "Missiles can target this"
    ENT.Instructions		= ""
     
    ENT.Spawnable 			= true
    
    ENT.MissileModel                    =   "models/GMissiles/hellfire missile.mdl"
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
    ENT.IgnitionDelay                    =  1.0            
    ENT.ArmDelay                         =  0.1
    ENT.RotationalForce                  =  0
    ENT.ForceOrientation                 =  "NONE"       
    ENT.Timer                            =  0
    ENT.HomingAcc                        =  0      --The starting homing accuracy of the missile
    ENT.HomingAccIncrease	             =  0.001  --Increases the homing accuracy of the missle over its tracking duration
    ENT.HomingFlightSpeed                =  5000   --When Missile is tracking, this controls how fast it flys to its target
    ENT.TargetAquireDelay                =  1
    ENT.GuiOffset                        =  25
    ENT.FuelBurnoutDetonateTime          =  5





function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 
     local ent = ents.Create( self.ClassName )
     ent:SetPos( tr.HitPos + tr.HitNormal * .5 ) -- Changing the right most number makes the entity spawn further up or down...
	 ent:SetAngles(Angle(-90,0,0))
     ent:Spawn()
     ent:Activate()
	 
     return ent
	 
end