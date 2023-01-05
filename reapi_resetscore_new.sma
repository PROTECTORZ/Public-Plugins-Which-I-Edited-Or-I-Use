#include <amxmodx>
#include <reapi>

#define PREFIX "[ResetScore]"

public plugin_init()
{
	register_plugin("ReAPI: ResetScore", "1.0", "Huehue @ AMXX-BG.INFO")
	
	register_clcmd("say /resetscore", "Command_ResetScore")
	register_clcmd("say /rs", "Command_ResetScore")
	register_clcmd("say_team /resetscore", "Command_ResetScore")
	register_clcmd("say_team /rs", "Command_ResetScore")
}

public Command_ResetScore(id)
{
	if (!is_user_connected(id))
		return PLUGIN_HANDLED

	if (get_entvar(id, var_frags) == 0 && get_member(id, m_iDeaths) == 0)
	{
		client_print_color(id, print_team_default, "^4%s^1 Your score is already^3 0/0", PREFIX)
		return PLUGIN_HANDLED
	}

	set_entvar(id, var_frags, 0)
	set_member(id, m_iDeaths, 0)

	client_print_color(id, print_team_default, "^4%s^1 You have successfully reset your score!", PREFIX)

	set_hudmessage(255, 0, 0, 0.05, 0.7, .holdtime = 3.0)
	show_hudmessage(id, "%s^nYou have successfully reset your score!", PREFIX)


	// Update tabscore
	message_begin(MSG_BROADCAST, get_user_msgid("ScoreInfo"))
	write_byte(id)
	write_short(0)
	write_short(0)
	write_short(0)
	write_short(get_user_team(id))
	message_end()

	return PLUGIN_HANDLED
}