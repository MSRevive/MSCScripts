#pragma context server

namespace MS
{

class Devcmds : CGameScript
{
	void game_playercmd()
	{
		if (param1 == "dev_on")
		{
			if (param2 == "wargwable")
			{
			}
			LogMessage("ent_currentplayer Developer Mode ON");
			SendInfoMsg("all", "DEVELOPER MODE Developer mode is on.");
			SetGlobalVar("G_DEVELOPER_MODE", 1);
		}
		else
		{
			if (param1 == "dev_off")
			{
				if ((G_DEVELOPER_MODE))
				{
				}
				LogMessage("ent_currentplayer Developer Mode OFF");
				SendInfoMsg("all", "DEVELOPER MODE Developer mode is off.");
				SetGlobalVar("G_DEVELOPER_MODE", 0);
			}
		}
	}

	void dev_command()
	{
		if (("game.central")) return;
		if (!(G_DEVELOPER_MODE)) return;
		/* TODO: $pass */ $pass(param1)(/* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void mp3()
	{
		// TODO: playmp3 PARAM1 PARAM2 PARAM3
	}

	void tele()
	{
		string X_DEST = param1;
		string Y_DEST = param2;
		string Z_DEST = param3;
		string L_STR = "Teleportion to:";
		LogMessage("ent_currentplayer L_STR");
		SetEntityOrigin("ent_currentplayer", Vector3(X_DEST, Y_DEST, Z_DEST));
	}

	void teledest()
	{
		string L_ENT = FindEntityByName(param1);
		if (((L_ENT !is null)))
		{
			SetEntityOrigin("ent_currentplayer", GetEntityOrigin(L_ENT));
		}
	}

	void slayall()
	{
		string RACE_PARAMS = param1;
		if ((RACE_PARAMS))
		{
			LogMessage("ent_currentplayer Slaying Bad Guys");
			CallExternal("all", "npc_suicide", "only_bad");
		}
		else
		{
			LogMessage("ent_currentplayer Slaying all");
			CallExternal("all", "npc_suicide");
		}
	}

	void usetrig()
	{
		LogMessage("ent_currentplayer Fire map event: PARAM1");
		UseTrigger(param1);
	}

	void dumpquest()
	{
		string L_QUEST = param1;
		LogMessage("ent_currentplayer Quest L_QUEST is: GetPlayerQuestData("ent_currentplayer", L_QUEST)");
	}

	void newnpc()
	{
		LogMessage("Got command newnpc");
		string SPAWN_POINT = GetEntityOrigin("ent_currentplayer");
		string MY_ANGLES = GetEntityAngles("ent_currentplayer");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SpawnNPC(param1, SPAWN_POINT, ScriptMode::Legacy); // params: param2, param3, param4, param5, param6, param7, param8
	}

	void newdyn()
	{
		LogMessage("ent_currentplayer Got command newdyn");
		string L_IDX = param1;
		if ((L_IDX).findFirst("PARAM") == 0)
		{
			int L_IDX = 0;
		}
		string L_SCRIPT = GetToken(GetCvar("ms_dynamicnpc"), L_IDX, ";");
		newnpc(L_SCRIPT, /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void newitem()
	{
		LogMessage("ent_currentplayer Got command newitem");
		string SPAWN_POINT = GetEntityOrigin("ent_currentplayer");
		string MY_ANGLES = GetEntityAngles("ent_currentplayer");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 64, 0));
		SpawnItem(param1, SPAWN_POINT);
	}

	void eventtarg()
	{
		CallExternal(GetEntityProperty("ent_currentplayer", "target"), "PARAM1", /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void eventme()
	{
		CallExternal("ent_currentplayer", "PARAM1", /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void eventplayers()
	{
		CallExternal("players", "PARAM1", /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void eventgm()
	{
		CallExternal(GAME_MASTER, "PARAM1", /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void eventall()
	{
		CallExternal("all", "PARAM1", /* TODO: $pass */ $pass(param2), /* TODO: $pass */ $pass(param3), /* TODO: $pass */ $pass(param4), /* TODO: $pass */ $pass(param5), /* TODO: $pass */ $pass(param6), /* TODO: $pass */ $pass(param7), /* TODO: $pass */ $pass(param8));
	}

