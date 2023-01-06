#include <amxmodx>
#include <amxmisc>
#include <cstrike>

#define PLUGIN "RoundMessage"
#define AUTHOR "Unknown"

#define TAG "[Your Prefix]"
new mapname[32];

public plugin_init() {
	register_plugin(PLUGIN, AMXX_VERSION_STR, AUTHOR)
	register_logevent("everyround", 2, "1=Round_Start");
	get_mapname(mapname,31)
}

public everyround(){
client_print_color(0,0,"^3===========Server Hostname ===========",TAG);
client_print_color(0,0,"^4%s ^1Active Players: ^3TE ^4(%d) || ^3CT ^4(%d)",TAG,get_playersnum_ex(GetPlayers_None | GetPlayers_MatchTeam, "TERRORIST"),get_playersnum_ex(GetPlayers_None | GetPlayers_MatchTeam, "CT"));
client_print_color(0,0,"^4%s ^1Current Map: ^4%s",TAG,mapname);
client_print_color(0,0,"^4%s ^3Live ^3# ^3Live ^3# ^4Live ^4# ",TAG);	
}
