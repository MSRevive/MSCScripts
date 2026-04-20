#pragma context server

namespace MS
{

class FelewynShard : CGameScript
{
	float CHAT_DELAY;
	int CUR_ANG;
	int GAVE_SWORD;
	string GLOW_COLOR;
	string GLOW_RAD;
	string MY_SCRIPT_IDX;
	string MY_TARGET;
	int NPC_FWD_SPEED;
	string NPC_NOCLIP_DEST;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	FelewynShard()
	{
		NPC_FWD_SPEED = 5;
		CHAT_DELAY = 5.0;
	}

	void game_dynamically_created()
	{
		MY_TARGET = param1;
	}

	void OnSpawn() override
	{
		SetName("Shard of Felewyn");
		SetInvincible(true);
		SetWidth(32);
		SetHeight(128);
		SetGravity(0);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 43);
		SetIdleAnim("spin_horizontal_slow");
		PlayAnim("once", "spin_horizontal_slow");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetSolid("none");
		ClientEvent("new", "all", currentscript, GetEntityIndex(GetOwner()), Vector3(255, 255, 255), 255);
		MY_SCRIPT_IDX = "game.script.last_sent_id";
		SetMonsterClip(0);
		SetFly(true);
		SetSayTextRange(2048);
		ScheduleDelayedEvent(1.0, "do_intro");
	}

	void do_intro()
	{
		SayText(I + " am a shard of the original Felewyn Blade...");
		CHAT_DELAY("do_intro2");
	}

	void do_intro2()
	{
		SayText("One of five , scattered throughout the lands , when our goddess pierced the heart of the Doom Bringer with her sword.");
		CHAT_DELAY("do_intro3");
	}

	void do_intro3()
	{
		SayText("We await that dread day when the Lor Malgoriand is destined to return. We await that day when great warriors may find us.");
		CHAT_DELAY("do_intro4");
	}

	void do_intro4()
	{
		SayText("And lo , it has come , for you mighty warriors have defeated the mighty Undamael , a task previously believed beyond the reach of mortal hands.");
		CHAT_DELAY("do_intro5");
	}

	void do_intro5()
	{
		SayText("Although you have all fought valiantly , " + I + "am but one shard. Thus , " + I + "offer myself to the warrior known as " + GetEntityName(MY_TARGET));
		CHAT_DELAY("do_intro6");
		SetMoveDest(MY_TARGET);
		NPC_NOCLIP_DEST = MY_TARGET;
		ScheduleDelayedEvent(0.1, "basenoclip_flight");
	}

	void basenoclip_flight()
	{
		if ((GAVE_SWORD)) return;
		ScheduleDelayedEvent(0.1, "basenoclip_flight");
		string MY_ORG = GetMonsterProperty("origin");
		MY_ORG += /* TODO: $relvel */ $relvel(0, NPC_FWD_SPEED, 0);
		SetEntityOrigin(GetOwner(), MY_ORG);
		SetMoveDest(NPC_NOCLIP_DEST);
		string TARG_ORG = GetEntityOrigin(MY_TARGET);
		if (!(Distance(MY_ORG, TARG_ORG) < 30)) return;
		GAVE_SWORD = 1;
		SetProp(GetOwner(), "renderamt", 0);
		Effect("screenfade", MY_TARGET, 3, 1, Vector3(255, 255, 255), 255, "fadein");
		int FRAG_ELM = RandomInt(1, 5);
		if (FRAG_ELM == 1)
		{
			// TODO: offer MY_TARGET swords_fshard1
		}
		if (FRAG_ELM == 2)
		{
			// TODO: offer MY_TARGET swords_fshard2
		}
		if (FRAG_ELM == 3)
		{
			// TODO: offer MY_TARGET swords_fshard3
		}
		if (FRAG_ELM == 4)
		{
			// TODO: offer MY_TARGET swords_fshard4
		}
		if (FRAG_ELM == 5)
		{
			// TODO: offer MY_TARGET swords_fshard5
		}
		SetPlayerQuestData(MY_TARGET, "f");
		ShowHelpTip(GetOwner(), "generic", "One Time Quest (Shard of Felewyn) Completed", "The Felwyn Shard has been acquired.|Quest Complete.");
		SetModel("none");
		ClientEvent("remove", "all", MY_SCRIPT_IDX);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		CUR_ANG = 0;
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		GLOW_RAD = param3;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		int RND_R = RandomInt(0, 255);
		int RND_G = RandomInt(0, 255);
		int RND_B = RandomInt(0, 255);
		Vector3 RND_COLOR = Vector3(RND_R, RND_G, RND_B);
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, RND_COLOR, 1.0);
		CUR_ANG += 18;
		if (CUR_ANG > 359)
		{
			CUR_ANG -= 359;
		}
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ANG, 0), Vector3(0, 32, 0));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", L_POS, "glow_sprite");
	}

	void glow_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", -1.1);
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
	}

}

}
