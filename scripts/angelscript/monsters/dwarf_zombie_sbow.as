#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_struck.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class DwarfZombieSbow : CGameScript
{
	int ADJUSTED_XP;
	int AMMO_COUNT;
	string AMMO_TYPE;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string CUR_PBOLT_ORG;
	int DID_ALERT;
	string DROP_GOLD;
	string DROP_GOLD_AMT;
	string EXPLOSIVE_BOLTS;
	int IMMUNE_VAMPIRE;
	int IN_RELOAD;
	int IS_BLOODLESS;
	int IS_UNHOLY;
	int I_AM_TURNABLE;
	int MISS_COUNT;
	string NEXT_ALERT;
	string NEXT_DZOMB_FLEE;
	string NEXT_SCRIPT_UPDATE;
	string NPC_GIVE_EXP;
	int NPC_RANGED;
	int PBOLT_ACTIVE;
	string PBOLT_ARRAY_NAME;
	int PBOLT_COUNTER;
	string XBOW_AIM_ANGLES;
	string XBOW_BOLT_LAND;
	string XBOW_BOLT_START;
	string XBOW_CL_SCRIPT_ID;
	string XBOW_REPELL_POINT;

	DwarfZombieSbow()
	{
		const int XBOW_TYPE = 1;
		const string ANIM_SXBOW_ATTACK = "anim_sxbow_shoot";
		const string ANIM_HXBOW_ATTACK = "anim_hxbow_shoot_reload";
		const string SOUND_DEATH = "agrunt/ag_die5.wav";
		ANIM_WALK = "walk";
		const string ACT_ANIM_RUN = "walk";
		ANIM_RUN = ACT_ANIM_RUN;
		ANIM_IDLE = "idle";
		if (XBOW_TYPE == 1)
		{
			NPC_GIVE_EXP = 200;
			DROP_GOLD = 1;
			DROP_GOLD_AMT = 100;
			ANIM_ATTACK = ANIM_SXBOW_ATTACK;
		}
		else
		{
			NPC_GIVE_EXP = 150;
			DROP_GOLD = 1;
			DROP_GOLD_AMT = 75;
			ANIM_ATTACK = ANIM_HXBOW_ATTACK;
		}
		const string ANIM_RELOAD = "anim_sxbow_reload";
		const string ANIM_RELOAD_DONE = "anim_sxbow_reload_done";
		const string ANIM_DODGE = "anim_roll_back";
		const string ANIM_ALERT = "nod";
		AMMO_TYPE = "unset";
		NPC_RANGED = 1;
		ATTACK_RANGE = 2048;
		ATTACK_HITRANGE = 2048;
		ATTACK_MOVERANGE = 768;
		const int AMMO_MAX = 5;
		AMMO_COUNT = 5;
		const string SOUND_TURNED1 = "ambience/the_horror1.wav";
		const string SOUND_TURNED2 = "ambience/the_horror2.wav";
		const string SOUND_TURNED3 = "ambience/the_horror3.wav";
		const string SOUND_TURNED4 = "ambience/the_horror4.wav";
		const string SOUND_HOLYPAIN1 = "agrunt/ag_pain4.wav";
		const string SOUND_HOLYPAIN2 = "agrunt/ag_die3.wav";
		const string SOUND_ALERT = "agrunt/ag_alert2.wav";
		I_AM_TURNABLE = 1;
		const string SOUND_XBOW_STRETCH = "weapons/bow/stretch.wav";
		const string SOUND_XBOW_SHOOT = "weapons/bow/crossbow.wav";
		const string SOUND_BOLT_HIT = "weapons/bow/bolthit1.wav";
		const string SOUND_RELOAD = "weapons/357_reload1.wav";
		const int XBOW_ACCURACY = 80;
		const string XBOW_CL_SCRIPT = "monsters/elf_xbow_cl";
		const int XBOW_BONE = 35;
		const int DMG_XBOW = 30;
		const int DOT_POISON = 5;
		const float PBOLT_DURATION = 8.0;
		const int PBOLT_AOE = 64;
		const float FREQ_CLIENT_REFRESH = 40.0;
		const string SOUND_IDLE1 = "agrunt/ag_idle2.wav";
		const string SOUND_IDLE2 = "agrunt/ag_alert3.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle5.wav";
		const string SOUND_PAIN1 = "agrunt/ag_pain3.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain5.wav";
		const string SOUND_PAIN3 = "agrunt/ag_pain2.wav";
		const string SOUND_FLINCH1 = "agrunt/ag_pain3.wav";
		const string SOUND_FLINCH2 = "agrunt/ag_pain5.wav";
		const string SOUND_FLINCH3 = "agrunt/ag_pain2.wav";
		const string ANIM_FLINCH = "anim_xbow_flinch";
		const string NPC_MATERIAL_TYPE = "flesh";
		const int NPC_USE_PAIN = 1;
		const int NPC_USE_IDLE = 1;
		const int NPC_USE_FLINCH = 1;
		const int LANTERN_HAND_SUBMODEL = 2;
		const int LANTERN_HAND_INDEX = 0;
		const Vector3 LANTERN_COLOR = Vector3(0, 64, 32);
	}

	void game_precache()
	{
		Precache(XBOW_CL_SCRIPT);
		Precache("weapons/bows/boltexplosive.mdl");
		Precache("explode1.spr");
		// svplaysound: svplaysound 0 0 agrunt/ag_pain3.wav
		EmitSound(0, 0, "agrunt/ag_pain3.wav");
	}

	void OnSpawn() override
	{
		darcher_spawn();
		select_ammo();
	}

	void darcher_spawn()
	{
		SetName("Dwarven Zombie Bowman");
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 6);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(300);
		SetRace("undead");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("slash", 1.25);
		SetHearingSensitivity(8);
		IS_BLOODLESS = 1;
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
	}

	void npc_targetsighted()
	{
		if (XBOW_CL_SCRIPT_ID == "XBOW_CL_SCRIPT_ID")
		{
			ClientEvent("new", "all", XBOW_CL_SCRIPT, FREQ_CLIENT_REFRESH);
			NEXT_SCRIPT_UPDATE = GetGameTime();
			NEXT_SCRIPT_UPDATE += FREQ_CLIENT_REFRESH;
			XBOW_CL_SCRIPT_ID = "game.script.last_sent_id";
		}
		else
		{
			if (GetGameTime() > NEXT_SCRIPT_UPDATE)
			{
			}
			XBOW_CL_SCRIPT_ID = "XBOW_CL_SCRIPT_ID";
		}
		if (GetEntityRange(m_hAttackTarget) < 64)
		{
			if (!(NPC_IS_TURRET))
			{
			}
			if (GetGameTime() > NEXT_DZOMB_FLEE)
			{
			}
			NEXT_DZOMB_FLEE = GetGameTime();
			NEXT_DZOMB_FLEE += Random(8, 12);
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			// svplaysound: svplaysound 2 10 SOUND_PAIN1
			EmitSound(2, 10, SOUND_PAIN1);
			PlayAnim("critical", ANIM_DODGE);
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 100));
		}
		if ((DID_ALERT)) return;
		DID_ALERT = 1;
		NEXT_DZOMB_FLEE = GetGameTime();
		NEXT_DZOMB_FLEE += Random(8, 12);
		if (!(GetGameTime() > NEXT_ALERT)) return;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("critical", ANIM_ALERT);
		if (!(NPC_NO_PLAYER_DMG))
		{
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3
			array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		NEXT_ALERT = GetGameTime();
		NEXT_ALERT += 20.0;
	}

	void frame_roll_back_push()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -100, 100));
	}

	void npcatk_clear_targets()
	{
		DID_ALERT = 0;
	}

	void select_ammo()
	{
		if (!(AMMO_TYPE == "unset")) return;
		AMMO_TYPE = "pierce";
	}

	void set_ammo()
	{
		AMMO_TYPE = param1;
		if ((param1).findFirst("poison") == 0)
		{
			AMMO_TYPE = "poison";
		}
		else
		{
			if ((param1).findFirst("fire") == 0)
			{
				AMMO_TYPE = "explode";
			}
			else
			{
				if ((param1).findFirst("pierce") == 0)
				{
					AMMO_TYPE = "pierce";
				}
				else
				{
					AMMO_TYPE = "unset";
				}
			}
		}
		adjust_xp();
		if (AMMO_TYPE == "unset")
		{
			string L_TITLE = "MAP ERROR - ";
			L_TITLE += GetScriptName(GetOwner());
			SendInfoMsg("all", "L_TITLE Ammo type incorrectly set, options are: set_ammo;poison | fire | pierce");
		}
	}

	void adjust_xp()
	{
		if ((ADJUSTED_XP)) return;
		if (AMMO_TYPE == "explode")
		{
			EXPLOSIVE_BOLTS = 1;
			NPC_GIVE_EXP += 100;
		}
		if (AMMO_TYPE == "poison")
		{
			NPC_GIVE_EXP += 100;
		}
		ADJUSTED_XP = 1;
	}

	void frame_attack_sxbow()
	{
		if (AMMO_COUNT >= 1)
		{
			AMMO_COUNT -= 1;
			bow_fire();
		}
		else
		{
			if (!(NPC_NO_ATTACK))
			{
				npcatk_suspend_attack(1.0);
			}
			bow_reload();
		}
	}

	void bow_fire()
	{
		if (AMMO_TYPE == "unset")
		{
			select_ammo();
		}
		EmitSound(GetOwner(), 1, SOUND_XBOW_SHOOT, 10);
		MISS_COUNT += 1;
		string L_START_LINE = GetEntityProperty(GetOwner(), "svbonepos");
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (RandomInt(1, 100) > XBOW_ACCURACY)
		{
			string RND_X = Random(-64.0, 64.0);
			string RND_Y = Random(-64.0, 64.0);
			TARG_ORG += "x";
			TARG_ORG += "y";
		}
		if (AMMO_TYPE != "pierce")
		{
			if (AMMO_TYPE == "poison")
			{
				string L_NBOLTS = /* TODO: $get_array_amt */ $get_array_amt(PBOLT_ARRAY_NAME);
				if (L_NBOLTS >= 5)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB + 1))
			{
			}
			string L_MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
			TARG_ORG += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_YAW, 0), Vector3(0, -32, 0));
			TARG_ORG = "z";
			XBOW_REPELL_POINT = TARG_ORG;
		}
		else
		{
			if (!(IsValidPlayer(m_hAttackTarget)))
			{
			}
			string L_THHEIGHT = GetEntityHeight(m_hAttackTarget);
			L_THHEIGHT *= 0.5;
			TARG_ORG += "z";
		}
		XBOW_AIM_ANGLES = /* TODO: $angles3d */ $angles3d(L_START_LINE, TARG_ORG);
		string L_ANG_PITCH = (XBOW_AIM_ANGLES).x;
		string L_ANG_PITCH = /* TODO: $neg */ $neg(L_ANG_PITCH);
		XBOW_AIM_ANGLES = "x";
		string L_END_LINE = L_START_LINE;
		L_END_LINE += /* TODO: $relpos */ $relpos(XBOW_AIM_ANGLES, Vector3(0, 2048, 0));
		string L_END_LINE = TraceLine(L_START_LINE, L_END_LINE);
		XBOW_BOLT_START = L_START_LINE;
		XBOW_BOLT_LAND = L_END_LINE;
		XDoDamage(XBOW_BOLT_START, XBOW_BOLT_LAND, DMG_XBOW, 1.0, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bolt");
		if ((EXPLOSIVE_BOLTS))
		{
			ScheduleDelayedEvent(0.1, "bolt_explode");
		}
		if (AMMO_TYPE == "poison")
		{
			if (L_NBOLTS < 5)
			{
			}
			ScheduleDelayedEvent(0.1, "pbolt_explode");
		}
		if (XBOW_CL_SCRIPT_ID != "XBOW_CL_SCRIPT_ID")
		{
			string L_LAND_POINT = XBOW_BOLT_LAND;
			if (AMMO_TYPE != "pierce")
			{
				string L_LAND_POINT = XBOW_REPELL_POINT;
			}
			ClientEvent("update", "all", XBOW_CL_SCRIPT_ID, "fire_bolt", XBOW_BOLT_START, L_LAND_POINT, XBOW_AIM_ANGLES, EXPLOSIVE_BOLTS);
		}
		if (!(MISS_COUNT > 4)) return;
		MISS_COUNT = 0;
		chicken_run(3.0);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		MISS_COUNT = 0;
	}

	void bolt_dodamage()
	{
		if (!(param1)) return;
		MISS_COUNT = 0;
		if (AMMO_TYPE == "poison")
		{
			if (GetRelationship(param2) == "enemy")
			{
			}
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
		}
	}

	void bolt_explode()
	{
		XDoDamage(XBOW_REPELL_POINT, 128, DMG_XBOW, 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:explode");
	}

	void explode_dodamage()
	{
		string CUR_TARG = param2;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(XBOW_REPELL_POINT, TARG_ORG);
		string TARG_DIST = Distance(TARG_ORG, XBOW_REPELL_POINT);
		TARG_DIST /= 128;
		string PUSH_STR = /* TODO: $ratio */ $ratio(TARG_DIST, 500, 100);
		string HALF_PUSH_STR = PUSH_STR;
		HALF_PUSH_STR /= 2;
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, PUSH_STR, HALF_PUSH_STR)));
	}

	void bow_reload()
	{
		IN_RELOAD = 1;
		PlayAnim("critical", ANIM_RELOAD);
	}

	void frame_reload_sxbow()
	{
		EmitSound(GetOwner(), 2, SOUND_RELOAD, 10);
		AMMO_COUNT += 1;
		if (AMMO_COUNT >= AMMO_MAX)
		{
			PlayAnim("critical", ANIM_RELOAD_DONE);
		}
	}

	void frame_reload_sxbow_done()
	{
		IN_RELOAD = 0;
	}

	void pbolt_explode()
	{
		add_poison_bolt(XBOW_REPELL_POINT);
	}

	void add_poison_bolt()
	{
		string L_PBOLT_LOC = param1;
		SetScriptFlags(GetOwner(), "add", "stack_pbolt", "pbolt", L_PBOLT_LOC, PBOLT_DURATION);
		ClientEvent("new", "all", "effects/sfx_poison_cloud", L_PBOLT_LOC, PBOLT_AOE, PBOLT_DURATION);
		if ((PBOLT_ACTIVE)) return;
		PBOLT_ACTIVE = 1;
		PBOLT_COUNTER = 0;
		ext_poison_bolt_loop();
	}

	void ext_poison_bolt_loop()
	{
		if (!(PBOLT_ACTIVE)) return;
		PBOLT_ARRAY_NAME = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "pbolt", "type_array");
		if (PBOLT_ARRAY_NAME != "none")
		{
			string L_NBOLTS = /* TODO: $get_array_amt */ $get_array_amt(PBOLT_ARRAY_NAME);
			L_NBOLTS -= 1;
			if (PBOLT_COUNTER > L_NBOLTS)
			{
				PBOLT_COUNTER = 0;
			}
			CUR_PBOLT_ORG = /* TODO: $get_array */ $get_array(PBOLT_ARRAY_NAME, PBOLT_COUNTER);
			ext_poison_bolt_dmg();
			float L_BOLT_SCAN_SPEED = 1.0;
			if (L_NBOLTS > 0)
			{
				L_BOLT_SCAN_SPEED /= L_NBOLTS;
			}
			if (L_BOLT_SCAN_SPEED < 0.1)
			{
				float L_BOLT_SCAN_SPEED = 0.2;
			}
			PBOLT_COUNTER += 1;
			L_BOLT_SCAN_SPEED("ext_poison_bolt_loop");
		}
		else
		{
			PBOLT_ACTIVE = 0;
		}
	}

	void ext_poison_bolt_dmg()
	{
		string L_SCAN_POINT = CUR_PBOLT_ORG;
		L_SCAN_POINT += "z";
		XDoDamage(L_SCAN_POINT, PBOLT_AOE, DMG_XBOW, 0.1, GetOwner(), GetOwner(), "none", "poison_effect", "dmgevent:pbolt_cloud");
	}

	void pbolt_cloud_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((NPC_NO_DROP)) return;
		string L_CHANCE = "game.playersnb";
		L_CHANCE *= 2;
		if (!(RandomInt(1, 100) < L_CHANCE)) return;
		SpawnNPC("chests/base_quiver_of", "proj_bolt_poison", ScriptMode::Legacy); // params: 25
	}

}

}
