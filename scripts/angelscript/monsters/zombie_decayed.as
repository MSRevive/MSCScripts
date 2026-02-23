#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ZombieDecayed : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_DEATH5;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int DID_WARCRY;
	int DISEASE_DELAY;
	int FLINCH_CHANCE;
	int I_ATTACKING;
	int I_DISEASE;
	int NPC_GIVE_EXP;
	int PAIN_DELAY;

	ZombieDecayed()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_DISEASE = "attack2";
		ANIM_ATTACK = ANIM_SWIPE;
		ANIM_IDLE = "idle1";
		ANIM_DEATH1 = "diesimple";
		ANIM_DEATH2 = "diebackward";
		ANIM_DEATH3 = "dieheadshot";
		ANIM_DEATH4 = "dieheadshot2";
		ANIM_DEATH5 = "dieforward";
		ANIM_DEATH = ANIM_DEATH1;
		ANIM_FLINCH = "llflinch";
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 30;
		const string SOUND_IDLE1 = "monsters/zombie1/zo_idle1.wav";
		const string SOUND_IDLE2 = "monsters/zombie1/zo_idle2.wav";
		const string SOUND_IDLE3 = "monsters/zombie1/zo_idle3.wav";
		const string SOUND_IDLE4 = "monsters/zombie1/zo_idle4.wav";
		const string SOUND_PAIN1 = "monsters/zombie1/zo_pain1.wav";
		const string SOUND_PAIN2 = "monsters/zombie1/zo_pain2.wav";
		const string SOUND_PAIN3 = "monsters/zombie1/zo_pain3.wav";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_WARCRY1 = "monsters/zombie1/zo_alert10.wav";
		const string SOUND_WARCRY2 = "monsters/zombie1/zo_alert20.wav";
		const string SOUND_WARCRY3 = "monsters/zombie1/zo_alert30.wav";
		const string SOUND_RAGE1 = "monsters/zombie1/zo_attack1.wav";
		const string SOUND_RAGE2 = "monsters/zombie1/zo_attack2.wav";
		const string SOUND_DEATH = "monsters/zombie1/hitground.wav";
		const string SOUND_MISS1 = "zombie/claw_miss1.wav";
		const string SOUND_MISS2 = "zombie/claw_miss2.wav";
		const string SOUND_HIT1 = "zombie/claw_strike1.wav";
		const string SOUND_HIT2 = "zombie/claw_strike2.wav";
		Precache(SOUND_DEATH);
		const string ATTACK_DAMAGE = Random(3, 5);
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 130;
		const int ATTACK_HITCHANCE = 60;
		ATTACK_MOVERANGE = 40;
		const float DISEASE_FREQ = 10.0;
		const string DISEASE_DMG = Random(0.25, 2);
		const string DISEASE_DUR = RandomInt(10, 20);
		NPC_GIVE_EXP = 20;
		const string MONSTER_MODEL = "monsters/decayed_zombie.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Decayed Zombie");
		SetModel(MONSTER_MODEL);
		string MAX_HP = RandomInt(30, 100);
		SetHealth(MAX_HP);
		SetWidth(20);
		SetHeight(60);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetRace("undead");
		SetHearingSensitivity(7);
		if (!(ME_NO_WANDER))
		{
			SetRoam(true);
		}
		if ((ME_NO_WANDER))
		{
			SetRoam(false);
		}
		SetGold(RandomInt(0, 3));
		SetDamageResistance("holy", 4.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 2.0);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("slash", 1.25);
		string PICK_DEATH = RandomInt(1, 5);
		if (PICK_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (PICK_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (PICK_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (PICK_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (PICK_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
		ScheduleDelayedEvent(1.0, "idle_sounds");
		CatchSpeech("debug_props", "debug");
	}

	void debug_props()
	{
		SayText("My Atkrange ATTACK_RANGE vs. MIN_ATTACK_RANGE against game.monster.height");
	}

	void npc_selectattack()
	{
		if ((DISEASE_DELAY)) return;
		DISEASE_DELAY = 1;
		DISEASE_FREQ("reset_disease_delay");
		ANIM_ATTACK = ANIM_DISEASE;
	}

	void reset_disease_delay()
	{
		DISEASE_DELAY = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		DISEASE_DELAY = 1;
		DISEASE_FREQ("reset_disease_delay");
		// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2, SOUND_WARCRY3
		array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2, SOUND_WARCRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_1()
	{
		I_ATTACKING = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
	}

	void attack_2()
	{
		I_ATTACKING = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
		I_DISEASE = 1;
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void game_dodamage()
	{
		if (!(I_ATTACKING)) return;
		I_ATTACKING = 0;
		if ((param1))
		{
			// PlayRandomSound from: SOUND_HIT1, SOUND_HIT2
			array<string> sounds = {SOUND_HIT1, SOUND_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_MISS1, SOUND_MISS2
			array<string> sounds = {SOUND_MISS1, SOUND_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(I_DISEASE)) return;
		I_DISEASE = 0;
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison", DISEASE_DUR, GetEntityIndex(GetOwner()), DISEASE_DMG, "none");
	}

	void idle_sounds()
	{
		if (m_hAttackTarget == "unset")
		{
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (m_hAttackTarget != "unset")
		{
			// PlayRandomSound from: SOUND_RAGE1, SOUND_RAGE2
			array<string> sounds = {SOUND_RAGE1, SOUND_RAGE2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		string NEXT_SOUND = Random(4, 15);
		NEXT_SOUND("idle_sounds");
	}

	void walk_step1()
	{
		EmitSound(GetOwner(), 0, "common/npc_step1.wav", 10);
	}

	void walk_step2()
	{
		EmitSound(GetOwner(), 0, "common/npc_step3.wav", 10);
	}

	void walk_step3()
	{
		EmitSound(GetOwner(), 0, "common/npc_step2.wav", 10);
	}

	void walk_step4()
	{
		EmitSound(GetOwner(), 0, "common/npc_step4.wav", 10);
	}

	void walk_step5()
	{
		EmitSound(GetOwner(), 0, "common/npc_step1.wav", 10);
	}

	void walk_step6()
	{
		EmitSound(GetOwner(), 0, "common/npc_step3.wav", 10);
	}

	void cycle_up()
	{
		if ((ME_NO_WANDER))
		{
			SetRoam(true);
		}
	}

	void cycle_down()
	{
		DID_WARCRY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(PAIN_DELAY))
		{
			ScheduleDelayedEvent(0.1, "pain_sound");
		}
	}

	void pain_sound()
	{
		PAIN_DELAY = 1;
		string Random(5, 10) = NEXT_PAIN;
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_PAIN("pain_delay_reset");
	}

	void pain_delay_reset()
	{
		PAIN_DELAY = 0;
	}

	void OnFlinch()
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
