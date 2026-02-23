#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_jumper.as"

namespace MS
{

class DragonGuard : CGameScript
{
	string AM_WOUNDED;
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	string ANIM_ATTACK_DEFAULT;
	string ANIM_ATTACK_REACH;
	string ANIM_BREATH;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE_COMBAT;
	string ANIM_IDLE_DEEP;
	string ANIM_RUN;
	string ANIM_WALK;
	string ATTACK_HITRANGE;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	string ATTACK_RANGE_DEFAULT;
	int ATTACK_REACH_RANGE;
	string ATTEMPTED_HEAL;
	int BREATH_ATTACK;
	string BREATH_CL_IDX;
	int BREATH_DOT;
	int BREATH_MIN_RANGE;
	string BREATH_ON;
	int BREATH_PUSH_VEL;
	int BREATH_QUICK;
	int BREATH_RANGE;
	string BREATH_TARGS;
	string BREATH_TYPE;
	string BURST_START;
	string BURST_TARGS;
	int CAN_STUN;
	int CAN_THROW;
	int CAUTIOUS_APPROACH;
	string DEFAULT_TAKDMG_ACID;
	string DEFAULT_TAKDMG_COLD;
	string DEFAULT_TAKDMG_FIRE;
	string DEFAULT_TAKDMG_LIGHTNING;
	string DEFAULT_TAKDMG_POISON;
	int DG_FAURA;
	string DG_FAURA_CLIDX;
	string DG_FAURA_NEXT_CL;
	string DG_FAURA_SCAN;
	string DG_SUSPEND;
	int DID_INIT;
	int DMG_CRESCENT;
	int DMG_MELEE;
	string DMG_MELEE_TYPE;
	string DO_HEAL;
	string ELF_AIM_ANGLES;
	string ELF_BOLT_LAND;
	int ELF_XBOW_SHOT;
	string EXPLOSIVE_BOLT;
	int EXTEND_KICK_RANGE;
	float EXT_DEMON_BLOOD_RATIO;
	float FREQ_BREATH;
	string FREQ_KICK;
	float FREQ_REACH_ATTACK;
	string HALF_HP;
	int HAS_DOT;
	int HAS_SHIELD;
	string HEAL_READY;
	int IS_ARMORED;
	int IS_BLACK;
	int IS_GREEN;
	int IS_RED;
	int MELEE_ATTACK;
	int MELEE_DOT;
	int MELEE_DOT_DUR;
	string MELEE_DOT_EFFECT;
	int MELEE_VAMPIRE;
	string MISS_COUNT;
	string MOVE_RANGE;
	string NAME_PREF;
	int NEVER_JUMPS;
	string NEW_NAME;
	string NEXT_ALERT_SOUND;
	string NEXT_BREATH;
	string NEXT_BREATH_REMOVE;
	string NEXT_CALM;
	string NEXT_CRE_THROW;
	string NEXT_GLOAT;
	string NEXT_HEAL;
	string NEXT_KICK;
	string NEXT_REACH_ATTACK;
	string NEXT_SHIELD_BASH;
	string NEXT_SPLODIE_BOLT;
	int NO_ARMOR;
	int NO_BREATH;
	int NO_POTION;
	int NO_REACH_ATTACK;
	int NPC_GIVE_EXP;
	int NPC_JUMPER;
	int NPC_MUST_SEE_TARGET;
	int NPC_NO_VADJ;
	int NPC_RANGED;
	string PLR_POT_ALERT_LIST;
	string POT_HEAL;
	int POT_SPECIAL;
	string POT_TYPE;
	string PROJECTILE_THROW;
	string QUARTER_HP;
	int RETREATS_NEAR_RANGE;
	string RETREATS_NEAR_TYPE;
	int RETREATS_WHEN_NEAR;
	string SELECTED_RND_ARMOR;
	string SELECTED_RND_POT;
	string SELECTED_RND_WEP;
	int SKIN_SET;
	int STUN_BURST;
	float STUN_CHANCE;
	int TAKEDMG_ADJ_ACID;
	int TAKEDMG_ADJ_COLD;
	int TAKEDMG_ADJ_FIRE;
	int TAKEDMG_ADJ_LIGHTNING;
	int TAKEDMG_ADJ_POISON;
	int WEAPON_TYPE;
	int XBOW_ACCURACY;

	DragonGuard()
	{
		const string ANIM_CAUTIOUS_APPROACH = "cwalkf";
		const string ANIM_CAUTIOUS_RETREAT = "cwalkb";
		ANIM_DEATH = "death_long";
		const string ANIM_KICK = "kick";
		const string ANIM_SHOCK = "spasm";
		const string ANIM_THROW = "throwr";
		const string ANIM_DRINK = "drink";
		const string ANIM_WALK_HEARDSOUND = "cwalkf";
		const string ANIM_WALK_WOUNDED = "walkinj";
		const string ANIM_NPC_JUMP = "kick";
		const string ANIM_BREATH_LOOP = "breath_loop";
		ANIM_WALK = "walk";
		ANIM_IDLE = "deep_idle";
		ANIM_RUN = "run";
		const string SOUND_XBOW_STRETCH = "weapons/bow/stretch.wav";
		const string SOUND_XBOW_SHOOT = "weapons/bow/crossbow.wav";
		const string SOUND_BOLT_HIT = "weapons/bow/bolthit1.wav";
		TAKEDMG_ADJ_ACID = 0;
		TAKEDMG_ADJ_COLD = 0;
		TAKEDMG_ADJ_FIRE = 0;
		TAKEDMG_ADJ_POISON = 0;
		TAKEDMG_ADJ_LIGHTNING = 0;
		SetGlobalVar("DEV_STRING", "Flags: ");
		IS_GREEN = 1;
		NPC_GIVE_EXP = 1500;
		const int RANGE_MELEE_STANDARD = 64;
		const int MOVERANGE_MELEE_STANDARD = 32;
		const int HITRANGE_MELEE_STANDARD = 96;
		const int HITRANGE_POLE_SHORT = 75;
		FREQ_KICK = Random(20.0, 30.0);
		const string FREQ_SHIELD_BASH = Random(10.0, 20.0);
		const float HEAL_DELAY = 15.0;
		const int DMG_STUN_BURST = 300;
		DMG_CRESCENT = 60;
		const int DMG_KICK = 100;
		const int DG_FAURA_DOT = 100;
		const int DG_FAURA_AOE = 64;
		const float DG_FAURA_CL_RATE = 15.0;
		const int DMG_XBOW = 100;
		XBOW_ACCURACY = 75;
		const string SOUND_HEARD_ALERT1 = "monsters/dg/c_lizardm_bat1.wav";
		const string SOUND_HEARD_ALERT2 = "monsters/dg/c_lizardm_bat2.wav";
		const string SOUND_PAIN1 = "monsters/dg/c_lizardm_hit1.wav";
		const string SOUND_PAIN2 = "monsters/dg/c_lizardm_hit2.wav";
		const string SOUND_NPC_JUMP = "monsters/dg/c_lizardm_atk1.wav";
		const string SOUND_DEATH1 = "monsters/dg/c_lizardm_dead.wav";
		const string SOUND_DEATH2 = "monsters/dg/vs_nlizardm_bye.wav";
		const string SOUND_INVESTIGATE = "monsters/dg/c_lizardmw_bat1.wav";
		const string SOUND_ATTACK1 = "monsters/dg/c_lizardm_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/dg/c_lizardm_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/dg/c_lizardm_atk3.wav";
		const string SOUNDA_HEARD_ALERT1 = "monsters/dg/c_lizardmc_bat1.wav";
		const string SOUNDA_HEARD_ALERT2 = "monsters/dg/c_lizardmw_bat2.wav";
		const string SOUNDA_PAIN1 = "monsters/dg/vs_nlizardm_hit1.wav";
		const string SOUNDA_PAIN2 = "monsters/dg/vs_nlizardm_hit2.wav";
		const string SOUNDA_PAIN3 = "monsters/dg/vs_nlizardm_hit3.wav";
		const string SOUNDA_NPC_JUMP = "monsters/dg/vs_nlizardm_atk1.wav";
		const string SOUNDA_DEATH1 = "monsters/dg/vs_nlizardm_dead.wav";
		const string SOUNDA_DEATH2 = "monsters/dg/vs_nlizardm_bye.wav";
		const string SOUNDA_INVESTIGATE = "monsters/dg/vs_nlizardm_bat2.wav";
		const string SOUNDA_ATTACK1 = "monsters/dg/vs_nlizardm_atk1.wav";
		const string SOUNDA_ATTACK2 = "monsters/dg/vs_nlizardm_atk2.wav";
		const string SOUNDA_ATTACK3 = "monsters/dg/vs_nlizardm_atk3.wav";
		const string SOUNDA_HEAL = "monsters/dg/vs_nlizardm_heal.wav";
		const string SOUND_BREATH_LOOP = "monsters/goblin/sps_fogfire.wav";
		const string SOUND_BREATH_ACID_READY = "bullchicken/bc_attack1.wav";
		const string SOUND_BREATH_ACID_BOLT = "bullchicken/bc_attack2.wav";
		const string SOUND_BREATH_LIGHTNING_READY = "debris/beamstart1.wav";
		const string SOUND_BREATH_LIGHTNING = "debris/zap1.wav";
		const string SOUND_MELEE1 = "zombie/claw_miss1.wav";
		const string SOUND_MELEE2 = "zombie/claw_miss2.wav";
		const string SOUND_MELEE_LARGE = "weapons/swinghuge.wav";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_STRUCK_ARMOR1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK_ARMOR2 = "weapons/axemetal2.wav";
		NPC_JUMPER = 1;
	}

