#include <amxmodx>
#include <fakemeta>
#include <hamsandwich>

#define DMG_HE (1<<24)
const Float:HE_DMG_MULTIPLIER = 0.55

public plugin_init()
{
	register_plugin("HE Damage", "1.0", "AMXX-BG.INFO")
	RegisterHam(Ham_TakeDamage, "player", "TakeDamage", 0)
}

public TakeDamage(victim, idinflictor, idattacker, Float:damage, damagebits)
{
	if(damagebits & DMG_HE)
	{
		SetHamParamFloat(4, damage * HE_DMG_MULTIPLIER)
		return HAM_OVERRIDE
	}

	return HAM_IGNORED
}