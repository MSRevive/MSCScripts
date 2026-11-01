#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class BoarBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BOAR_RUN;
	string ANIM_CHARGE;
	string ANIM_DEATH;
	string ANIM_FORWARD;
	string ANIM_IDLE;
	string ANIM_IDLE_EATGRASS;
	string ANIM_LEFT;
	string ANIM_RIGHT;
	string ANIM_RUN;
	string ANIM_STOMP;
	string ANIM_WALK;
	string AS_ATTACKING;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BOAR_CAN_FLEE;
	string BOAR_CHARGE_TARGET;
	int BOAR_IS_CHARGING;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HEAR;
	int CAN_RETALIATE;
	string CL_SCRIPT;
	string CL_SCRIPT_ID;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	float RETALIATE_CHANGETARGET_CHANCE;
	string SOUND_CHARGE;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	BoarBase()
	{
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "monsters/boar/boarpain.wav";
		SOUND_IDLE1 = "monsters/boar/boaridle.wav";
		SOUND_IDLE2 = "monsters/boar/boarsight2.wav";
		SOUND_CHARGE = "monsters/boar/boarsight.wav";
		SOUND_DEATH = "monsters/boar/boardeath.wav";
		HUNT_AGRO = 0;
		Precache(SOUND_IDLE1);
		Precache(SOUND_IDLE2);
		Precache(SOUND_DEATH);
		Precache(SOUND_CHARGE);
		ANIM_IDLE = "idle1";
		ANIM_IDLE_EATGRASS = "idle2";
		ANIM_RUN = "run";
		ANIM_BOAR_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_FORWARD = "gore_forward";
		ANIM_RIGHT = "gore_right";
		ANIM_LEFT = "gore_left";
		ANIM_STOMP = "stompsnort";
		ANIM_CHARGE = "charge";
		ANIM_DEATH = "die1";
		MOVE_RANGE = 64;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 120;
		ATTACK_HITCHANCE = 0.5;
		DROP_ITEM1 = "skin_boar";
		DROP_ITEM1_CHANCE = 0.2;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		BOAR_IS_CHARGING = 0;
		BOAR_CHARGE_TARGET = �PNONE�P;
		ANIM_ATTACK = ANIM_FORWARD;
		CL_SCRIPT = "monsters/boar_base_cl_charge";
		Precache(CL_SCRIPT);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(10, 25));
		if (!(IS_HUNTING))
		{
		}
		if (!(IS_FLEEING))
		{
		}
		// PlayRandomSound from: "game.sound.maxvol", SOUND_IDLE1, SOUND_IDLE2
		array<string> sounds = {"game.sound.maxvol", SOUND_IDLE1, SOUND_IDLE2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(RandomInt(8, 12));
		if (!(IS_HUNTING))
		{
		}
		if (!(IS_FLEEING))
		{
		}
		PlayAnim("once", ANIM_IDLE_EATGRASS);
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(0.1);
		if ((BOAR_IS_CHARGING))
		{
		}
		if (!(IS_FLEEING))
		{
		}
		string CHARGE_RANGE = MOVE_RANGE;
		CHARGE_RANGE *= 1.8;
		if (GetEntityDist(BOAR_CHARGE_TARGET) <= CHARGE_RANGE)
		{
		}
		DoDamage(BOAR_CHARGE_TARGET, ATTACK_HITRANGE, BOAR_CHARGE_DMG, 1.0, "slash");
		boar_charge_stop();
	}

	void OnSpawn() override
	{
		SetWidth(50);
		SetHeight(40);
		SetRace("wildanimal");
		SetRoam(true);
		SetHearingSensitivity(0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetEntitySkin(GetOwner(), SKIN_NAME);
		SetModel("monsters/boar.mdl");
		if (StringToLower(GetMapName()) == "nightmare_thornlands")
		{
			SetMonsterClip(0);
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		if ((BOAR_IS_CHARGING))
		{
			boar_charge_hit();
		}
		else
		{
			AddVelocity(m_hLastStruckByMe, PUSH_VEL);
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void npc_attack()
	{
		int NEXT_ATTACK = RandomInt(0, 2);
		if (NEXT_ATTACK == 0)
		{
			ANIM_ATTACK = ANIM_FORWARD;
		}
		else
		{
			if (NEXT_ATTACK == 1)
			{
				ANIM_ATTACK = ANIM_LEFT;
			}
			else
			{
				if (NEXT_ATTACK == 2)
				{
					ANIM_ATTACK = ANIM_RIGHT;
				}
			}
		}
	}

	void npc_targetsighted()
	{
		if (!(BOAR_CAN_CHARGE)) return;
		if ((BOAR_IS_CHARGING)) return;
		if (!(GetEntityDist(HUNT_LASTTARGET) > 256)) return;
		BOAR_CHARGE_TARGET = HUNT_LASTTARGET;
		boar_charge();
	}

	void boar_charge()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_CHARGE, "game.sound.maxvol");
		AS_ATTACKING = GetGameTime();
		PlayAnim("once", ANIM_STOMP);
		SetMoveSpeed(3);
		ANIM_RUN = ANIM_CHARGE;
		BOAR_IS_CHARGING = 1;
		CAN_ATTACK = 0;
		CAN_HEAR = 0;
		CAN_RETALIATE = 0;
		BOAR_CAN_FLEE = CAN_FLEE;
		CAN_FLEE = 0;
		ScheduleDelayedEvent(1, "boar_charge2");
		ScheduleDelayedEvent(15, "boar_charge_stop");
		ClientEvent("new", "all_in_sight", CL_SCRIPT, GetEntityIndex(GetOwner()));
		CL_SCRIPT_ID = "game.script.last_sent_id";
	}

	void boar_charge2()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_CHARGE, "game.sound.maxvol");
	}

	void boar_charge_stop()
	{
		if (!(BOAR_IS_CHARGING)) return;
		SetMoveSpeed(1);
		ANIM_RUN = ANIM_BOAR_RUN;
		BOAR_CHARGE_TARGET = �PNONE�P;
		BOAR_IS_CHARGING = 0;
		CAN_ATTACK = 1;
		CAN_HEAR = 1;
		CAN_RETALIATE = 1;
		CAN_FLEE = BOAR_CAN_FLEE;
		ClientEvent("remove", "all", CL_SCRIPT);
	}

	void boar_charge_hit()
	{
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 200, 200));
		ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
	}

	void npc_wander()
	{
		if (!(BOAR_IS_CHARGING)) return;
		boar_charge_stop();
	}

	void gore_forward()
	{
		if (!(IS_HARD)) return;
		string TARG_RANGE = GetEntityRange(HUNT_LASTTARGET);
		int MAX_PUSH_RANGE = 96;
		if (!(TARG_RANGE < MAX_PUSH_RANGE)) return;
		string RANGE_PERCENT = TARG_RANGE;
		RANGE_PERCENT /= MAX_PUSH_RANGE;
		string PUSH_STR = /* TODO: $get_skill_ratio */ $get_skill_ratio(RANGE_PERCENT, 400, 110);
		if ((G_DEVELOPER_MODE))
		{
			SendColoredMessage(HUNT_LASTTARGET, "gore - " + PUSH + "str " + PUSH_STR + "per " + RANGE_PERCENT + "rng " + TARG_RANGE);
		}
		AddVelocity(HUNT_LASTTARGET, /* TODO: $relvel */ $relvel(0, PUSH_STR, 110));
	}

}

}
