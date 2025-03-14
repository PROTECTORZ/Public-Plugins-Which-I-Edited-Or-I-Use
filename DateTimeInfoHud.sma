#include <amxmodx>

new const g_szMessage[] = "Your Text Here"

public plugin_init()
{
    register_plugin(""Date and Time Hud", "1.0", "PROTECTOR")

    set_task(1.0, "displayMessage", .flags = "b")
}

public displayMessage()
{
    new szCurrentTime[64]
    get_time("%d/%m/%Y^n%H:%M:%S", szCurrentTime, charsmax(szCurrentTime))

    set_dhudmessage(random(256), random(256), random(256), 0.02, 0.2, 0, 0.1, 1.0, 0.1, 0.1, -1)
    show_dhudmessage(0, "%s^n%s", g_szMessage, szCurrentTime)
}
