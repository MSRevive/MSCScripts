#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BanditBoss : CGameScript
{
	int AM_LEAPING;
	string ANIM_ATTACK;
	string ANIM_AXE_FAST;
	string ANIM_AXE_SLOW;
	string ANIM_BOW;
	string ANIM_CAST;
	string ANIM_DEATH;
	string ANIM_DRINK;
	string ANIM_FLINCH;
	string ANIM_HOP;
	string ANIM_JAB;
	string ANIM_KICK_HIGH;
	string ANIM_KICK_LOW;
	string ANIM_LEAP;
	string ANIM_MOVE_SLOW;
	string ANIM_PARRY;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_SPELL;
	string ANIM_SWING_FAST;
	string ANIM_SWING_SLOW;
	string ANIM_SWORD_FAST;
	string ANIM_SWORD_SLOW;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	int ARROW_SPEED;
	int AS_ATK_VALUE;
	string AS_ATTACKING;
	string ATTACK_ANIMINDEX;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string AVOID_DELAY;
	string BALL_DMG;
	string BALL_SIZE;
	string BALL_SPEED;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int BB_IN_ATTACK;
	string BD_COUNT;
	string BEAM_SPRITE;
	string BOSS_TYPE;
	int CAN_FLINCH;
	int COLD_STRUCK;
	int CYCLES_ON;
	string DEMON_BLOOD;
	string DEMON_NOHP_LOSS;
	string DID_FIRST_POT;
	string DID_SECOND_POT;
	int DMG_ARROW;
	int DMG_AXE_FAST;
	int DMG_AXE_SLOW;
	int DMG_BLIZ;
	int DMG_BURN_DAGGER;
	int DMG_BURN_MACE;
	int DMG_DAGGER;
	int DMG_FIRE_BALL;
	int DMG_FLAME_BURST;
	int DMG_KICK;
	int DMG_MACE;
	int DMG_NOVA_FAST;
	int DMG_NOVA_SLOW;
	int DMG_NOVA_STAB;
	int DMG_SKULL;
	int DMG_SWING_FAST;
	int DMG_SWING_SLOW;
	int DMG_SWORD_FAST;
	int DMG_SWORD_JAB;
	int DMG_SWORD_SLOW;
	string DOING_NOVA;
	int DOING_PULL;
	int DRINKING_POT;
	string DRINK_TYPE;
	int ELEMENT_DMG_THRESH;
	int ELEMENT_LIMIT;
	int FAST_SWINGS;
	int FIRE_STRUCK;
	string FIRST_SPEC_POT_HEALTH;
	int FLANK_DELAY;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	int FLINCH_DAMAGE_THRESHOLD;
	int FREEZE_ATTACK;
	string FREQ_ATTACK;
	float FREQ_AVOID;
	float FREQ_FLANK;
	float FREQ_HEALTH;
	int FREQ_INVIS;
	int FREQ_KICK;
	float FREQ_PULL;
	float FREQ_SPECIAL;
	float FREQ_TURBO;
	float FREQ_VOLCANO;
	string GLOW_LOOP_COLOR;
	string GLOW_ON;
	string HALF_HEALTH;
	int HEALTH_AMMO;
	string HEALTH_POT_DELAY;
	string IN_RESIST;
	int KICK_ATTACK;
	string LEAP_TARGET;
	int LEGAL_ACT;
	int LIGHTNING_STRUCK;
	string MELEE_HIT;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	string NEXT_ATTACK;
	int NORM_ATTACK;
	string NOVA_ATTACK;
	int NOVA_PICK_ATK;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	int NPC_FORCED_MOVEDEST;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_NO_MOVE;
	string ORIG_ATTACK;
	string ORIG_FREQ_ATTACK;
	string ORIG_MOVE_RANGE;
	string ORIG_WEAPON;
	int POISON_STRUCK;
	string POWER_ATTACK;
	int PULL_DELAY;
	string QUARTER_HEALTH;
	int RESIST_AMMO;
	string SCATTER_COUNT;
	string SCATTER_SHOT;
	string SOUND_BOW_SHOOT;
	string SOUND_BOW_STRETCH;
	string SOUND_DEATH;
	string SOUND_LEAP;
	string SOUND_PAIN;
	string SOUND_PAIN2;
	string SOUND_PARRY;
	string SOUND_POWERUP;
	string SOUND_PULL;
	string SOUND_SATTACK;
	string SOUND_SWING_FAST;
	string SOUND_SWING_SLOW1;
	string SOUND_SWING_SLOW2;
	string SOUND_TAUNT1;
	string SOUND_TAUNT2;
	int SPECIAL_AMMO;
	string SPEC_TYPE;
	int STUN_ATTACK;
	int SWEEP_KICK_DELAY;
	string USED_COLD_POT;
	string USED_FIRE_POT;
	string USED_LIGHTNING_POT;
	string USED_POISON_POT;

	BanditBoss()
	{
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 0.25;
		if (StringToLower(GetMapName()) == "the_keep")
		{
			NPC_IS_BOSS = 1;
		}
		ANIM_DRINK = "swordready1_R";
		ANIM_AXE_FAST = "battleaxe_swing1_R";
		ANIM_AXE_SLOW = "battleaxe_swing1_L";
		ANIM_SWORD_FAST = "longsword_swipe_R";
		ANIM_SWORD_SLOW = "longsword_swipe_L";
		ANIM_BOW = "shootbow";
		ANIM_SWING_SLOW = "swordswing1_R";
		ANIM_SWING_FAST = "swordswing2_R";
		ANIM_JAB = "swordjab1_R";
		ANIM_KICK_HIGH = "stance_normal_highkick_r1";
		ANIM_KICK_LOW = "stance_normal_lowkick_r1";
		ANIM_PARRY = "longsword_parry";
		ANIM_SPELL = "prepare_fireball";
		ANIM_CAST = "throw_fireball_R";
		ANIM_FLINCH = ANIM_PARRY;
		ANIM_WALK_NORM = "walk2";
		ANIM_RUN_NORM = "run";
		ANIM_MOVE_SLOW = "run_squatwalk1_R";
		ANIM_WALK = "walk2";
		ANIM_RUN = "run";
		ANIM_HOP = "jump";
		ANIM_LEAP = "long_jump";
		ANIM_DEATH = "die_backwards1";
		SOUND_PARRY = "weapons/parry.wav";
		SOUND_POWERUP = "voices/big_swordready.wav";
		SOUND_LEAP = "voices/big_shout1.wav";
		SOUND_SATTACK = "voices/big_shout1.wav";
		SOUND_TAUNT1 = "voices/big_yeah1.wav";
		SOUND_TAUNT2 = "voices/big_taunt1.wav";
		SOUND_PULL = "voices/big_pull.wav";
		SOUND_SWING_FAST = "weapons/cbar_miss1.wav";
		SOUND_SWING_SLOW1 = "zombie/claw_miss1.wav";
		SOUND_SWING_SLOW2 = "zombie/claw_miss2.wav";
		SOUND_DEATH = "voices/big_death.wav";
		SOUND_BOW_STRETCH = "weapons/bow/stretch.wav";
		SOUND_BOW_SHOOT = "weapons/bow/crossbow.wav";
		SOUND_PAIN = "voices/big_chesthit1.wav";
		SOUND_PAIN2 = "voices/big_armhit1.wav";
		FREQ_HEALTH = 20.0;
		FREQ_PULL = 10.0;
		FREQ_KICK = RandomInt(10, 30);
		FREQ_VOLCANO = 45.0;
		FREQ_TURBO = Random(40, 60);
		FREQ_SPECIAL = Random(15, 30);
		FREQ_INVIS = RandomInt(30, 120);
		FREQ_FLANK = 5.0;
		FREQ_AVOID = 10.0;
		CAN_FLINCH = 1;
		FLINCH_DAMAGE_THRESHOLD = 75;
		FLINCH_CHANCE = 50;
		FLINCH_ANIM = "longsword_parry";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 180;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_MOVERANGE = 90;
		MOVE_RANGE = 90;
		DMG_KICK = RandomInt(50, 100);
		DMG_MACE = RandomInt(300, 500);
		DMG_SWORD_FAST = RandomInt(30, 80);
		DMG_SWORD_SLOW = RandomInt(50, 100);
		DMG_SWORD_JAB = RandomInt(50, 100);
		DMG_SWING_FAST = RandomInt(30, 80);
		DMG_SWING_SLOW = RandomInt(50, 100);
		DMG_AXE_FAST = RandomInt(80, 150);
		DMG_AXE_SLOW = RandomInt(400, 600);
		DMG_DAGGER = RandomInt(30, 80);
		DMG_NOVA_SLOW = RandomInt(100, 300);
		DMG_NOVA_FAST = RandomInt(50, 100);
		DMG_NOVA_STAB = RandomInt(100, 200);
		DMG_BURN_DAGGER = RandomInt(10, 20);
		DMG_BURN_MACE = RandomInt(30, 60);
		DMG_FLAME_BURST = 400;
		DMG_FIRE_BALL = 200;
		DMG_ARROW = RandomInt(50, 100);
		DMG_BLIZ = 50;
		DMG_SKULL = 60;
		ELEMENT_LIMIT = 5;
		ELEMENT_DMG_THRESH = 30;
		ARROW_SPEED = 1200;
		AS_ATK_VALUE = 10;
		BEAM_SPRITE = "lgtning.spr";
		MONSTER_MODEL = "npc/bandit_boss.mdl";
		Precache(MONSTER_MODEL);
		Precache("nhth1.spr");
		Precache("ambience/alienflyby1.wav");
		Precache("monsters/bat.mdl");
		Precache("misc/gold.wav");
		Precache("amb/quest1.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2.0);
		if ((SUSPEND_AI))
		{
			BD_COUNT += 1;
		}
		if (!(SUSPEND_AI))
		{
			BD_COUNT = 0;
		}
		if (BD_COUNT > 20)
		{
			npcatk_resume_ai();
		}
	}

	void game_precache()
	{
		Precache("monsters/summon/ice_blast");
		Precache("monsters/summon/summon_blizzard");
		Precache("monsters/summon/stun_burst");
		Precache("monsters/summon/flame_burst");
		Precache("monsters/summon/bandit_boss_fire_wall");
		Precache("monsters/summon/flame_burst");
		Precache("monsters/summon/npc_volcano");
		Precache("monsters/summon/flame_skull");
		Precache("helena/bandit_boss_chest");
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		SetModel(MONSTER_MODEL);
		SetWidth(40);
		SetHeight(120);
		SetRace("rogue");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("stun", 0.5);
		SetSayTextRange(2048);
		SetRoam(true);
		SetHealth(9999);
		SetHearingSensitivity(8);
		HEALTH_AMMO = 1;
		RESIST_AMMO = 2;
		SPECIAL_AMMO = 2;
		FIRE_STRUCK = 0;
		COLD_STRUCK = 0;
		POISON_STRUCK = 0;
		LIGHTNING_STRUCK = 0;
		FAST_SWINGS = 0;
		NEXT_ATTACK = "unset";
		BD_COUNT = 0;
		NOVA_PICK_ATK = 0;
		ANIM_RUN = "run";
		ANIM_WALK = "walk2";
		ScheduleDelayedEvent(0.1, "setup_boss");
	}

	void setup_boss()
	{
		if (!(BOSS_TYPE_OVERRIDE))
		{
			BOSS_TYPE = RandomInt(1, 6);
		}
		if (BOSS_TYPE == 1)
		{
			SetName("Plevmus of the Hidden Knife");
			SetHealth(2500);
			SetModelBody(1, 1);
			ANIM_ATTACK = ANIM_JAB;
			SetSkillLevel(1000);
		}
		if (BOSS_TYPE == 2)
		{
			SetName("Golgar the Hammer");
			SetHealth(6000);
			SetModelBody(1, 2);
			ANIM_ATTACK = ANIM_AXE_SLOW;
			NPC_GIVE_EXP = 1000;
		}
		if (BOSS_TYPE == 3)
		{
			SetName("Vultekh of the Runes");
			SetHealth(4000);
			SetModelBody(1, 3);
			ANIM_ATTACK = ANIM_AXE_FAST;
			NPC_GIVE_EXP = 1000;
		}
		if (BOSS_TYPE == 4)
		{
			SetName("Kryoh of the Frozen Blade");
			SetHealth(3000);
			SetModelBody(1, 4);
			ATTACK_MOVERANGE = 256;
			ANIM_ATTACK = ANIM_SWING_FAST;
			NPC_GIVE_EXP = 1500;
		}
		if (BOSS_TYPE == 5)
		{
			SetName("Xaron of the Orion Bow");
			SetHealth(3000);
			SetModelBody(1, 5);
			ANIM_ATTACK = ANIM_BOW;
			NPC_GIVE_EXP = 2000;
		}
		if (BOSS_TYPE == 6)
		{
			SetName("Demonicus of the Burning Blade");
			SetHealth(6000);
			SetModelBody(1, 6);
			SetStat("parry", 100);
			ANIM_ATTACK = ANIM_SWORD_FAST;
			NPC_GIVE_EXP = 500;
		}
		if (StringToLower(GetMapName()) == "helena")
		{
			NPC_GIVE_EXP *= 4;
		}
		SetMoveAnim(ANIM_WALK);
		string L_MAP_NAME = StringToLower(GetMapName());
		int GENERIC_NAME = 1;
		if (L_MAP_NAME == "keep_test")
		{
			int GENERIC_NAME = 0;
		}
		if (L_MAP_NAME == "the_keep")
		{
			int GENERIC_NAME = 0;
		}
		if ((GENERIC_NAME))
		{
			SetName("Bandit Leader");
		}
		SetInvincible(false);
	}

	void OnPostSpawn() override
	{
		ORIG_MOVE_RANGE = ATTACK_MOVERANGE;
		HALF_HEALTH = GetMonsterMaxHP();
		HALF_HEALTH /= 2;
		FIRST_SPEC_POT_HEALTH = GetMonsterMaxHP();
		FIRST_SPEC_POT_HEALTH *= 0.75;
		QUARTER_HEALTH = GetMonsterMaxHP();
		QUARTER_HEALTH *= 0.25;
		ORIG_ATTACK = ANIM_ATTACK;
		ORIG_WEAPON = BOSS_TYPE;
		if ((BOSS_TYPE + "=" + 1))
		{
			FREQ_ATTACK = 0.25;
		}
		if ((BOSS_TYPE + "=" + 2))
		{
			FREQ_ATTACK = 2.0;
		}
		if ((BOSS_TYPE + "=" + 3))
		{
			FREQ_ATTACK = 1.75;
		}
		if ((BOSS_TYPE + "=" + 4))
		{
			FREQ_ATTACK = 0.25;
		}
		if ((BOSS_TYPE + "=" + 5))
		{
			FREQ_ATTACK = 0.1;
		}
		if ((BOSS_TYPE + "=" + 6))
		{
			FREQ_ATTACK = 1.5;
		}
		ORIG_FREQ_ATTACK = FREQ_ATTACK;
	}

	void OnDamage(int damage) override
	{
		if (!(GetMonsterProperty("isalive"))) return;
		if (param2 > 30)
		{
			// TODO: getents player 128
			if (getCount >= 3)
			{
				if (!(SWEEP_KICK_DELAY))
				{
				}
				if (!(DRINKING_POT))
				{
				}
				if (BOSS_TYPE != 5)
				{
				}
				SWEEP_KICK_DELAY = 1;
				FREQ_KICK("reset_sweep_kick_delay");
				int SWEEP_KICK = 1;
				CAN_FLINCH = 0;
				AS_ATTACKING = GetGameTime();
				PlayAnim("critical", ANIM_KICK_LOW);
			}
		}
		if (BOSS_TYPE == 5)
		{
			if (GetEntityRange(param1) < 120)
			{
			}
			if (!(AVOID_DELAY))
			{
			}
			if (!(DRINKING_POT))
			{
			}
			AVOID_DELAY = 1;
			FREQ_AVOID("reset_avoid_delay");
			int AVOID_TYPE = RandomInt(1, 3);
			AS_ATTACKING = GetGameTime();
			if (AVOID_TYPE == 1)
			{
				leap_away(GetEntityIndex(param1));
			}
			if (AVOID_TYPE == 2)
			{
				PlayAnim("critical", ANIM_KICK_HIGH);
			}
			if (AVOID_TYPE == 3)
			{
				PlayAnim("critical", ANIM_KICK_LOW);
			}
		}
		if (HEALTH_AMMO > 0)
		{
			if (!(AM_INVISIBLE))
			{
			}
			if (!(DRINKING_POT))
			{
			}
			if (GetMonsterHP() < HALF_HEALTH)
			{
			}
			if (!(HEALTH_POT_DELAY))
			{
			}
			HEALTH_POT_DELAY = 1;
			FREQ_HEALTH("reset_health_pot_delay");
			drink_pot("health");
		}
		if (!(DID_FIRST_POT))
		{
			if (!(DRINKING_POT))
			{
			}
			if (!(SPEC_TYPE))
			{
			}
			if (GetMonsterHP() < FIRST_SPEC_POT_HEALTH)
			{
			}
			DID_FIRST_POT = 1;
			drink_special();
		}
		if (!(DID_SECOND_POT))
		{
			if (!(DRINKING_POT))
			{
			}
			if (!(SPEC_TYPE))
			{
			}
			if (GetMonsterHP() < QUARTER_HEALTH)
			{
			}
			DID_SECOND_POT = 1;
			drink_special();
		}
		if (GetEntityRange(param1) > ATTACK_HITRANGE)
		{
			if (BOSS_TYPE != 5)
			{
				if (!(AM_INVISIBLE))
				{
				}
				if (!(DRINKING_POT))
				{
				}
				PULL_TARGET = param1;
				if (param2 > 20)
				{
					int PULL_CHANCE = RandomInt(1, 10);
				}
				if (param2 > 60)
				{
					int PULL_CHANCE = RandomInt(1, 2);
				}
				if (!(PULL_DELAY))
				{
				}
				PULL_DELAY = 1;
				FREQ_PULL("reset_pull_delay");
				tractor_beam(PULL_TARGET);
			}
		}
		if (RESIST_AMMO > 0)
		{
			if (param2 > ELEMENT_DMG_THRESH)
			{
			}
			if (!(AM_INVISIBLE))
			{
			}
			if (!(DRINKING_POT))
			{
			}
			if (!(IN_RESIST))
			{
			}
			if (param3 == "fire")
			{
				FIRE_STRUCK += 1;
			}
			if (param3 == "cold")
			{
				COLD_STRUCK += 1;
			}
			if (param3 == "lightning")
			{
				LIGHTNING_STRUCK += 1;
			}
			if (param3 == "poison")
			{
				POISON_STRUCK += 1;
			}
			if (FIRE_STRUCK >= ELEMENT_LIMIT)
			{
				if (!(USED_FIRE_POT))
				{
					drink_pot("fire");
				}
			}
			if (COLD_STRUCK >= ELEMENT_LIMIT)
			{
				if (!(USED_COLD_POT))
				{
					drink_pot("cold");
				}
			}
			if (LIGHTNING_STRUCK >= ELEMENT_LIMIT)
			{
				if (!(USED_LIGHTNING_POT))
				{
					drink_pot("lightning");
				}
			}
			if (POISON_STRUCK >= ELEMENT_LIMIT)
			{
				if (!(USED_POISON_POT))
				{
					drink_pot("poison");
				}
			}
		}
	}

	void reset_avoid_delay()
	{
		AVOID_DELAY = 0;
	}

	void reset_sweep_kick_delay()
	{
		SWEEP_KICK_DELAY = 0;
	}

	void reset_health_pot_delay()
	{
		HEALTH_POT_DELAY = 0;
	}

	void reset_pull_delay()
	{
		PULL_DELAY = 0;
	}

	void drink_special()
	{
		int RND_POT = RandomInt(1, 3);
		if (BOSS_TYPE == 1)
		{
			int RND_POT = RandomInt(1, 2);
		}
		if (RND_POT == 1)
		{
			drink_pot("demon");
		}
		if (RND_POT == 2)
		{
			drink_pot("protection");
		}
		if (RND_POT == 3)
		{
			drink_pot("speed");
		}
	}

	void drink_pot()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		if ((DRINKING_POT)) return;
		DRINKING_POT = 1;
		if (param1 != "health")
		{
			SetModelBody(1, 8);
		}
		if (param1 == "health")
		{
			SetModelBody(1, 7);
		}
		npcatk_suspend_ai(2.0);
		PlayAnim("once", "break");
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_DRINK);
		DRINK_TYPE = param1;
	}

	void drink_done()
	{
		npcatk_resume_ai();
		DRINKING_POT = 0;
		EmitSound(GetOwner(), 0, "items/drink.wav", 10);
		if (DRINK_TYPE == "fire")
		{
			USED_FIRE_POT = 1;
			RESIST_AMMO -= 1;
			IN_RESIST = 1;
			Vector3 GLOW_COLOR = Vector3(255, 0, 0);
			SetDamageResistance("fire", 0.5);
			ScheduleDelayedEvent(60, "normal_immune");
			string OUT_MSG = GetMonsterProperty("name");
			OUT_MSG += " has drank a potion and is now resistant to fire!";
			SendInfoMsg("all", "POTION OF RESISTANCE TO FIRE " + OUT_MSG);
		}
		if (DRINK_TYPE == "cold")
		{
			USED_COLD_POT = 1;
			RESIST_AMMO -= 1;
			IN_RESIST = 1;
			Vector3 GLOW_COLOR = Vector3(128, 128, 255);
			SetDamageResistance("cold", 0.5);
			ScheduleDelayedEvent(60, "normal_immune");
			string OUT_MSG = GetMonsterProperty("name");
			OUT_MSG += " has drank a potion and is now resistant to cold!";
			SendInfoMsg("all", "POTION OF RESISTANCE TO COLD " + OUT_MSG);
		}
		if (DRINK_TYPE == "poison")
		{
			USED_POISON_POT = 1;
			RESIST_AMMO -= 1;
			IN_RESIST = 1;
			Vector3 GLOW_COLOR = Vector3(0, 255, 0);
			SetDamageResistance("poison", 0.5);
			ScheduleDelayedEvent(60, "normal_immune");
			string OUT_MSG = GetMonsterProperty("name");
			OUT_MSG += " has drank a potion and is now resistant to poison!";
			SendInfoMsg("all", "POTION OF RESISTANCE TO POISON " + OUT_MSG);
		}
		if (DRINK_TYPE == "lightning")
		{
			USED_LIGHTNING_POT = 1;
			RESIST_AMMO -= 1;
			IN_RESIST = 1;
			Vector3 GLOW_COLOR = Vector3(255, 255, 0);
			SetDamageResistance("lightning", 0.5);
			ScheduleDelayedEvent(60, "normal_immune");
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += " has drank a potion and is now resistant to lightning!";
			SendInfoMsg("all", "POTION OF RESISTANCE TO LIGHTNING " + OUT_MSG);
		}
		if (DRINK_TYPE == "health")
		{
			HEALTH_AMMO -= 1;
			Vector3 GLOW_COLOR = Vector3(0, 255, 0);
			string HP_GIVE = GetMonsterMaxHP();
			HP_GIVE -= GetMonsterHP();
			HealEntity(GetOwner(), HP_GIVE);
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += " has used a potion of health!";
			SendInfoMsg("all", "POTION OF HEALTH " + OUT_MSG);
		}
		if (DRINK_TYPE == "protection")
		{
			SPEC_TYPE = "protection";
			Vector3 GLOW_COLOR = Vector3(255, 255, 255);
			GLOW_ON = 1;
			GLOW_LOOP_COLOR = Vector3(255, 255, 255);
			ScheduleDelayedEvent(5.0, "glow_loop");
			SetDamageResistance("all", 0.25);
			ScheduleDelayedEvent(60, "end_special_effect");
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += " has used a potion of protection!";
			SendInfoMsg("all", "POTION OF PROTECTION " + OUT_MSG);
		}
		if (DRINK_TYPE == "demon")
		{
			SPEC_TYPE = "demon";
			Vector3 GLOW_COLOR = Vector3(255, 0, 0);
			DEMON_NOHP_LOSS = 1;
			ScheduleDelayedEvent(5.0, "demon_blood");
			ScheduleDelayedEvent(60, "end_special_effect");
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += " has used a vial of demon blood!";
			SendInfoMsg("all", "POTION OF DEMON BLOOD " + OUT_MSG);
		}
		if (DRINK_TYPE == "speed")
		{
			if (BOSS_TYPE != 1)
			{
			}
			SPEC_TYPE = "speed";
			Vector3 GLOW_COLOR = Vector3(255, 0, 255);
			ScheduleDelayedEvent(5.0, "turbo_on");
			ScheduleDelayedEvent(60, "end_special_effect");
			FREQ_ATTACK /= 2;
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += " has used a potion of speed!";
			SendInfoMsg("all", "POTION OF SPEED " + OUT_MSG);
		}
		Effect("glow", GetOwner(), GLOW_COLOR, 128, 5, 5);
		DRINK_TYPE = "unset";
		SetModelBody(1, ORIG_WEAPON);
	}

	void normal_immune()
	{
		IN_RESIST = 0;
	}

	void OnFlinch()
	{
		npcatk_resume_ai();
		if (DRINK_TYPE == "health")
		{
			SpawnItem("health_spotion", /* TODO: $relpos */ $relpos(0, 0, 0));
		}
	}

	void npcatk_resume_ai()
	{
		SetModelBody(1, ORIG_WEAPON);
		DRINKING_POT = 0;
	}

	void npcatk_checkflinch()
	{
		if ((CAN_FLINCH))
		{
			if (!(FLINCHED_RECENTLY))
			{
			}
			if (GetMonsterHP() < HALF_HEALTH)
			{
				if (param1 > FLINCH_DAMAGE_THRESHOLD)
				{
				}
				if (RandomInt(1, 100) <= FLINCH_CHANCE)
				{
					npc_flinch();
					PlayAnim("once", "break");
					AS_ATTACKING = GetGameTime();
					PlayAnim("critical", FLINCH_ANIM);
				}
				FLINCHED_RECENTLY = 1;
				FLINCH_DELAY("npcatk_reset_flinch");
			}
		}
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_PARRY);
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
	}

	void end_special_effect()
	{
		if (SPEC_TYPE == "demon")
		{
			DEMON_BLOOD = 0;
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += "'s demon blood potion has run out.";
			SendInfoMsg("all", "EFFECT ENDED " + OUT_MSG);
		}
		if (SPEC_TYPE == "protection")
		{
			SetDamageResistance("all", 0.5);
			GLOW_ON = 0;
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += "'s protection potion has run out.";
			SendInfoMsg("all", "EFFECTED ENDED " + OUT_MSG);
		}
		if (SPEC_TYPE == "speed")
		{
			FREQ_ATTACK = ORIG_FREQ_ATTACK;
			turbo_off();
			string OUT_MSG = GetMonsterProperty("name.full");
			OUT_MSG += "'s speed potion has run out.";
			SendInfoMsg("all", "EFFECTED ENDED " + OUT_MSG);
		}
		SPEC_TYPE = 0;
	}

	void turbo_on()
	{
		if (!(GLOW_ON))
		{
			GLOW_ON = 1;
			GLOW_LOOP_COLOR = Vector3(255, 255, 0);
			glow_loop();
		}
		SPEC_TYPE = "speed";
		SetMoveSpeed(2.0);
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(3.0);
		BASE_FRAMERATE = 3.0;
		BASE_MOVESPEED = 3.0;
		ScheduleDelayedEvent(0.1, "stuck_fix");
	}

	void stuck_fix()
	{
		PlayAnim("critical", ANIM_ATTACK);
	}

	void do_turbo()
	{
		turbo_on();
		ScheduleDelayedEvent(10.0, "turbo_off");
	}

	void turbo_off()
	{
		SetMoveSpeed(1.0);
		SetAnimMoveSpeed(1.0);
		SetAnimFrameRate(1.0);
		BASE_FRAMERATE = 1.0;
		BASE_MOVESPEED = 1.0;
		if (BOSS_TYPE == 1)
		{
			FREQ_TURBO("do_turbo");
		}
	}

	void tractor_beam()
	{
		DOING_PULL = 1;
		if (!(GetEntityRange(PULL_TARGET) < 4000)) return;
		npcatk_suspend_ai();
		SetMoveDest(PULL_TARGET);
		EmitSound(GetOwner(), 0, SOUND_PULL, 10);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_JAB);
		string BEAM_START = /* TODO: $relpos */ $relpos(0, 0, 60);
		string BEAM_END = GetEntityOrigin(PULL_TARGET);
		Effect("beam", "end", BEAM_SPRITE, 30, BEAM_START, PULL_TARGET, 0, Vector3(255, 255, 0), 200, 30, 1.5);
		ScheduleDelayedEvent(1.0, "tractor_beam2");
	}

	void tractor_beam2()
	{
		SayText("Get over here!");
		SetAngles("face");
		AddVelocity(PULL_TARGET, /* TODO: $relvel */ $relvel(10, -3000, 10));
		ScheduleDelayedEvent(0.25, "npcatk_resume_ai");
		ScheduleDelayedEvent(0.5, "tractor_beam3");
	}

	void tractor_beam3()
	{
		SetAngles("face");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		SetAngles("face");
		npcatk_settarget(PULL_TARGET);
	}

	void kick_low()
	{
		KICK_ATTACK = 1;
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 256, 1, 100
		npcatk_dodamage(m_hAttackTarget, ATTACK_RANGE, DMG_KICK, 1.0, "blunt");
		CAN_FLINCH = 1;
		ANIM_ATTACK = ORIG_ATTACK;
	}

	void kick_high()
	{
		KICK_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, 1.0, "blunt");
		ANIM_ATTACK = ORIG_ATTACK;
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if (GetEntityRange(param2) < ATTACK_HITRANGE)
			{
			}
			if ((KICK_ATTACK))
			{
				ApplyEffect(param2, "effects/debuff_stun", 10, GetEntityIndex(GetOwner()));
				if (BOSS_TYPE == 5)
				{
					AddVelocity(param2, /* TODO: $relvel */ $relvel(10, 800, 10));
				}
				ANIM_ATTACK = ORIG_ATTACK;
			}
			if ((FREEZE_ATTACK))
			{
				int FREEZE_CHANCE = RandomInt(1, 4);
				if (FREEZE_CHANCE < 4)
				{
					EmitSound(GetOwner(), 0, "playsound", 10);
					ApplyEffect(param2, "effects/dot_cold_freeze", 10, GetEntityIndex(GetOwner()), 30);
				}
				if (FREEZE_CHANCE == 4)
				{
					EmitSound(GetOwner(), 0, "debris/zap1.wav", 10);
				}
				ANIM_ATTACK = ORIG_ATTACK;
			}
			if ((STUN_ATTACK))
			{
				ApplyEffect(param2, "effects/debuff_stun", 10, GetEntityIndex(GetOwner()));
			}
			if ((MELEE_HIT))
			{
			}
			MELEE_HIT = 0;
			if (BOSS_TYPE == 1)
			{
				if (!(KICK_ATTACK))
				{
				}
				ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_BURN_DAGGER);
			}
			if (BOSS_TYPE == 2)
			{
				if (!(KICK_ATTACK))
				{
				}
				ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_BURN_MACE);
			}
			if (BOSS_TYPE == 6)
			{
				if ((NORM_ATTACK))
				{
				}
				ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_BURN_MACE);
			}
		}
		KICK_ATTACK = 0;
		FREEZE_ATTACK = 0;
		STUN_ATTACK = 0;
		NORM_ATTACK = 0;
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_KICK("do_kick");
		if (BOSS_TYPE == 1)
		{
			FREQ_SPECIAL("do_special");
			FREQ_TURBO("do_turbo");
			FREQ_INVIS("do_invis");
		}
		if (BOSS_TYPE == 2)
		{
			FREQ_SPECIAL("do_special");
		}
		if (BOSS_TYPE == 3)
		{
			FREQ_SPECIAL("do_special");
		}
		if (BOSS_TYPE == 4)
		{
			FREQ_SPECIAL("do_special");
		}
		if (BOSS_TYPE == 5)
		{
			FREQ_SPECIAL("do_special");
			FREQ_INVIS("do_invis");
		}
		if (BOSS_TYPE == 6)
		{
			FREQ_VOLCANO("do_volcano");
			FREQ_SPECIAL("do_special");
		}
	}

	void do_special()
	{
		string L_FREQ_SPECIAL = FREQ_SPECIAL;
		check_legal_act();
		if (!(LEGAL_ACT))
		{
			int L_FREQ_SPECIAL = 5;
		}
		string CAN_SEE_NME = false;
		if (!(CAN_SEE_NME))
		{
			int L_FREQ_SPECIAL = 5;
		}
		L_FREQ_SPECIAL("do_special");
		if (!(CAN_SEE_NME)) return;
		if (!(LEGAL_ACT)) return;
		if (BOSS_TYPE == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 128, 3, 3);
			AS_ATTACKING = 20;
			PlayAnim("critical", ANIM_SPELL);
		}
		if (BOSS_TYPE == 2)
		{
			NEXT_ATTACK = ANIM_SWORD_SLOW;
		}
		if (BOSS_TYPE == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
			PlayAnim("once", "break");
			LEAP_TARGET = GetEntityIndex(m_hLastSeen);
			POWER_ATTACK = 1;
			if (GetEntityRange(LEAP_TARGET) < 200)
			{
				PURE_FLEE = 1;
				npcatk_flee(LEAP_TARGET, 300, 2.0);
				ScheduleDelayedEvent(2.1, "leap_scan");
				int LEAP_EXIT_SUB = 1;
			}
			if (!(LEAP_EXIT_SUB))
			{
			}
			ScheduleDelayedEvent(0.1, "leap_scan");
		}
		if (BOSS_TYPE == 4)
		{
			int PICK_ATK = RandomInt(1, 2);
			if (PICK_ATK == 1)
			{
				npcatk_find_distant(2048);
				npcatk_suspend_ai();
				SetMoveDest(NPC_MOST_DISTANT);
				BLIZZ_TARGET = NPC_MOST_DISTANT;
				ScheduleDelayedEvent(0.1, "go_blizz");
			}
			if (PICK_ATK == 2)
			{
				Effect("glow", GetOwner(), Vector3(128, 128, 255), 128, 3, 3);
				ScheduleDelayedEvent(2.0, "do_sphere");
			}
		}
		if (BOSS_TYPE == 5)
		{
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
			Effect("glow", GetOwner(), Vector3(0, 255, 255), 128, 3, 3);
			SCATTER_SHOT = 1;
		}
		if (BOSS_TYPE == 6)
		{
			NOVA_PICK_ATK += 1;
			DOING_NOVA = 1;
			ScheduleDelayedEvent(10.0, "reset_doing_nova");
			if (NOVA_PICK_ATK > 4)
			{
				NOVA_PICK_ATK = 1;
			}
			if (NOVA_PICK_ATK == 1)
			{
				npcatk_find_distant(2048);
				SetMoveDest(NPC_MOST_DISTANT);
				NOvA_TARGET = NPC_MOST_DISTANT;
				EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
				AS_ATTACKING = 20;
				NOVA_ATTACK = "fire_wall";
				ScheduleDelayedEvent(0.1, "do_fire_wall");
			}
			if (NOVA_PICK_ATK == 2)
			{
				NOVA_ATTACK = "flame_burst";
				EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
				Effect("glow", GetOwner(), Vector3(255, 0, 0), 128, 3, 3);
				AS_ATTACKING = 20;
				PlayAnim("critical", ANIM_SPELL);
			}
			if (NOVA_PICK_ATK == 3)
			{
				EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
				Effect("glow", GetOwner(), Vector3(255, 72, 0), 128, 3, 3);
				ScheduleDelayedEvent(2.0, "do_fireball");
			}
			if (NOVA_PICK_ATK == 4)
			{
				NOVA_ATTACK = "flame_skull";
				EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
				Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 3, 3);
				AS_ATTACKING = 20;
				PlayAnim("critical", ANIM_SPELL);
			}
		}
	}

	void reset_doing_nova()
	{
		DOING_NOVA = 0;
	}

	void do_fire_wall()
	{
		PlayAnim("critical", ANIM_SPELL);
		Effect("glow", GetOwner(), Vector3(255, 255, 128), 128, 3, 3);
	}

	void do_fireball()
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_JAB);
	}

	void do_sphere()
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_JAB);
		EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
		SpawnNPC("monsters/summon/ice_blast", /* TODO: $relpos */ $relpos(0, 64, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 20.0, /* TODO: $relpos */ $relpos(0, 2000, 0)
	}

	void go_blizz()
	{
		EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_JAB);
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 128, 3, 3);
		string BLIZZ_POS = GetEntityOrigin(BLIZZ_TARGET);
		SpawnNPC("monsters/summon/summon_blizzard", BLIZZ_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityAngles(GetOwner()), DMG_BLIZZ, 20.0
		npcatk_resume_ai();
	}

	void do_kick()
	{
		FREQ_KICK("do_kick");
		check_legal_act();
		if (!(LEGAL_ACT)) return;
		int KICK_TYPE = RandomInt(1, 3);
		if (KICK_TYPE <= 2)
		{
			NEXT_ATTACK = ANIM_KICK_HIGH;
		}
		if (KICK_TYPE == 3)
		{
			NEXT_ATTACK = ANIM_KICK_LOW;
		}
	}

	void do_volcano()
	{
		string L_FREQ_VOLCANO = FREQ_VOLCANO;
		check_legal_act();
		if ((DOING_NOVA))
		{
			float L_FREQ_VOLCANO = 5.0;
		}
		if (!(LEGAL_ACT))
		{
			float L_FREQ_VOLCANO = 5.0;
		}
		L_FREQ_VOLCANO("do_volcano");
		if (!(LEGAL_ACT)) return;
		if ((DOING_NOVA)) return;
		NOVA_ATTACK = "volcano";
		AS_ATTACKING = 20;
		PlayAnim("critical", ANIM_SPELL);
	}

	void do_scatter_shot()
	{
		SCATTER_COUNT += 1;
		if (SCATTER_COUNT < 10)
		{
			ScheduleDelayedEvent(0.1, "do_scatter_shot");
		}
		EmitSound(GetOwner(), 0, SOUND_BOW_SHOOT, 10);
		int RND_ARROW = RandomInt(1, 3);
		string FIN_DMG = DMG_ARROW;
		if (RND_ARROW == 1)
		{
			string ARROW_TYPE = "proj_arrow_frost";
		}
		if (RND_ARROW == 2)
		{
			string ARROW_TYPE = "proj_arrow_gpoison";
		}
		if (RND_ARROW == 3)
		{
			string ARROW_TYPE = "proj_arrow_jagged";
			FIN_DMG *= 4;
		}
		TossProjectile(ARROW_TYPE, /* TODO: $relpos */ $relpos(0, 32, 32), "none", ARROW_SPEED, FIN_DMG, 10, "none");
		CallExternal("ent_lastprojectile", "ext_lighten", 0.1);
	}

	void axe_fast()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			NORM_ATTACK = 1;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
		}
		if (BOSS_TYPE == 3)
		{
			if (RandomInt(1, 10) == 1)
			{
			}
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 1, 1);
			NEXT_ATTACK = ANIM_AXE_SLOW;
		}
	}

	void axe_slow()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		if (BOSS_TYPE == 3)
		{
			NEXT_ATTACK = ANIM_SWING_FAST;
			EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
		}
		if (BOSS_TYPE != 3)
		{
			NORM_ATTACK = 1;
		}
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_SLOW, ATTACK_HITCHANCE, "blunt");
			MELEE_HIT = 1;
		}
	}

	void sword_fast()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		NORM_ATTACK = 1;
		if (BOSS_TYPE == 6)
		{
			if (RandomInt(1, 10) == 1)
			{
			}
			NEXT_ATTACK = ANIM_SWORD_SLOW;
		}
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD_FAST, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
		}
	}

	void sword_slow()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		if (BOSS_TYPE == 2)
		{
			STUN_ATTACK = 1;
			ANIM_ATTACK = ORIG_ATTACK;
			SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 256, 0, 200
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD_SLOW, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
		}
		if (BOSS_TYPE != 2)
		{
			NORM_ATTACK = 1;
		}
	}

	void swing_slow()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		NORM_ATTACK = 1;
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWING_SLOW, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
		}
	}

	void swing_fast()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		if (BOSS_TYPE == 3)
		{
			FAST_SWINGS += 1;
			if (FAST_SWINGS >= 20)
			{
				NEXT_ATTACK = ANIM_AXE_FAST;
				FAST_SWINGS = 0;
			}
		}
		NORM_ATTACK = 1;
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		else
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWING_FAST, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
		}
	}

	void attack_jab()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		if ((DOING_PULL))
		{
			DOING_PULL = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (BOSS_TYPE == 1)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_DAGGER, ATTACK_HITCHANCE, "slash");
			MELEE_HIT = 1;
			if (RandomInt(1, 20) == 1)
			{
				if (!(FLANK_DELAY))
				{
				}
				FLANK_DELAY = 1;
				FREQ_FLANK("flank_delay_reset");
				npcatk_flank(m_hAttackTarget);
			}
		}
		if (BOSS_TYPE == 2)
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE_FAST, ATTACK_HITCHANCE, "dark");
			MELEE_HIT = 1;
		}
		if (BOSS_TYPE == 4)
		{
			EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
			FREEZE_ATTACK = 1;
			ANIM_ATTACK = ORIG_ATTACK;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD_STAB, ATTACK_HITCHANCE, "pierce");
			MELEE_HIT = 1;
		}
		if (BOSS_TYPE == 6)
		{
			EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
			ANIM_ATTACK = ORIG_ATTACK;
			TossProjectile("proj_fire_ball2", /* TODO: $relpos */ $relpos(0, 48, 36), "none", 200, DMG_FIRE_BALL, 0, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "lighten", 20);
		}
	}

	void prep_done()
	{
		BB_IN_ATTACK = 0;
		if (BOSS_TYPE == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
			SpawnNPC("monsters/summon/flame_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FLAME_BURST, 1
		}
		if (BOSS_TYPE == 6)
		{
			if (NOVA_ATTACK == "fire_wall")
			{
				EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
				SpawnNPC("monsters/summon/bandit_boss_fire_wall", GetEntityOrigin(NOvA_TARGET), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityAngles(GetOwner()), 75, 20
			}
			if (NOVA_ATTACK == "flame_burst")
			{
				EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
				string BURST_DAM = DMG_FLAME_BURST;
				BURST_DAM *= 2;
				SpawnNPC("monsters/summon/flame_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), BURST_DAM, 1
			}
			if (NOVA_ATTACK == "volcano")
			{
				if ((false))
				{
					string pos = GetEntityOrigin(m_hLastSeen);
				}
				if (GetRelationship(m_hLastSeen) == "enemy")
				{
					string pos = GetEntityOrigin(m_hLastSeen);
				}
				if (!(false))
				{
					if (Distance(GetMonsterProperty("origin"), pos) > 2000)
					{
					}
					Vector3 pos = Vector3(0, 0, 0);
					pos += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 500, 0));
					string pos = TraceLine(GetMonsterProperty("origin"), pos);
				}
				string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
				string x = (pos).x;
				string y = (pos).y;
				Vector3 pos = Vector3(x, y, temp);
				SetGlobalVar("VOLCANO_DMG", 2);
				DMG_VOLCANO = 40;
				SpawnNPC("monsters/summon/npc_volcano", pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 40.0
			}
			if (NOVA_ATTACK == "flame_skull")
			{
				SpawnNPC("monsters/summon/flame_skull", /* TODO: $relpos */ $relpos(0, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_SKULL, 256
			}
			NOVA_ATTACK = "none";
		}
	}

	void bow_shoot()
	{
		BB_IN_ATTACK = 0;
		if (NEXT_ATTACK != "unset")
		{
			ANIM_ATTACK = NEXT_ATTACK;
			NEXT_ATTACK = "unset";
		}
		EmitSound(GetOwner(), 0, SOUND_BOW_SHOOT, 10);
		if (!(SCATTER_SHOT))
		{
			BALL_SIZE = Random(1, 9);
			BALL_SPEED = 1000;
			int BALL_SADJ = 90;
			BALL_SADJ *= BALL_SIZE;
			BALL_SPEED -= BALL_SADJ;
			BALL_DMG = BALL_SIZE;
			BALL_DMG *= 30;
			Vector3 OFS_ADJ = Vector3(0, 28, 36);
			if (GetEntityRange(m_hAttackTarget) < 100)
			{
				Vector3 OFS_ADJ = Vector3(0, 28, -28);
			}
			TossProjectile("proj_mana", /* TODO: $relpos */ $relpos(OFS_ADJ), "none", BALL_SPEED, BALL_DMG, 1, "none");
		}
		if ((SCATTER_SHOT))
		{
			EmitSound(GetOwner(), 0, SOUND_SATTACK, 10);
			SCATTER_SHOT = 0;
			SCATTER_COUNT = 0;
			do_scatter_shot();
		}
	}

	void bow_stretch()
	{
		BB_IN_ATTACK = 0;
		EmitSound(GetOwner(), 0, SOUND_BOW_STRETCH, 10);
	}

	void sound_fast()
	{
		if (NEXT_ATTACK == "unset")
		{
			EmitSound(GetOwner(), 0, SOUND_SWING_FAST, 10);
		}
		if (NEXT_ATTACK != "unset")
		{
			if (NEXT_ATTACK != ANIM_KICK_HIGH)
			{
			}
			if (NEXT_ATTACK != ANIM_KICK_LOW)
			{
			}
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		}
	}

	void sound_slow()
	{
		if (NEXT_ATTACK == "unset")
		{
			// PlayRandomSound from: SOUND_SWING_SLOW1, SOUND_SWING_SLOW2
			array<string> sounds = {SOUND_SWING_SLOW1, SOUND_SWING_SLOW2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
		if (NEXT_ATTACK != "unset")
		{
			if (NEXT_ATTACK != ANIM_KICK_HIGH)
			{
			}
			if (NEXT_ATTACK != ANIM_KICK_LOW)
			{
			}
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 2, 2);
			EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		}
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
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "bandit_charge");
		ScheduleDelayedEvent(1.0, "reset_leaping");
		ScheduleDelayedEvent(0.9, "bullrush_stun");
	}

	void bandit_charge()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void reset_leaping()
	{
		AM_LEAPING = 0;
	}

	void bullrush_stun()
	{
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 60, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 256, 1, 150
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
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_HOP);
		ScheduleDelayedEvent(0.1, "bandit_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
	}

	void bandit_hop()
	{
		int JUMP_HEIGHT = RandomInt(350, 450);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void flank_delay_reset()
	{
		FLANK_DELAY = 0;
	}

	void my_target_died()
	{
		ScheduleDelayedEvent(0.1, "taunt_sound");
		AS_ATTACKING = GetGameTime();
		if ((DRINKING_POT)) return;
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		PlayAnim("critical", "aim_punch1");
	}

	void taunt_sound()
	{
		// PlayRandomSound from: SOUND_TAUNT1, SOUND_TAUNT2
		array<string> sounds = {SOUND_TAUNT1, SOUND_TAUNT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "helena")
		{
			CallExternal(GAME_MASTER, "helena_bandit_chest", /* TODO: $relpos */ $relpos(0, 0, 0));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (L_MAP_NAME == "keep_test")
		{
			int TREASURE_MAP = 1;
		}
		if (L_MAP_NAME == "the_keep")
		{
			int TREASURE_MAP = 1;
		}
		SetGlobalVar("G_BANDIT_BOSS_TYPE", BOSS_TYPE);
	}

	void glow_loop()
	{
		if (!(GLOW_ON)) return;
		ScheduleDelayedEvent(5.1, "glow_loop");
		Effect(GetOwner(), "glow", GLOW_LOOP_COLOR, 128, 5, 0);
	}

	void npc_targetsighted()
	{
		if (BOSS_TYPE == 5)
		{
			if (!(IS_FLEEING))
			{
			}
			if ((false))
			{
			}
			AS_ATTACKING = GetGameTime();
			PlayAnim("once", ANIM_BOW);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void do_invis()
	{
	}

	void check_legal_act()
	{
		LEGAL_ACT = 1;
		if ((I_R_FROZEN))
		{
			LEGAL_ACT = 0;
		}
		if (ANIM_ATTACK == ANIM_KICK_HIGH)
		{
			LEGAL_ACT = 0;
		}
		if (ANIM_ATTACK == ANIM_KICK_LOW)
		{
			LEGAL_ACT = 0;
		}
		if ((IS_FLEEING))
		{
			LEGAL_ACT = 0;
		}
		if ((SUSPEND_AI))
		{
			LEGAL_ACT = 0;
		}
		if ((DRINKING_POT))
		{
			LEGAL_ACT = 0;
		}
	}

	void npcatk_attack()
	{
		if ((NPC_NO_ATTACK)) return;
		npc_selectattack();
		PlayAnim("once", ANIM_ATTACK);
		ATTACK_ANIMINDEX = GetEntityProperty(GetOwner(), "anim.index");
		ATTACK_MOVERANGE = 9999;
		NPC_NO_MOVE = 1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (ATTACK_ANIMINDEX == GetEntityProperty(GetOwner(), "anim.index"))
		{
			NPC_NO_MOVE = 1;
			NPC_FORCED_MOVEDEST = 1;
			SetMoveDest(m_hAttackTarget);
			AS_ATTACKING = 5;
		}
		if (!(ATTACK_ANIMINDEX != GetEntityProperty(GetOwner(), "anim.index"))) return;
		ATTACK_MOVERANGE = ORIG_MOVE_RANGE;
		NPC_NO_MOVE = 0;
	}

}

}
