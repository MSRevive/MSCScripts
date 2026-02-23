#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class PolearmsBase : CGameScript
{
	string BWEAPON_CHARGE_PERCENT;
	string GAME_PVP;
	string NEXT_BLOCK;
	string OWNER_YAW;
	int POLE_BACKHAND_ATTACK;
	string POLE_HOLD_IDLE_CL;
	int POLE_IDLE_ACTIVE_CL;
	int POLE_IDLE_ANIM_COUNT_CL;
	int POLE_IN_BLOCK;
	int POLE_IN_SPIN;
	string POLE_NEXT_IDLE_CL;
	string POLE_NEXT_THROW;
	string POLE_POKE2_DMG;
	int POLE_SWIPE_ATTACK;
	string POLE_THROW_PREPING;
	int POLE_THROW_PREPPED;
	int POLE_THROW_PREPPING;
	string POLE_THROW_START_CHARGE_TIME;
	string PUSH_TARGETS;
	string WAS_UNDERSKILLED;
	string WEAPON_NEXT_SKILL_WARN;
	string WEAPON_PRIMARY_SKILL;
	string WEAPON_UNDERSKILLED;

	PolearmsBase()
	{
		const string VMODEL_FILE = "viewmodels/v_polearms.mdl";
		const float BWEAPON_DBL_CHARGE_ADJ = 2.0;
		const int VANIM_IDLE1 = 0;
		const int VANIM_IDLE2 = 1;
		const int VANIM_IDLE3 = 2;
		const int VANIM_DRAW = 3;
		const int VANIM_POKE1 = 4;
		const int VANIM_POKE2 = 5;
		const int VANIM_POKE_BACK = 6;
		const int VANIM_SWIPE1 = 7;
		const int VANIM_SWIPE2 = 8;
		const int VANIM_WIDE = 9;
		const int VANIM_SPIN_START = 10;
		const int VANIM_SPIN_HOLD = 11;
		const int VANIM_SPIN_END = 12;
		const int VANIM_REPEL = 13;
		const int VANIM_BLOCK_START = 14;
		const int VANIM_BLOCK_HOLD = 15;
		const int VANIM_BLOCK_END = 16;
		const int VANIM_THROW_POWER = 17;
		const int VANIM_THROW_PREP = 18;
		const int VANIM_THROW_PREPED_THROW = 19;
		const int VANIM_THROW_IDLE = 20;
		const string WANIM_FLOOR = "standard_floor_idle";
		const string WANIM_HAND = "standard_idle";
		const string PANIM_IDLE = "aim_pole";
		const string PANIM_POKE = "pole_swing";
		const string PANIM_POKE_BACK = "Pattack2";
		const string PANIM_SWIPE1 = "Pattack2";
		const string PANIM_SWIPE2 = "Pattack3";
		const string PANIM_SPIN_START = "Spin_start";
		const string PANIM_SPIN_HOLD = "Spin";
		const string PANIM_SPIN_END = "Spin_end";
		const string PANIM_REPEL = "repel";
		const string PANIM_BLOCK_START = "block_start";
		const string PANIM_BLOCK_HOLD = "block";
		const string PANIM_BLOCK_END = "block_end";
		const string PANIM_THROW = "throw1";
		const string PANIM_THROW_PREP = "throw2_start";
		const string PANIM_THROW_IDLE = "throw2_aim";
		const string PANIM_THROW_PREPED_THROW = "throw2_end";
		const string SOUND_HITWALL1 = "weapons/bullet_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/bullet_hit2.wav";
		const string SOUND_THRUST = "weapons/cbar_miss1.wav";
		const string SOUND_SWIPE = "zombie/claw_miss2.wav";
		const string SOUND_BACKHAND = "weapons/swingsmall.wav";
		const string SOUND_BLOCK = "body/armour1.wav";
		const string SOUND_READY = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_CHARGE = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_SPIN_LOOP = "weapons/polearm_spin.wav";
		const string SOUND_THROW = "zombie/claw_miss1.wav";
		const int MELEE_DMG = 120;
		const int MELEE_RANGE = 90;
		const string MELEE_DMG_TYPE = "blunt";
		const int MELEE_DMG_RANGE = 0;
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.5;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.5;
		const float MELEE_ACCURACY = 0.9;
		const string MELEE_STAT = "polearms";
		const int MELEE_STARTPOS = 0;
		const int MELEE_AIMANGLE = 0;
		const int MELEE_NOISE = 650;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const float POLE_POKE2_ATK_DURATION = 1.5;
		const int POLE_CAN_SWIPE = 1;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 1;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_CAN_THROW = 0;
		const int POLE_CAN_POWER_THROW = 0;
		const float POLE_BLOCK_PROT_RATIO = 0.3;
		const float POLE_BLOCK_DELAY = 3.0;
		const int POLE_REPEL_STRENGTH = 600;
		const int POLE_SWIPE_DMG = 60;
		const int POLE_SWIPE_DMG_RANGE = 20;
		const string POLE_SWIPE_DMG_TYPE = "blunt";
		const int POLE_SWIPE_RANGE = 60;
		const float POLE_SWIPE_ACCURACY = 0.6;
		const float POLE_SWIPE_DMG_DELAY = 0.5;
		const float POLE_SWIPE_ATK_DURATION = 0.9;
		const int POLE_BACKHAND_DMG = 100;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "blunt";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.7;
		const float POLE_BACKHAND_DMG_DELAY = 0.8;
		const float POLE_BACKHAND_ATK_DURATION = 1.2;
		const int POLE_BACKHAND_STUN = 0;
		const float POLE_BACKHAND_STUN_CHANCE = 0.0;
		const int POLE_BACKHAND_REPEL = 0;
		const float POLE_THROW_PREPED_ATKDELAY = 0.1;
		const float POLE_THROW_PREP_DELAY = 0.3;
		const int POLE_THROW_POWER = 600;
		const string POLE_THOW_PROJECTILE = "proj_pole_spear";
		const float POLE_THROW_RECHARGE_TIME = 1.0;
		const float POLE_THROW_MAX_CHARGE_TIME = 3.0;
		const float POLE_THROW_COF = 1.0;
		const int POLE_THROW_MP = 0;
		const string POLE_THROW_STAT = "polearms";
	}

	void OnSpawn() override
	{
		SetHand("both");
		item_spawn();
		weapon_spawn();
		polearm_spawn();
		polearm_register_attacks();
	}

	void OnDeploy() override
	{
		pole_draw();
		if (!(true)) return;
		GAME_PVP = "game.pvp";
		pole_check_skill();
		ScheduleDelayedEvent(0.01, "polearm_setup_model");
	}

	void game_show()
	{
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetModelBody(0, PMODEL_IDX_HANDS);
	}

	void OnDrop() override
	{
		item_drop();
		string RL_HAND = "game.item.hand_index";
		CallExternal(GetOwner(), "ext_set_hand_id", RL_HAND, 0);
	}

	void game_switchhands()
	{
		PlayViewAnim(VANIM_IDLE1);
		POLE_IDLE_ANIM_COUNT_CL = 0;
		item_switchhands();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		pole_draw();
	}

	void game_fall()
	{
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetModelBody(0, PMODEL_IDX_FLOOR);
		PlayAnim("once", WANIM_FLOOR);
		weapon_fall();
	}

	void pole_draw()
	{
		LogDebug("pole_draw");
		PlayViewAnim("break");
		PlayAnim("once", "break");
		SetViewModel(VMODEL_FILE);
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetModelBody(0, PMODEL_IDX_HANDS);
		SetAnimExt("pole");
		POLE_IDLE_ANIM_COUNT_CL = 0;
		if (!(false)) return;
		PlayViewAnim("break");
		PlayAnim("once", "break");
		PlayViewAnim(VANIM_DRAW);
		PlayAnim("once", WANIM_HAND);
		if ((POLE_IDLE_ACTIVE_CL)) return;
		POLE_IDLE_ACTIVE_CL = 1;
		ScheduleDelayedEvent(4.0, "pole_idle_anim_cl");
	}

	void polearm_setup_model()
	{
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") VMODEL_IDX
	}

	void polearm_register_attacks()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "+attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "attack_poke1";
		string reg.attack.noise = MELEE_NOISE;
		string reg.attack.reqskill = BASE_LEVEL_REQ;
		RegisterAttack();
		WEAPON_PRIMARY_SKILL = reg.attack.stat;
		if ((POLE_CAN_POKE2))
		{
			string reg.attack.type = "strike-land";
			string reg.attack.range = MELEE_RANGE;
			string reg.attack.dmg = MELEE_DMG;
			string reg.attack.dmg.range = MELEE_DMG_RANGE;
			string reg.attack.dmg.type = MELEE_DMG_TYPE;
			string reg.attack.energydrain = MELEE_ENERGY;
			string reg.attack.stat = MELEE_STAT;
			string reg.attack.hitchance = MELEE_ACCURACY;
			int reg.attack.priority = 1;
			string reg.attack.delay.strike = MELEE_DMG_DELAY;
			string reg.attack.delay.end = POLE_POKE2_ATK_DURATION;
			string reg.attack.ofs.startpos = MELEE_STARTPOS;
			string reg.attack.ofs.aimang = MELEE_AIMANGLE;
			string reg.attack.noise = MELEE_NOISE;
			string reg.attack.keys = "-attack1";
			string reg.attack.callback = "attack_poke2";
			reg.attack.dmg *= BWEAPON_DBL_CHARGE_ADJ;
			reg.attack.energydrain *= BWEAPON_DBL_CHARGE_ADJ;
			POLE_POKE2_DMG = reg.attack.dmg;
			float reg.attack.chargeamt = 1.0;
			string reg.attack.reqskill = BASE_LEVEL_REQ;
			reg.attack.reqskill += 2;
			RegisterAttack();
		}
		if ((POLE_CAN_POWER_THROW))
		{
			string reg.attack.mpdrain = POLE_THROW_MP;
			int reg.attack.ammodrain = 0;
			string reg.attack.type = "charge-throw-projectile";
			string reg.attack.hold_min&max = "1;1";
			string reg.attack.dmg.type = "pierce";
			string reg.attack.range = POLE_THROW_POWER;
			string reg.attack.energydrain = MELEE_ENERGY;
			string reg.attack.stat = POLE_THROW_STAT;
			int reg.attack.COF = 1;
			string reg.attack.projectile = POLE_THOW_PROJECTILE;
			int reg.attack.priority = 2;
			float reg.attack.delay.strike = 0.01;
			float reg.attack.chargeamt = 2.0;
			float reg.attack.delay.end = 0.2;
			Vector3 reg.attack.ofs.startpos = Vector3(5, 0, 4);
			Vector3 reg.attack.ofs.aimang = Vector3(0, 0, 0);
			string reg.attack.noise = MELEE_NOISE;
			string reg.attack.callback = "pole_powerthrow";
			string reg.attack.reqskill = BASE_LEVEL_REQ;
			reg.attack.reqskill += 4;
			string reg.attack.keys = "-attack1";
			RegisterAttack();
		}
	}

	void pole_powerthrow_start()
	{
		PlayViewAnim(VANIM_THROW_POWER);
		PlayOwnerAnim("once", PANIM_THROW);
		if (!(true)) return;
		EmitSound(GetOwner(), 0, SOUND_SHOUT, 10);
		ScheduleDelayedEvent(0.5, "pole_powerthrow_sound");
	}

	void pole_powerthrow_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_THROW, 10);
	}

	void attack_poke1_start()
	{
		if (!(true)) return;
		if (!(POLE_PRIMARY_SWIPE))
		{
			pole_attack("poke1");
		}
		else
		{
			pole_attack("priswipe");
		}
		if ((POLE_THROW_PREPING))
		{
			int ABORT_THROW = 1;
		}
		if ((POLE_THROW_PREPPED))
		{
			int ABORT_THROW = 1;
		}
		if ((ABORT_THROW))
		{
			pole_abort_throw("pole_attack");
		}
	}

	void attack_poke2_start()
	{
		EmitSound(GetOwner(), 1, SOUND_CHARGE, 10);
		if (!(true)) return;
		pole_attack("poke2");
		if ((POLE_THROW_PREPING))
		{
			int ABORT_THROW = 1;
		}
		if ((POLE_THROW_PREPPED))
		{
			int ABORT_THROW = 1;
		}
		if ((ABORT_THROW))
		{
			pole_abort_throw("pole_attack");
		}
	}

	void pole_attack()
	{
		int NORMAL_ATTACK = 1;
		POLE_BACKHAND_ATTACK = 0;
		POLE_SWIPE_ATTACK = 0;
		if ((POLE_CAN_SWIPE))
		{
			if (param1 != "poke2")
			{
			}
			if ((IsKeyDown(GetOwner(), "moveright")))
			{
				POLE_SWIPE_ATTACK = 1;
				int L_SWIPE = 1;
				string VIEW_ANIM = VANIM_SWIPE1;
				string OWNER_ANIM = PANIM_SWIPE2;
				int NORMAL_ATTACK = 0;
			}
			if ((IsKeyDown(GetOwner(), "moveleft")))
			{
				POLE_SWIPE_ATTACK = 1;
				int L_SWIPE = 1;
				string VIEW_ANIM = VANIM_SWIPE2;
				string OWNER_ANIM = PANIM_SWIPE1;
				int NORMAL_ATTACK = 0;
			}
			if ((L_SWIPE))
			{
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				POLE_SWIPE_DMG_DELAY("attack_swipe_strike");
			}
		}
		if ((POLE_CAN_BACKHAND))
		{
			if (param1 != "poke2")
			{
			}
			if ((IsKeyDown(GetOwner(), "back")))
			{
				if ((IsKeyDown(GetOwner(), "use")))
				{
				}
				POLE_BACKHAND_ATTACK = 1;
				string VIEW_ANIM = VANIM_POKE_BACK;
				string OWNER_ANIM = PANIM_POKE_BACK;
				int NORMAL_ATTACK = 0;
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				POLE_BACKHAND_DMG_DELAY("attack_backhand_strike");
			}
		}
		if ((NORMAL_ATTACK))
		{
			if (param1 == "poke1")
			{
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				string VIEW_ANIM = VANIM_POKE1;
				string OWNER_ANIM = PANIM_POKE;
			}
			if (param1 == "poke2")
			{
				string VIEW_ANIM = VANIM_POKE2;
				string OWNER_ANIM = PANIM_POKE;
			}
			if (param1 == "priswipe")
			{
				LogDebug("pole_attack priswipe");
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				if ((IsKeyDown(GetOwner(), "moveleft")))
				{
					int SIDE_SWIPE = 1;
				}
				if ((IsKeyDown(GetOwner(), "moveright")))
				{
					int SIDE_SWIPE = 1;
				}
				if (!(SIDE_SWIPE))
				{
					string VIEW_ANIM = VANIM_SWIPE1;
					string OWNER_ANIM = PANIM_SWIPE1;
				}
				else
				{
					string VIEW_ANIM = VANIM_SWIPE2;
					string OWNER_ANIM = PANIM_SWIPE2;
				}
			}
		}
		if ((WEAPON_UNDERSKILLED))
		{
			WAS_UNDERSKILLED = 1;
			SetAttackProp("ent_me", 0);
		}
		else
		{
			if ((WAS_UNDERSKILLED))
			{
			}
			SetAttackProp("ent_me", 0);
			WAS_UNDERSKILLED = 0;
		}
		PlayOwnerAnim("critical", OWNER_ANIM);
		// TODO: splayviewanim ent_me VIEW_ANIM
	}

	void attack_poke1_strike()
	{
		EmitSound(GetOwner(), 1, SOUND_THRUST, 10);
	}

	void attack_poke2_strike()
	{
		EmitSound(GetOwner(), 1, SOUND_THRUST, 10);
	}

	void attack_swipe_strike()
	{
		EmitSound(GetOwner(), 1, SOUND_SWIPE, 10);
	}

	void attack_backhand_strike()
	{
		EmitSound(GetOwner(), 1, SOUND_BACKHAND, 10);
	}

	void attack_poke1_damaged_other()
	{
		if (!(true)) return;
		string TARGET_HIT = param1;
		string DMG_DONE = param2;
		pole_adjust_damage(TARGET_HIT, DMG_DONE);
		if (!(BWEAPON_CHARGE_PERCENT < 1)) return;
		if (BWEAPON_CHARGE_PERCENT > 0.25)
		{
			BWEAPON_CHARGE_PERCENT -= 0.25;
			string L_CHARGE_RATIO = /* TODO: $ratio */ $ratio(BWEAPON_CHARGE_PERCENT, 1.25, BWEAPON_DBL_CHARGE_ADJ);
			string NEW_DMG = param2;
			NEW_DMG *= L_CHARGE_RATIO;
			SetDamage("dmg");
			return;
			LogDebug("Adjusted dmg x L_CHARGE_RATIO");
			BWEAPON_CHARGE_PERCENT = 0;
			string CUR_DRAIN = MELEE_ENERGY;
			CUR_DRAIN *= BWEAPON_CHARGE_PERCENT;
			DrainStamina(GetOwner());
		}
	}

	void attack_poke2_damaged_other()
	{
		string TARGET_HIT = param1;
		string DMG_DONE = param2;
		pole_adjust_damage(TARGET_HIT, DMG_DONE);
	}

	void pole_adjust_damage()
	{
		string TARGET_HIT = param1;
		if (!(GetEntityOrigin(TARGET_HIT) != "(0.00,0.00,0.00)")) return;
		if ((POLE_SWIPE_ATTACK))
		{
			POLE_SWIPE_ATTACK = 0;
			int EXIT_SUB = 1;
		}
		if ((POLE_BACKHAND_ATTACK))
		{
			POLE_BACKHAND_ATTACK = 0;
			if ((POLE_BACKHAND_STUN))
			{
				string TARGET_HIT = param1;
				if ((IsValidPlayer(TARGET_HIT)))
				{
					if (!(GAME_PVP))
					{
					}
					int EXIT_SUB1 = 1;
				}
				if (!(EXIT_SUB1))
				{
				}
				if ((POLE_BACKHAND_SPECIAL))
				{
					pole_backhand_special(TARGET_HIT);
				}
				if (RandomInt(1, 100) < POLE_BACKHAND_STUN_CHANCE)
				{
				}
				ApplyEffect(TARGET_HIT, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
			}
			if (POLE_BACKHAND_REPEL > 0)
			{
				if (GetRelationship(TARGET_HIT) == "enemy")
				{
				}
				AddVelocity(TARGET_HIT, /* TODO: $relvel */ $relvel(0, POLE_BACKHAND_REPEL, 110));
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DMG_DONE = param2;
		if (!(DMG_DONE > 0)) return;
		string TARGET_RANGE = GetEntityRange(TARGET_HIT);
		if ((POLE_POKE1_ENHANCED))
		{
			pole_poke_enhance(TARGET_HIT, DMG_DONE);
		}
		if (TARGET_RANGE < POLE_MIN_RANGE)
		{
			DMG_DONE *= POLE_MIN_DMG_MULTI;
			SetDamage("dmg");
			return;
			LogDebug("pole_adjust_damage short");
		}
		else
		{
			string RANGE_RATIO = TARGET_RANGE;
			RANGE_RATIO /= MELEE_RANGE;
			string ADJUST_RATIO = /* TODO: $ratio */ $ratio(RANGE_RATIO, POLE_MIN_DMG_MULTI, POLE_MAX_DMG_MULTI);
			DMG_DONE *= ADJUST_RATIO;
			SetDamage("dmg");
			return;
			LogDebug("pole_adjust_damage ADJUST_RATIO TARGET_RANGE vs MELEE_RANGE");
		}
	}

	void game_attack_cancel()
	{
		PlayOwnerAnim("once", PANIM_IDLE);
	}

	void game_viewanimdone()
	{
		LogDebug("game_viewanimdone PARAM1");
	}

	void pole_idle_anim_cl()
	{
		if (!(false)) return;
		if ((POLE_NO_IDLE)) return;
		if (!(GetEntityProperty(GetOwner(), "inhand")))
		{
			POLE_IDLE_ACTIVE_CL = 0;
		}
		if (!("get" + GetOwner() + "," + "inhand")) return;
		Random(2_0, 4_0)("pole_idle_anim_cl");
		if ((POLE_HOLD_IDLE_CL)) return;
		if (("game.item.attacking"))
		{
			POLE_IDLE_ANIM_COUNT_CL = 0;
			POLE_NEXT_IDLE_CL = GetGameTime();
			POLE_NEXT_IDLE_CL += 3.0;
		}
		if (!(GetGameTime() > POLE_NEXT_IDLE_CL)) return;
		if (("game.item.attacking")) return;
		if (POLE_IDLE_ANIM_COUNT_CL == 0)
		{
			PlayViewAnim(VANIM_IDLE1);
		}
		if (POLE_IDLE_ANIM_COUNT_CL == 1)
		{
			PlayViewAnim(VANIM_IDLE1);
		}
		if (POLE_IDLE_ANIM_COUNT_CL == 2)
		{
			PlayViewAnim(VANIM_IDLE1);
		}
		if (POLE_IDLE_ANIM_COUNT_CL == 3)
		{
			PlayViewAnim(VANIM_IDLE1);
		}
		if (POLE_IDLE_ANIM_COUNT_CL == 4)
		{
			PlayViewAnim(VANIM_IDLE2);
		}
		if (POLE_IDLE_ANIM_COUNT_CL == 5)
		{
			PlayViewAnim(VANIM_IDLE3);
		}
		POLE_IDLE_ANIM_COUNT_CL += 1;
		if (!(POLE_IDLE_ANIM_COUNT_CL > 5)) return;
		POLE_IDLE_ANIM_COUNT_CL = 0;
	}

	void game_attack1()
	{
		if (!(WEAPON_UNDERSKILLED)) return;
		if (!(GetGameTime() > WEAPON_NEXT_SKILL_WARN)) return;
		WEAPON_NEXT_SKILL_WARN = GetGameTime();
		WEAPON_NEXT_SKILL_WARN += 15.0;
		pole_check_skill();
	}

	void pole_check_skill()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += MELEE_STAT;
		if (GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += MELEE_STAT;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill OUT_STR");
			WEAPON_UNDERSKILLED = 1;
			WAS_UNDERSKILLED = 1;
		}
		else
		{
			WEAPON_UNDERSKILLED = 0;
		}
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		if ((POLE_CAN_THROW))
		{
			if (!("game.item.attacking"))
			{
			}
			if (!(POLE_THROW_PREPING))
			{
			}
			if (!(POLE_THROW_PREPPED))
			{
			}
			if (GetGameTime() > POLE_NEXT_THROW)
			{
			}
			POLE_NEXT_THROW = GetGameTime();
			POLE_NEXT_THROW += 1.0;
			POLE_THROW_PREPING = 1;
			// TODO: splayviewanim ent_me VANIM_THROW_PREP
			PlayOwnerAnim("once", PANIM_THROW_PREP);
			CallClientItemEvent(GetOwner(), "pole_toggle_idle_cl", 1);
			POLE_THROW_PREP_DELAY("pole_throw_ready");
		}
		if ((POLE_CAN_BLOCK))
		{
			if (!(POLE_IN_BLOCK))
			{
			}
			if (!(POLE_IN_SPIN))
			{
			}
			if (GetGameTime() > NEXT_BLOCK)
			{
			}
			if (!("game.item.attacking"))
			{
			}
			NEXT_BLOCK = GetGameTime();
			NEXT_BLOCK += POLE_BLOCK_DELAY;
			if ((POLE_CAN_REPEL))
			{
				if (!(IsKeyDown(GetOwner(), "forward")))
				{
					pole_block_start();
				}
				else
				{
					pole_repel();
				}
			}
			else
			{
				pole_block_start();
			}
		}
	}

	void pole_throw_ready()
	{
		POLE_THROW_PREPING = 0;
		POLE_THROW_PREPPED = 1;
		POLE_THROW_START_CHARGE_TIME = GetGameTime();
		PlayOwnerAnim("once", PANIM_THROW_IDLE);
	}

	void game__attack2()
	{
		if (!(true)) return;
		if ((POLE_THROW_PREPPING))
		{
			if (!("game.item.attacking"))
			{
			}
			// TODO: splayviewanim ent_me VANIM_IDLE
			PlayOwnerAnim("once", PANIM_IDLE);
		}
		if ((POLE_THROW_PREPPED))
		{
			if (!("game.item.attacking"))
			{
			}
			pole_do_throw();
		}
		if ((POLE_IN_BLOCK))
		{
			if ((POLE_IN_SPIN))
			{
				pole_spin_end();
			}
			else
			{
				pole_block_end();
			}
		}
	}

	void pole_block_start()
	{
		PlayOwnerAnim("critical", PANIM_BLOCK_START);
		// TODO: splayviewanim ent_me VANIM_BLOCK_START
		ApplyEffect(GetOwner(), "effects/effect_templock");
		CallClientItemEvent(GetOwner(), "pole_toggle_idle_cl", 1);
		ScheduleDelayedEvent(1.0, "pole_block_hold");
		if (!(POLE_CAN_SPIN)) return;
		if (!(IsKeyDown(GetOwner(), "back"))) return;
		ScheduleDelayedEvent(5.0, "pole_spin_start");
	}

	void pole_toggle_idle_cl()
	{
		POLE_HOLD_IDLE_CL = param1;
	}

	void pole_suspend_idle_cl()
	{
		POLE_IDLE_ANIM_COUNT_CL = 0;
		POLE_NEXT_IDLE_CL = GetGameTime();
		POLE_NEXT_IDLE_CL += param1;
	}

	void pole_block_hold()
	{
		LogDebug("pole_block_start canattack CanAttack(GetOwner())");
		PlayOwnerAnim("hold", PANIM_BLOCK_HOLD);
		// TODO: splayviewanim ent_me VANIM_BLOCK_HOLD
		POLE_IN_BLOCK = 1;
	}

	void pole_block_end()
	{
		LogDebug("pole_block_end");
		POLE_IN_BLOCK = 0;
		NEXT_BLOCK = GetGameTime();
		NEXT_BLOCK += 3.0;
		CallExternal(GetOwner(), "ext_end_templock");
		PlayOwnerAnim("break");
		PlayOwnerAnim("critical", PANIM_BLOCK_END);
		CallClientItemEvent(GetOwner(), "pole_block_end_cl");
	}

	void pole_block_end_cl()
	{
		PlayViewAnim(VANIM_BLOCK_END);
		POLE_HOLD_IDLE_CL = 0;
		POLE_IDLE_ANIM_COUNT_CL = 0;
		POLE_NEXT_IDLE_CL = GetGameTime();
		POLE_NEXT_IDLE_CL += 3.0;
	}

	void pole_spin_start()
	{
		if (!(POLE_IN_BLOCK)) return;
		LogDebug("pole_spin_start");
		// TODO: splayviewanim ent_me VANIM_SPIN_START
		PlayOwnerAnim("break");
		PlayOwnerAnim("once", PANIM_SPIN_START);
		// svplaysound: svplaysound 2 10 SOUND_SPIN_LOOP
		EmitSound(2, 10, SOUND_SPIN_LOOP);
		ScheduleDelayedEvent(0.5, "pole_spin_hold");
		ScheduleDelayedEvent(30.0, "pole_spin_end");
	}

	void pole_spin_hold()
	{
		LogDebug("pole_spin_hold canattack CanAttack(GetOwner())");
		POLE_IN_SPIN = 1;
		// TODO: splayviewanim ent_me VANIM_SPIN_HOLD
		PlayOwnerAnim("hold", PANIM_SPIN_HOLD);
	}

	void pole_spin_end()
	{
		if (!(POLE_IN_SPIN)) return;
		LogDebug("pole_spin_end");
		NEXT_BLOCK = GetGameTime();
		NEXT_BLOCK += 3.0;
		CallExternal(GetOwner(), "ext_end_templock");
		POLE_IN_SPIN = 0;
		POLE_IN_BLOCK = 0;
		// svplaysound: svplaysound 2 0 SOUND_SPIN_LOOP
		EmitSound(2, 0, SOUND_SPIN_LOOP);
		PlayOwnerAnim("break");
		PlayOwnerAnim("critical", PANIM_SPIN_END);
		CallClientItemEvent(GetOwner(), "pole_spin_end_cl");
	}

	void pole_spin_end_cl()
	{
		PlayViewAnim(VANIM_SPIN_END);
		POLE_HOLD_IDLE_CL = 0;
		POLE_IDLE_ANIM_COUNT_CL = 0;
		POLE_NEXT_IDLE_CL = GetGameTime();
		POLE_NEXT_IDLE_CL += 3.0;
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if ((POLE_IN_SPIN))
		{
			pole_spin_end();
		}
		if ((POLE_IN_BLOCK))
		{
			pole_block_end();
		}
	}

	void bweapon_effect_remove()
	{
		if ((POLE_IN_SPIN))
		{
			pole_spin_end();
		}
		if ((POLE_IN_BLOCK))
		{
			pole_block_end();
		}
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if ((POLE_IN_BLOCK))
		{
			if ((param4).findFirst("effect") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if ((param4).findFirst("target") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string PROJECTILE_FIRED = GetEntityProperty(param2, "is_projectile");
			if ((PROJECTILE_FIRED))
			{
				string BLOCK_TARG = param1;
			}
			else
			{
				string BLOCK_TARG = param2;
			}
			string OWNER_ORG = GetEntityOrigin(GetOwner());
			string OWNER_ANG = GetEntityAngles(GetOwner());
			string ATTACK_ORG = GetEntityOrigin(BLOCK_TARG);
			if ((WithinCone2D(ATTACK_ORG, OWNER_ORG, OWNER_ANG)))
			{
			}
			string DMG_TAKEN = param3;
			string ORIG_DMG = param3;
			DMG_TAKEN *= POLE_BLOCK_PROT_RATIO;
			if ((POLE_IN_SPIN))
			{
				DMG_TAKEN *= POLE_BLOCK_PROT_RATIO;
				if ((PROJECTILE_FIRED))
				{
					int PROJECTILE_BLOCKED = 1;
				}
			}
			if (!(PROJECTILE_BLOCKED))
			{
				SetDamage("dmg");
				ORIG_DMG -= DMG_TAKEN;
				SendPlayerMessage("Polearm", "blocked ORIG_DMG damage");
			}
			else
			{
				SetDamage("hit");
				SetDamage("dmg");
				SendPlayerMessage("Polearm", "deflected GetEntityName(param2)");
			}
			if (!(POLE_IN_SPIN))
			{
				// TODO: splayviewanim ent_me VANIM_BLOCK_HOLD
			}
			EmitSound(GetOwner(), 1, SOUND_BLOCK, 10);
		}
	}

	void game_hitworld()
	{
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void pole_repel()
	{
		EmitSound(GetOwner(), 1, SOUND_READY, 10);
		// TODO: splayviewanim ent_me VANIM_REPEL
		PlayOwnerAnim("critical", PANIM_REPEL);
		CallClientItemEvent(GetOwner(), "pole_suspend_idle_cl", 3.0);
		string SCAN_LOC = GetEntityOrigin(GetOwner());
		OWNER_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		SCAN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 32, 0));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 64, SCAN_LOC);
		PUSH_TARGETS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(PUSH_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(PUSH_TARGETS, ";"); i++)
		{
			pole_repel_affect_targets();
		}
	}

	void pole_repel_affect_targets()
	{
		string CUR_TARGET = GetToken(PUSH_TARGETS, i, ";");
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARGET)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string MAX_HP_PUSH = GetEntityMaxHealth(GetOwner());
		MAX_HP_PUSH *= 2;
		if (MAX_HP_PUSH < 1500)
		{
			int MAX_HP_PUSH = 1500;
		}
		if (!(GetEntityMaxHealth(CUR_TARGET) < MAX_HP_PUSH)) return;
		AddVelocity(CUR_TARGET, /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, POLE_REPEL_STRENGTH, 10)));
	}

	void pole_do_throw()
	{
		LogDebug("pole_do_throw");
		POLE_THROW_PREPPED = 0;
		// TODO: splayviewanim ent_me VANIM_THROW_PREPED_THROW
		PlayOwnerAnim("once", PANIM_THROW_PREPED_THROW);
		POLE_THROW_PREPED_ATKDELAY("pole_do_throw2");
	}

	void pole_do_throw2()
	{
		EmitSound(GetOwner(), 1, SOUND_THROW, 10);
		string CHARGE_RATIO = GetGameTime();
		CHARGE_RATIO -= POLE_THROW_START_CHARGE_TIME;
		if (CHARGE_RATIO >= POLE_THROW_MAX_CHARGE_TIME)
		{
			float CHARGE_RATIO = 1.0;
		}
		else
		{
			CHARGE_RATIO /= POLE_THROW_MAX_CHARGE_TIME;
			string CHARGE_RATIO = /* TODO: $ratio */ $ratio(CHARGE_RATIO, 0.01, 1.0);
		}
		LogDebug("pole_do_throw2 CHARGE_RATIO");
		string L_THROW_POWER = POLE_THROW_POWER;
		string L_COF = POLE_THROW_COF;
		if ((WEAPON_UNDERSKILLED))
		{
			float SKILL_DIFF = 1.0;
			string SKILL_RATIO = GetSkillLevel(GetOwner(), "polearms");
			SKILL_RATIO /= BASE_LEVEL_REQ;
			SKILL_DIFF -= SKILL_RATIO;
			L_COF += SKILL_DIFF;
			L_THROW_POWER *= SKILL_RATIO;
			if (CHARGE_RATIO > 0.1)
			{
				float CHARGE_RATIO = 0.1;
			}
			LogDebug("skildiff SKILL_DIFF cof L_COF thr L_THROW_POWER rat SKILL_RATIO");
		}
		else
		{
			string CR_PLUS_ONE = CHARGE_RATIO;
			CHARGE_RATIO += 1;
			L_THROW_POWER *= CHARGE_RATIO;
		}
		CallExternal(GetOwner(), "ext_toss_spear", CHARGE_RATIO, POLE_THOW_PROJECTILE, "view", "none", L_THROW_POWER, 0, L_COF, "polearms");
		CallClientItemEvent(GetOwner(), "pole_toggle_idle_cl", 0);
		POLE_NEXT_THROW = GetGameTime();
		POLE_NEXT_THROW += POLE_THROW_RECHARGE_TIME;
	}

	void pole_abort_throw()
	{
		POLE_THROW_PREPPED = 0;
		POLE_THROW_PREPPING = 0;
	}

	void ext_player_sit()
	{
		LogDebug("ext_player_sit");
		if ((POLE_IN_SPIN))
		{
			pole_spin_end();
		}
		if ((POLE_IN_BLOCK))
		{
			pole_block_end();
		}
	}

	void game_setchargepercent()
	{
		BWEAPON_CHARGE_PERCENT = param1;
	}

}

}
