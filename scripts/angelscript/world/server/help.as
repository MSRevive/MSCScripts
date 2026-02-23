#pragma context server

namespace MS
{

class Help : CGameScript
{
	int LISTMAPS_COUNT;
	string LISTMAPS_MSG_EPC;
	string LISTMAPS_MSG_HAR;
	string LISTMAPS_MSG_LOW;
	string LISTMAPS_MSG_MED;
	string LISTMAPS_MSG_VHR;
	string LISTMAPS_TARGET;

	Help()
	{
		LISTMAPS_MSG_LOW = "=========== Low level maps (up to ~200hp) ===========";
		LISTMAPS_MSG_MED = "=========== Medium level maps (~150hp-600hp) ===========";
		LISTMAPS_MSG_HAR = "=========== Hard level maps (~600hp-1000hp) ===========";
		LISTMAPS_MSG_VHR = "=========== Very Hard level maps (~1000hp-1500hp) ===========";
		LISTMAPS_MSG_EPC = "=========== Epic level maps (>1500hp + Apostle) ===========";
		array<string> ARRAY_MAPLIST_LOW;
		ARRAY_MAPLIST_LOW.insertLast("deralia (safe)");
		ARRAY_MAPLIST_LOW.insertLast("edana (safe)");
		ARRAY_MAPLIST_LOW.insertLast("ms_town (safe)");
		ARRAY_MAPLIST_LOW.insertLast("helena (safe, except during raids, where it can self-adjust up to medium)");
		ARRAY_MAPLIST_LOW.insertLast("ms_quest (almost safe)");
		ARRAY_MAPLIST_LOW.insertLast("msc_tutorial (can technically complete without combat)");
		ARRAY_MAPLIST_LOW.insertLast("edanasewers");
		ARRAY_MAPLIST_LOW.insertLast("thornlands (spitting spiders can be a bit mean)");
		ARRAY_MAPLIST_LOW.insertLast("ms_caves (empty, save for a thornlands boss spider)");
		ARRAY_MAPLIST_LOW.insertLast("gertenheld_cape");
		ARRAY_MAPLIST_LOW.insertLast("chapel (beware under the church floorboards)");
		ARRAY_MAPLIST_LOW.insertLast("mines");
		ARRAY_MAPLIST_LOW.insertLast("ms_swamp (empty, save for a few skeletons)");
		ARRAY_MAPLIST_LOW.insertLast("challs");
		ARRAY_MAPLIST_LOW.insertLast("goblintown (hidden)");
		ARRAY_MAPLIST_LOW.insertLast("island1");
		ARRAY_MAPLIST_LOW.insertLast("m2_quest");
		ARRAY_MAPLIST_LOW.insertLast("gertenheld_forest (beware of goblin cheif)");
		ARRAY_MAPLIST_LOW.insertLast("heras (beware of lobbing troll)");
		ARRAY_MAPLIST_LOW.insertLast("sfor (up to glowing slime forest area)");
		ARRAY_MAPLIST_LOW.insertLast("gatecity (above dzombie area) (hidden)");
		ARRAY_MAPLIST_LOW.insertLast("mscave (beware fire shamans)");
		ARRAY_MAPLIST_LOW.insertLast("isle (beware lobbing trolls and hidden brawler)");
		ARRAY_MAPLIST_LOW.insertLast("lowlands (start of 'Curse of the Bear Gods' series)");
		array<string> ARRAY_MAPLIST_MEDIUM;
		ARRAY_MAPLIST_MEDIUM.insertLast("keledrosprelude2 (Beware the Ice Troll)");
		ARRAY_MAPLIST_MEDIUM.insertLast("orcplace2_beta ('Curse of the Bear Gods', starts at lowlands)");
		ARRAY_MAPLIST_MEDIUM.insertLast("smugglers_cove");
		ARRAY_MAPLIST_MEDIUM.insertLast("daragoth (beware trolls)");
		ARRAY_MAPLIST_MEDIUM.insertLast("sfor (beyond slime forest area)");
		ARRAY_MAPLIST_MEDIUM.insertLast("orc_for (self-adjusted low)");
		ARRAY_MAPLIST_MEDIUM.insertLast("ms_underworldv2 (crappy throw-back map)");
		ARRAY_MAPLIST_MEDIUM.insertLast("ww1 (Start of 'World Walker' series)");
		ARRAY_MAPLIST_MEDIUM.insertLast("ww2b ('World Walker', starts at ww1)");
		ARRAY_MAPLIST_MEDIUM.insertLast("keledrosruins (hidden)");
		ARRAY_MAPLIST_MEDIUM.insertLast("unrest");
		ARRAY_MAPLIST_MEDIUM.insertLast("unrest2_beta1");
		ARRAY_MAPLIST_MEDIUM.insertLast("calruin2");
		ARRAY_MAPLIST_MEDIUM.insertLast("highlands_msc ('Curse of the Bear Gods', starts at lowlands)");
		ARRAY_MAPLIST_MEDIUM.insertLast("lostcastle_msc ('Curse of the Bear Gods', starts at lowlands)");
		ARRAY_MAPLIST_MEDIUM.insertLast("keledrosprelude2 (Ice Troll Battle)");
		ARRAY_MAPLIST_MEDIUM.insertLast("b_castle");
		ARRAY_MAPLIST_MEDIUM.insertLast("gatecity (dzombie area) (hidden)");
		ARRAY_MAPLIST_MEDIUM.insertLast("lostcaverns");
		ARRAY_MAPLIST_MEDIUM.insertLast("ara (long siege is long)");
		ARRAY_MAPLIST_MEDIUM.insertLast("bloodrose (up through Slithar)");
		ARRAY_MAPLIST_MEDIUM.insertLast("Cleicert");
		ARRAY_MAPLIST_MEDIUM.insertLast("ww3d ('World Walker', starts at ww1)");
		ARRAY_MAPLIST_MEDIUM.insertLast("idemarks_tower");
		ARRAY_MAPLIST_MEDIUM.insertLast("skycastle ('Curse of the Bear Gods', starts at lowlands)");
		ARRAY_MAPLIST_MEDIUM.insertLast("demontemple");
		ARRAY_MAPLIST_MEDIUM.insertLast("the_keep (random final boss maybe mean though)");
		ARRAY_MAPLIST_MEDIUM.insertLast("ms_snow");
		ARRAY_MAPLIST_MEDIUM.insertLast("foutpost");
		ARRAY_MAPLIST_MEDIUM.insertLast("oceancrossing");
		ARRAY_MAPLIST_MEDIUM.insertLast("ms_wicardoven");
		ARRAY_MAPLIST_MEDIUM.insertLast("islesofdread1");
		ARRAY_MAPLIST_MEDIUM.insertLast("islesofdread2_old");
		ARRAY_MAPLIST_MEDIUM.insertLast("nightmare_edana (self-adjusts medium-hard)");
		ARRAY_MAPLIST_MEDIUM.insertLast("catacombs (self-adjusts medium-hard)");
		ARRAY_MAPLIST_MEDIUM.insertLast("dragooncaves");
		ARRAY_MAPLIST_MEDIUM.insertLast("islesofdread2");
		ARRAY_MAPLIST_MEDIUM.insertLast("bloodrose (after Slithar)");
		ARRAY_MAPLIST_MEDIUM.insertLast("underpath (self adjusted low)");
		ARRAY_MAPLIST_MEDIUM.insertLast("undermines");
		ARRAY_MAPLIST_MEDIUM.insertLast("thanatos");
		ARRAY_MAPLIST_MEDIUM.insertLast("lodagond-2 ('Lodagond' series, starts at Lodagond-1)");
		ARRAY_MAPLIST_MEDIUM.insertLast("nightmare_thornlands");
		ARRAY_MAPLIST_MEDIUM.insertLast("phobia (beware final boss)");
		array<string> ARRAY_MAPLIST_HARD;
		ARRAY_MAPLIST_HARD.insertLast("aleyesu");
		ARRAY_MAPLIST_HARD.insertLast("lodagond-3 ('Lodagond' series, starts at Lodagond-1)");
		ARRAY_MAPLIST_HARD.insertLast("old_helena");
		ARRAY_MAPLIST_HARD.insertLast("aluhandra2");
		ARRAY_MAPLIST_HARD.insertLast("gertenheld_cave");
		ARRAY_MAPLIST_HARD.insertLast("lodagond-1 (start of 'Lodagond' series)");
		ARRAY_MAPLIST_HARD.insertLast("deraliasewers");
		ARRAY_MAPLIST_HARD.insertLast("catacombs (self-adjusts medium-hard)");
		ARRAY_MAPLIST_HARD.insertLast("tundra");
		ARRAY_MAPLIST_HARD.insertLast("umulak");
		ARRAY_MAPLIST_HARD.insertLast("kfortress");
		ARRAY_MAPLIST_HARD.insertLast("gertenhell");
		ARRAY_MAPLIST_HARD.insertLast("orc_for (self-adjusted high)");
		ARRAY_MAPLIST_HARD.insertLast("lodagond-4 ('Lodagond' series, starts at Lodagond-1)");
		ARRAY_MAPLIST_HARD.insertLast("undercliffs (self adjusted low)");
		ARRAY_MAPLIST_HARD.insertLast("underpath (self adjusted high)");
		ARRAY_MAPLIST_HARD.insertLast("sorc_villa (though safe, in some conditions)");
		array<string> ARRAY_MAPLIST_VHARD;
		ARRAY_MAPLIST_VHARD.insertLast("shad_palace");
		ARRAY_MAPLIST_VHARD.insertLast("bloodshrine");
		ARRAY_MAPLIST_VHARD.insertLast("undermines (self adjusted high)");
		ARRAY_MAPLIST_VHARD.insertLast("shender_east (self-adjusted min)");
		ARRAY_MAPLIST_VHARD.insertLast("hunderswamp_north");
		ARRAY_MAPLIST_VHARD.insertLast("the_wall");
		ARRAY_MAPLIST_VHARD.insertLast("the_wall2");
		ARRAY_MAPLIST_VHARD.insertLast("phlames");
		ARRAY_MAPLIST_VHARD.insertLast("undercliffs (self adjusted high)");
		ARRAY_MAPLIST_VHARD.insertLast("nashalrath (hidden)");
		ARRAY_MAPLIST_VHARD.insertLast("shender_east (self-adjusted max, nightmare battle self-adjusts near-epic)");
		array<string> ARRAY_MAPLIST_EPIC;
		ARRAY_MAPLIST_EPIC.insertLast("(none available as of yet)");
	}

