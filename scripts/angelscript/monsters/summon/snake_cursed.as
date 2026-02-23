#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SnakeCursed : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BITE_SOUND;
	string CYCLE_TIME;
	int DID_ALERT;
	string MY_OWNER;
	int NO_SPAWN_STUCK_CHECK;
	string NPCATK_TARGET;
	int NPC_NO_PLAYER_DMG;

	SnakeCursed()
	{
		ANIM_WALK = "snake_walk";
		ANIM_RUN = "snake_walk";
		ANIM_DEATH = "snake_diesimple";
		ANIM_IDLE = "snake_idle1";
		ANIM_ATTACK = "snake_attack1";
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 35;
		const float ATTACK_HITCHANCE = 0.8;
		const string ATTACK_DAMAGE = "$randf(5,20)";
		const string POISON_DAMAGE = "$randf(2,10)";
		const string POISON_DURATION = "$rand(10,20)";
		const string SOUND_ALERT = "monsters/snake_idle1.wav";
		const string SOUND_IDLE = "monsters/snake_idle2.wav";
		const string SOUND_ATTACK = "bullchicken/bc_bite2.wav";
		const string SOUND_PAIN1 = "monsters/snake_pain1.wav";
		const string SOUND_PAIN2 = "monsters/snake_pain2.wav";
		const string SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		const string SOUND_STRUCK = "debris/flesh2.wav";
		NO_SPAWN_STUCK_CHECK = 1;
		const string MONSTER_MODEL = "monsters/giant_rat.mdl";
		const float CYCLE_TIME_BATTLE = 0.1;
		const float CYCLE_TIME_IDLE = 0.1;
		const float CYCLE_TIME_NPC = 0.1;
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		NPC_NO_PLAYER_DMG = 1;
	}

	void OnSpawn() override
	{
		SetName("Cursed Snake");
		SetHealth(1);
		SetWidth(48);
		SetHeight(32);
		SetRoam(false);
		SetRace("human");
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 6);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(4);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("stun", 0);
		SetSolid("none");
	}

	void idle_sounds()
	{
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		Random(5, 10)("idle_sounds");
	}

	void bite1()
	{
		BITE_SOUND = 1;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		XDoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, MY_OWNER, GetOwner(), "spellcasting.affliction", "pierce", "*dmgevent:bite");
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		LogDebug("game_dodamage GetEntityName(param2)");
		if (!(BITE_SOUND)) return;
		BITE_SOUND = 0;
		if (!(RandomInt(1, 5) == 1)) return;
		EmitSound(GetOwner(), 0, SOUND_POISON, 10);
		LogDebug("dot_poison GetEntityName(param2)");
		string L_DOT = POISON_DAMAGE;
		L_DOT *= GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		L_DOT *= 0.2;
		ApplyEffect(param2, "effects/dot_poison", POISON_DURATION, MY_OWNER, L_DOT);
		ScheduleDelayedEvent(0.1, "npc_fade_away");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((IsValidPlayer(param1)))
		{
			NPCATK_TARGET = "unset";
		}
		if ((DID_ALERT)) return;
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		SetRoam(true);
		DID_ALERT = 1;
	}

	void my_target_died()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		LogDebug("game_dynamically_created GetEntityName(param1)");
		string FIRST_TARG = GetEntityProperty(MY_OWNER, "target");
		if ((IsEntityAlive(FIRST_TARG)))
		{
			if (GetRelationship(FIRST_TARG) == "enemy")
			{
			}
			npcatk_settarget(GetEntityIndex(FIRST_TARG));
		}
		ScheduleDelayedEvent(30.0, "npc_fade_away");
		SetAngles("face");
		SetAnimMoveSpeed(5.0);
		SetAnimFrameRate(1.5);
		ScheduleDelayedEvent(0.01, "set_hp");
		if ((IsEntityAlive(FIRST_TARG))) return;
		string FIRST_TARG = /* TODO: $get_insphere */ $get_insphere("monster", 1024);
		if (!(IsEntityAlive(FIRST_TARG))) return;
		if (!(GetRelationship(FIRST_TARG) == "enemy")) return;
		npcatk_target(FIRST_TARG);
	}

	void set_hp()
	{
		SetHealth(GetSkillLevel(MY_OWNER, "spellcasting.affliction"));
	}

}

}