	void game_precache()
	{
		Precache("monsters/dragon_guard_breath_cl");
		Precache("monsters/elf_xbow_cl");
		Precache(SOUND_DEATH1);
		Precache(SOUND_DEATH2);
		Precache(SOUNDA_DEATH1);
		Precache(SOUNDA_DEATH2);
		Precache("rain_mist.spr");
		Precache("explode1.spr");
		Precache("poison_cloud.spr");
	}

	void OnSpawn() override
	{
		SetName("Dragon Guard");
		SetModel("monsters/dragon_guard.mdl");
		SetWidth(32);
		SetHeight(90);
		SetRace("demon");
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetHealth(4000);
		SetHearingSensitivity(6);
		SetRoam(true);
		SetDamageResistance("stun", 0.75);
		if (!(true)) return;
		PLR_POT_ALERT_LIST = "";
		ScheduleDelayedEvent(0.2, "pick_specials");
		ScheduleDelayedEvent(2.0, "dragon_guard_finalize");
	}

	void OnPostSpawn() override
	{
		EXT_DEMON_BLOOD_RATIO = 3.0;
		ANIM_IDLE = ANIM_IDLE_DEEP;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		MOVE_RANGE = ATTACK_RANGE;
		ANIM_ATTACK = ANIM_ATTACK1;
	}

	void pick_specials()
	{
		if (!(NO_POTION))
		{
			POT_HEAL = RandomInt(0, 1);
			if ((POT_HEAL))
			{
				if ((G_DEVELOPER_MODE))
				{
					DEV_STRING += "Pot_Healing ";
				}
				NPC_GIVE_EXP += 200;
			}
			if (RandomInt(1, 5) == 1)
			{
				POT_SPECIAL = 1;
			}
			if ((POT_SPECIAL))
			{
			}
			string RND_POT = RandomInt(1, 4);
			if (RND_POT == 1)
			{
				dg_potd();
			}
			if (RND_POT == 2)
			{
				dg_potp();
			}
			if (RND_POT == 3)
			{
				dg_potf();
			}
			if (RND_POT == 4)
			{
				dg_pots();
			}
			SELECTED_RND_POT = 1;
		}
		if (!(NO_BREATH))
		{
			if (!(BREATH_ATTACK))
			{
			}
			if (RandomInt(1, 4) == 1)
			{
			}
			string RND_BREATH = RandomInt(1, 5);
			if (RND_BREATH == 1)
			{
				dg_bfir();
			}
			if (RND_BREATH == 2)
			{
				dg_bice();
			}
			if (RND_BREATH == 3)
			{
				dg_bpoi();
			}
			if (RND_BREATH == 4)
			{
				dg_bacd();
			}
			if (RND_BREATH == 5)
			{
				dg_blgt();
			}
		}
		if (!(IS_ARMORED))
		{
			if (!(NO_ARMOR))
			{
			}
			if (RandomInt(1, 5) == 1)
			{
			}
			dg_armr();
			SELECTED_RND_ARMOR = 1;
		}
		if (!(WEAPON_TYPE))
		{
			string RND_WEP = RandomInt(1, 8);
			SELECTED_RND_WEP = 1;
			if (StringToLower(GetMapName()) == "nashalrath")
			{
				if (RND_WEP == 4)
				{
					int RND_WEP = 5;
				}
			}
			if (RND_WEP == 6)
			{
				int L_STRIKE_COUNT = 1;
				if ((SELECTED_RND_ARMOR))
				{
					if ((IS_ARMORED))
					{
					}
					L_STRIKE_COUNT += 1;
				}
				if ((SELECTED_RND_POT))
				{
					if (RND_POT == 4)
					{
					}
					L_STRIKE_COUNT += 1;
				}
				if (L_STRIKE_COUNT == 3)
				{
					int RND_WEP = 5;
				}
			}
			if (RND_WEP == 1)
			{
				dg_wice();
			}
			if (RND_WEP == 2)
			{
				dg_wbow();
			}
			if (RND_WEP == 3)
			{
				dg_wpol();
			}
			if (RND_WEP == 4)
			{
				dg_wham();
			}
			if (RND_WEP == 5)
			{
				dg_wcre();
			}
			if (RND_WEP == 6)
			{
				dg_wdbl();
			}
			if (RND_WEP == 7)
			{
				dg_wfrb();
			}
			if (RND_WEP == 8)
			{
				dg_wgrb();
			}
		}
	}

