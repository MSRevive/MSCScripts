#pragma context server

namespace MS
{

class Maps : CGameScript
{
	Maps()
	{
		SetGlobalVar("MAPS_HIDDEN", "challs;keledrosruins;nashalrath;undermines;underpath;undercliffs");
		SetGlobalVar("MAPS_MAZE", "goblintown");
		SetGlobalVar("MAPS_GAUNTLET", "highlands_msc;lostcastle_msc;skycastle;orcplace2_beta;ww2b;ww3d;old_helena;lodagond-2;lodagond-3;lodagond-4;nashalrath;the_wall2");
		SetGlobalVar("MAPS_GAUNTLET_START", "lowlands;lodagond-1;ww1;the_wall;old_helena;nashalrath");
		SetGlobalVar("MAPS_UNCONNECTEDS", 2);
		SetGlobalVar("MAPS_UNCONNECTED1", "ms_quest;char_recover;guildmaster;cleicert;foutpost;lodagond-1;island1;lostcaverns;ms_underworldv2;orc_arena;pvp_archery;pvp_arena;unrest;unrest2;unrest2_beta1;ww1;pvp_canyons;canyons;ocean_crossing;smugglers_cove;isles_dread1;");
		SetGlobalVar("MAPS_UNCONNECTED2", "kfortress;gertenheld_cave;islesofdread2_old;the_wall;catacombs;bloodshrine;ms_soccer;shender_east;nightmare_edana;m2_quest;gertenhell");
		SetGlobalVar("G_NOT_ON_FN", "test_scripts");
		if (/* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_RMAPS) == -1)
		{
			CreateGlobalArray("G_ARRAY_RMAPS");
			CreateGlobalArray("G_ARRAY_RMAPS_TYPES");
			CreateGlobalArray("G_ARRAY_RMAPS_CONNECTORS");
			GlobalArrayAdd("G_ARRAY_RMAPS", "highlands_msc");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lowlands;Curse of the Bear Gods");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lostcastle_msc;lowlands");
			GlobalArrayAdd("G_ARRAY_RMAPS", "lostcastle_msc");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lowlands");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "highlands_msc;skycastle;orcplace2_beta");
			GlobalArrayAdd("G_ARRAY_RMAPS", "skycastle");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lowlands;Curse of the Bear Gods");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lostcastle_msc");
			GlobalArrayAdd("G_ARRAY_RMAPS", "orcplace2_beta");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lowlands;Curse of the Bear Gods");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lostcastle_msc");
			GlobalArrayAdd("G_ARRAY_RMAPS", "ww2b");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;ww1;World Walker");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "ww1");
			GlobalArrayAdd("G_ARRAY_RMAPS", "ww3d");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;ww1;World Walker");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "ww2b");
			GlobalArrayAdd("G_ARRAY_RMAPS", "old_helena");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "helena");
			GlobalArrayAdd("G_ARRAY_RMAPS", "lodagond-2");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lodagond-1;The Lodagond Skyfortress");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lodagond-1");
			GlobalArrayAdd("G_ARRAY_RMAPS", "lodagond-3");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lodagond-1;The Lodagond Skyfortress");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lodagond-2");
			GlobalArrayAdd("G_ARRAY_RMAPS", "lodagond-4");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;lodagond-1;The Lodagond Skyfortress");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "lodagond-3");
			GlobalArrayAdd("G_ARRAY_RMAPS", "challs");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "sfor;ms_wicardoven");
			GlobalArrayAdd("G_ARRAY_RMAPS", "keledrosruins");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "keledrosprelude2");
			GlobalArrayAdd("G_ARRAY_RMAPS", "nashalrath");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "daragoth");
			GlobalArrayAdd("G_ARRAY_RMAPS", "goblintown");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "mscave");
			GlobalArrayAdd("G_ARRAY_RMAPS", "the_wall2");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "series;the_wall;The Wall (West)");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "the_wall;fcaverns");
			GlobalArrayAdd("G_ARRAY_RMAPS", "undermines");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "underpath;underkeep;undercrypt");
			GlobalArrayAdd("G_ARRAY_RMAPS", "underpath");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "undercliffs;gatecity;undercaves;undermines;underkeep;understream");
			GlobalArrayAdd("G_ARRAY_RMAPS", "undercliffs");
			GlobalArrayAdd("G_ARRAY_RMAPS_TYPES", "hidden");
			GlobalArrayAdd("G_ARRAY_RMAPS_CONNECTORS", "underpath;underkeep;bloodrose");
		}
	}

}

}
