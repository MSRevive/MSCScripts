#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"

namespace MS
{

class ZyEye : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string BEAM_DAMAGE;
	int IS_UNHOLY;
	string MY_OWNER;
	int NPC_GIVE_EXP;
	int RENDER_AMT;

	ZyEye()
	{
		IS_UNHOLY = 1;
		ANIM_DEATH = "spin_vertical_norm";
		ANIM_IDLE = "spin_horizontal_slow";
		ANIM_WALK = "spin_horizontal_slow";
		ANIM_RUN = "spin_horizontal_slow";
		ANIM_ATTACK = "spin_horizontal_slow";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const int SHOCK_DMG = 100;
		const float SHOCK_DUR = 5.0;
		const int RUN_REQ = 30;
		NPC_GIVE_EXP = 200;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		if ((false))
		{
		}
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 64, 3.0, 3.0);
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ApplyEffect(m_hLastSeen, "effects/dot_lightning", SHOCK_DUR, GetEntityIndex(GetOwner()), BEAM_DAMAGE);
		npcatk_flee(m_hLastSeen, 9999, 10.0);
		string BEAM_START = GetMonsterProperty("origin");
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "end", "lgtning.spr", 30, BEAM_START, m_hLastSeen, 0, Vector3(255, 255, 255), 200, 30, 1.5);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.0);
		if (RENDER_AMT == 255)
		{
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		SetHealth(param2);
		BEAM_DAMAGE = param3;
		npcatk_flee(MY_OWNER, 9999, 5.0);
	}

	void OnSpawn() override
	{
		SetName("Eye of Zygoli");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 10);
		SetIdleAnim("spin_horizontal_slow");
		SetMoveAnim("spin_horizontal_slow");
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("pierce", 2.0);
		SetRace("demon");
		SetInvincible(true);
		RENDER_AMT = 1;
		ScheduleDelayedEvent(0.1, "remove_invuln");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		npcatk_suspend_ai();
	}

	void remove_invuln()
	{
		SetInvincible(false);
		fade_in();
		EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
	}

	void fade_in()
	{
		if (!(RENDER_AMT < 255)) return;
		RENDER_AMT += 1;
		ScheduleDelayedEvent(0.1, "fade_in");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_AMT);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (param1 > RUN_REQ)
		{
			npcatk_flee(m_hLastStruck, 9999, 15.0);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(MY_OWNER, "ext_eye_died");
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()));
	}

	void zygoli_died()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
