#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_jumper.as"

namespace MS
{

class GhoulGreater : CGameScript
{
	int ALERTED_OTHERS;
	string ANIM_ATTACK;
	string ANIM_CLAW;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_LOOK;
	string ANIM_NPC_JUMP;
	string ANIM_RUN;
	string ANIM_SLASH;
	string ANIM_WALK;
	float ATTACK2_ACCURACY;
	float ATTACK_ACCURACY;
	int ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_VOLUME;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_WANDER;
	int DID_ALERT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	int HUNT_AGRO;
	int I_AM_TURNABLE;
	int MONSTER_WIDTH;
	int MOVE_RAGE;
	int NPC_GIVE_EXP;
	string NPC_JUMPER;
	int RETALIATE_CHANGETARGET_CHANCE;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACKHIT1;
	string SOUND_ATTACKHIT2;
	string SOUND_ATTACKHIT3;
	string SOUND_DEATH;
	string SOUND_HOLYPAIN1;
	string SOUND_HOLYPAIN2;
	string SOUND_HOLYPAIN3;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_NPC_JUMP;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STEP3;
	string SOUND_STEP4;
	string SOUND_STRUCK;
	string SOUND_TURNED1;
	string SOUND_TURNED2;
	string SOUND_TURNED3;
	string SOUND_TURNED4;
	string STRUCK_BY_HOLY;
	float STUCK_CHECK_FREQUENCY;
	int STUCK_COUNT;

	GhoulGreater()
	{
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_DEATH = "diesimple";
		ANIM_ATTACK = "claw";
		ANIM_NPC_JUMP = "slash";
		ANIM_LOOK = "idle_look";
		ANIM_SLASH = "slash";
		ANIM_CLAW = "claw";
		if (StringToLower(GetMapName()) == "the_wall")
		{
			NPC_JUMPER = 1;
		}
		if (StringToLower(GetMapName()) == "walltest")
		{
			NPC_JUMPER = 1;
		}
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		CAN_WANDER = 1;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 80;
		CAN_FLINCH = 0;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 25;
		FLEE_DISTANCE = 2048;
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		MOVE_RAGE = 55;
		ATTACK_ACCURACY = 0.8;
		ATTACK2_ACCURACY = 0.9;
		ATTACK_DAMAGE = 80;
		SOUND_IDLE1 = "zombie/zo_alert10.wav";
		SOUND_IDLE2 = "zombie/zo_alert20.wav";
		SOUND_IDLE3 = "zombie/zo_alert30.wav";
		SOUND_ALERT = "zombie/zo_attack1.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		SOUND_ATTACKHIT3 = "zombie/claw_strike3.wav";
		SOUND_DEATH = "bullchicken/bc_die1.wav";
		SOUND_STRUCK = "debris/flesh2.wav";
		SOUND_PAIN1 = "zombie/zo_pain2.wav";
		SOUND_PAIN2 = "zombie/zo_idle3.wav";
		SOUND_TURNED1 = "ambience/the_horror1.wav";
		SOUND_TURNED2 = "ambience/the_horror2.wav";
		SOUND_TURNED3 = "ambience/the_horror3.wav";
		SOUND_TURNED4 = "ambience/the_horror4.wav";
		SOUND_HOLYPAIN1 = "agrunt/ag_pain2.wav";
		SOUND_HOLYPAIN2 = "agrunt/ag_pain3.wav";
		SOUND_HOLYPAIN3 = "agrunt/ag_pain4.wav";
		SOUND_STEP1 = "player/pl_dirt1.wav";
		SOUND_STEP2 = "player/pl_dirt2.wav";
		SOUND_STEP3 = "player/pl_dirt3.wav";
		SOUND_STEP4 = "player/pl_dirt4.wav";
		SOUND_NPC_JUMP = "zombie/zo_attack1.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 50;
		DROP_GOLD_MAX = 75;
		I_AM_TURNABLE = 0;
		MONSTER_WIDTH = 32;
		STUCK_CHECK_FREQUENCY = 1.1;
		Precache(SOUND_DEATH);
		Precache("monsters/ghoul_greater.mdl");
		1_0();
		if (!(false))
		{
		}
	}

	void OnSpawn() override
	{
		SetName("Greater Ghoul");
		SetHealth(450);
		SetWidth(32);
		SetHeight(72);
		SetRoam(true);
		SetRace("undead");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("poison", 0.0);
		SetHearingSensitivity(8);
		SetModel("monsters/ghoul_greater.mdl");
		NPC_GIVE_EXP = 120;
		ScheduleDelayedEvent(1.0, "look_around_ghoul");
	}

	void attack1()
	{
		STUCK_COUNT = 0;
		ATTACK_VOLUME = 5;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		if (RandomInt(1, 20) == 1)
		{
			ANIM_ATTACK = ANIM_SLASH;
		}
	}

	void attack2()
	{
		STUCK_COUNT = 0;
		ATTACK_VOLUME = 10;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK2_ACCURACY, "slash");
		ANIM_ATTACK = ANIM_CLAW;
		if (!(GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/debuff_stun", RandomInt(2, 8), GetEntityIndex(GetOwner()));
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			// PlayRandomSound from: ATTACK_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {ATTACK_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((param1))
		{
			// PlayRandomSound from: ATTACK_VOLUME, SOUND_ATTACKHIT1, SOUND_ATTACKHIT2, SOUND_ATTACKHIT3
			array<string> sounds = {ATTACK_VOLUME, SOUND_ATTACKHIT1, SOUND_ATTACKHIT2, SOUND_ATTACKHIT3};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((ALERTED_OTHERS)) return;
		// svplaysound: emitsound ent_laststruck $get(ent_laststruck,origin) 10 10 combat
		EmitSound(m_hLastStruck, GetEntityOrigin(m_hLastStruck), 10, 10, "combat");
		ALERTED_OTHERS = 1;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		string HURT_THRESHOLD = GetEntityMaxHealth(GetOwner());
		HURT_THRESHOLD *= 0.25;
		if ((STRUCK_BY_HOLY))
		{
			// PlayRandomSound from: SOUND_HOLYPAIN1, SOUND_HOLYPAIN2, SOUND_HOLYPAIN3
			array<string> sounds = {SOUND_HOLYPAIN1, SOUND_HOLYPAIN2, SOUND_HOLYPAIN3};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
			STRUCK_BY_HOLY = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (MY_HEALTH > HURT_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN1
			array<string> sounds = {SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN1};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
		if (MY_HEALTH <= HURT_THRESHOLD)
		{
			// PlayRandomSound from: SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN2
			array<string> sounds = {SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN2};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
	}

	void run_step()
	{
		// PlayRandomSound from: SOUND_STEP1, SOUND_STEP2, SOUND_STEP3, SOUND_STEP4
		array<string> sounds = {SOUND_STEP1, SOUND_STEP2, SOUND_STEP3, SOUND_STEP4};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void basenpcatk_target_lost()
	{
		look_around_ghoul();
	}

	void my_target_died()
	{
		DID_ALERT = 0;
		look_around_ghoul();
	}

	void give_up_advanced()
	{
		look_around_ghoul();
	}

	void game_reached_dest()
	{
		if ((false)) return;
		look_around_ghoul();
	}

	void npcatk_stopflee()
	{
		if ((false)) return;
		look_around_ghoul();
	}

	void look_around_ghoul()
	{
		if ((false)) return;
		PlayAnim("once", ANIM_LOOK);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		1_0();
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		alert_ghoul();
	}

	void alert_ghoul()
	{
		if ((DID_ALERT)) return;
		if (!(false)) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_ALERT, 10);
		DID_ALERT = 1;
	}

}

}
