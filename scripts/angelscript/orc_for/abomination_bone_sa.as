#pragma context server

#include "monsters/abomination_bone.as"

namespace MS
{

class AbominationBoneSa : CGameScript
{
	string FLING_IDX;
	int INTRO_DONE;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_SELF_ADJUST;

	AbominationBoneSa()
	{
		const int MONSTER_HP = 20000;
		const int NPC_BASE_EXP = 7000;
		const int DOT_BREATH = 100;
		const int DMG_BITE_SHORT = 150;
		const int DMG_BITE_LONG = 350;
		const int DMG_LSHIELD = 150;
		NPC_SELF_ADJUST = 1;
		const string NPC_ADJ_TIERS = "0;500;1000;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.0;1.0;1.0;1.25;2.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;1.0;1.0;1.0;1.5;2.0;";
		const int START_SUSPEND = 1;
		NO_SPAWN_STUCK_CHECK = 1;
		const float NPC_BOSS_REGEN_RATE = 0.03;
		const float NPC_BOSS_RESTORATION = 0.25;
	}

	void game_precache()
	{
		Precache("monsters/abomination_bone");
		Precache("monsters/Orc.mdl");
	}

	void OnSpawn() override
	{
		SetName("bone_abomination");
	}

	void final_adj()
	{
		if (NPC_ADJ_LEVEL < 5)
		{
			SetName("Lesser Bone Abomination");
		}
		else
		{
			SetName("Bone Abomination");
		}
	}

	void eat_me()
	{
		PlayAnim("critical", "grab_fling");
	}

	void frame_grab()
	{
		DeleteEntity(FindEntityByName("orc_summoner"));
		ClientEvent("new", "all", "orc_for/orc_summoner_slaughter_cl", GetEntityIndex(GetOwner()));
		FLING_IDX = "game.script.last_sent_id";
		EmitSound(GetOwner(), 0, "debris/bustflesh1.wav", 10);
	}

	void frame_fling()
	{
		UseTrigger("twal_shaman_block");
		string FLING_VEL = /* TODO: $relvel */ $relvel(-400, 400, 110);
		ClientEvent("update", "all", FLING_IDX, "do_fling", FLING_VEL);
		ScheduleDelayedEvent(1.0, "intro_done");
		EmitSound(GetOwner(), 0, "debris/bustflesh2.wav", 10);
	}

	void intro_done()
	{
		npcatk_resume_ai();
		SetRoam(true);
		SetInvincible(false);
		INTRO_DONE = 1;
		ScheduleDelayedEvent(4.0, "start_da_musak");
	}

	void start_da_musak()
	{
		GetAllPlayers(PLAYER_LIST);
		GetTokenCount(PLAYER_LIST, ";")("start_musak");
		ScheduleDelayedEvent(45.0, "start_da_musak2");
	}

	void start_musak()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (GetEntityRange(CUR_TARG) < 768)
		{
			CallExternal(CUR_TARG, "ext_orcfor_boss_musak", 1);
		}
	}

	void start_da_musak2()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(80.0, "start_da_musak2");
		if (!(m_hAttackTarget != "unset")) return;
		GetAllPlayers(PLAYER_LIST);
		GetTokenCount(PLAYER_LIST, ";")("start_musak2");
	}

	void start_musak2()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (GetEntityRange(CUR_TARG) < 768)
		{
			CallExternal(CUR_TARG, "ext_orcfor_boss_musak", 2);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal("players", "ext_orcfor_boss_musak", 3, GetEntityOrigin(GetOwner()));
	}

}

}
