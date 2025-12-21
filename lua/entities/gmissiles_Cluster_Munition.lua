AddCSLuaFile()
 
	   				            --If you are reading this--
	            --What Are you doing here snooping around you dont belong here...--
	   			      --NAH just kidding, Feel free to have a snoop:P--
	   			      DEFINE_BASECLASS( "gmissile_base" )
	   			      ENT.Type = "anim"
   

   
	   			      ENT.Category       		= "G-Missiles"
	   			      ENT.PrintName			= "Cluster Munition Bomblet"
	   			      ENT.Author			= "Forsomethings1"
	   			      ENT.Contact			= "Don't"
	   			      ENT.Purpose			= "Blow Shit Up"
	   			      ENT.Instructions		= "AGM-114 HellFire"

	   			      ENT.Spawnable 			= false
   
	   			      ENT.MissileModel                    =   "models/GMissiles/hellfire missile.mdl"
	   			      ENT.RocketTrail                      =  ""
	   			      ENT.RocketBurnoutTrail               =  ""
	   			      ENT.Effect                           =  "50lb_main"
	   			      ENT.EffectAir                        =  "50lb_air" 
	   			      ENT.EffectWater                      =  "water_medium"
	   			      ENT.ExplosionSound                   =  "GMissiles/explosions/Explosion6Trail.mp3"        
	   			      ENT.StartSound                       =  ""         
	   			      ENT.ArmSound                         =  "GMissiles/arm/hominglockaquired1.wav"            
	   			      ENT.ActivationSound                  =  "Missile_ARMED"    
	   			      ENT.EngineSound                      =  ""  
   
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
	   			      ENT.EnginePower                      =  0          
	   			      ENT.FuelBurnoutTime                  =  0
	   			      ENT.FuelBurnoutDetonateTime          =  5          
	   			      ENT.IgnitionDelay                    =  0            
	   			      ENT.ArmDelay                         =  0.5
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
                      ENT.Dumb = true
					  ENT.ShouldFreezeOnSpawn = false

 function ENT:SpawnFunction( ply, tr )-- Used so the ENT doesnt fucking spawn in the ground
	
    if ( not tr.Hit ) then return end
	 self.GBOWNER = ply
     local ent = ents.Create( self.ClassName )
	-- ent:SetOwner()
	 ent:SetPhysicsAttacker(ply)
     ent:SetPos( tr.HitPos + tr.HitNormal * 25 ) -- Changing the right most number makes the entity spawn further up or down...
     ent:Spawn()
	 self.PlayersTeam = team.GetName((ply):Team()) 
	 print(self.PlayersTeam)
	 ent:SetAngles(Angle(-90,90,0))
     ent:Activate()
	 
     return ent
	 
end