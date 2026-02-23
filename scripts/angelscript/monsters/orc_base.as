#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class OrcBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BO_ZOMBIE_MODE;
	int CALLED_HELP;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int IS_RANGED;
	string LAST_ENEMY;
	int MOVE_RANGE;
	string NEXT_ORC_VALIDATE_SOUND;
	int NO_STEP_ADJ;
	int NPC_SILENT_DEATH;
	int ORC_JUMPER;

	OrcBase()
	{
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "voices/orc/hit.wav";
		const string SOUND_HIT2 = "voices/orc/hit2.wav";
		const string SOUND_HIT3 = "voices/orc/hit3.wav";
		const string SOUND_PAIN = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/orc/battlecry.wav";
		const string SOUND_ATTACK1 = "voices/orc/attack.wav";
		const string SOUND_ATTACK2 = "voices/orc/attack2.wav";
		const string SOUND_ATTACK3 = "voices/orc/attack3.wav";
		NPC_SILENT_DEATH = 1;
		const string SOUND_HELP = "voices/orc/help.wav";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fallback";
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		CAN_FLEE = 0;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.3;
		ANIM_FLINCH = "flinch";
		FLINCH_DELAY = 4;
		LAST_ENEMY = "NONE";
		const float ZORC_DMG_MULTI = 5.0;
		const float ZORC_HP_MULTI = 6.0;
		const string SOUND_ZOMB_STRUCK1 = "debris/flesh2.wav";
		const string SOUND_ZOMB_STRUCK2 = "agrunt/ag_pain3.wav";
		const string SOUND_ZOMB_STRUCK3 = "agrunt/ag_pain5.wav";
		const string SOUND_ZOMB_ATK1 = "zombie/claw_miss1.wav";
		const string SOUND_ZOMB_ATK2 = "zombie/claw_miss2.wav";
		const string SOUND_ZOMB_ATK3 = "zombie/claw_strike1.wav";
		const string SOUND_ZOMB_ALERT1 = "monsters/zombie1/orc_zo_alert10.wav";
		const string SOUND_ZOMB_ALERT2 = "monsters/zombie1/orc_zo_alert20.wav";
		const string SOUND_ZOMB_ALERT3 = "monsters/zombie1/orc_zo_alert30.wav";
	}

	void OnSpawn() override
	{
		SetRoam(true);
		SetRace("orc");
		SetModel("monsters/orc.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		orc_spawn();
		if (!(StringToLower(GetMapName()) == "daragoth")) return;
		NO_STEP_ADJ = 1;
	}

	void OnPostSpawn() override
	{
		if ((G_SHAD_PRESENT))
		{
			bo_zombie_mode();
		}
		if ((G_SHAD_PRESENT)) return;
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "old_helena")
		{
			NPC_GIVE_EXP /= 2;
			SetSkillLevel(NPC_GIVE_EXP);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
		SetModelBody(4, 0);
		orc_death();
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		string LASTSEEN_ENEMY = m_hAttackTarget;
		if (!(LASTSEEN_ENEMY != LAST_ENEMY)) return;
		if (!(BO_ZOMBIE_MODE))
		{
			if (GetGameTime() > NEXT_ORC_VALIDATE_SOUND)
			{
			}
			NEXT_ORC_VALIDATE_SOUND = GetGameTime();
			NEXT_ORC_VALIDATE_SOUND += Random(5.0, 10.0);
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK2, 5);
		}
		else
		{
			if (GetGameTime() > NEXT_ORC_VALIDATE_SOUND)
			{
			}
			NEXT_ORC_VALIDATE_SOUND = GetGameTime();
			NEXT_ORC_VALIDATE_SOUND += Random(5.0, 10.0);
			// PlayRandomSound from: SOUND_ZOMB_ALERT1, SOUND_ZOMB_ALERT2, SOUND_ZOMB_ALERT3
			array<string> sounds = {SOUND_ZOMB_ALERT1, SOUND_ZOMB_ALERT2, SOUND_ZOMB_ALERT3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		LAST_ENEMY = LASTSEEN_ENEMY;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (ORC_SHIELD == 1)
		{
			if (!(BO_ZOMBIE_MODE))
			{
			}
			string block = RandomInt(0, 99);
			if (block < 30)
			{
				if (block < 5)
				{
					PlayAnim("critical", "deflectcounter");
					swing_axe();
				}
				else
				{
					string rand = RandomInt(0, 1);
					if (rand == 0)
					{
						PlayAnim("critical", "shielddeflect1");
					}
					if (rand == 1)
					{
						PlayAnim("critical", "shielddeflect2");
					}
				}
			}
			else
			{
				sound_struck();
			}
		}
		else
		{
			sound_struck();
		}
		orc_struck();
	}

	void sound_struck()
	{
		if ((BO_ZOMBIE_MODE))
		{
			// PlayRandomSound from: SOUND_ZOMB_STRUCK1, SOUND_ZOMB_STRUCK2, SOUND_ZOMB_STRUCK3
			array<string> sounds = {SOUND_ZOMB_STRUCK1, SOUND_ZOMB_STRUCK2, SOUND_ZOMB_STRUCK3};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
			array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void baseorc_yell()
	{
		if ((BO_ZOMBIE_MODE))
		{
			// PlayRandomSound from: SOUND_ZOMB_ATK1, SOUND_ZOMB_ATK2, SOUND_ZOMB_ATK3
			array<string> sounds = {SOUND_ZOMB_ATK1, SOUND_ZOMB_ATK2, SOUND_ZOMB_ATK3};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(ATTACK_PUSH != "ATTACK_PUSH")) return;
		if (!(ATTACK_PUSH != "none")) return;
		AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)
	{
		if ((CALLED_HELP)) return;
		CALLED_HELP = 1;
		Precache("voices/orc/help.wav");
		CallExternal(GetEntityIndex(param2), "ext_mon_playsound", 0, 10, "voices/orc/help.wav");
	}

	void bo_zombie_mode()
	{
		SetRace("undead");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.5);
		SetProp(GetOwner(), "skin", 1);
		SetAnimFrameRate(0.5);
		SetModelBody(2, 0);
		MOVE_RANGE = 32;
		ATTACK_MOVERANGE = 32;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 140;
		IS_RANGED = 0;
		ORC_JUMPER = 0;
		ANIM_ATTACK = "swordswing1_L";
		SetDamageMultiplier(ZORC_DMG_MULTI);
		string HP_MULTI = GetMonsterMaxHP();
		HP_MULTI *= ZORC_HP_MULTI;
		SetHealth(HP_MULTI);
		BO_ZOMBIE_MODE = 1;
		SetStat("parry", 0);
		NPC_GIVE_EXP *= 4.0;
		SetSkillLevel(NPC_GIVE_EXP);
		string MY_NAME = GetEntityName(GetOwner());
		if ((StringToLower(MY_NAME)).findFirst("zombie") >= 0)
		{
			int NO_NAME_CHANGE = 1;
		}
		if ((NO_NAME_CHANGE)) return;
		SetName("GetEntityName(GetOwner()) Zombie");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(BO_ZOMBIE_MODE))
		{
			EmitSound(GetOwner(), 0, "voices/orc/die.wav", 5);
		}
		else
		{
			EmitSound(GetOwner(), 0, "agrunt/ag_die5.wav", 5);
		}
	}

}

}