	void game_playercmd()
	{
		if (param1 == "listmaps")
		{
			if (LISTMAPS_TARGET != "LISTMAPS_TARGET")
			{
				if (LISTMAPS_TARGET != GetEntityIndex("ent_currentplayer"))
				{
				}
				LogMessage("ent_currentplayer One moment , listmaps system is helping GetEntityName(LISTMAPS_TARGET)");
			}
			if ((param2).findFirst(PARAM) == 0)
			{
				string L_HP = GetEntityMaxHealth("ent_currentplayer");
				if (L_HP <= 150)
				{
					LISTMAPS_START = "low";
					LISTMAPS_STOP = "low";
				}
				else
				{
					if (L_HP > 150)
					{
						if (L_HP > 200)
						{
							LISTMAPS_START = "low";
							LISTMAPS_STOP = "medium";
						}
						if (L_HP >= 600)
						{
							LISTMAPS_START = "hard";
							LISTMAPS_STOP = "hard";
						}
						if (L_HP >= 800)
						{
							LISTMAPS_START = "hard";
							LISTMAPS_STOP = "vhard";
						}
						if (L_HP >= 1500)
						{
							LISTMAPS_START = "vhard";
							LISTMAPS_STOP = "epic";
						}
					}
				}
				int L_LISTING_CUSTOM = 1;
				LogMessage("ent_currentplayer Listing maps recommended for your character level: LISTMAPS_START to LISTMAPS_STOP");
				LogMessage("ent_currentplayer To list more maps , try listmaps [difficulty] or listmaps all");
			}
			else
			{
				LISTMAPS_START = "none";
				LISTMAPS_STOP = "none";
				if (param2 == "low")
				{
					LISTMAPS_START = "low";
					LISTMAPS_STOP = "low";
				}
				if (param2 == "medium")
				{
					LISTMAPS_START = "medium";
					LISTMAPS_STOP = "medium";
				}
				if (param2 == "hard")
				{
					LISTMAPS_START = "hard";
					LISTMAPS_STOP = "hard";
				}
				if (param2 == "vhard")
				{
					LISTMAPS_START = "vhard";
					LISTMAPS_STOP = "vhard";
				}
				if (param2 == "epic")
				{
					LISTMAPS_START = "epic";
					LISTMAPS_STOP = "epic";
				}
				if (param2 == "all")
				{
					LISTMAPS_START = "low";
					LISTMAPS_STOP = "epic";
				}
			}
			if (LISTMAPS_START != "none")
			{
				if (!(L_LISTING_CUSTOM))
				{
					if (param2 == "all")
					{
						LogMessage("ent_currentplayer Listing maps recomended for LISTMAPS_START levels");
					}
					else
					{
						LogMessage("ent_currentplayer Listing all maps by difficulty");
					}
				}
				LISTMAPS_TARGET = GetEntityIndex("ent_currentplayer");
				do_listmaps();
			}
			else
			{
				LISTMAPS_TARGET = "LISTMAPS_TARGET";
				LogMessage("ent_currentplayer listmaps , unrecognized parameter: PARAM2");
				LogMessage("ent_currentplayer listmaps [low|medium|hard|vhard|epic|all]");
			}
		}
		else
		{
			if (param1 == "summon_help")
			{
				LogMessage("ent_currentplayer SUMMON CHAT COMMANDS");
				LogMessage("ent_currentplayer follow - disengage and follow you");
				LogMessage("ent_currentplayer defend - stay near, engage nearby enemies");
				LogMessage("ent_currentplayer kill - attack your current target");
				LogMessage("ent_currentplayer hunt - roam away and attack any enemies");
				LogMessage("ent_currentplayer vanish - unsummon");
				LogMessage("ent_currentplayer stay - guard position");
				LogMessage("ent_currentplayer * Prefix any of the above commands with all [command] to affect all your summons");
				return;
			}
			else
			{
				if (param1 == "mapinfo")
				{
					LogMessage("ent_currentplayer Map Title: game.map.title");
					LogMessage("ent_currentplayer Map Desc: game.map.desc");
					LogMessage("ent_currentplayer HPWarn: game.map.hpwarn");
					LogMessage("ent_currentplayer Weather: game.map.weather");
					return;
				}
			}
		}
	}

