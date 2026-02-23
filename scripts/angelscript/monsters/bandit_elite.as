#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_aim_proj.as"

namespace MS
{

class BanditElite : CGameScript
{
	string ADJ_RANGE;
	int AM_LEAPING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATK_TYPE;
	string ATTACK1_DAMAGE;
	int ATTACK_COF;
	float ATTACK_PERCENTAGE;
	string ATTACK_RANGE;
	int ATTACK_SPEED;
	string BANDIT_TYPE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int CAN_ATTACK;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	string CHANGE_POSITION;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DO_STUN;
	int DROPS_CONTAINER;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string FINAL_DAMAGE;
	string FREQ_SPEC_ATTACK;
	int HUNT_AGRO;
	string LEAP_TARGET;
	int LEAP_UP_DELAY;
	string MOVE_RANGE;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string OLD_Z;
	string ORIG_ATTACK;
	string POWER_ATTACK;
	string PURE_FLEE;
	int SPEC_LOOP;
	int TOO_CLOSE;
	string WEAPON;

	BanditElite()
	{
		Precache("magic/boom.wav");
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_frost_arrows";
		const string MONSTER_MODEL = "npc/rogue_1337.mdl";
		Precache(MONSTER_MODEL);
		const string ANIM_HOP = "long_jump";
		const string FREQ_BOW = Random(15, 30);
		const string FREQ_DAGGER = Random(20, 30);
		const string FREQ_MA = Random(10, 15);
		const string FREQ_SWORD = Random(15, 30);
		const string FREQ_AXE = Random(15, 30);
		const string FREQ_MACE = Random(15, 30);
		const string DMG_DAGGER = Random(20, 30);
		const int DMG_MA = 25;
		const string DMG_SWORD = Random(20, 30);
		const string DMG_AXE = Random(30, 60);
		const string DMG_MACE = Random(60, 75);
		const string SOUND_PAIN = "player/chesthit1.wav";
		const string SOUND_PAIN2 = "player/armhit1.wav";
		const string SOUND_BOW = "weapons/bow/bow.wav";
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk2";
		ANIM_DEATH = "die_simple";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_ATTACK = 1;
		CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_HEAR = 1;
		NPC_GIVE_EXP = 300;
		const int AIM_RATIO = 50;
		const string ARROW_DAMAGE = "$rand(50,120)";
		if (!(OVERRIDE_BANDIT_SPAWN))
		{
		}
		bowey();
		fistey();
		daggerey();
		swordey();
		axey();
		macey();
	}

	void OnSpawn() override
	{
		if ((OVERRIDE_BANDIT_SPAWN)) return;
		if (WEAPON == "WEAPON")
		{
			WEAPON = RandomInt(0, 5);
		}
		SetGold(RandomInt(30, 40));
		SetWidth(32);
		SetHeight(92);
		SetRace("rogue");
		SetDamageResistance("all", 0.6);
		SetHearingSensitivity(3);
		SetRoam(true);
		SetModel(MONSTER_MODEL);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void bowey()
	{
		if (!(WEAPON == 0)) return;
		SetName("Elite Bandit Archer");
		SetHealth(800);
		ATTACK_SPEED = 1200;
		MOVE_RANGE = ATTACK_SPEED;
		ATTACK_RANGE = ATTACK_SPEED;
		ATTACK_COF = 0;
		ANIM_ATTACK = "shootbow";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 5);
		TOO_CLOSE = 0;
		DROPS_CONTAINER = 1;
		NO_STUCK_CHECKS = 1;
		BANDIT_TYPE = "bow";
	}

	void daggerey()
	{
		if (!(WEAPON == 1)) return;
		SetName("Elite Bandit Rogue");
		SetHealth(800);
		MOVE_RANGE = 30;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = DMG_DAGGER;
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "swordjab1_R";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 1);
		DROP_ITEM1 = "smallarms_fangstooth";
		DROP_ITEM1_CHANCE = 0.05;
		BANDIT_TYPE = "dagger";
	}

