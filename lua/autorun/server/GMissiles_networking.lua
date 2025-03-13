util.AddNetworkString( "gmissiles_cvar" )


net.Receive( "gmissiles_cvar", function( len, pl ) 
	if( not pl:IsAdmin() ) then return end
	local cvar = net.ReadString();
	local val = net.ReadFloat();
	
	if not (cvar:sub(1, 4) == "gb5_") then return end
	
	if( GetConVar( tostring( cvar ) ) == nil ) then return end
	if( GetConVarNumber( tostring( cvar ) ) == tonumber( val ) ) then return end

	game.ConsoleCommand( tostring( cvar ) .." ".. tostring( val ) .."\n" );

end );

