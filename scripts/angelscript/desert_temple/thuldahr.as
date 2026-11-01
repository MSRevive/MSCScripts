#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class Thuldahr : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_KICK;
	string ANIM_KNEEL;
	string ANIM_SWING;
	int ATTACH_IDX_AXE;
	int CYCLES_ON;
	int DMG_SWING;
	int DMG_ZAP;
	int DOT_ZAP;
	float FREQ_KICK;
	float FREQ_SPECIAL;
	int KICK_ATTACK;
	string NEXT_KICK;
	int NO_STUCK_CHECKS;
	int NPC_BATTLE_ALLY;
	int NPC_FIGHTS_NPCS;
	int NPC_NO_PLAYER_DMG;
	int N_SPECIALS;
	string REPULSE_TARGETS;
	float SORC_LRESIST;
	int SORC_NO_TELE;
	float SORC_PRESIST;
	string SOUND_DRAW_WEAPON;
	string SOUND_SWING;
	string SPECIAL_DURATION;
	string ZAP_INDEXES;
	string ZAP_TARGETS;

	Thuldahr()
	{
		NPC_NO_PLAYER_DMG = 1;
		NPC_BATTLE_ALLY = 1;
		NPC_FIGHTS_NPCS = 1;
		ANIM_KNEEL = "kneel";
		ANIM_SWING = "gglowswing";
		ANIM_KICK = "kick";
		ANIM_ATTACK = "gglowswing";
		SORC_NO_TELE = 1;
		SOUND_DRAW_WEAPON = "weapons/swords/sworddraw.wav";
		SOUND_SWING = "weapons/swinghuge.wav";
		ATTACH_IDX_AXE = 2;
		FREQ_SPECIAL = Random(10.0, 20.0);
		N_SPECIALS = 3;
		FREQ_KICK = Random(10.0, 20.0);
		DMG_SWING = 400;
		DMG_ZAP = 300;
		DOT_ZAP = 100;
		SORC_LRESIST = 0.0;
		SORC_PRESIST = 1.25;
	}

	void game_precache()
	{
		Precache("weather/lightning.wav");
	}

	void orc_spawn()
	{
		SetModel("monsters/thuldahr.mdl");
		SetWidth(64);
		SetHeight(128);
		SetModelBody(2, 1);
		SetName("Thuldahr");
		SetHealth(15000);
		SetRace("human");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("poison", 1.2);
		SetDamageResistance("acid", 1.5);
		SetWidth(48);
		SetHeight(128);
		NO_STUCK_CHECKS = 1;
	}

	void npc_targetsighted()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_SPECIAL("do_special");
	}

	void do_special()
	{
		int RND_SPECIAL = RandomInt(1, N_SPECIALS);
		if (RND_SPECIAL == 1)
		{
			lstrikes_go();
			SPECIAL_DURATION = 5.0;
		}
		if (RND_SPECIAL == 2)
		{
			repulse_go();
			SPECIAL_DURATION = 5.0;
		}
		string SPECIAL_DELAY = FREQ_SPECIAL;
		SPECIAL_DELAY += SPECIAL_DURATION;
		SPECIAL_DELAY("do_special");
	}

	void lstrikes_go()
	{
		PlayAnim("critical", "warcry");
		npcatk_suspend_ai();
		ScheduleDelayedEvent(3.0, "npcatk_resume_ai");
		ZAP_TARGETS = FindEntitiesInSphere("enemy", 1024);
		if (!(ZAP_TARGETS != "none")) return;
		ZAP_INDEXES = "";
		string N_ZAP_TARGETS = GetTokenCount(ZAP_TARGETS, ";");
		for (int i = 0; i < N_ZAP_TARGETS; i++)
		{
			lstrikes_affect_targets();
		}
		ClientEvent("new", "all", "effects/sfx_multi_lightning", ZAP_INDEXES);
	}

	void lstrikes_affect_targets()
	{
		string CUR_TARG = GetToken(ZAP_TARGETS, i, ";");
		if (ZAP_INDEXES.length() > 0) ZAP_INDEXES += ";";
		ZAP_INDEXES += GetEntityIndex(CUR_TARG);
		DoDamage(CUR_TARG, "direct", DMG_ZAP, 1.0, GetOwner());
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_ZAP);
	}

	void repulse_go()
	{
		PlayAnim("critical", "warcry");
		npcatk_suspend_ai();
		ScheduleDelayedEvent(3.0, "npcatk_resume_ai");
		ClientEvent("new", "all", "effects/sfx_shock_burst", GetEntityOrigin(GetOwner()), 256, 1, Vector3(255, 255, 0));
		REPULSE_TARGETS = FindEntitiesInSphere("enemy", 512);
		if (!(REPULSE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(REPULSE_TARGETS, ";"); i++)
		{
			repulse_affect_targets();
		}
	}

	void repulse_affect_targets()
	{
		string CUR_TARG = GetToken(REPULSE_TARGETS, i, ";");
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_ZAP);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 2000, 110)));
	}

	void frame_swing()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		string AXE_POS = GetEntityProperty(GetOwner(), "attachpos");
		XDoDamage(AXE_POS, 200, DMG_SWING, 0, GetOwner(), GetOwner(), "none", "slash");
		if (!(GetGameTime() > NEXT_KICK)) return;
		ANIM_ATTACK = ANIM_KICK;
	}

	void frame_kick_start()
	{
		baseorc_yell();
	}

	void frame_kick_land()
	{
		EmitSound(GetOwner(), 0, SOUND_KICK, 10);
		KICK_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, 1.0, "blunt");
		ANIM_ATTACK = ANIM_SWING;
		NEXT_KICK = GetGameTime();
		NEXT_KICK += FREQ_KICK;
	}

}

}
