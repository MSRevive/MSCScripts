#pragma context server

#include "monsters/djinn_ogre_fire.as"

namespace MS
{

class DjinnOgreFireSa : CGameScript
{
	string ANIM_WARCRY;
	string NPC_ADJ_DMG_MUTLI_TOKENS;
	string NPC_ADJ_HP_MUTLI_TOKENS;
	string NPC_ADJ_TIERS;
	int NPC_BASE_EXP;
	int NPC_SELF_ADJUST;
	string SOUND_WARCRY;
	int START_SUSPEND;

	DjinnOgreFireSa()
	{
		NPC_BASE_EXP = 4000;
		NPC_SELF_ADJUST = 1;
		NPC_ADJ_TIERS = "0;500;1000;2000;3000;5000";
		NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.0;1.5;2.0;5.0;7.0;";
		NPC_ADJ_HP_MUTLI_TOKENS = "1.0;1.0;1.25;2.0;5.0;7.0;";
		START_SUSPEND = 1;
		SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		ANIM_WARCRY = "warcry";
	}

	void game_precache()
	{
		Precache("monsters/djinn_ogre_fire");
	}

	void OnSpawn() override
	{
		SetName("fire_djinn");
		SetInvincible(true);
		npcatk_suspend_ai();
	}

	void final_postspawn()
	{
		npcatk_suspend_ai();
	}

	void kill_zugdah()
	{
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		ScheduleDelayedEvent(1.0, "kill_summoner");
	}

	void kill_summoner()
	{
		PlayAnim("critical", "attack1");
		CallExternal(FindEntityByName("orc_summoner"), "ext_me_die");
		// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
		array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ScheduleDelayedEvent(1.0, "bring_the_pain");
	}

	void bring_the_pain()
	{
		UseTrigger("twal_shaman_block");
		SetRoam(true);
		SetInvincible(false);
		npcatk_resume_ai();
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
