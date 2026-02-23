#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_jumper.as"

namespace MS
{

class GhoulGreater : CGameScript
{
	int ALERTED_OTHERS;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
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
	int FLEE_DISTANCE;
	int HUNT_AGRO;
	int MONSTER_WIDTH;
	int NPC_GIVE_EXP;
	string NPC_JUMPER;
	string STRUCK_BY_HOLY;
	int STUCK_COUNT;

	GhoulGreater()
	{
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_DEATH = "diesimple";
		ANIM_ATTACK = "claw";
		const string ANIM_NPC_JUMP = "slash";
		const string ANIM_LOOK = "idle_look";
		const string ANIM_SLASH = "slash";
		const string ANIM_CLAW = "claw";
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
		const int RETALIATE_CHANGETARGET_CHANCE = 80;
		CAN_FLINCH = 0;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 25;
		const int FLEE_CHANCE = 25;
		FLEE_DISTANCE = 2048;
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		const int MOVE_RAGE = 55;
		const float ATTACK_ACCURACY = 0.8;
		const float ATTACK2_ACCURACY = 0.9;
		const int ATTACK_DAMAGE = 80;
		const string SOUND_IDLE1 = "zombie/zo_alert10.wav";
		const string SOUND_IDLE2 = "zombie/zo_alert20.wav";
		const string SOUND_IDLE3 = "zombie/zo_alert30.wav";
		const string SOUND_ALERT = "zombie/zo_attack1.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		const string SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		const string SOUND_ATTACKHIT3 = "zombie/claw_strike3.wav";
		const string SOUND_DEATH = "bullchicken/bc_die1.wav";
		const string SOUND_STRUCK = "debris/flesh2.wav";
		const string SOUND_PAIN1 = "zombie/zo_pain2.wav";
		const string SOUND_PAIN2 = "zombie/zo_idle3.wav";
		const string SOUND_TURNED1 = "ambience/the_horror1.wav";
		const string SOUND_TURNED2 = "ambience/the_horror2.wav";
		const string SOUND_TURNED3 = "ambience/the_horror3.wav";
		const string SOUND_TURNED4 = "ambience/the_horror4.wav";
		const string SOUND_HOLYPAIN1 = "agrunt/ag_pain2.wav";
		const string SOUND_HOLYPAIN2 = "agrunt/ag_pain3.wav";
		const string SOUND_HOLYPAIN3 = "agrunt/ag_pain4.wav";
		const string SOUND_STEP1 = "player/pl_dirt1.wav";
		const string SOUND_STEP2 = "player/pl_dirt2.wav";
		const string SOUND_STEP3 = "player/pl_dirt3.wav";
		const string SOUND_STEP4 = "player/pl_dirt4.wav";
		const string SOUND_NPC_JUMP = "zombie/zo_attack1.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 50;
		DROP_GOLD_MAX = 75;
		const int I_AM_TURNABLE = 0;
		MONSTER_WIDTH = 32;
		const float STUCK_CHECK_FREQUENCY = 1.1;
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
