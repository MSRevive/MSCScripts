#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class TestNpc : CGameScript
{
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int FIGHT_STARTED;
	int KEEP_PLAYERS_WARM_ACTIVE;
	string MY_LOC;
	string PLAYER_LIST;

	TestNpc()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		const string NPC_MODEL = "npc/balancepriest1.mdl";
		Precache(NPC_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Ancient Jailer");
		SetRace("beloved");
		SetHealth(1000);
		SetModel(NPC_MODEL);
		SetWidth(32);
		SetHeight(72);
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetInvincible(true);
		npcatk_suspend_ai();
		FIGHT_STARTED = 0;
		KEEP_PLAYERS_WARM_ACTIVE = 1;
		CatchSpeech("begin_fight", "start");
	}

	void begin_fight()
	{
		if (FIGHT_STARTED == 0)
		{
			MY_LOC = GetEntityOrigin(GetOwner());
			CallExternal("ent_creationowner", "begin_float");
			FIGHT_STARTED += 1;
			keep_players_warm_loop();
			SayText("Heroes! Stay near me and I will protect you from his ice!");
		}
	}

	void res_circle()
	{
		ClientEvent("new", "all", "effects/sfx_seal", MY_LOC, 172, 26, 3);
		string L_FX_ORIGIN = MY_LOC;
		L_FX_ORIGIN = "z";
	}

	void keep_players_warm_loop()
	{
		if (!(KEEP_PLAYERS_WARM_ACTIVE)) return;
		ScheduleDelayedEvent(3.0, "keep_players_warm_loop");
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			check_can_warm_players();
		}
		res_circle();
	}

	void check_can_warm_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (GetEntityRange(CUR_TARG) < 256)
		{
			CallExternal(CUR_TARG, "ext_register_element", "warm", "cold", 99);
			SendColoredMessage(CUR_TARG, "You are now protected from ICE!");
		}
		else
		{
			CallExternal(CUR_TARG, "ext_register_element", "warm", "remove");
			SendColoredMessage(CUR_TARG, "You are no longer protected from ICE!");
		}
	}

}

}
