#include <amxmodx>

enum _:Cvars
{
	amx_demorecorder_demoname,
	amx_demorecorder_start_time
}

new g_pCvar[Cvars]
public plugin_init()
{
	register_plugin("Demo Recorder","1.0","hackera457")
	register_cvar("hackera457_demorecorder","1.0", FCVAR_SERVER|FCVAR_SPONLY|FCVAR_UNLOGGED)
	
	g_pCvar[amx_demorecorder_demoname] = register_cvar("amx_demorecorder_demoname","GPlays-EU")
	g_pCvar[amx_demorecorder_start_time] = register_cvar("amx_demorecorder_start_time","5.0")
	
}

public client_putinserver(id)
{
	set_task(get_pcvar_float(g_pCvar[amx_demorecorder_start_time]), "startDemo", id)
}

public startDemo(id)
{
	if(is_user_connected(id))
	{
		client_cmd(id, "stop")

		new szTime[16], szDate[16], szMap[16], szDemoName[64]

		get_time("%H:%M:%S", szTime, charsmax(szTime))
		get_time("%d/%m/%Y", szDate, charsmax(szDate))
		
		get_mapname(szMap, charsmax(szMap))
		get_pcvar_string(g_pCvar[amx_demorecorder_demoname],szDemoName,charsmax(szDemoName))

		client_cmd(id, "record %s", szDemoName)
		
		client_print_color(id,print_chat,"^1[^4DemoRecorder^1] ^4Demo ^3Name: ^4[^3%s^4]^1 | ^4Date & ^3Time: ^3[^4%s^1 & ^4%s^3]", szDemoName, szTime, szDate)
	} 
}