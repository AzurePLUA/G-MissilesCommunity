local Created = false;

local function GMissilesSettings( CPanel )
	Created = true;

	local logo = vgui.Create( "DImage" );
	logo:SetImage( "hud/GMissiles.jpg" );
	logo:SetSize( 300, 300 );
	logo.DoClick = function() end

	CPanel:AddPanel( logo );
		
	
	local targetPlayers = CPanel:AddControl( "CheckBox", { Label = "Missiles Target Players", Command = "target_players" } );
	targetPlayers.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_players" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_players" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local targetNpc = CPanel:AddControl( "CheckBox", { Label = "Missiles Target NPC's", Command = "target_Npc" } );
	targetNpc.OnChange = function( panel, bVal ) 
		if( LocalPlayer() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_Npc" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_Npc" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local targetNextBot = CPanel:AddControl( "CheckBox", { Label = "Missiles Target NextBots", Command = "target_nextbots" } );
	targetNextBot.OnChange = function( panel, bVal ) 
		if( LocalPlayer() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_nextbots" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_nextbots" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local targetVehicles = CPanel:AddControl( "CheckBox", { Label = "Missiles Target Vehicles", Command = "target_vehicles" } );
	targetVehicles.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_vehicles" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_vehicles" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	

	local targetThruster = CPanel:AddControl( "CheckBox", { Label = "Missiles Target Thrusters", Command = "target_thrusters" } );
	targetThruster.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_thrusters" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_thrusters" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local targetIR = CPanel:AddControl( "CheckBox", { Label = "Missiles Target G-IR Target", Command = "target_IR" } );
	targetIR.OnChange = function( panel, bVal ) 
		if( LocalPlayer() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "target_IR" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "target_IR" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	local unfreeze = CPanel:AddControl( "CheckBox", { Label = "Missiles Can Unfreeze stuff?", Command = "GMissiles_shockwave_unfreeze" } );
	unfreeze.OnChange = function( panel, bVal ) 
		if( LocalPlayer() and not Created ) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "GMissiles_shockwave_unfreeze" ) ) then return end
			net.Start( "gmissiles_cvar" );
				net.WriteString( "GMissiles_shockwave_unfreeze" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end
	
	
	local soundIR = CPanel:AddControl( "CheckBox", { Label = "Should G-IR emit sound?", Command = "ir_sound" } );
	--soundIR.OnChange = function( panel, bVal ) 
		--if( LocalPlayer() and not Created ) then
		--	if( ( bVal and 1 or 0 ) == cvars.Number( "ir_sound" ) ) then return end
		--	net.Start( "gmissiles_cvar" );
		--		net.WriteString( "ir_sound" );
		--		net.WriteFloat( bVal and 1 or 0 );
		--	net.SendToServer();
		--end
	--end
	
	local guiEnable = CPanel:AddControl( "CheckBox", { Label = "Should Guided Missiles Show Info Box?", Command = "GMissile_Draw_Gui" } );
	--guiEnable.OnChange = function( panel, bVal ) 
		--if( LocalPlayer():IsSuperAdmin() and not Created ) then
		--	if( ( bVal and 1 or 0 ) == cvars.Number( "GMissile_Draw_Gui" ) ) then return end
		--	net.Start( "gmissiles_cvar" );
			--	net.WriteString( "GMissile_Draw_Gui" );
			--	net.WriteFloat( bVal and 1 or 0 );
			--net.SendToServer();
		--end
	--end
	
	timer.Simple( 0.1, function() 
	
		if( targetPlayers ) then
			targetPlayers:SetValue(GetConVarNumber( "target_players" ) );
		end
		if( targetNpc ) then
			targetNpc:SetValue( GetConVarNumber( "target_Npc" ) );
		end
		if( targetNextBot ) then
			targetNextBot:SetValue( GetConVarNumber( "target_nextbots" ) );
		end
		if( targetVehicles ) then
			targetVehicles:SetValue( GetConVarNumber( "target_vehicles" ) );
		end
		if( targetIR ) then
			targetIR:SetValue( GetConVarNumber( "target_IR" ) );
		end
		if( unfreeze) then
			unfreeze:SetValue( GetConVarNumber( "GMissiles_shockwave_unfreeze" ) );
		end
		if( targetThruster ) then
			targetThruster:SetValue( GetConVarNumber( "target_thrusters" ) );
		end
		--if( guiEnable ) then
		--	guiEnable:SetValue( GetConVarNumber( "GMissile_Draw_Gui" ) );
		--end
		
		Created = false;

	end );

end

hook.Add( "PopulateToolMenu", "PopulateGmissileMenus", function()

	spawnmenu.AddToolMenuOption( "Utilities", "G-Missiles", "G-MissileSettings", "Settings", "", "", GMissilesSettings )

end );

hook.Add( "AddToolMenuCategories", "CreateGmissileCategories", function()

	spawnmenu.AddToolCategory( "Utilities", "G-Missiles", "G-Missiles" );

end );