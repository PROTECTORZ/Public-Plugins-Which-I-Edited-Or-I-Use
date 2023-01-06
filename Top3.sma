#include <amxmodx>
#include <amxmisc>
#include <csx>


#define PLUGIN "TOP15 Best 3"
#define VERSION "1.0a" 
#define AUTHOR "Unknown"

new Top15_First[36] = ".....";
new Top15_Second[36] = ".....";
new Top15_Third[36] = ".....";

new cvar_active

new RED = 255
new GREEN = 1
new BLUE = 0

new Count

public plugin_init() { 
	
	register_plugin(PLUGIN, VERSION, AUTHOR) 
	register_event("HLTV", "New_Round_Started", "a", "1=0", "2=0") 
	
	cvar_active = register_cvar("radar_top_3","2")
	
	New_Round_Started()
	
	set_task (7.0,"show_hud",_,_,_,"b")
	
}

public show_hud(){

	Count += 1
	
	if ( get_pcvar_num(cvar_active) == 0 )
		return PLUGIN_HANDLED
		
	if ( get_pcvar_num(cvar_active) == 2 && Count > 3)
		return PLUGIN_HANDLED
		
	Color_Change()
	set_hudmessage( random(256), random(256), random(256), 0.005, 0.15, 2, 3.5, 3.0, 0.1, 4.5 );
	show_hudmessage(0,"| Top15 | Best Of 3 |^n^n1. %s^n2. %s^n3. %s",Top15_First,Top15_Second,Top15_Third); 
	
	return PLUGIN_HANDLED
	

}
public New_Round_Started(){

	Count = 0
	
	new stats[8],bodyhits[8],authid[64]
	get_stats(0,stats,bodyhits,Top15_First,31,authid,63)
	get_stats(1,stats,bodyhits,Top15_Second,31,authid,63)
	get_stats(2,stats,bodyhits,Top15_Third,31,authid,63)
		

}
stock Color_Change(){


	if ( RED == 255 ) RED = 0
	else if ( RED == 0 ) RED = 1
	else if ( RED == 1) RED = 255

	if ( GREEN == 255 ) GREEN = 0
	else if ( GREEN == 0 ) GREEN = 1
	else if ( GREEN == 1) GREEN = 255

	if ( BLUE == 255 ) BLUE = 0
	else if ( BLUE == 0 ) BLUE = 1
	else if ( BLUE == 1) BLUE = 255


}

/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1034\\ f0\\ fs16 \n\\ par }
*/
