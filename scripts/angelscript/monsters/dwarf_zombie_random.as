#pragma context server

#include "monsters/base_monster_new.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class DwarfZombieRandom : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_LEAP;
	string ANIM_NOD;
	string ANIM_RUN;
	string ANIM_SLASH;
	string ANIM_WALK;
	float ATTACK2_ACCURACY;
	string ATTACK2_CHANCE;
	string ATTACK2_DAMAGE;
	float ATTACK_ACCURACY;
	string ATTACK_DAMAGE;
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
	string DROP_ITEM1;
	string DROP_ITEM1_CHANCE;
	int FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	int HUNT_AGRO;
	float HURT_POINT;
	int IS_FLEEING;
	int I_AM_TURNABLE;
	int JUST_SPAWNED;
	string LANTERN_COLOR;
	string LNT_B;
	string LNT_G;
	string LNT_R;
	int MAX_TYPE;
	int MONSTER_WIDTH;
	int MOVE_RAGE;
	string NPCATK_FLEE_RESTORETARGET;
	string NPC_GIVE_EXP;
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
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_LEAP;
	string SOUND_NOD;
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
	int STUCK_COUNT;
	string WALKING_MY_OLD_POS;
	int WALK_STEP;
	int WEAPON_TYPE;

	DwarfZombieRandom()
	{
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		CAN_WANDER = 1;
		MAX_TYPE = 4;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 80;
		CAN_FLINCH = 0;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 25;
		FLEE_DISTANCE = 2048;
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		MOVE_RAGE = 65;
		ATTACK_ACCURACY = 0.8;
		ATTACK2_ACCURACY = 0.75;
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		ANIM_LEAP = "attack2";
		ANIM_SLASH = "attack";
		ANIM_NOD = "nod";
		SOUND_IDLE1 = "agrunt/ag_idle2.wav";
		SOUND_IDLE2 = "agrunt/ag_alert3.wav";
		SOUND_IDLE3 = "agrunt/ag_idle5.wav";
		SOUND_ALERT = "agrunt/ag_alert2.wav";
		SOUND_LEAP = "agrunt/ag_attack2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		SOUND_ATTACKHIT3 = "zombie/claw_strike3.wav";
		SOUND_DEATH = "agrunt/ag_die5.wav";
		SOUND_STRUCK = "debris/flesh2.wav";
		SOUND_PAIN1 = "agrunt/ag_pain3.wav";
		SOUND_PAIN2 = "agrunt/ag_pain5.wav";
		HURT_POINT = 0.5;
		SOUND_TURNED1 = "ambience/the_horror1.wav";
		SOUND_TURNED2 = "ambience/the_horror2.wav";
		SOUND_TURNED3 = "ambience/the_horror3.wav";
		SOUND_TURNED4 = "ambience/the_horror4.wav";
		SOUND_HOLYPAIN1 = "agrunt/ag_pain4.wav";
		SOUND_HOLYPAIN2 = "agrunt/ag_die3.wav";
		SOUND_STEP1 = "player/pl_grate1.wav";
		SOUND_STEP2 = "player/pl_grate2.wav";
		SOUND_STEP3 = "player/pl_grate3.wav";
		SOUND_STEP4 = "player/pl_grate4.wav";
		SOUND_NOD = "x/x_laugh1.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 5;
		DROP_GOLD_MAX = 30;
		I_AM_TURNABLE = 1;
		MONSTER_WIDTH = 32;
		Precache(SOUND_DEATH);
		LANTERN_COLOR = Vector3(LNT_R, LNT_G, LNT_B);
		int L_RND = RandomInt(1, 5);
		if (L_RND == 1)
		{
			LNT_R = Random(16, 64);
			LNT_B = 0;
			LNT_G = 0;
		}
		else
		{
			if (L_RND == 2)
			{
				LNT_R = 0;
				LNT_G = Random(16, 64);
				LNT_B = 0;
			}
			else
			{
				if (L_RND == 3)
				{
					LNT_R = 0;
					LNT_G = 0;
					LNT_B = Random(16, 64);
				}
				else
				{
					if (L_RND == 4)
					{
						LNT_R = 0;
						LNT_G = Random(16, 64);
						LNT_B = Random(16, 64);
					}
					else
					{
						if (L_RND == 5)
						{
							LNT_R = Random(16, 64);
							LNT_G = 0;
							LNT_B = Random(16, 64);
						}
					}
				}
			}
		}
	}

	void OnSpawn() override
	{
		if ((ZOMBIE_QUEST_COMPLETE))
		{
			DeleteEntity(GetOwner());
		}
		JUST_SPAWNED = 1;
		SetName("Dwarven Zombie");
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetRace("undead");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("holy", 2.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.5);
		SetHearingSensitivity(10);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 2);
		SetModelBody(2, 0);
		pick_weapon_type();
		if (GetMapName() == "gatecity")
		{
			SetMonsterClip(0);
		}
		if (WEAPON_TYPE == 0)
		{
			NPC_GIVE_EXP = 40;
			SetHealth(150);
			SetModelBody(1, 0);
			ATTACK_DAMAGE = 20;
			ATTACK2_DAMAGE = 80;
			ATTACK_RANGE = 50;
			ATTACK_HITRANGE = 100;
			MOVE_RAGE = 48;
			ATTACK2_CHANCE = 0;
			DROP_GOLD_MIN = 5;
			DROP_GOLD_MAX = 15;
			if (RandomInt(1, 100) < 25)
			{
				if (!(LANTERN_SET))
				{
				}
				set_lantern();
			}
		}
		if (WEAPON_TYPE == 1)
		{
			NPC_GIVE_EXP = 50;
			SetHealth(200);
			SetModelBody(1, 1);
			ATTACK_DAMAGE = 30;
			ATTACK2_DAMAGE = 90;
			ATTACK_RANGE = 125;
			ATTACK_HITRANGE = 175;
			MOVE_RAGE = 48;
			ATTACK2_CHANCE = 0;
			DROP_GOLD_MIN = 10;
			DROP_GOLD_MAX = 20;
			DROP_ITEM1 = "axes_smallaxe";
			DROP_ITEM1_CHANCE = 0.1;
			if (RandomInt(1, 100) < 25)
			{
				if (!(LANTERN_SET))
				{
				}
				set_lantern();
			}
		}
		if (WEAPON_TYPE == 2)
		{
			NPC_GIVE_EXP = 100;
			SetHealth(300);
			SetModelBody(1, 2);
			ATTACK_DAMAGE = 40;
			ATTACK2_DAMAGE = 100;
			ATTACK_RANGE = 125;
			ATTACK_HITRANGE = 200;
			MOVE_RAGE = 65;
			ATTACK2_CHANCE = 25;
			DROP_GOLD_MIN = 15;
			DROP_GOLD_MAX = 30;
			DROP_ITEM1 = "axes_doubleaxe";
			DROP_ITEM1_CHANCE = 0.1;
		}
		if (WEAPON_TYPE == 3)
		{
			NPC_GIVE_EXP = 200;
			SetHealth(400);
			SetModelBody(1, 3);
			ATTACK_DAMAGE = 55;
			ATTACK2_DAMAGE = 150;
			ATTACK_RANGE = 125;
			ATTACK_HITRANGE = 200;
			MOVE_RAGE = 65;
			ATTACK2_CHANCE = 15;
			DROP_GOLD_MIN = 15;
			DROP_GOLD_MAX = 40;
			DROP_ITEM1 = "swords_bastardsword";
			DROP_ITEM1_CHANCE = 0.05;
		}
		if (WEAPON_TYPE == 4)
		{
			NPC_GIVE_EXP = 175;
			SetHealth(300);
			SetModelBody(1, 8);
			ATTACK_DAMAGE = 50;
			ATTACK2_DAMAGE = 150;
			ATTACK_RANGE = 125;
			ATTACK_HITRANGE = 200;
			MOVE_RAGE = 65;
			ATTACK2_CHANCE = 30;
			DROP_GOLD_MIN = 50;
			DROP_GOLD_MAX = 100;
			if (RandomInt(1, 100) < 25)
			{
				if (!(LANTERN_SET))
				{
				}
				set_lantern();
			}
		}
		WALKING_MY_OLD_POS = GetEntityOrigin(GetOwner());
		WALK_STEP = 1;
		ScheduleDelayedEvent(1.0, "walking");
	}

	void npcatk_get_postspawn_properties()
	{
		if (StringToLower(GetMapName()) == "gatecity")
		{
			string MY_POS = GetEntityOrigin(GetOwner());
			string MY_X = (MY_POS).x;
			string MY_Y = (MY_POS).y;
			string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
			LogDebug("npcatk_get_postspawn_properties MY_X MY_Y MY_GROUND");
			SetEntityOrigin(GetOwner(), Vector3(MY_X, MY_Y, MY_GROUND));
		}
		ATTACK_RANGE *= 0.5;
		ATTACK_HITRANGE *= 0.5;
	}

	void attack_1()
	{
		STUCK_COUNT = 0;
		ATTACK_VOLUME = 5;
		npcatk_dodamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
		if (RandomInt(1, 100) < ATTACK2_CHANCE)
		{
			ANIM_ATTACK = ANIM_LEAP;
		}
	}

	void attack_2()
	{
		STUCK_COUNT = 0;
		ATTACK_VOLUME = 10;
		npcatk_dodamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK2_DAMAGE, ATTACK2_ACCURACY);
		ANIM_ATTACK = ANIM_SLASH;
		EmitSound(GetOwner(), CHAN_ITEM, SOUND_LEAP, 10);
		if (!(GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/debuff_stun", RandomInt(2, 8), GetEntityIndex(GetOwner()));
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 2, /* TODO: $relvel */ $relvel(10, -200, 10), 0);
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
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		string HURT_THRESHOLD = GetEntityMaxHealth(GetOwner());
		HURT_THRESHOLD *= HURT_POINT;
		if ((STRUCK_BY_HOLY))
		{
			// PlayRandomSound from: SOUND_HOLYPAIN1, SOUND_HOLYPAIN2
			array<string> sounds = {SOUND_HOLYPAIN1, SOUND_HOLYPAIN2};
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

	void walking()
	{
		string MY_POS = GetEntityOrigin(GetOwner());
		float TRAVEL_DIST = Distance(MY_POS, WALKING_MY_OLD_POS);
		if (TRAVEL_DIST > 32)
		{
			if (WALK_STEP == 1)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_STEP1, 2);
			}
			if (WALK_STEP == 2)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_STEP2, 2);
			}
			if (WALK_STEP == 3)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_STEP3, 2);
			}
			if (WALK_STEP == 4)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_STEP4, 2);
			}
			WALK_STEP += 1;
			if (WALK_STEP > 4)
			{
				WALK_STEP = 1;
			}
		}
		WALKING_MY_OLD_POS = MY_POS;
		ScheduleDelayedEvent(1.0, "walking");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		alert_dwarf_zombie();
	}

	void alert_dwarf_zombie()
	{
		if ((DID_ALERT)) return;
		if (!(false)) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_ALERT, 10);
		PlayAnim("critical", ANIM_NOD);
		DID_ALERT = 1;
	}

	void pick_weapon_type()
	{
		int MIN_TYPE = 0;
		string MAYOR_ENT = FindEntityByName("dwarf_mayor");
		string MAYOR_ID = GetEntityIndex(MAYOR_ENT);
		if (GetEntityProperty(MAYOR_ID, "scriptvar") == 1)
		{
			string C_ZOMBIE_COUNT = GetEntityProperty(MAYOR_ID, "scriptvar");
			string C_ZOMBIE_REQ = GetEntityProperty(MAYOR_ID, "scriptvar");
			string QUART_WAY = C_ZOMBIE_REQ;
			QUART_WAY *= 0.2;
			string HALF_WAY = C_ZOMBIE_REQ;
			HALF_WAY *= 0.4;
			string ALMOST_THERE = C_ZOMBIE_REQ;
			ALMOST_THERE *= 0.6;
			if (C_ZOMBIE_COUNT > QUART_WAY)
			{
				int MIN_TYPE = 1;
			}
			if (C_ZOMBIE_COUNT > HALF_WAY)
			{
				int MIN_TYPE = 2;
			}
			if (C_ZOMBIE_COUNT > ALMOST_THERE)
			{
				int MIN_TYPE = 3;
			}
		}
		WEAPON_TYPE = RandomInt(MIN_TYPE, MAX_TYPE);
	}

	void my_target_died()
	{
		if ((JUST_SPAWNED))
		{
			JUST_SPAWNED = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayAnim("critical", ANIM_NOD);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_NOD, 10);
	}

	void OnFlee()
	{
		ANIM_RUN = "run";
		if ((IS_FLEEING)) return;
		PlayAnim("once", "break");
		SetMoveDest(param1);
		SetMoveAnim(ANIM_RUN);
		IS_FLEEING = 1;
		NPCATK_FLEE_RESTORETARGET = IS_HUNTING;
		if (param3 != "PARAM3")
		{
			PARAM3("npcatk_stopflee");
		}
	}

	void npcatk_stopflee()
	{
		ANIM_RUN = "walk";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string MAYOR_ENT = FindEntityByName("dwarf_mayor");
		string MAYOR_ID = GetEntityIndex(MAYOR_ENT);
		if (!(GetEntityProperty(MAYOR_ID, "scriptvar") == 1)) return;
		CallExternal(MAYOR_ID, "zombie_died");
		string C_ZOMBIE_COUNT = GetEntityProperty(MAYOR_ID, "scriptvar");
		string C_ZOMBIE_REQ = GetEntityProperty(MAYOR_ID, "scriptvar");
		int C_ZOMBIE_REQ = int(C_ZOMBIE_REQ);
		if (C_ZOMBIE_COUNT < C_ZOMBIE_REQ)
		{
			int Z_COUNT = int(C_ZOMBIE_COUNT);
			SendPlayerMessage(m_hLastStruck, "You have slain " + Z_COUNT + "/ " + C_ZOMBIE_REQ + " dwarven zombies.");
		}
		if (!(C_ZOMBIE_COUNT == C_ZOMBIE_REQ)) return;
		UseTrigger("zombie_remove");
		SendColoredMessage(m_hLastStruck, "You have completed the dwarven zombie quest. Return to the mayor for your reward.");
		SetGlobalVar("ZOMBIE_QUEST_COMPLETE", 1);
		CallExternal("all", "zombie_remove");
	}

	void zombie_remove()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
