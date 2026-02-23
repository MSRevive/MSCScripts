#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class TrollFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string DROP_ITEM1;
	string DROP_ITEM1_CHANCE;
	int HUNT_AGRO;
	int I_AM_TURNABLE;
	int I_R_SUMMONED;
	int MOVE_RANGE;
	string MY_MASTER;
	int NPC_GIVE_EXP;
	string PUSH_VEL;
	string STEP_COUNT;

	TrollFire()
	{
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "monsters/troll/trollpain.wav";
		const string SOUND_STRUCK3 = "monsters/troll/trollpain.wav";
		const string SOUND_PAIN = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK1 = "monsters/troll/trollattack.wav";
		const string SOUND_ATTACK2 = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK = "monsters/troll/trollidle.wav";
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		const string SOUND_IDLE = "monsters/troll/trollidle.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 35;
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "dieheadshot2";
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		MOVE_RANGE = 100;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		const string FIRE_DAMAGE = "$rand(20,100)";
		const string ATTACK1_DAMAGE = "$randf(30,80)";
		const string ATTACK2_DAMAGE = "$randf(100,300)";
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetWidth(72);
		SetHeight(135);
		SetRace("demon");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		SetHealth(1000);
		SetName("Efreeti");
		SetRoam(true);
		NPC_GIVE_EXP = 200;
		SetDamageResistance("all", 1.0);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("cold", 1.75);
		SetDamageResistance("fire", 0.0);
		SetHearingSensitivity(8);
		SetModel("monsters/firetroll.mdl");
		if (RandomInt(1, 32) < "game.playersnb")
		{
			DROP_ITEM1 = "item_eh";
			DROP_ITEM1_CHANCE = 100;
		}
		else
		{
			if (StringToLower(GetMapName()) == "phlames")
			{
			}
			DROP_ITEM1 = "item_eh";
			DROP_ITEM1_CHANCE = 100;
		}
		Effect("glow", GetOwner(), Vector3(255, 64, 48), 512, 3, 3);
		troll_spawn();
	}

	void attack_1()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK1_DAMAGE, 0.75, "slash");
		if (RandomInt(0, 3) == 0)
		{
			ANIM_ATTACK = "attack2";
		}
		if ((RandomInt(1, 8) + "=" + 1))
		{
			ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 10, GetEntityIndex(GetOwner()), FIRE_DAMAGE);
		}
		if ((RandomInt(1, 20) + "=" + 1))
		{
			SetVolume(10);
			EmitSound(GetOwner(), SOUND_IDLE);
		}
		SetVolume(8);
		EmitSound(GetOwner(), SOUND_ATTACK1);
	}

	void attack_2()
	{
		ANIM_ATTACK = "attack1";
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), FIRE_DAMAGE);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK2_DAMAGE, 0.75, "slash");
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_hearsound()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE);
	}

	void game_dynamically_created()
	{
		SetSolid("none");
		ScheduleDelayedEvent(1, "ice_solidify");
		I_R_SUMMONED = 1;
		MY_MASTER = GetEntityIndex("ent_creationowner");
		string MY_MASTER_LIVES = IsEntityAlive("ent_creationowner");
		if (!(MY_MASTER_LIVES)) return;
		ScheduleDelayedEvent(2, "npcatk_flee", MY_MASTER, 275, 3);
		anti_stuck_checks();
	}

	void ice_solidify()
	{
		string MY_LOC = GetEntityOrigin(GetOwner());
		string MY_MASTER_LOC = GetEntityOrigin("ent_creationowner");
		string MASTER_DISTANCE = Distance(MY_LOC, MY_MASTER_LOC);
		if (MASTER_DISTANCE > 80)
		{
			SetSolid("box");
		}
		if (MASTER_DISTANCE <= 80)
		{
			if (!(IS_FLEEING))
			{
				npcatk_flee(GetEntityIndex("ent_creationowner"), 512, 3);
			}
			ScheduleDelayedEvent(0.25, "ice_solidify");
		}
	}

	void anti_stuck_checks()
	{
		if (!(I_R_SUMMONED)) return;
		if (!(STUCK_COUNT == 2)) return;
		CallExternal(GetEntityIndex("ent_creationowner"), "my_pet_stuck");
	}

	void walk_step()
	{
		STEP_COUNT += 1;
		if (STEP_COUNT == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_WALK1, 10);
		}
		if (STEP_COUNT == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_WALK2, 10);
			STEP_COUNT = 0;
		}
	}

}

}
