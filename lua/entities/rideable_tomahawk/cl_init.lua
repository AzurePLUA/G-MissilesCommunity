include('shared.lua')
 
function ENT:Draw()
    
	self:DrawModel()       -- Draw the model.
	
    --hook.Add( "Think", "draw World Tip", function()
	--if not self:IsValid() then return end
	--local ply = Entity( 1 )
	--local tr = ply:GetEyeTrace()
	
	--local ent = self
	--if not ent:IsValid() then return end
	--local pos = ent:GetPos() -- will be unused if ent is valid
	--if not self.Notified then 
	--if LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance(self.Entity:GetPos()) < 328 then
	
	--notification.AddLegacy( "NOTE: Press spacebar to launch the tomahawk", NOTIFY_HINT, 5)
	--surface.PlaySound( "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav"  )
	--self.Notified = true
	--AddWorldTip( nil, "Hello world!", nil, pos, ent )
	--end
	--end
--end )

end