#include <amxmodx>
#include <amxmisc>

#define CONNECT_DELAY 1.0
#define FREEVIP_FLAG "q"
#define FREEVIP_START 19
#define FREEVIP_END 23

new g_iFlags

public plugin_init()
{
	register_plugin("Free VIP", "1.0", "OciXCrom")
	g_iFlags = read_flags(FREEVIP_FLAG)
}
	
public client_putinserver(id)
{
	if(has_all_flags(id, FREEVIP_FLAG))
		return
		
	if(is_happy_hour(FREEVIP_START, FREEVIP_END))
		set_task(CONNECT_DELAY, "set_freevip", id)
}

public set_freevip(id)
	set_user_flags(id, g_iFlags)
	
bool:is_happy_hour(const iStart, const iEnd)
{
    static iHour; time(iHour)
    return bool:(iStart < iEnd ? (iStart <= iHour < iEnd) : (iStart <= iHour || iHour < iEnd))
}