	void fistey()
	{
		if (!(WEAPON == 2)) return;
		SetName("Elite Bandit Martial Artist");
		SetHealth(1000);
		SetMoveSpeed(1.5);
		SetAnimMoveSpeed(1.5);
		BASE_FRAMERATE = 1.5;
		BASE_MOVESPEED = 1.5;
		MOVE_RANGE = 30;
		ATTACK_RANGE = 80;
		ATTACK1_DAMAGE = DMG_MA;
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "aim_punch1";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 0);
		BANDIT_TYPE = "ma";
	}

	void swordey()
	{
		if (!(WEAPON == 3)) return;
		SetName("Elite Bandit Swordsman");
		SetHealth(1000);
		MOVE_RANGE = 60;
		ATTACK_RANGE = 100;
		ATTACK1_DAMAGE = Random(20, 30);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "swordswing2_R";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 4);
		BANDIT_TYPE = "sword";
	}

	void axey()
	{
		if (!(WEAPON == 4)) return;
		SetName("Elite Bandit Axeman");
		SetHealth(1500);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 100;
		ATTACK1_DAMAGE = Random(30, 60);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 3);
		BANDIT_TYPE = "axe";
	}

	void macey()
	{
		if (!(WEAPON == 5)) return;
		SetName("Elite Bandit Berserker");
		SetHealth(1750);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 100;
		ATTACK1_DAMAGE = Random(30, 60);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		ORIG_ATTACK = ANIM_ATTACK;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 2);
		BANDIT_TYPE = "mace";
	}

	void check_attack()
	{
		if (!(WEAPON == 0)) return;
		if ((IS_FLEEING)) return;
		if (CHANGE_POSITION > 3)
		{
			CHANGE_POSITION = 0;
			PlayAnim("once", "break");
			PlayAnim("critical", ANIM_RUN);
			chicken_run(3);
		}
		if (!(false)) return;
		if (GetEntityRange(m_hLastSeen) < 100)
		{
			TOO_CLOSE += 0.1;
		}
		if (TOO_CLOSE > 5)
		{
			TOO_CLOSE = 0;
			PURE_FLEE = 1;
			npcatk_flee(m_hLastSeen, 600, 5);
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(WEAPON == 0)) return;
		if (!(IsValidPlayer(m_hLastStruck) + "add" + CHANGE_POSITION + 1)) return;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string L_DEATHANIM = RandomInt(0, 6);
		if (L_DEATHANIM == 0)
		{
			ANIM_DEATH = "die_simple";
		}
		if (L_DEATHANIM == 1)
		{
			ANIM_DEATH = "die_backwards1";
		}
		if (L_DEATHANIM == 2)
		{
			ANIM_DEATH = "die_backwards";
		}
		if (L_DEATHANIM == 3)
		{
			ANIM_DEATH = "die_forwards";
		}
		if (L_DEATHANIM == 4)
		{
			ANIM_DEATH = "headshot";
		}
		if (L_DEATHANIM == 5)
		{
			ANIM_DEATH = "die_spin";
		}
		if (L_DEATHANIM == 6)
		{
			ANIM_DEATH = "gutshot";
		}
	}

	void npc_targetsighted()
	{
		if (WEAPON == 0)
		{
			if (!(IS_FLEEING))
			{
			}
			if ((false))
			{
			}
			AS_ATTACKING = GetGameTime();
			PlayAnim("once", ANIM_ATTACK);
		}
		if (!(BANDIT_TYPE != "bow")) return;
		if ((LEAP_UP_DELAY)) return;
		LEAP_UP_DELAY = 1;
		ScheduleDelayedEvent(2.0, "reset_leap_up_delay");
		string TARG_POS = GetEntityOrigin(HUNT_LASTTARGET);
		string MY_Z = (GetMonsterProperty("origin")).z;
		string TARG_Z = (TARG_POS).z;
		string Z_DIFF = TARG_Z;
		MY_Z += PLAYER_HALFHEIGHT;
		Z_DIFF -= MY_Z;
		if (Z_DIFF < 0)
		{
			string Z_DIFF = /* TODO: $neg */ $neg(Z_DIFF);
		}
		if (Z_DIFF > 96)
		{
			if (Z_DIFF < 300)
			{
				leap_at(GetEntityIndex(HUNT_LASTTARGET));
			}
		}
	}

	void cycle_up()
	{
		if ((SPEC_LOOP)) return;
		SPEC_LOOP = 1;
		if (BANDIT_TYPE == "bow")
		{
			FREQ_SPEC_ATTACK = FREQ_BOW;
		}
		if (BANDIT_TYPE == "dagger")
		{
			FREQ_SPEC_ATTACK = FREQ_DAGGER;
		}
		if (BANDIT_TYPE == "ma")
		{
			FREQ_SPEC_ATTACK = FREQ_MA;
		}
		if (BANDIT_TYPE == "sword")
		{
			FREQ_SPEC_ATTACK = FREQ_SWORD;
		}
		if (BANDIT_TYPE == "axe")
		{
			FREQ_SPEC_ATTACK = FREQ_AXE;
		}
		if (BANDIT_TYPE == "mace")
		{
			FREQ_SPEC_ATTACK = FREQ_MACE;
		}
		FREQ_SPEC_ATTACK("special_attack");
	}

	void special_attack()
	{
		if (BANDIT_TYPE == "bow")
		{
			FREQ_SPEC_ATTACK = FREQ_BOW;
		}
		if (BANDIT_TYPE == "dagger")
		{
			FREQ_SPEC_ATTACK = FREQ_DAGGER;
		}
		if (BANDIT_TYPE == "ma")
		{
			FREQ_SPEC_ATTACK = FREQ_MA;
		}
		if (BANDIT_TYPE == "sword")
		{
			FREQ_SPEC_ATTACK = FREQ_SWORD;
		}
		if (BANDIT_TYPE == "axe")
		{
			FREQ_SPEC_ATTACK = FREQ_AXE;
		}
		if (BANDIT_TYPE == "mace")
		{
			FREQ_SPEC_ATTACK = FREQ_MACE;
		}
		FREQ_SPEC_ATTACK("special_attack");
		if ((I_R_FROZEN))
		{
			ScheduleDelayedEvent(10.0, "freeze_solid_end");
		}
		if ((I_R_FROZEN)) return;
		if (!(false)) return;
		EmitSound(GetOwner(), 0, "player/swordready.wav", 10);
		if (BANDIT_TYPE != "dagger")
		{
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 64, 1, 1);
		}
		ScheduleDelayedEvent(0.75, "special_attack2");
	}

	void special_attack2()
	{
		if (BANDIT_TYPE == "bow")
		{
			if ((false))
			{
				SetAngles("add_view.pitch");
				EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
				ScheduleDelayedEvent(0.1, "bow_sound");
				ScheduleDelayedEvent(0.2, "bow_sound");
				ScheduleDelayedEvent(0.3, "bow_sound");
				ScheduleDelayedEvent(0.4, "bow_sound");
				string L_POS = /* TODO: $relpos */ $relpos(0, 0, 2);
				TossProjectile("proj_arrow_gpoison", L_POS, "none", ATTACK_SPEED, FINAL_DAMAGE, 10, "none");
				TossProjectile("proj_arrow_gpoison", L_POS, "none", ATTACK_SPEED, FINAL_DAMAGE, 10, "none");
				TossProjectile("proj_arrow_gpoison", L_POS, "none", ATTACK_SPEED, FINAL_DAMAGE, 10, "none");
				TossProjectile("proj_arrow_gpoison", L_POS, "none", ATTACK_SPEED, FINAL_DAMAGE, 10, "none");
			}
		}
		if (BANDIT_TYPE == "dagger")
		{
			EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
			turbo_attack();
		}
		if (BANDIT_TYPE == "ma")
		{
			POWER_ATTACK = 1;
			PlayAnim("once", "break");
		}
		if (BANDIT_TYPE == "sword")
		{
			PlayAnim("once", "break");
			POWER_ATTACK = 1;
		}
		if (BANDIT_TYPE == "axe")
		{
			if ((false))
			{
				PlayAnim("once", "break");
				LEAP_TARGET = GetEntityIndex(m_hLastSeen);
				POWER_ATTACK = 1;
				if (GetEntityRange(LEAP_TARGET) < 200)
				{
					PURE_FLEE = 1;
					npcatk_flee(LEAP_TARGET, 300, 2.0);
				}
				ScheduleDelayedEvent(0.1, "leap_scan");
			}
		}
		if (BANDIT_TYPE == "mace")
		{
			PlayAnim("once", "break");
			POWER_ATTACK = 1;
		}
	}

	void turbo_attack()
	{
		PlayAnim("critical", ANIM_ATTACK);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 64, 10, 10);
		SetMoveSpeed(2.0);
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(3.0);
		BASE_FRAMERATE = 3.0;
		BASE_MOVESPEED = 3.0;
		ScheduleDelayedEvent(10.0, "end_turbo");
	}

	void end_turbo()
	{
		SetMoveSpeed(1.0);
		SetAnimMoveSpeed(1.0);
		SetAnimFrameRate(1.0);
		BASE_FRAMERATE = 1.0;
		BASE_MOVESPEED = 1.0;
	}

	void npc_selectattack()
	{
		if (BANDIT_TYPE == "ma")
		{
			ATK_TYPE = RandomInt(1, 3);
			if ((POWER_ATTACK))
			{
				ATK_TYPE = 2;
			}
			if (ATK_TYPE == 1)
			{
				ANIM_ATTACK = "aim_punch1";
			}
			if (ATK_TYPE == 2)
			{
				ANIM_ATTACK = "stance_normal_highkick_r1";
			}
			if (ATK_TYPE == 3)
			{
				ANIM_ATTACK = "stance_normal_lowkick_r1";
			}
		}
		if ((POWER_ATTACK))
		{
			if (BANDIT_TYPE == "sword")
			{
				SetMoveAnim("walk_squatwalk1_R");
				ANIM_ATTACK = "swordjab1_R";
			}
			if (BANDIT_TYPE == "axe")
			{
				if (!(IS_FLEEING))
				{
				}
				if (!(IsEntityAlive(LEAP_TARGET)))
				{
					LEAP_TARGET = HUNT_LASTTARGET;
				}
			}
			if (BANDIT_TYPE == "mace")
			{
				SetMoveAnim("walk_squatwalk1_R");
				ANIM_ATTACK = "battleaxe_swing1_R";
			}
		}
	}

	void leap_at()
	{
		if ((AM_LEAPING)) return;
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		POWER_ATTACK = 0;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_at2");
	}

	void leap_at2()
	{
		EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
		PlayAnim("critical", ANIM_HOP);
		AS_ATTACKING = GetGameTime();
		ScheduleDelayedEvent(0.1, "bandit_charge");
		ScheduleDelayedEvent(1.0, "reset_leaping");
		OLD_Z = (GetMonsterProperty("origin")).z;
		DO_STUN = 1;
		ScheduleDelayedEvent(0.5, "ground_scan");
	}

	void leap_away()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_away2");
	}

	void leap_away2()
	{
		EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
		PlayAnim("critical", ANIM_HOP);
		AS_ATTACKING = GetGameTime();
		ScheduleDelayedEvent(0.1, "bandit_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
	}

	void bandit_charge()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void bandit_hop()
	{
		string JUMP_HEIGHT = RandomInt(350, 450);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void reset_leaping()
	{
		AM_LEAPING = 0;
	}

	void ground_scan()
	{
		if (!(DO_STUN)) return;
		ScheduleDelayedEvent(0.2, "ground_scan");
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string MY_Z = (GetMonsterProperty("origin")).z;
		string DIFF = MY_Z;
		DIFF -= MY_GROUND;
		if (DIFF < 5)
		{
			DO_STUN = 0;
		}
		if ((DO_STUN)) return;
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 60, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 1, 100
	}

	void attack()
	{
		AS_ATTACKING = GetGameTime();
		if ((IS_FLEEING)) return;
		if (WEAPON == 0)
		{
			SetAngles("add_view.pitch");
			FINAL_DAMAGE = ARROW_DAMAGE;
			npcatk_adj_attack();
			AS_ATTACKING = GetGameTime();
			TossProjectile("proj_arrow_frost", /* TODO: $relpos */ $relpos(0, 0, 2), "none", ATTACK_SPEED, FINAL_DAMAGE, ATTACK_COF, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
			bow_sound();
		}
		if (WEAPON != 0)
		{
			ADJ_RANGE = ATTACK_RANGE;
			npcatk_range_adj();
		}
		if (BANDIT_TYPE == "dagger")
		{
			smallswing_sound();
			string FINAL_DAMAGE = DMG_DAGGER;
			if ((TURBO_ON))
			{
				FINAL_DAMAGE *= 2;
			}
			npcatk_adj_attack();
			DoDamage(HUNT_LASTTARGET, ADJ_RANGE, FINAL_DAMAGE, ATTACK_PERCENTAGE, "slash");
		}
		if (BANDIT_TYPE == "ma")
		{
			ma_sound();
			string FINAL_DAMAGE = DMG_MA;
			string HIT_CHANCE = ATTACK_PERCENTAGE;
			if ((POWER_ATTACK))
			{
				FINAL_DAMAGE *= 2;
				float HIT_CHANCE = 1.0;
			}
			npcatk_adj_attack();
			DoDamage(HUNT_LASTTARGET, ADJ_RANGE, FINAL_DAMAGE, HIT_CHANCE, "slash");
		}
		if (BANDIT_TYPE == "sword")
		{
			bigswing_sound();
			string FINAL_DAMAGE = DMG_SWORD;
			if ((POWER_ATTACK))
			{
				FINAL_DAMAGE *= 2;
			}
			npcatk_adj_attack();
			DoDamage(HUNT_LASTTARGET, ADJ_RANGE, FINAL_DAMAGE, ATTACK_PERCENTAGE, "slash");
		}
		if (BANDIT_TYPE == "axe")
		{
			bigswing_sound();
			string FINAL_DAMAGE = DMG_AXE;
			if ((POWER_ATTACK))
			{
				FINAL_DAMAGE *= 2;
			}
			npcatk_adj_attack();
			DoDamage(HUNT_LASTTARGET, ADJ_RANGE, FINAL_DAMAGE, ATTACK_PERCENTAGE, "slash");
		}
		if (BANDIT_TYPE == "mace")
		{
			bigswing_sound();
			string FINAL_DAMAGE = DMG_MACE;
			if ((POWER_ATTACK))
			{
				FINAL_DAMAGE *= 2;
			}
			npcatk_adj_attack();
			if ((POWER_ATTACK))
			{
				FINAL_DAMAGE *= 2;
			}
			DoDamage(HUNT_LASTTARGET, ADJ_RANGE, FINAL_DAMAGE, ATTACK_PERCENTAGE, "slash");
			if (RandomInt(1, 3) == 1)
			{
				ApplyEffect(HUNT_LASTTARGET, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), RandomInt(10, 20));
			}
		}
	}

	void reset_power_attack()
	{
		POWER_ATTACK = 0;
		ANIM_ATTACK = ORIG_ATTACK;
		SetMoveAnim(ANIM_RUN);
	}

	void game_dodamage()
	{
		if (WEAPON == 0)
		{
			if (!(param1))
			{
				CHANGE_POSITION += 1;
			}
			if ((param1))
			{
				if (IsValidPlayer(param2) == 1)
				{
					CHANGE_POSITION = -2;
				}
				if (CHANGE_POSITION < -5)
				{
					CHANGE_POSITION = 0;
				}
			}
		}
		if (BANDIT_TYPE == "ma")
		{
			if ((param1))
			{
			}
			if (!(POWER_ATTACK))
			{
			}
			if (ATK_TYPE > 1)
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(10, 200, 10));
		}
		if ((POWER_ATTACK))
		{
			if (BANDIT_TYPE == "ma")
			{
				EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
				reset_power_attack();
				if ((param1))
				{
				}
				AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 200, 200));
				ApplyEffect(param2, "effects/debuff_stun", 10, GetEntityIndex(GetOwner()));
			}
			if (BANDIT_TYPE == "sword")
			{
				EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
				reset_power_attack();
				if ((param1))
				{
				}
				ApplyEffect(param2, "effects/dot_cold_freeze", Random(5, 10), GetEntityIndex(GetOwner()));
			}
			if (BANDIT_TYPE == "mace")
			{
				EmitSound(GetOwner(), 0, "player/shout1.wav", 10);
				reset_power_attack();
				SpawnNPC("monsters/summon/stun_burst", GetEntityOrigin(param2), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128
			}
		}
	}

	void bow_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_BOW, 10);
	}

	void bigswing_sound()
	{
		EmitSound(GetOwner(), 0, "weapons/swingsmall.wav", 8);
	}

	void smallswing_sound()
	{
		EmitSound(GetOwner(), 0, "weapons/swingsmall.wav", 8);
	}

	void ma_sound()
	{
		// PlayRandomSound from: "player/jab1.wav", "player/jab2.wav"
		array<string> sounds = {"player/jab1.wav", "player/jab2.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void attack_jab()
	{
		attack();
	}

	void kick_high()
	{
		attack();
	}

	void kick_low()
	{
		attack();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(BANDIT_TYPE == "ma")) return;
		if ((I_R_FROZEN)) return;
		string LEAP_CHANCE = RandomInt(1, 10);
		if (param1 > 100)
		{
			int LEAP_CHANCE = 1;
		}
		if (param1 > 20)
		{
			if (LEAP_CHANCE == 1)
			{
			}
			leap_away(GetEntityIndex(m_hLastStruck));
		}
	}

	void reset_leap_up_delay()
	{
		LEAP_UP_DELAY = 0;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(BANDIT_TYPE == "dagger")) return;
		string HP_TO_GIVE = param2;
		string MAX_CHECK = GetMonsterHP();
		MAX_CHECK += HP_TO_GIVE;
		if (!(MAX_CHECK < GetMonsterMaxHP())) return;
		HealEntity(GetOwner(), HP_TO_GIVE);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 80, 0.5, 0.5);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
	}

	void leap_scan()
	{
		if (!(POWER_ATTACK)) return;
		ScheduleDelayedEvent(0.25, "leap_scan");
		if ((IS_FLEEING)) return;
		if ((IsEntityAlive(LEAP_TARGET)))
		{
			leap_at(LEAP_TARGET);
		}
		if (!(IsEntityAlive(LEAP_TARGET)))
		{
			LEAP_TARGET = m_hAttackTarget;
			if (m_hAttackTarget == "unset")
			{
				leap_at(LEAP_TARGET);
			}
		}
	}

}

}
