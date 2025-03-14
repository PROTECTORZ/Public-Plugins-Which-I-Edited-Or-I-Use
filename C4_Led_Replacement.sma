/*	Copyright � 2008, ConnorMcLeod

	C4 Led Replacement is free software;
	you can redistribute it and/or modify it under the terms of the
	GNU General Public License as published by the Free Software Foundation.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with C4 Led Replacement; if not, write to the
	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
	Boston, MA 02111-1307, USA.
*/

#define NEW_LED	"sprites/ledglow2.spr"

#include <amxmodx>
#include <fakemeta>

#define PLUGIN "C4 Led Replacement"
#define AUTHOR "ConnorMcLeod"

new g_iLedSprite, g_iNewLed

public plugin_precache()
{
	g_iLedSprite = precache_model("sprites/ledglow.spr")
	g_iNewLed = precache_model(NEW_LED)
}

public plugin_init()
{
	register_plugin(PLUGIN, NEW_LED, AUTHOR)

	if( engfunc( EngFunc_FindEntityByString , FM_NULLENT , "classname" , "func_bomb_target" )
	||  engfunc( EngFunc_FindEntityByString , FM_NULLENT , "classname" , "info_bomb_target" )  )
	{
		register_message(SVC_TEMPENTITY, "Message_TempEntity")
	}
}


public Message_TempEntity(iMsgId, MSG_DEST, id)
{
	if(	MSG_DEST == MSG_PVS
	&&	get_msg_arg_int(1) == TE_GLOWSPRITE
	&&	get_msg_arg_int(5) == g_iLedSprite	)
	{
		set_msg_arg_int(5, ARG_SHORT, g_iNewLed)
	}
}