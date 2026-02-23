#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Guildmaster : CGameScript
{
	int CANCHAT;
	string CUR_SKILL;
	string NERF_PLR;
	string PROP_TOKENS;
	int PROXY_SPOKE;
	string SKILL_TOKENS;

	Guildmaster()
	{
		if (!(PROXY_SPOKE))
		{
		}
		if (CanSee("player", 512) == 1)
		{
			say_hi();
		}
		PROXY_SPOKE = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetGold(0);
		SetName("Fenrin , the Crest Keeper");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/balancepriest1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		SetSayTextRange(1024);
		CatchSpeech("say_hi", "hello");
		CatchSpeech("cheater_guessing", "edana");
		CatchSpeech("give_orochi", "krizarid");
		Precache("npc/balancepriest1.mdl");
		Precache("voices/human/male_idle2.wav");
		PROXY_SPOKE = 0;
		ScheduleDelayedEvent(0.1, "check_central");
	}

	void check_central()
	{
		if (!("game.central" == 0)) return;
		if ((G_DEVELOPER_MODE)) return;
		SendInfoMsg("all", "FENRIN_FN_ONLY You must be connected to [FN] to use the Guild Master");
		DeleteEntity(GetOwner());
	}

	void say_hi()
	{
		SetVolume(10);
		SayText("Greetings , I am Fenrin , the Master of Guilds.");
		PlayAnim("once", "talkleft");
		ScheduleDelayedEvent(5, "say_hi2");
	}

	void say_hi2()
	{
		if ((GetEntityName("ent_lastspoke")).findFirst("dridje") >= 0)
		{
			if (("game.central"))
			{
			}
			hi_dridge();
			return;
		}
		SetVolume(10);
		SayText("Or I was , now I just kinda sit here looking over this gaudy map fragment.");
		ScheduleDelayedEvent(5.0, "say_hi3");
	}

	void say_hi3()
	{
		PlayAnim("once", "retina");
		SayText("By the gods , this is gaudy. Who built this monstrosity anyways?");
		ScheduleDelayedEvent(5.0, "say_hi4");
	}

	void say_hi4()
	{
		SayText("Oh , if you re here for a crest, that system is changed. You should hit up the forums and send Thothie a PM.");
		ScheduleDelayedEvent(5.0, "say_hi5");
	}

	void say_hi5()
	{
		PlayAnim("once", "nod");
		SayText("The forums being at www.msremake.com , of course.");
	}

	void hi_dridge()
	{
		PlayAnim("once", "nod");
		SayText("Oh hi there Dridje...");
		ScheduleDelayedEvent(3.0, "hi_dridge2");
	}

	void hi_dridge2()
	{
		PlayAnim("once", "retina");
		NERF_PLR = GetEntityIndex("ent_lastspoke");
		SayText("Enjoy your rollback.");
		SKILL_TOKENS = "archery;bluntarms;axehandling;swordsmanship;polearms;smallarms;spellcasting";
		PROP_TOKENS = "proficiency;power;balance";
		for (int i = 0; i < GetTokenCount(SKILL_TOKENS, ";"); i++)
		{
			do_nerf();
		}
	}

	void do_nerf()
	{
		string CUR_IDX = i;
		CUR_SKILL = GetToken(SKILL_TOKENS, CUR_IDX, ";");
		for (int i = 0; i < GetTokenCount(PROP_TOKENS, ";"); i++)
		{
			do_nerf_props();
		}
	}

	void do_nerf_props()
	{
		string CUR_SKILL_NAME = CUR_SKILL;
		CUR_SKILL_NAME += ".";
		CUR_SKILL_NAME += GetToken(PROP_TOKENS, i, ";");
		string L_GRAB_SKILL = "skill.";
		L_GRAB_SKILL += CUR_SKILL_NAME;
		string L_SKILL_LEVEL = GetEntityProperty(NERF_PLR, "l_grab_skill");
		L_SKILL_LEVEL *= 0.5;
	}

}

}
