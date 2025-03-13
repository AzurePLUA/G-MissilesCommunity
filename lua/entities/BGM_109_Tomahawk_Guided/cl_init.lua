include('shared.lua')
   local Text = draw.SimpleText;
local Box = draw.RoundedBox;
local SetColor = surface.SetDrawColor;
local OutlineBox = surface.DrawOutlinedRect;
local OutlineText = draw.SimpleTextOutlined;

local Start3D2D = cam.Start3D2D;
local End3D2D = cam.End3D2D;
function ENT:Draw()
    
	self:DrawModel()       -- Draw the model.
    if(GetConVar("GMissile_Draw_Gui"):GetInt() >= 1) then
    if LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance(self.Entity:GetPos()) < 128 then
        local OffSet = Vector(0, 0, 43);
	    local Ang = LocalPlayer():EyeAngles();
	    local Pos = self:GetPos() + OffSet + Ang:Up();
 
	    Ang:RotateAroundAxis(Ang:Forward(), 90);
	    Ang:RotateAroundAxis(Ang:Right(), 90);
 
	    Start3D2D(Pos, Angle(0, Ang.y, 90), 0.25);
            Box(0, 60, 0, 150, 85, Color(255, 255, 255, 150));
            Box(0, 60, -25, 123, 20, Color(243, 247, 251, 150));


            SetColor(0, 0, 0, 225);
            OutlineBox(60, 0, 150, 85);
            OutlineBox(60, -25, 123, 20);
			
			Text('BGM-109 Tomahawk', 'DermaDefaultBold', 65, -22, Color(0, 0, 0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP,0.7,Color(0, 0, 0,255));
            OutlineText('Currently targeting', 'DermaDefaultBold', 65, 2, Color(171, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP,0.7,Color(0, 0, 0,255));
           -- Text('Current Target', 'Default', 65, 12, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
           -- Text('VERSION: ' .. self.ActualVer, 'DermaDefault', 188, 7, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
            
            Box(0, 62, 20, 146, 1, Color(0,0,0,170));

			Text('Change targets under Utilities/GMissiles', 'DermaDefault', 65, 87, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
            Text('Players: ', 'DermaDefault', 65, 20, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
            Text('Npcs:', 'DermaDefault', 65, 33, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
            Text('Vehicles: ', 'DermaDefault', 65, 46, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			Text('Thrusters: ', 'DermaDefault', 65, 58, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			Text('G-IR Target: ', 'DermaDefault', 65, 70, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			
			if(GetConVar("target_players"):GetInt() >= 1) then
				Text('Yes', 'DermaDefaultBold', 108, 20, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			else
				Text('No', 'DermaDefaultBold', 108, 20, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			end
			if(GetConVar("target_npc"):GetInt() >= 1) then
				Text('Yes', 'DermaDefaultBold', 95,  33, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			else
				Text('No', 'DermaDefaultBold', 95,  33, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			end
			if(GetConVar("target_vehicles"):GetInt() >= 1) then
				Text('Yes', 'DermaDefaultBold', 108, 46, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			else
				Text('No', 'DermaDefaultBold', 108, 46, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			end
			if(GetConVar("target_thrusters"):GetInt() >= 1) then
				Text('Yes', 'DermaDefaultBold', 118,  58, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			else
				Text('No', 'DermaDefaultBold', 118,  58, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			end
			if(GetConVar("target_IR"):GetInt() >= 1) then
				Text('Yes', 'DermaDefaultBold', 128,  70, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			else
				Text('No', 'DermaDefaultBold', 128,  70, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
			end
			
        End3D2D();
		end
	end
end