#include <amxmodx>
#include <WPMGPrintChatColor>
#include <geoip>
#include <reapi>

#define PLUGIN_VERSION "1.0.0"

new const PREFIX[] = "!y[!gHere Your Prefix?!y] "
new const COMPLAINT[] = "Your Discord Link"
new const g_Symbols[][] = { " ", ":", ".", "*", "/", "|", "\", "?", ">", "<" }
new szMapName[MAX_MAPNAME_LENGTH]

const MAX_COUNTRY_LENGTH = 45

public plugin_init()
{
	register_plugin("DeathRun: Demo Recorder", PLUGIN_VERSION, "Huehue")
	register_cvar("deathrun_demo_recorder", PLUGIN_VERSION, FCVAR_SERVER|FCVAR_SPONLY|FCVAR_UNLOGGED)
	set_cvar_string("deathrun_demo_recorder", PLUGIN_VERSION)
	
	get_mapname(szMapName, charsmax(szMapName))
}

public client_putinserver(id)
{
	set_task(15.0, "Start_Recording", id)
}

public Start_Recording(id)
{
	if(!is_user_connected(id))
		return
	
	new szTime[9], szFileName[128], szServerName[128], szPlayerIP[MAX_IP_LENGTH], szCountry[MAX_COUNTRY_LENGTH], szAuthID[MAX_AUTHID_LENGTH]

	get_user_ip(id, szPlayerIP, charsmax(szPlayerIP), .without_port = 1)
	geoip_country_ex(szPlayerIP, szCountry, charsmax(szCountry))
	get_user_authid(id, szAuthID, charsmax(szAuthID))

	get_time("%H:%M:%S", szTime, charsmax(szTime))
	
	get_pcvar_string(get_cvar_pointer("hostname"), szServerName, charsmax(szServerName))
	
	formatex(szFileName, charsmax(szFileName), "%s_%s", szServerName, szMapName)
	
	for(new i = 0; i < sizeof(g_Symbols); i++)
		replace_all(szFileName, charsmax(szFileName), g_Symbols[i], "_")
	
	PrintChatColor(id, PRINT_COLOR_PLAYERTEAM, "%s !yDemo Name: !t'!g%s!t'", PREFIX, szFileName)

	PrintChatColor(id, PRINT_COLOR_PLAYERTEAM, "%s !g[!yName: !t%n!g] [!yMap: !t%s!g] [!yTime: !t%s!g]", PREFIX, id, szMapName, szTime)
	PrintChatColor(id, PRINT_COLOR_PLAYERTEAM, "%s !g[!yIP: !t%s!g] [!ySteamID: !t%s!g]", szPlayerIP, szAuthID)

	PrintChatColor(id, PRINT_COLOR_PLAYERTEAM, "%s !yIf you were unfairly banned", PREFIX)
	PrintChatColor(id, PRINT_COLOR_PLAYERTEAM, "!yplease submit your complaint at: !t%s", COMPLAINT)

	PrintChatColor(0, PRINT_COLOR_PLAYERTEAM, "%s %s%s !t%n !ghas connected from !y[!t%s!y]", PREFIX, is_user_steam(id) ? "!ySTEAM " : "", get_user_flags(id) & ADMIN_RESERVATION ? "!gADMIN" : "", id, szCountry)

	client_cmd(id, "stop; record ^"%s^"", szFileName)
}