	void dragon_guard_finalize()
	{
		if (!(NPC_CUSTOM_NAME))
		{
			if (NAME_PREF != "NAME_PREF")
			{
				string L_NEW_NAME = NAME_PREF;
				L_NEW_NAME += " ";
				L_NEW_NAME += NEW_NAME;
				NEW_NAME = L_NEW_NAME;
			}
			if (("aeiou").findFirst((NEW_NAME).substr(0, 0)) >= 0)
			{
				SetName("an");
			}
			if (BREATH_TYPE == "lightning")
			{
				string L_START = (NEW_NAME).findFirst("Guard");
				string L_LEFT = (NEW_NAME).substr(0, L_START);
				L_LEFT += "Thunderguard";
				string L_LEN = (NEW_NAME).length();
				L_LEN -= L_START;
				L_LEN -= 5;
				string L_RIGHT = (NEW_NAME).substr((NEW_NAME).length() - L_LEN);
				NEW_NAME = L_LEFT;
				NEW_NAME += L_RIGHT;
			}
			SetName(NEW_NAME);
		}
		ANIM_IDLE = ANIM_IDLE_DEEP;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		QUARTER_HP = GetEntityMaxHealth(GetOwner());
		QUARTER_HP *= 0.25;
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
		if ((HAS_SHIELD))
		{
			SetStat("parry", 150);
		}
		ATTACK_RANGE_DEFAULT = ATTACK_RANGE;
		ANIM_ATTACK_DEFAULT = ANIM_ATTACK;
		if (!(CAUTIOUS_APPROACH))
		{
			ANIM_RUN = "run";
		}
		float F_TAKEDMG_ADJ_ACID = 0.75;
		float F_TAKEDMG_ADJ_COLD = 0.75;
		float F_TAKEDMG_ADJ_FIRE = 0.75;
		float F_TAKEDMG_ADJ_POISON = 0.75;
		float F_TAKEDMG_ADJ_LIGHTNING = 0.75;
		if ((IS_GREEN))
		{
			F_TAKEDMG_ADJ_ACID += -0.25;
			F_TAKEDMG_ADJ_POISON += -0.25;
			F_TAKEDMG_ADJ_LIGHTNING += 0.25;
		}
		if ((IS_RED))
		{
			F_TAKEDMG_ADJ_FIRE += -1.0;
			F_TAKEDMG_ADJ_COLD += 0.5;
		}
		if ((IS_BLACK))
		{
			F_TAKEDMG_ADJ_ACID += -0.5;
			F_TAKEDMG_ADJ_FIRE += -0.5;
			F_TAKEDMG_ADJ_COLD += -0.5;
			F_TAKEDMG_ADJ_POISON += -0.5;
			F_TAKEDMG_ADJ_LIGHTNING += -0.5;
			SetDamageResistance("holy", 2.0);
			SetDamageResistance("stun", 0.25);
		}
		if ((IS_ARMORED))
		{
			string L_ADJ = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
			L_ADJ -= 0.25;
			SetDamageResistance("stun", L_ADJ);
		}
		DEFAULT_TAKDMG_ACID = F_TAKEDMG_ADJ_ACID;
		DEFAULT_TAKDMG_COLD = F_TAKEDMG_ADJ_COLD;
		DEFAULT_TAKDMG_FIRE = F_TAKEDMG_ADJ_FIRE;
		DEFAULT_TAKDMG_POISON = F_TAKEDMG_ADJ_POISON;
		DEFAULT_TAKDMG_LIGHTNING = F_TAKEDMG_ADJ_LIGHTNING;
		F_TAKEDMG_ADJ_ACID += TAKEDMG_ADJ_ACID;
		F_TAKEDMG_ADJ_COLD += TAKEDMG_ADJ_COLD;
		F_TAKEDMG_ADJ_FIRE += TAKEDMG_ADJ_FIRE;
		F_TAKEDMG_ADJ_POISON += TAKEDMG_ADJ_POISON;
		F_TAKEDMG_ADJ_LIGHTNING += TAKEDMG_ADJ_LIGHTNING;
		if (F_TAKEDMG_ADJ_ACID < 0)
		{
			int F_TAKEDMG_ADJ_ACID = 0;
		}
		if (F_TAKEDMG_ADJ_COLD < 0)
		{
			int F_TAKEDMG_ADJ_COLD = 0;
		}
		if (F_TAKEDMG_ADJ_FIRE < 0)
		{
			int F_TAKEDMG_ADJ_FIRE = 0;
		}
		if (F_TAKEDMG_ADJ_POISON < 0)
		{
			int F_TAKEDMG_ADJ_POISON = 0;
		}
		if (F_TAKEDMG_ADJ_LIGHTNING < 0)
		{
			int F_TAKEDMG_ADJ_LIGHTNING = 0;
		}
		if (F_TAKEDMG_ADJ_ACID > 3)
		{
			int F_TAKEDMG_ADJ_ACID = 3;
		}
		if (F_TAKEDMG_ADJ_COLD > 3)
		{
			int F_TAKEDMG_ADJ_COLD = 3;
		}
		if (F_TAKEDMG_ADJ_FIRE > 3)
		{
			int F_TAKEDMG_ADJ_FIRE = 3;
		}
		if (F_TAKEDMG_ADJ_POISON > 3)
		{
			int F_TAKEDMG_ADJ_POISON = 3;
		}
		if (F_TAKEDMG_ADJ_LIGHTNING > 3)
		{
			int F_TAKEDMG_ADJ_LIGHTNING = 3;
		}
		SetDamageResistance("acid", F_TAKEDMG_ADJ_ACID);
		SetDamageResistance("cold", F_TAKEDMG_ADJ_COLD);
		SetDamageResistance("fire", F_TAKEDMG_ADJ_FIRE);
		SetDamageResistance("poison", F_TAKEDMG_ADJ_POISON);
		SetDamageResistance("lightning", F_TAKEDMG_ADJ_LIGHTNING);
		if ((G_DEVELOPER_MODE))
		{
			SetSayTextRange(1024);
			dev_text();
		}
	}

	void dev_text()
	{
		SayText("DEV_STRING");
		SayText("Takedmg: acd: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "acid") cld: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "cold") fir: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "fire") poi: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "poison") lgt: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "lightning") stun: IMMUNE_STUN");
		SayText("hp: GetEntityMaxHealth(GetOwner()) exp: NPC_GIVE_EXP");
		LogDebug("DEV_STRING");
		LogDebug("Takedmg: acd: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "acid") cld: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "cold") fir: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "fire") poi: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "poison") lgt: /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "lightning") stun: IMMUNE_STUN");
		LogDebug("hp: GetEntityMaxHealth(GetOwner()) exp: NPC_GIVE_EXP");
	}

	void dg_narm()
	{
		NO_ARMOR = 1;
	}

	void dg_armr()
	{
		IS_ARMORED = 1;
		SetModelBody(0, 1);
		SetDamageResistance("all", 0.5);
		NPC_GIVE_EXP += 350;
	}

	void dg_red()
	{
		if ((SKIN_SET))
		{
			SendInfoMsg("all", "MAPPER ERROR Two skins set on Dragon Guard");
		}
		if ((SKIN_SET)) return;
		SKIN_SET = 1;
		IS_RED = 1;
		IS_GREEN = 0;
		IS_BLACK = 0;
		SetProp(GetOwner(), "skin", 1);
		NPC_GIVE_EXP += 50;
	}

	void dg_black()
	{
		if ((SKIN_SET))
		{
			SendInfoMsg("all", "MAPPER ERROR Two skins set on Dragon Guard");
		}
		if ((SKIN_SET)) return;
		SKIN_SET = 1;
		IS_BLACK = 1;
		IS_GREEN = 0;
		IS_RED = 0;
		SetProp(GetOwner(), "skin", 2);
		NPC_GIVE_EXP += 1000;
	}

	void dg_wice()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 1;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 200;
		ATTACK_REACH_RANGE = 128;
		ATTACK_RANGE = RANGE_MELEE_STANDARD;
		ATTACK_HITRANGE = HITRANGE_MELEE_STANDARD;
		ATTACK_MOVERANGE = MOVERANGE_MELEE_STANDARD;
		ANIM_IDLE_COMBAT = "combat_idle";
		ANIM_IDLE_DEEP = "deep_idle";
		ANIM_ATTACK1 = "1h_slash1";
		ANIM_ATTACK2 = "1h_slash2";
		ANIM_ATTACK_REACH = "1h_reach";
		NPC_JUMPER = 1;
		FREQ_REACH_ATTACK = 15.0;
		CAUTIOUS_APPROACH = 0;
		DMG_MELEE = 200;
		DMG_MELEE_TYPE = "slash";
		HAS_DOT = 1;
		MELEE_DOT_DUR = 5;
		MELEE_DOT = 50;
		MELEE_DOT_EFFECT = "effects/dot_cold";
		NEW_NAME = "Dragon Guard Iceblade";
	}

