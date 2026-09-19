#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Chest : CGameScript
{
	int DOOR_OPENED;
	int NO_ORE;
	int NPC_ECHO_ITEMS;
	int WEPS_ATTAINED;

	Chest()
	{
		WEPS_ATTAINED = 0;
		NO_ORE = 1;
		NPC_ECHO_ITEMS = 1;
	}

	void chest_additems()
	{
		AddStoreItem(STORENAME, "axes_rsmallaxe", 1, 0);
		AddStoreItem(STORENAME, "swords_rsword", 1, 0);
		AddStoreItem(STORENAME, "smallarms_rknife", 1, 0);
		AddStoreItem(STORENAME, "blunt_hammer1", 1, 0);
		AddStoreItem(STORENAME, "bows_treebow", 1, 0);
		AddStoreItem(STORENAME, "blunt_gauntlets_leather", 1, 0);
	}

	void ext_player_got_item()
	{
		LogDebug("ext_player_got_item PARAM1 [ GetEntityProperty(param1, "itemname") ] GetEntityName(param2)");
		if ((GetEntityProperty(param1, "itemname")).findFirst("axes_rsmallaxe") >= 0)
		{
			ShowHelpTip(param2, "generic", "Axe Handling", "Axes are slow, but powerful. They also have|a higher chance to miss than most weapons.|At higher levels, and with two-handed axes, you can|perform a leap attack, hitting all enemies|in an area in front of you for lower damage.");
			WEPS_ATTAINED += 1;
			ScheduleDelayedEvent(0.1, "axes_msg");
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("swords_rsword") >= 0)
		{
			ShowHelpTip(param2, "generic", "Swordsmanship", "Swords are the most balanced of melee weapons,|providing average speed, damage, and hit chance.|Swordsmanship increases Strength, Fitness, and,|to a lower degree, agility and awareness.");
			WEPS_ATTAINED += 1;
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("smallarms_rknife") >= 0)
		{
			ShowHelpTip(param2, "generic", "Small Arms", "Daggers are fast and accurate, at the cost of damage.|Higher levels allow for a speed burst, enhancing|attack and run speed for a time. Small Arms|increases Strength, Agility, Fitness, and Awareness.");
			WEPS_ATTAINED += 1;
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("blunt_hammer1") >= 0)
		{
			ShowHelpTip(param2, "generic", "Blunt Arms", "Blunt arms, like this hammer, are slow, but powerful.|Higher levels allow for a stun attack.|Blunt Arms increases Strength heavily, Fitness moderately|and Agility and Awareness minimally.");
			WEPS_ATTAINED += 1;
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("bows_treebow") >= 0)
		{
			ShowHelpTip(param2, "generic", "Archery", "Bows and crossbows allow you to attack your enemy|at range. Better bows allow for more accuracy, range,|and slightly more damage.");
			ScheduleDelayedEvent(0.1, "bows_msg");
			WEPS_ATTAINED += 1;
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("blunt_gauntlets_leather") >= 0)
		{
			ShowHelpTip(param2, "generic", "Martial Arts", "Martial Arts uses your fists and feet to deal damage to foes.|Kicking is gained at higher levels, and as you level your martial|arts stat, you will be able to kick enemies away from you and even stun.");
			WEPS_ATTAINED += 1;
			ScheduleDelayedEvent(0.1, "marts_msg");
		}
		ScheduleDelayedEvent(7.0, "trigger_door");
	}

	void trigger_door()
	{
		if ((DOOR_OPENED)) return;
		DOOR_OPENED = 1;
		UseTrigger("chest_door");
	}

	void axes_msg()
	{
		ShowHelpTip(CHEST_USER, "generic", " ", "Axe Handling increases Strength heavily, Fitness|moderately, and Agility and Awareness minimally.");
	}

	void bows_msg()
	{
		ShowHelpTip(CHEST_USER, "generic", " ", "You have an unlimited supply of basic arrows and bolts,|though better ammunition can be bought from vendors,dropped|from monsters, or found in chests around the world of Daragoth.|Crossbows shoots with much higher accuracy, but take longer|to reload. Archery increases Concentration heavily, Strength,|Agility, and Awareness moderately, and Fitness minimally.");
	}

	void marts_msg()
	{
		ShowHelpTip(CHEST_USER, "generic", " ", "Martial Arts increases Strength, Agility, Awareness and Fitness.");
	}

}

}
