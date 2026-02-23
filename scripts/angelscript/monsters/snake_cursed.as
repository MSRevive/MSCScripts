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
	int ATTACK_DELAY;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BITE_SOUND;
	int DID_ALERT;
	int IS_UNHOLY;
	int NO_SPAWN_STUCK_CHECK;
	string NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;

	SnakeCursed()
	{
		IS_UNHOLY = 1;
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "diesimple";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		ATTACK_MOVERANGE = 35;
		const float ATTACK_HITCHANCE = 0.8;
		const string ATTACK_DAMAGE = "$randf(5,20)";
		const string POISON_DAMAGE = "$randf(10,50)";
		const string POISON_DURATION = "$rand(10,20)";
		const string SOUND_ALERT = "monsters/snake_idle1.wav";
		const string SOUND_IDLE = "monsters/snake_idle2.wav";
		const string SOUND_ATTACK = "bullchicken/bc_bite2.wav";
		const string SOUND_PAIN1 = "monsters/snake_pain1.wav";
		const string SOUND_PAIN2 = "monsters/snake_pain2.wav";
		const string SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		const string SOUND_STRUCK = "debris/flesh2.wav";
		NPC_GIVE_EXP = 5;
		NO_SPAWN_STUCK_CHECK = 1;
		const string MONSTER_MODEL = "monsters/csnake.mdl";
	}

	void OnSpawn() override
	{
		SetName("Cursed Snake");
		SetHealth(30);
		SetWidth(48);
		SetHeight(32);
		SetRoam(false);
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetHearingSensitivity(4);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
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
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner());
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(BITE_SOUND)) return;
		BITE_SOUND = 0;
		if (!(RandomInt(1, 5) == 1)) return;
		EmitSound(GetOwner(), 0, SOUND_POISON, 10);
		ApplyEffect(param1, "effects/dot_poison", POISON_DURATION, GetEntityIndex(GetOwner()), POISON_DAMAGE);
		npc_fade_away();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((DID_ALERT)) return;
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		SetRoam(true);
		DID_ALERT = 1;
	}

	void my_target_died()
	{
		npc_fade_away();
	}

	void npcatk_attack()
	{
		NPC_DELAYING_UNSTUCK = NPC_UNSTUCK_DELAY;
		if ((ATTACK_DELAY)) return;
		PlayAnim("critical", ANIM_ATTACK);
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 10);
		ATTACK_DELAY = 1;
		ScheduleDelayedEvent(1.0, "reset_attack_delay");
	}

	void reset_attack_delay()
	{
		ATTACK_DELAY = 0;
	}

}

}