	void blamb()
	{
		int L_RADIUS = 300;
		int L_DMG = 300;
		string L_TYPE = "dark_effect";
		if ((param1).findFirst("PARAM") == 0)
		{
			string L_RADIUS = param1;
		}
		if ((param2).findFirst("PARAM") == 0)
		{
			string L_DMG = param2;
		}
		if ((param3).findFirst("PARAM") == 0)
		{
			string L_TYPE = param3;
		}
		LogMessage("ent_currentplayer Blamb! AOE: L_RADIUS DMG: L_DMG Type: L_TYPE");
		XDoDamage(GetEntityOrigin("ent_currentplayer"), L_RADIUS, L_DMG, 0, GetEntityIndex("ent_currentplayer"), GetEntityIndex("ent_currentplayer"), "none", L_TYPE, "none");
	}

	void setquest()
	{
		string L_QUEST = param1;
		string L_DATA = param2;
		LogMessage("ent_currentplayer Setting Quest: L_QUEST to L_DATA");
		SetPlayerQuestData(GetEntityIndex("ent_currentplayer"), L_QUEST);
	}

	void getquest()
	{
		string L_QUEST_DATA = GetPlayerQuestData("ent_currentplayer", param1);
		LogMessage("ent_currentplayer L_QUEST_DATA");
	}

	void setgold()
	{
		CallExternal("ent_currentplayer", "ext_setgold", /* TODO: $pass */ $pass(param1));
	}

	void addhp()
	{
		CallExternal("ent_currentplayer", "give_hp", /* TODO: $pass */ $pass(param1));
	}

	void addmp()
	{
		CallExternal("ent_currentplayer", "give_mp", /* TODO: $pass */ $pass(param1));
	}

	void rat()
	{
		LogMessage("ent_currentplayer Spawning Rat");
		string SPAWN_POINT = GetEntityOrigin("ent_currentplayer");
		string MY_ANGLES = GetEntityAngles("ent_currentplayer");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SpawnNPC("monsters/giantrat", SPAWN_POINT, ScriptMode::Legacy);
	}

	void skele()
	{
		LogMessage("ent_currentplayer Spawning skele");
		string SPAWN_POINT = GetEntityOrigin("ent_currentplayer");
		string MY_ANGLES = GetEntityAngles("ent_currentplayer");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 128, 0));
		SpawnNPC("monsters/skeleton", SPAWN_POINT, ScriptMode::Legacy);
	}

	void teleforward()
	{
		string DIST_FORWARD = param1;
		LogMessage("ent_currentplayer Teleporting Forward DIST_FORWARD units");
		string MY_POS = GetEntityOrigin("ent_currentplayer");
		string MY_ANG = GetEntityProperty("ent_currentplayer", "viewangles");
		MY_POS += /* TODO: $relpos */ $relpos(MY_ANG, Vector3(0, DIST_FORWARD, 0));
		SetEntityOrigin("ent_currentplayer", MY_POS);
	}

	void effectme()
	{
		LogMessage("ent_currentplayer Applying effect, PARAM1 to self.");
		ApplyEffect("ent_currentplayer", param1, param2, param3, param4, param5, param6);
	}

	void effectmestack()
	{
		LogMessage("ent_currentplayer Applying stacking effect, PARAM1 to self.");
		ApplyEffect("ent_currentplayer", param1, param2, param3, param4, param5, param6);
	}

	void effecttarg()
	{
		LogMessage("ent_currentplayer Applying effect, PARAM1 to target, GetEntityName(GetEntityProperty("ent_currentplayer", "target"))");
		ApplyEffect(GetEntityProperty("ent_currentplayer", "target"), param1, param2, param3, param4, param5, param6);
	}

	void effecttargstack()
	{
		LogMessage("ent_currentplayer Applying effect, PARAM1 to target, GetEntityName(GetEntityProperty("ent_currentplayer", "target"))");
		ApplyEffect(GetEntityProperty("ent_currentplayer", "target"), param1, param2, param3, param4, param5, param6);
	}

	void testdmg()
	{
		LogMessage("ent_currentplayer Damage mult for PARAM1 is /* TODO: $get_takedmg */ $get_takedmg("ent_currentplayer", param1)");
	}

	void throw()
	{
		CallExternal("ent_currentplayer", "ext_tossprojectile", "proj_fire_ball", "view", "none", 6000, 10, 0, "none");
	}

}

}