	void do_listmaps()
	{
		LISTMAPS_COUNT = 0;
		if (LISTMAPS_START == "low")
		{
			LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_LOW");
			ScheduleDelayedEvent(0.1, "do_listmaps_low");
		}
		if (LISTMAPS_START == "medium")
		{
			LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_MED");
			ScheduleDelayedEvent(0.1, "do_listmaps_medium");
		}
		if (LISTMAPS_START == "hard")
		{
			LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_HAR");
			ScheduleDelayedEvent(0.1, "do_listmaps_hard");
		}
		if (LISTMAPS_START == "vhard")
		{
			LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_VHR");
			ScheduleDelayedEvent(0.1, "do_listmaps_vhard");
		}
		if (LISTMAPS_START == "epic")
		{
			LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_EPC");
			ScheduleDelayedEvent(0.1, "do_listmaps_epic");
		}
	}

	void do_listmaps_low()
	{
		if (!(LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_LOW))) return;
		LogMessage("LISTMAPS_TARGET /* TODO: $get_array */ $get_array(ARRAY_MAPLIST_LOW, LISTMAPS_COUNT)");
		LISTMAPS_COUNT += 1;
		if (LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_LOW))
		{
			ScheduleDelayedEvent(0.1, "do_listmaps_low");
		}
		else
		{
			if (LISTMAPS_STOP != "low")
			{
				LISTMAPS_COUNT = 0;
				LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_MED");
				do_listmaps_medium();
			}
			else
			{
				LISTMAPS_TARGET = "LISTMAPS_TARGET";
			}
		}
	}

	void do_listmaps_medium()
	{
		if (!(LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_MEDIUM))) return;
		LogMessage("LISTMAPS_TARGET /* TODO: $get_array */ $get_array(ARRAY_MAPLIST_MEDIUM, LISTMAPS_COUNT)");
		LISTMAPS_COUNT += 1;
		if (LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_MEDIUM))
		{
			ScheduleDelayedEvent(0.1, "do_listmaps_medium");
		}
		else
		{
			if (LISTMAPS_STOP != "medium")
			{
				LISTMAPS_COUNT = 0;
				LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_HAR");
				do_listmaps_hard();
			}
			else
			{
				LISTMAPS_TARGET = "LISTMAPS_TARGET";
			}
		}
	}

	void do_listmaps_hard()
	{
		if (!(LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_HARD))) return;
		LogMessage("LISTMAPS_TARGET /* TODO: $get_array */ $get_array(ARRAY_MAPLIST_HARD, LISTMAPS_COUNT)");
		LISTMAPS_COUNT += 1;
		if (LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_HARD))
		{
			ScheduleDelayedEvent(0.1, "do_listmaps_hard");
		}
		else
		{
			if (LISTMAPS_STOP != "hard")
			{
				LISTMAPS_COUNT = 0;
				LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_VHR");
				do_listmaps_vhard();
			}
			else
			{
				LISTMAPS_TARGET = "LISTMAPS_TARGET";
			}
		}
	}

	void do_listmaps_vhard()
	{
		if (!(LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_VHARD))) return;
		LogMessage("LISTMAPS_TARGET /* TODO: $get_array */ $get_array(ARRAY_MAPLIST_VHARD, LISTMAPS_COUNT)");
		LISTMAPS_COUNT += 1;
		if (LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_VHARD))
		{
			ScheduleDelayedEvent(0.1, "do_listmaps_vhard");
		}
		else
		{
			if (LISTMAPS_STOP != "vhard")
			{
				LISTMAPS_COUNT = 0;
				LogMessage("LISTMAPS_TARGET LISTMAPS_MSG_EPC");
				do_listmaps_epic();
			}
			else
			{
				LISTMAPS_TARGET = "LISTMAPS_TARGET";
			}
		}
	}

	void do_listmaps_epic()
	{
		if (!(LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_EPIC))) return;
		LogMessage("LISTMAPS_TARGET /* TODO: $get_array */ $get_array(ARRAY_MAPLIST_EPIC, LISTMAPS_COUNT)");
		LISTMAPS_COUNT += 1;
		if (LISTMAPS_COUNT < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_MAPLIST_EPIC))
		{
			ScheduleDelayedEvent(0.1, "do_listmaps_epic");
		}
		else
		{
			LISTMAPS_TARGET = "LISTMAPS_TARGET";
		}
	}

	void list_custom_maps2()
	{
		string TOTAL_MAPS = GetTokenCount(MAPS_UNCONNECTED2, ";");
		TOTAL_MAPS -= 1;
		if (!(CUSTOM_COUNT <= TOTAL_MAPS)) return;
		string CUST_MAP = GetToken(MAPS_UNCONNECTED2, CUSTOM_COUNT, ";");
		if ((ValidateMapName(CUST_MAP)))
		{
			LogMessage("L_VOTE_CALLER CUST_MAP");
		}
		if (CUSTOM_COUNT == TOTAL_MAPS)
		{
			LogMessage("L_VOTE_CALLER == == == == == == == == == == == == == == == == == =");
			LogMessage("L_VOTE_CALLER Type listmaps for a listing of maps by difficulty");
			LogMessage("L_VOTE_CALLER Or type maps * for a listing of all maps on your client");
		}
		CUSTOM_COUNT += 1;
		ScheduleDelayedEvent(0.1, "list_custom_maps2");
	}

}

}
