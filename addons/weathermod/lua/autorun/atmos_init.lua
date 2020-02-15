AddCSLuaFile();
AddCSLuaFile( "atmos/shared.lua" );
AddCSLuaFile( "atmos/cl_init.lua" );

include( "atmos/shared.lua" );

if SERVER then

	include("atmos/init.lua");

else

	include("atmos/cl_init.lua");

end
