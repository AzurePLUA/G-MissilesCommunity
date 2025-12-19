AddCSLuaFile()

							         --If you are reading this--
			      --What Are you doing here snooping around you dont belong here...--
						   --NAH just kidding, Feel free to have a snoop:P--
                     DEFINE_BASECLASS( "gmissile_base" )
                     ENT.Type = "anim"
                     
                      
                     
                     ENT.Category       		= "G-Missiles Guided"
                     ENT.PrintName			= "AMRAAM Guided"
                     ENT.Author			= "Forsomethings1"
                     ENT.Contact			= "Don't"
                     ENT.Purpose			= "Blow Shit Up"
                     ENT.Instructions		= "AIM 120D AMRAAM"
                      
                     ENT.Spawnable 			= true
                     
                     ENT.MissileModel                    =   "models/GMissiles/aim-120d_amraam.mdl"
                     ENT.RocketTrail                      =  "HellFire_Thrust"
                     ENT.RocketBurnoutTrail               =  "HellFire_burnout"
                     ENT.Effect                           =  "100lb120D_air"
                     ENT.EffectAir                        =  "100lb120D_air" 
                     ENT.EffectWater                      =  "water_medium"
                     ENT.ExplosionSound                   =  "Explosion11"        
                     ENT.StartSound                       =  "GMissiles/launch/Missle_Launch.mp3"         
                     ENT.ArmSound                         =  "Missile_ARMED"            
                     ENT.ActivationSound                  =  "Missile_ARMED"    
                     ENT.EngineSound                      =  "GMissiles/launch/Missile_Launch1.wav"  
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
                     ENT.Mass                             =  500             
                     ENT.EnginePower                      =  480           
                     ENT.FuelBurnoutTime                  =  20          
                     ENT.IgnitionDelay                    =  0.8           
                     ENT.ArmDelay                         =  0.8
                     ENT.RotationalForce                  =  0
                     ENT.ForceOrientation                 =  "NONE"       
                     ENT.Timer                            =  0
                     ENT.HomingAcc                        =  0.01     --The starting homing accuracy of the missile
                     ENT.HomingAccIncrease	             =  0.0009  --Increases the homing accuracy of the missle over its tracking duration
                     ENT.HomingFlightSpeed                =  4000   --When Missile is tracking, this controls how fast it flys to its target
                     ENT.TargetAquireDelay                =  0.5
                     ENT.GuiOffset                        =  43
                     ENT.FuelBurnoutDetonateTime          =  20
                     
                     ENT.DEFAULT_PHYSFORCE = 255
                     ENT.DEFAULT_PHYSFORCE_PLYAIR = 25
                     ENT.DEFAULT_PHYSFORCE_PLYGROUND = 2555
                     ENT.GMISSILE                         = nil
                     ENT.MissileDragAmmount = 4
                     

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