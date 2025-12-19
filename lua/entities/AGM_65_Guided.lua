AddCSLuaFile() -- Make sure clientside

							         --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--
                     DEFINE_BASECLASS( "gmissile_base" )
                     ENT.Type = "anim"
                     
                      
                     
                     ENT.Category       		= "G-Missiles Guided"
                     ENT.PrintName			= "AGM-65 Guided"
                     ENT.Author			= "Forsomethings1"
                     ENT.Contact			= "Don't"
                     ENT.Purpose			= "Blow Shit Up"
                     ENT.Instructions		= "AGM-65"
                      
                     ENT.Spawnable 			= true
                     
                     ENT.MissileModel                    =   "models/GMissiles/AGM-65.mdl"
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
                     ENT.ArmDelay                         =  0.8
                     ENT.RotationalForce                  =  0
                     ENT.ForceOrientation                 =  "NONE"       
                     ENT.Timer                            =  0
                     ENT.FuelBurnoutDetonateTime          =  20 
                     ENT.HomingAcc    = 0
                     ENT.HomingAccIncrease	= 0.003
                     ENT.HomingFlightSpeed = 20000
                     ENT.TargetAquireDelay = 1.4
                     ENT.GuiOffset = 55
                     
                     ENT.DEFAULT_PHYSFORCE = 255
                     ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
                     ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
                     ENT.GMISSILE                         = nil

 function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 self.GMISSILE = ply
     local ent = ents.Create( self.ClassName )
	 ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 0.01 ) -- Changing the right most number makes the entity spawn further up or down...
     ent:Spawn()
	 ent:SetAngles(Angle(-90,90,0))
     ent:Activate()
	 
     return ent
	 
end

