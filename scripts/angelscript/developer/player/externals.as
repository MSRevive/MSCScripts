#pragma context server

namespace MS
{

class Externals : CGameScript
{
	void ext_setstat()
	{
		LogMessage("ent_me Stat " + param1 + "set to " + param2);
		SetStat("PARAM1", param2);
	}

	void ext_fullstats()
	{
		SetStat("swordsmanship.proficiency", 45);
		SetStat("swordsmanship.balance", 45);
		SetStat("swordsmanship.power", 45);
		SetStat("martialarts.proficiency", 45);
		SetStat("martialarts.balance", 45);
		SetStat("martialarts.power", 45);
		SetStat("smallarms.proficiency", 45);
		SetStat("smallarms.balance", 45);
		SetStat("smallarms.power", 45);
		SetStat("axehandling.proficiency", 45);
		SetStat("axehandling.balance", 45);
		SetStat("axehandling.power", 45);
		SetStat("bluntarms.proficiency", 45);
		SetStat("bluntarms.balance", 45);
		SetStat("bluntarms.power", 45);
		SetStat("archery.proficiency", 45);
		SetStat("archery.balance", 45);
		SetStat("archery.power", 45);
		SetStat("spellcasting.fire", 45);
		SetStat("spellcasting.ice", 45);
		SetStat("spellcasting.lightning", 45);
		SetStat("spellcasting.divination", 45);
		SetStat("spellcasting.affliction", 45);
		SetStat("polearms.proficiency", 45);
		SetStat("polearms.balance", 45);
		SetStat("polearms.power", 45);
	}

	void ext_setstats()
	{
		SetStat("swordsmanship.proficiency", param1);
		SetStat("swordsmanship.balance", param1);
		SetStat("swordsmanship.power", param1);
		SetStat("martialarts.proficiency", param1);
		SetStat("martialarts.balance", param1);
		SetStat("martialarts.power", param1);
		SetStat("smallarms.proficiency", param1);
		SetStat("smallarms.balance", param1);
		SetStat("smallarms.power", param1);
		SetStat("axehandling.proficiency", param1);
		SetStat("axehandling.balance", param1);
		SetStat("axehandling.power", param1);
		SetStat("bluntarms.proficiency", param1);
		SetStat("bluntarms.balance", param1);
		SetStat("bluntarms.power", param1);
		SetStat("archery.proficiency", param1);
		SetStat("archery.balance", param1);
		SetStat("archery.power", param1);
		SetStat("spellcasting.fire", param1);
		SetStat("spellcasting.ice", param1);
		SetStat("spellcasting.lightning", param1);
		SetStat("spellcasting.divination", param1);
		SetStat("spellcasting.affliction", param1);
		SetStat("polearms.proficiency", param1);
		SetStat("polearms.balance", param1);
		SetStat("polearms.power", param1);
	}

}

}