	void dg_wbow()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 2;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP -= 200;
		ATTACK_RANGE = 1024;
		ATTACK_MOVERANGE = 384;
		ATTACK_HITRANGE = 1024;
		NO_REACH_ATTACK = 1;
		NPC_NO_VADJ = 1;
		ANIM_IDLE_COMBAT = "xbowrdy";
		ANIM_IDLE_DEEP = "deep_idle";
		ANIM_ATTACK1 = "xbowshot";
		ANIM_ATTACK2 = "xbowshot";
		NPC_JUMPER = 0;
		NEVER_JUMPS = 1;
		FREQ_KICK = 8.0;
		EXTEND_KICK_RANGE = 1;
		RETREATS_WHEN_NEAR = 1;
		RETREATS_NEAR_RANGE = 72;
		RETREATS_NEAR_TYPE = "flee";
		ATTACK_REACH_RANGE = 128;
		CAUTIOUS_APPROACH = 0;
		NPC_RANGED = 1;
		DMG_MELEE = 200;
		DMG_MELEE_TYPE = "pierce";
		HAS_DOT = 1;
		MELEE_DOT_DUR = 5;
		MELEE_DOT = 50;
		MELEE_DOT_EFFECT = "effects/dot_poison";
		NEW_NAME = "Dragon Guard Bowman";
	}

	void dg_wpol()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 3;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 150;
		ATTACK_REACH_RANGE = 196;
		ATTACK_RANGE = 128;
		ATTACK_HITRANGE = 190;
		ATTACK_MOVERANGE = 96;
		NPC_JUMPER = 1;
		NPC_MUST_SEE_TARGET = 0;
		ANIM_IDLE_COMBAT = "pole_idle2";
		ANIM_IDLE_DEEP = "pole_idle1";
		ANIM_ATTACK1 = "pole_close";
		ANIM_ATTACK2 = "plparryl";
		ANIM_ATTACK_REACH = "pole_reach";
		FREQ_REACH_ATTACK = 1.0;
		FREQ_KICK = 8.0;
		RETREATS_WHEN_NEAR = 1;
		RETREATS_NEAR_RANGE = 96;
		RETREATS_NEAR_TYPE = "walk";
		CAUTIOUS_APPROACH = 1;
		DMG_MELEE = 600;
		DMG_MELEE_TYPE = "pierce";
		HAS_DOT = 0;
		NEW_NAME = "Dragon Guard Pikeman";
	}

	void dg_wham()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 4;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 400;
		ATTACK_REACH_RANGE = 196;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 110;
		ATTACK_MOVERANGE = 48;
		NPC_JUMPER = 1;
		FREQ_KICK = 9999;
		ANIM_IDLE_COMBAT = "2w_idle";
		ANIM_IDLE_DEEP = "combat_idle";
		ANIM_ATTACK1 = "2hclosel";
		ANIM_ATTACK2 = "2hcloseh";
		ANIM_ATTACK_REACH = "hammer_reach";
		FREQ_REACH_ATTACK = 15.0;
		CAUTIOUS_APPROACH = 0;
		DMG_MELEE = 400;
		DMG_MELEE_TYPE = "blunt";
		HAS_DOT = 0;
		CAN_STUN = 1;
		STUN_BURST = 1;
		STUN_CHANCE = 0.25;
		NEW_NAME = "Dragon Guard Mauler";
	}

	void dg_wcre()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 5;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 200;
		ATTACK_REACH_RANGE = 128;
		ATTACK_RANGE = 52;
		ATTACK_HITRANGE = 70;
		ATTACK_MOVERANGE = MOVERANGE_MELEE_STANDARD;
		NPC_JUMPER = 1;
		FREQ_KICK = Random(10.0, 15.0);
		ANIM_IDLE_COMBAT = "2w_readyvs";
		ANIM_IDLE_DEEP = "2w_idle";
		ANIM_ATTACK1 = "2wslashl";
		ANIM_ATTACK2 = "2wcloseh";
		ANIM_ATTACK_REACH = "2wreach";
		FREQ_REACH_ATTACK = 10.0;
		CAUTIOUS_APPROACH = 1;
		DMG_MELEE = 100;
		DMG_MELEE_TYPE = "slash";
		HAS_DOT = 1;
		MELEE_DOT = 50;
		MELEE_DOT_DUR = 5;
		MELEE_DOT_EFFECT = "effects/dot_poison";
		CAN_THROW = 1;
		PROJECTILE_THROW = "proj_crescent";
		NEW_NAME = "Dragon Guard Ravager";
	}

	void dg_wdbl()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 6;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 250;
		ATTACK_REACH_RANGE = 128;
		ATTACK_RANGE = RANGE_MELEE_STANDARD;
		ATTACK_HITRANGE = HITRANGE_MELEE_STANDARD;
		ATTACK_MOVERANGE = MOVERANGE_MELEE_STANDARD;
		NPC_JUMPER = 1;
		ANIM_IDLE_COMBAT = "2w_readyvs";
		ANIM_IDLE_DEEP = "deep_idle";
		ANIM_ATTACK1 = "2wslashl";
		ANIM_ATTACK2 = "2wcloseh";
		ANIM_ATTACK_REACH = "2wreach";
		FREQ_REACH_ATTACK = 10.0;
		CAUTIOUS_APPROACH = 1;
		DMG_MELEE = 150;
		DMG_MELEE_TYPE = "dark";
		HAS_DOT = 0;
		MELEE_VAMPIRE = 1;
		NEW_NAME = "Dragon Guard Bladesman";
	}

	void dg_wfrb()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 7;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 150;
		TAKEDMG_ADJ_FIRE += -0.5;
		ATTACK_REACH_RANGE = 128;
		ATTACK_RANGE = RANGE_MELEE_STANDARD;
		ATTACK_HITRANGE = HITRANGE_MELEE_STANDARD;
		ATTACK_MOVERANGE = MOVERANGE_MELEE_STANDARD;
		NPC_JUMPER = 1;
		FREQ_KICK = 9999;
		ANIM_IDLE_COMBAT = "2w_idle";
		ANIM_IDLE_DEEP = "deep_idle";
		ANIM_ATTACK1 = "1h_slash1";
		ANIM_ATTACK2 = "1h_slash2";
		ANIM_ATTACK_REACH = "1h_reach";
		FREQ_REACH_ATTACK = 10.0;
		CAUTIOUS_APPROACH = 1;
		HAS_SHIELD = 1;
		DMG_MELEE = 200;
		DMG_MELEE_TYPE = "slash";
		HAS_DOT = 1;
		MELEE_DOT = 150;
		MELEE_DOT_DUR = 5;
		MELEE_DOT_EFFECT = "effects/dot_fire";
		NEW_NAME = "Dragon Guard Flameblade";
	}

	void dg_wgrb()
	{
		if ((WEAPON_TYPE)) return;
		WEAPON_TYPE = 8;
		SetModelBody(1, WEAPON_TYPE);
		NPC_GIVE_EXP += 200;
		TAKEDMG_ADJ_POISON += -0.5;
		ATTACK_REACH_RANGE = 128;
		ATTACK_RANGE = RANGE_MELEE_STANDARD;
		ATTACK_HITRANGE = HITRANGE_MELEE_STANDARD;
		ATTACK_MOVERANGE = MOVERANGE_MELEE_STANDARD;
		NPC_JUMPER = 1;
		FREQ_KICK = 9999;
		ANIM_IDLE_COMBAT = "2w_idle";
		ANIM_IDLE_DEEP = "deep_idle";
		ANIM_ATTACK1 = "1h_slash1";
		ANIM_ATTACK2 = "1h_slash2";
		ANIM_ATTACK_REACH = "1h_reach";
		FREQ_REACH_ATTACK = 10.0;
		CAUTIOUS_APPROACH = 1;
		HAS_SHIELD = 1;
		HAS_DOT = 1;
		DMG_MELEE = 150;
		DMG_MELEE_TYPE = "slash";
		MELEE_DOT = 50;
		MELEE_DOT_DUR = 10;
		MELEE_DOT_EFFECT = "effects/dot_poison";
		NEW_NAME = "Dragon Guard Plaguebringer";
	}

	void dg_bfir()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Breath_Fire ";
		}
		NAME_PREF = "Infernal";
		BREATH_ATTACK = 1;
		BREATH_TYPE = "fire";
		NPC_GIVE_EXP += 100;
		BREATH_DOT = 200;
		ANIM_BREATH = "breath_start";
		BREATH_MIN_RANGE = 0;
		BREATH_PUSH_VEL = 200;
		TAKEDMG_ADJ_FIRE += -0.5;
		TAKEDMG_ADJ_COLD += 0.75;
		BREATH_RANGE = 256;
		FREQ_BREATH = 20.0;
	}

	void dg_bice()
	{
		if ((IS_RED)) return;
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Breath_Cold ";
		}
		NAME_PREF = "Freezing";
		LogDebug("dg_bice");
		BREATH_ATTACK = 1;
		BREATH_TYPE = "cold";
		NPC_GIVE_EXP += 200;
		TAKEDMG_ADJ_FIRE += 0.75;
		TAKEDMG_ADJ_COLD += -0.5;
		BREATH_DOT = 50;
		BREATH_MIN_RANGE = 0;
		BREATH_PUSH_VEL = 0;
		ANIM_BREATH = "breath_start";
		FREQ_BREATH = 20.0;
		BREATH_RANGE = 256;
	}

	void dg_bpoi()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Breath_Poison ";
		}
		NAME_PREF = "Noxious";
		BREATH_ATTACK = 1;
		BREATH_TYPE = "poison";
		NPC_GIVE_EXP += 100;
		TAKEDMG_ADJ_POISON += -0.5;
		TAKEDMG_ADJ_ACID += -0.5;
		TAKEDMG_ADJ_LIGHTNING += 0.75;
		BREATH_DOT = 50;
		ANIM_BREATH = "breath_start";
		BREATH_MIN_RANGE = 0;
		BREATH_PUSH_VEL = 200;
		FREQ_BREATH = 20.0;
		BREATH_RANGE = 256;
	}

	void dg_bacd()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Breath_Acid ";
		}
		NAME_PREF = "Caustic";
		BREATH_ATTACK = 1;
		BREATH_TYPE = "acid";
		NPC_GIVE_EXP += 100;
		TAKEDMG_ADJ_ACID += -0.5;
		TAKEDMG_ADJ_LIGHTNING += 0.5;
		ANIM_BREATH = "breath_quick";
		BREATH_QUICK = 1;
		FREQ_BREATH = 6.0;
		BREATH_RANGE = 1024;
		BREATH_MIN_RANGE = 150;
	}

	void dg_blgt()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Breath_lightning ";
		}
		BREATH_ATTACK = 1;
		BREATH_TYPE = "lightning";
		NPC_GIVE_EXP += 100;
		TAKEDMG_ADJ_ACID += 0.75;
		TAKEDMG_ADJ_POISON += 0.5;
		TAKEDMG_ADJ_LIGHTNING += -0.5;
		ANIM_BREATH = "breath_quick";
		BREATH_QUICK = 1;
		FREQ_BREATH = 6.0;
		BREATH_RANGE = 1024;
		BREATH_MIN_RANGE = 0;
	}

	void dg_nbrt()
	{
		NO_BREATH = 1;
	}

	void dg_npot()
	{
		NO_POTION = 1;
	}

	void dg_potd()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Pot_Demonblood ";
		}
		NO_POTION = 1;
		POT_SPECIAL = 1;
		POT_TYPE = "demon";
		NPC_GIVE_EXP += 750;
	}

	void dg_potp()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Pot_Protection";
		}
		NO_POTION = 1;
		POT_SPECIAL = 1;
		POT_TYPE = "protection";
		NPC_GIVE_EXP += 200;
	}

	void dg_potf()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Pot_Faura ";
		}
		NO_POTION = 1;
		POT_SPECIAL = 1;
		POT_TYPE = "faura";
		NPC_GIVE_EXP += 100;
	}

	void dg_pots()
	{
		if ((G_DEVELOPER_MODE))
		{
			DEV_STRING += "Pot_Speed ";
		}
		NO_POTION = 1;
		POT_SPECIAL = 1;
		POT_TYPE = "speed";
		NPC_GIVE_EXP += 500;
	}

	void npc_targetsighted()
	{
		if ((DID_INIT)) return;
		DID_INIT = 1;
		string GAME_TIME = GetGameTime();
		NEXT_ALERT_SOUND = GAME_TIME;
		NEXT_ALERT_SOUND += 10.0;
		NEXT_KICK = GAME_TIME;
		NEXT_KICK += FREQ_KICK;
		NEXT_BREATH = GAME_TIME;
		NEXT_BREATH += FREQ_BREATH;
		if ((IS_ARMORED))
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			// PlayRandomSound from: SOUNDA_HEARD_ALERT1, SOUNDA_HEARD_ALERT2
			array<string> sounds = {SOUNDA_HEARD_ALERT1, SOUNDA_HEARD_ALERT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			// PlayRandomSound from: SOUND_HEARD_ALERT1, SOUND_HEARD_ALERT2
			array<string> sounds = {SOUND_HEARD_ALERT1, SOUND_HEARD_ALERT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (StringToLower(GetMapName()) == "nashalrath")
		{
			string MAH_DADDY = FindEntityByName("gdragon_img");
			if (!(IsEntityAlive(MAH_DADDY)))
			{
			}
			CallExternal(m_hAttackTarget, "ext_play_music", "DemonicFlesh2.mp3");
		}
		if (!(POT_SPECIAL)) return;
		npcatk_suspend_ai(2.0);
		PlayAnim("critical", ANIM_DRINK);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI))
		{
			string L_LAST_AI_SUSPEND_PLUS10 = NPC_LAST_SUSPEND_AI;
			L_LAST_AI_SUSPEND_PLUS10 += 10.0;
			if (GetGameTime() > L_LAST_AI_SUSPEND_PLUS10)
			{
				LogDebug("AI SUSPENDED TOO LONG");
				npcatk_resume_ai();
				DG_SUSPEND = 0;
			}
		}
		if ((SUSPEND_AI)) return;
		if (ATTACK_HITRANGE < ATTACK_RANGE)
		{
			ATTACK_HITRANGE = ATTACK_RANGE;
			ATTACK_HITRANGE *= 1.25;
		}
		string GAME_TIME = GetGameTime();
		if (!(m_hAttackTarget != "unset")) return;
		if ((HEAL_READY))
		{
			if (!(ATTEMPTED_HEAL))
			{
			}
			if (GAME_TIME > NEXT_HEAL)
			{
			}
			SetModelBody(1, 10);
			DO_HEAL = 1;
			ATTEMPTED_HEAL = 1;
			npcatk_suspend_ai(2.0);
			PlayAnim("critical", ANIM_DRINK);
			if ((IS_ARMORED))
			{
				EmitSound(GetOwner(), 0, SOUNDA_HEAL, 10);
			}
			ScheduleDelayedEvent(5.0, "reset_weapon_submodel");
		}
		if ((SUSPEND_AI)) return;
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if ((BREATH_ATTACK))
		{
			if (GAME_TIME > NEXT_BREATH)
			{
			}
			if (TARG_RANGE < BREATH_RANGE)
			{
			}
			if (TARG_RANGE > BREATH_MIN_RANGE)
			{
			}
			if ((false))
			{
			}
			NEXT_BREATH = GetGameTime();
			NEXT_BREATH += FREQ_BREATH;
			PlayAnim("critical", ANIM_BREATH);
			DG_SUSPEND = GAME_TIME;
			if ((BREATH_QUICK))
			{
				DG_SUSPEND += 1.0;
			}
			else
			{
				DG_SUSPEND += 2.5;
			}
		}
		if (!(GAME_TIME > DG_SUSPEND)) return;
		if ((CAUTIOUS_APPROACH))
		{
			if (TARG_RANGE < 256)
			{
				if (GetEntityHealth(GetOwner()) > QUARTER_HP)
				{
				}
				if (GAME_TIME > NEXT_CALM)
				{
				}
				ANIM_RUN = ANIM_CAUTIOUS_APPROACH;
				SetMoveAnim(ANIM_RUN);
			}
			else
			{
				if (GetEntityHealth(GetOwner()) > QUARTER_HP)
				{
				}
				ANIM_RUN = "run";
				SetMoveAnim(ANIM_RUN);
			}
		}
		else
		{
			if (GetEntityHealth(GetOwner()) > QUARTER_HP)
			{
			}
			SetMoveAnim(ANIM_RUN);
		}
		if ((BREATH_ON))
		{
			if (GAME_TIME > NEXT_BREATH_REMOVE)
			{
			}
			NEXT_BREATH_REMOVE = "";
			NEXT_BREATH_REMOVE += 1.0;
			BREATH_ON = 0;
			ClientEvent("update", "all", BREATH_CL_IDX, "end_fx");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((RETREATS_WHEN_NEAR))
		{
			if (TARG_RANGE < RETREATS_NEAR_RANGE)
			{
			}
			if (GAME_TIME > NEXT_BACK_OFF)
			{
			}
			if (RETREATS_NEAR_TYPE == "walk")
			{
				PlayAnim("critical", ANIM_CAUTIOUS_RETREAT);
				NEXT_BACK_OFF = GAME_TIME;
				NEXT_BACK_OFF += 10.0;
			}
			if (RETREATS_NEAR_TYPE == "flee")
			{
				if (GetEntityHealth(GetOwner()) > QUARTER_HP)
				{
					ANIM_RUN = "run";
					SetMoveAnim(ANIM_RUN);
				}
				else
				{
					ANIM_RUN = "walkinj";
					SetMoveAnim(ANIM_RUN);
				}
				npcatk_flee(m_hAttackTarget, 512, 2.0);
				NEXT_BACK_OFF = GAME_TIME;
				NEXT_BACK_OFF += 20.0;
			}
		}
		if (!(NO_REACH_ATTACK))
		{
			if (WEAPON_TYPE != 3)
			{
			}
			if (TARG_RANGE < ATTACK_REACH_RANGE)
			{
			}
			if (GAME_TIME > NEXT_REACH_ATTACK)
			{
			}
			NEXT_REACH_ATTACK = GAME_TIME;
			NEXT_REACH_ATTACK += FREQ_REACH_ATTACK;
			ATTACK_RANGE = ATTACK_REACH_RANGE;
			ANIM_ATTACK = ANIM_ATTACK_REACH;
		}
		if (WEAPON_TYPE == 3)
		{
			if (TARG_RANGE < 70)
			{
				string RND_ATK = RandomInt(1, 2);
				if (RND_ATK == 1)
				{
					ANIM_ATTACK = "plparryl";
				}
				if (RND_ATK == 2)
				{
					ANIM_ATTACK = "pole_close";
				}
			}
			else
			{
				ANIM_ATTACK = "pole_reach";
			}
		}
		if (WEAPON_TYPE == 5)
		{
			if (GAME_TIME > NEXT_CRE_THROW)
			{
			}
			if ((false))
			{
			}
			NEXT_CRE_THROW = GetGameTime();
			NEXT_CRE_THROW += 3.0;
			PlayAnim("critical", ANIM_THROW);
		}
		if ((HAS_SHIELD))
		{
			if (TARG_RANGE < 48)
			{
			}
			if (GAME_TIME > NEXT_SHIELD_BASH)
			{
			}
			NEXT_SHIELD_BASH = GAME_TIME;
			NEXT_SHIELD_BASH += FREQ_SHIELD_BASH;
			PlayAnim("critical", "shieldl");
		}
		if (GAME_TIME > NEXT_KICK)
		{
			if (!(AM_WOUNDED))
			{
			}
			string L_KICK_RANGE = MOVERANGE_MELEE_STANDARD;
			if ((EXTEND_KICK_RANGE))
			{
				string L_KICK_RANGE = RANGE_MELEE_STANDARD;
			}
			if (GetEntityRange(m_hAttackTarget) < L_KICK_RANGE)
			{
			}
			ANIM_ATTACK = ANIM_KICK;
			NEXT_KICK = GetGameTime();
			NEXT_KICK += FREQ_KICK;
			NEXT_KICK += 2.0;
			int EXIT_SUB = 1;
		}
		else
		{
			string L_KICK_RANGE = MOVERANGE_MELEE_STANDARD;
			if ((EXTEND_KICK_RANGE))
			{
				string L_KICK_RANGE = RANGE_MELEE_STANDARD;
			}
			if (GetEntityRange(m_hAttackTarget) > L_KICK_RANGE)
			{
			}
			if (ANIM_ATTACK == ANIM_KICK)
			{
			}
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		if ((EXIT_SUB)) return;
		if (MISS_COUNT > 3)
		{
			MISS_COUNT = 0;
			chicken_run(2.0);
		}
	}

	void frame_kick_strike()
	{
		if ((IS_ARMORED))
		{
			EmitSound(GetOwner(), 2, SOUNDA_NPC_JUMP, 10);
		}
		else
		{
			EmitSound(GetOwner(), 2, SOUND_NPC_JUMP, 10);
		}
		// PlayRandomSound from: SOUND_MELEE1, SOUND_MELEE2
		array<string> sounds = {SOUND_MELEE1, SOUND_MELEE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hAttackTarget, HITRANGE_MELEE_STANDARD, DMG_KICK, 0.9, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:kick");
		ANIM_ATTACK = ANIM_ATTACK1;
	}

	void kick_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 300, 110));
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void OnDamage(int damage) override
	{
		string MY_HP = GetEntityHealth(GetOwner());
		if (!(IS_ARMORED))
		{
			if (MY_HP > HALF_HP)
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		else
		{
			if (MY_HP > HALF_HP)
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK_ARMOR1, SOUND_STRUCK_ARMOR2
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK_ARMOR1, SOUND_STRUCK_ARMOR2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK_ARMOR1, SOUND_STRUCK_ARMOR2, SOUNDA_PAIN1, SOUNDA_PAIN2, SOUNDA_PAIN3
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK_ARMOR1, SOUND_STRUCK_ARMOR2, SOUNDA_PAIN1, SOUNDA_PAIN2, SOUNDA_PAIN3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		if ((POT_HEAL))
		{
			if (MY_HP < HALF_HP)
			{
			}
			NEXT_HEAL = GAME_TIME;
			NEXT_HEAL += HEAL_DELAY;
			HEAL_READY = 1;
			POT_HEAL = 0;
		}
		NEXT_CALM = GetGameTime();
		NEXT_CALM += 20.0;
		if (MY_HP > QUARTER_HP)
		{
			AM_WOUNDED = 0;
			if (!(NEVER_JUMPS))
			{
				NPC_JUMPER = 1;
			}
			ANIM_RUN = "run";
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			AM_WOUNDED = 1;
			NPC_JUMPER = 0;
			ANIM_RUN = "walkinj";
			SetMoveAnim(ANIM_RUN);
		}
	}

	void cycle_up()
	{
		ANIM_IDLE = ANIM_IDLE_COMBAT;
		SetIdleAnim(ANIM_IDLE);
	}

	void cycle_down()
	{
		ANIM_IDLE = ANIM_IDLE_DEEP;
		SetIdleAnim(ANIM_IDLE);
		if (!(GetEntityHealth(GetOwner()) > QUARTER_HP)) return;
		ANIM_WALK = "walk";
		SetMoveAnim(ANIM_WALK);
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(m_hAttackTarget == "unset")) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(HEARD_ID) == "enemy")) return;
		if (GetEntityHealth(GetOwner()) > QUARTER_HP)
		{
			ANIM_WALK = ANIM_WALK_HEARDSOUND;
			SetMoveAnim(ANIM_WALK);
		}
		if (!(GetGameTime() > NEXT_ALERT_SOUND)) return;
		NEXT_ALERT_SOUND = GetGameTime();
		NEXT_ALERT_SOUND += 30.0;
		if ((IS_ARMORED))
		{
			EmitSound(GetOwner(), 0, SOUNDA_INVESTIGATE, 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_INVESTIGATE, 10);
		}
	}

	void frame_melee_strike()
	{
		// PlayRandomSound from: SOUND_MELEE1, SOUND_MELEE2
		array<string> sounds = {SOUND_MELEE1, SOUND_MELEE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((IS_ARMORED))
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			// PlayRandomSound from: SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3
			array<string> sounds = {SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		MELEE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_MELEE, 0.9, DMG_MELEE_TYPE);
	}

	void frame_reach_strike()
	{
		if ((IS_ARMORED))
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			// PlayRandomSound from: SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3
			array<string> sounds = {SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		// PlayRandomSound from: SOUND_MELEE1, SOUND_MELEE2
		array<string> sounds = {SOUND_MELEE1, SOUND_MELEE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		MELEE_ATTACK = 1;
		string L_HIT_RANGE = ATTACK_HITRANGE;
		L_HIT_RANGE *= 1.5;
		DoDamage(m_hAttackTarget, L_HIT_RANGE, DMG_MELEE, 0.9, DMG_MELEE_TYPE);
		ANIM_ATTACK = ANIM_ATTACK_DEFAULT;
		ATTACK_RANGE = ATTACK_RANGE_DEFAULT;
	}

	void frame_hammer_slam()
	{
		if ((IS_ARMORED))
		{
			// PlayRandomSound from: SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3
			array<string> sounds = {SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		ANIM_ATTACK = ANIM_ATTACK_DEFAULT;
		ATTACK_RANGE = ATTACK_RANGE_DEFAULT;
		EmitSound(GetOwner(), 0, SOUND_MELEE_LARGE, 10);
		BURST_START = /* TODO: $relpos */ $relpos(0, 150, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", BURST_START, 256, 0);
		BURST_START += "z";
		BURST_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			stun_burst_affect_targets();
		}
	}

	void stun_burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		if (!(IsOnGround(CUR_TARG))) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = BURST_START;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		XDoDamage(CUR_TARG, "direct", DMG_STUN_BURST, 1.0, GetOwner(), GetOwner(), "none", "blunt");
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
	}

	void frame_pole_close()
	{
		// PlayRandomSound from: SOUND_MELEE1, SOUND_MELEE2
		array<string> sounds = {SOUND_MELEE1, SOUND_MELEE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 300, 110));
		int L_DMG_MELEE = 100;
		DoDamage(m_hAttackTarget, HITRANGE_POLE_SHORT, L_DMG_MELEE, 0.9, DMG_MELEE_TYPE);
	}

	void frame_pole_strike()
	{
		if ((IS_ARMORED))
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			// PlayRandomSound from: SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3
			array<string> sounds = {SOUNDA_ATTACK1, SOUNDA_ATTACK2, SOUNDA_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		// PlayRandomSound from: SOUND_MELEE1, SOUND_MELEE2
		array<string> sounds = {SOUND_MELEE1, SOUND_MELEE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		string RANGE_RATIO = GetEntityRange(m_hAttackTarget);
		RANGE_RATIO /= ATTACK_RANGE;
		string HALF_MAX = DMG_MELEE;
		HALF_MAX *= 0.5;
		string L_DMG_MELEE = /* TODO: $ratio */ $ratio(RANGE_RATIO, HALF_MAX, DMG_MELEE);
		if ((NPC_MUST_SEE_TARGET))
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG_MELEE, 0.9, DMG_MELEE_TYPE);
		}
		else
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
			}
			DoDamage(m_hAttackTarget, "direct", L_DMG_MELEE, 0.9, GetOwner());
		}
	}

	void frame_shield_bash()
	{
		if (!(GetEntityRange(m_hAttackTarget) < 64)) return;
		string L_DMG_MELEE = DMG_MELEE;
		L_DMG_MELEE *= 0.25;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG_MELEE, 0.9, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:shieldbash");
	}

	void shieldbash_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 200, 110));
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		EmitSound(GetOwner(), 0, "body/armour1.wav", 10);
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((MELEE_VAMPIRE))
			{
				string GIVE_HP = GetEntityMaxHealth(GetOwner());
				if (GetEntityHealth(GetOwner()) < GIVE_HP)
				{
				}
				GIVE_HP *= 0.01;
				HealEntity(GetOwner(), GIVE_HP);
			}
			if (WEAPON_TYPE == 1)
			{
				if (param2 == OLD_ATTACK_TARGET)
				{
					if (!(GetEntityProperty(param2, "scriptvar")))
					{
						FREEZE_COUNT += 1;
					}
					else
					{
						FREEZE_COUNT = 0;
					}
					if (FREEZE_COUNT >= 4)
					{
						if ((param1))
						{
						}
						FREEZE_COUNT = 0;
						ApplyEffect(param2, "effects/dot_cold_freeze", MELEE_DOT_DUR, GetEntityIndex(GetOwner()), 0);
					}
				}
				else
				{
					OLD_ATTACK_TARGET = param2;
					FREEZE_COUNT = 0;
				}
			}
			if ((param1))
			{
			}
			if ((HAS_DOT))
			{
			}
			ApplyEffect(param2, MELEE_DOT_EFFECT, MELEE_DOT_DUR, GetEntityIndex(GetOwner()), MELEE_DOT);
		}
		MELEE_ATTACK = 0;
	}

	void frame_drink_done()
	{
		string LAST_FLINCH_P3 = LAST_FLINCH;
		LAST_FLINCH_P3 += 3.0;
		if (GetGameTime() < LAST_FLINCH_P3)
		{
			int FUMBLE_POTION = 0;
		}
		if ((DO_HEAL))
		{
			DO_HEAL = 0;
			HEAL_READY = 0;
			if (!(FUMBLE_POTION))
			{
				Effect("glow", GetOwner(), Vector3(0, 255, 255), 64, 1.0, 1.0);
				EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
				string HP_TO_GIVE = GetEntityMaxHealth(GetOwner());
				HP_TO_GIVE -= GetEntityHealth(GetOwner());
				HealEntity(GetOwner(), HP_TO_GIVE);
				POT_OUT_MSG = "Quaffs a potion of healing.";
				GetAllPlayers(PLR_POT_ALERT_LIST);
				if (PLR_POT_ALERT_LIST != "none")
				{
				}
				for (int i = 0; i < GetTokenCount(PLR_POT_ALERT_LIST, ";"); i++)
				{
					pot_message();
				}
			}
		}
		if ((POT_SPECIAL))
		{
			POT_SPECIAL = 0;
			if (!(FUMBLE_POTION))
			{
			}
			if (POT_TYPE == "demon")
			{
				POT_OUT_MSG = "Quaffs a potion of demon blood.";
				DEMON_NOHP_LOSS = 1;
				demon_blood();
			}
			if (POT_TYPE == "protection")
			{
				POT_OUT_MSG = "Quaffs a potion of greater protection.";
				ApplyEffect(GetOwner(), "effects/protection", 9999, 0.5);
			}
			if (POT_TYPE == "faura")
			{
				POT_OUT_MSG = "Quaffs a potion of flame aura.";
				string CUR_COLD_DMG = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "cold");
				CUR_COLD_DMG *= 0.5;
				SetDamageResistance("cold", CUR_COLD_DMG);
				ext_fire_aura_activate();
			}
			if (POT_TYPE == "speed")
			{
				POT_OUT_MSG = "Quaffs a potion of speed.";
				ClientEvent("persist", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0);
				speed_x2_5();
			}
			GetAllPlayers(PLR_POT_ALERT_LIST);
			if (PLR_POT_ALERT_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(PLR_POT_ALERT_LIST, ";"); i++)
			{
				pot_message();
			}
		}
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
		SetModelBody(1, WEAPON_TYPE);
	}

	void reset_weapon_submodel()
	{
		SetModelBody(1, WEAPON_TYPE);
	}

	void pot_message()
	{
		string CUR_PLAYER = GetToken(PLR_POT_ALERT_LIST, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < 1024)) return;
		SendInfoMsg(CUR_PLAYER, "GetEntityName(GetOwner()) POT_OUT_MSG");
	}

	void ext_fire_aura_activate()
	{
		if ((DG_FAURA)) return;
		DG_FAURA = 1;
		ClientEvent("new", "all", "items/armor_faura_cl", GetEntityIndex(GetOwner()), DG_FAURA_AOE, DG_FAURA_CL_RATE, 1);
		DG_FAURA_CLIDX = "game.script.last_sent_id";
		DG_FAURA_NEXT_CL = GetGameTime();
		DG_FAURA_NEXT_CL += DG_FAURA_CL_RATE;
		fire_aura_loop();
	}

	void fire_aura_loop()
	{
		if (!(DG_FAURA)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "fire_aura_loop");
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > DG_FAURA_NEXT_CL)
		{
			ClientEvent("new", "all", "items/armor_faura_cl", GetEntityIndex(GetOwner()), DG_FAURA_AOE, DG_FAURA_CL_RATE, 1);
			DG_FAURA_CLIDX = "game.script.last_sent_id";
			DG_FAURA_NEXT_CL = GAME_TIME;
			DG_FAURA_NEXT_CL += DG_FAURA_CL_RATE;
		}
		string SCAN_AOE = DG_FAURA_AOE;
		SCAN_AOE *= 1.5;
		DG_FAURA_SCAN = FindEntitiesInSphere("enemy", SCAN_AOE);
		if (!(DG_FAURA_SCAN != "none")) return;
		for (int i = 0; i < GetTokenCount(DG_FAURA_SCAN, ";"); i++)
		{
			fire_aura_burn();
		}
	}

	void fire_aura_burn()
	{
		string CUR_TARG = GetToken(DG_FAURA_SCAN, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DG_FAURA_DOT);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((IS_ARMORED))
		{
			if (RandomInt(1, 2) == 1)
			{
				NPC_ALT_SOUND_DEATH = SOUNDA_DEATH1;
			}
			else
			{
				NPC_ALT_SOUND_DEATH = SOUNDA_DEATH2;
			}
		}
		else
		{
			if (RandomInt(1, 2) == 1)
			{
				NPC_ALT_SOUND_DEATH = SOUND_DEATH1;
			}
			else
			{
				NPC_ALT_SOUND_DEATH = SOUND_DEATH2;
			}
		}
		if ((DG_FAURA))
		{
			ClientEvent("update", "all", DG_FAURA_CLIDX, "remove_fx");
		}
		if ((BREATH_ON))
		{
			ClientEvent("update", "all", BREATH_CL_IDX, "end_fx");
		}
		SetModelBody(1, 0);
	}

	void frame_breath_start()
	{
		if ((BREATH_ON)) return;
		SetRoam(false);
		npcatk_suspend_ai(5.0);
		npcatk_suspend_movement(ANIM_BREATH_LOOP, 5.0);
		ClientEvent("new", "all", "monsters/dragon_guard_breath_cl", GetEntityIndex(GetOwner()), BREATH_TYPE);
		BREATH_CL_IDX = "game.script.last_sent_id";
		BREATH_ON = 1;
		breath_loop();
		// svplaysound: svplaysound 1 10 SOUND_BREATH_LOOP
		EmitSound(1, 10, SOUND_BREATH_LOOP);
		ScheduleDelayedEvent(5.0, "breath_attack_end");
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		ScheduleDelayedEvent(0.5, "breath_loop");
		string L_BREATH_RANGE = BREATH_RANGE;
		L_BREATH_RANGE *= 2.0;
		BREATH_TARGS = FindEntitiesInSphere("enemy", L_BREATH_RANGE);
		if (!(BREATH_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BREATH_TARGS, ";"); i++)
		{
			breath_affect_targets();
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(BREATH_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		string TRACE_START = GetEntityOrigin(GetOwner());
		TRACE_START += /* TODO: $relpos */ $relpos(0, 24, 80);
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE != TRACE_END)) return;
		if (BREATH_TYPE == "cold")
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 6.0, GetEntityIndex(GetOwner()), BREATH_DOT);
		}
		if (BREATH_TYPE == "fire")
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), BREATH_DOT);
		}
		if (BREATH_TYPE == "poison")
		{
			ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), BREATH_DOT);
		}
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, BREATH_PUSH_VEL, 0));
	}

	void breath_attack_end()
	{
		npcatk_resume_ai();
		npcatk_resume_movement();
		PlayAnim("once", "break");
		SetRoam(true);
		BREATH_ON = 0;
		// svplaysound: svplaysound 1 0 SOUND_BREATH_LOOP
		EmitSound(1, 0, SOUND_BREATH_LOOP);
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void frame_breath_quick()
	{
		if (BREATH_TYPE == "acid")
		{
			EmitSound(GetOwner(), 0, SOUND_BREATH_ACID_BOLT, 10);
			TossProjectile("proj_acid_bolt", /* TODO: $relpos */ $relpos(0, 24, 35), m_hAttackTarget, 300, 800, 0.1, "none");
		}
		if (BREATH_TYPE == "lightning")
		{
			EmitSound(GetOwner(), 0, SOUND_BREATH_LIGHTNING, 10);
			string BEAM_START = GetEntityProperty(GetOwner(), "attachpos");
			string BEAM_END = GetEntityOrigin(m_hAttackTarget);
			string BEAM_ANGS = /* TODO: $angles3d */ $angles3d(BEAM_START, BEAM_END);
			BEAM_ANGS = "x";
			BEAM_END += /* TODO: $relpos */ $relpos(BEAM_ANGS, Vector3(0, 1024, 0));
			Effect("beam", "end", "lgtning.spr", 60, BEAM_END, GetOwner(), 1, Vector3(255, 255, 0), 200, 20, 1.0);
			XDoDamage(BEAM_START, BEAM_END, 500, 1.0, GetOwner(), GetOwner(), "none", "lightning", "dmgevent:zapbreath");
		}
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void zapbreath_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), 200);
	}

	void frame_throw()
	{
		if (WEAPON_TYPE == 5)
		{
			TossProjectile("proj_crescent", /* TODO: $relpos */ $relpos(-20, 0, 3), m_hAttackTarget, 200, 0, 0, "none");
		}
	}

	void frame_xbow()
	{
		if (GetGameTime() > NEXT_SPLODIE_BOLT)
		{
			EXPLOSIVE_BOLT = 1;
			NEXT_SPLODIE_BOLT = GetGameTime();
			NEXT_SPLODIE_BOLT += 3.0;
		}
		else
		{
			EXPLOSIVE_BOLT = 0;
		}
		EmitSound(GetOwner(), 1, SOUND_XBOW_SHOOT, 10);
		string START_LINE = GetEntityProperty(GetOwner(), "svbonepos");
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if ((EXPLOSIVE_BOLT))
		{
			TARG_ORG = "z";
		}
		if (RandomInt(1, 100) > XBOW_ACCURACY)
		{
			LogDebug("elf_shoot_xbow miss");
			string RND_X = Random(-64.0, 64.0);
			string RND_Y = Random(-64.0, 64.0);
			TARG_ORG += "x";
			TARG_ORG += "y";
			TARG_ORG = "z";
		}
		ELF_AIM_ANGLES = /* TODO: $angles3d */ $angles3d(START_LINE, TARG_ORG);
		LogDebug("before ELF_AIM_ANGLES");
		ELF_AIM_ANGLES = "x";
		LogDebug("after ELF_AIM_ANGLES");
		string END_LINE = START_LINE;
		END_LINE += /* TODO: $relpos */ $relpos(ELF_AIM_ANGLES, Vector3(0, 2048, 0));
		ELF_XBOW_SHOT = 1;
		string END_LINE = TraceLine(START_LINE, END_LINE);
		ELF_BOLT_LAND = END_LINE;
		MISS_COUNT += 1;
		XDoDamage(START_LINE, END_LINE, DMG_XBOW, 1.0, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:xbow");
		ClientEvent("new", "all", "monsters/elf_xbow_cl", START_LINE, ELF_BOLT_LAND, GetEntityAngles(GetOwner()), EXPLOSIVE_BOLT);
		if (!(EXPLOSIVE_BOLT)) return;
		ScheduleDelayedEvent(0.1, "bolt_explode");
	}

	void bolt_explode()
	{
		XDoDamage(ELF_BOLT_LAND, 128, DMG_XBOW, 0.2, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:exbow");
	}

	void xbow_dodamage()
	{
		if (!(param1)) return;
		MISS_COUNT = 0;
	}

	void exbow_dodamage()
	{
		if (!(param1)) return;
		MISS_COUNT = 0;
		string CUR_TARG = param2;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(ELF_BOLT_LAND, TARG_ORG);
		string TARG_DIST = Distance(TARG_ORG, ELF_BOLT_LAND);
		TARG_DIST /= 128;
		string PUSH_STR = /* TODO: $get_skill_ratio */ $get_skill_ratio(TARG_DIST, 600, 100);
		LogDebug("game_dodamage str PUSH_STR ratio TARG_DIST");
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, PUSH_STR, 120)));
	}

	void my_target_died()
	{
		if (!(IS_ARMORED)) return;
		if (!(GetGameTime() > NEXT_GLOAT)) return;
		NEXT_GLOAT = GetGameTime();
		NEXT_GLOAT += 20.0;
		EmitSound(GetOwner(), 0, "monsters/dg/vs_nlizardm_haha.wav", 10);
	}

}

}
