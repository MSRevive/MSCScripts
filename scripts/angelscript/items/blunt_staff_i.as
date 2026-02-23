#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntStaffI : CGameScript
{
	string CL_ICEMAN_FX_INDEX;
	int CONSEC_ATTACKS;
	string GAME_PVP;
	int ICEMAN_ON;
	string ICEMAN_YAW;
	string MELEE_ATTACK;
	string MELEE_TARG;
	string NEXT_ICEMAN;
	string OLD_MELEE_TARG;
	string OWNER_SKILL;
	int SLOW_LOOP_ACTIVE;

	BluntStaffI()
	{
		const int BASE_LEVEL_REQ = 25;
		const int ICEMAN_MP = 1;
		const float DOT_RATIO = 0.5;
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.4;
		const float MELEE_ATK_DURATION = 0.9;
		const float DEMON_DMG_DELAY = 0.25;
		const float DEMON_ATK_DURATION = 0.7;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 200;
		const int MELEE_DMG_RANGE = 20;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_PARRY_AUGMENT = 0.2;
		const string MELEE_DMG_TYPE = "cold";
		const string MELEE_STAT = "spellcasting.ice";
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 11;
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 25;
		const string ANIM_PREFIX = "standard";
		const string SPECIAL_02_CALLBACK = "attack_lance";
		const float SPECIAL_02_DELAY_STRIKE = 0.4;
		const float SPECIAL_02_DELAY_END = 0.9;
		const int SPECIAL_02_MP = 30;
		const int SPECIAL_02_RANGE = 0;
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const string MELEE_CALLBACK = "attack_bolt";
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "pole_swing";
	}

	void weapon_spawn()
	{
		SetName("Ice Staff");
		SetDescription("A staff of elemental ice");
		SetWeight(30);
		SetSize(10);
		SetValue(5000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", 48);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		CONSEC_ATTACKS = 0;
		GAME_PVP = "game.pvp";
		OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.ice");
	}

	void attack_bolt_start()
	{
		if (!(true)) return;
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		string OWNER_TARGET = GetEntityProperty(GetOwner(), "target");
		if ((IsEntityAlive(OWNER_TARGET)))
		{
			if (GetEntityRange(OWNER_TARGET) <= MELEE_RANGE)
			{
			}
			LogDebug("attack_bolt_start GetEntityProperty(GetOwner(), "target") GetEntityRange(OWNER_TARGET)");
			MELEE_ATTACK = 1;
			// TODO: splayviewanim ent_me 2
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((BITEM_UNDERSKILLED))
		{
			MELEE_ATTACK = 1;
			// TODO: splayviewanim ent_me 2
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		MELEE_ATTACK = 0;
		// TODO: splayviewanim ent_me 9
	}

	void attack_bolt_strike()
	{
		if (!(OWNER_SKILL > BASE_LEVEL_REQ)) return;
		if (!(MELEE_ATTACK))
		{
			if ((IsEntityAlive(param3)))
			{
				if (GetEntityRange(param3) < 150)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			EmitSound(GetOwner(), 0, "magic/ice_strike.wav", 10);
			CallExternal(GetOwner(), "ext_tossprojectile", "proj_staff_ice_bolt", "view", "none", 400, 0, 0, "none");
		}
		else
		{
			if ((IsEntityAlive(param3)))
			{
			}
			MELEE_TARG = param3;
			if ((IsValidPlayer(MELEE_TARG)))
			{
				if (!(GAME_PVP))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetRelationship(MELEE_TARG) == "enemy")
			{
			}
			if (MELEE_TARG == OLD_MELEE_TARG)
			{
				CONSEC_ATTACKS += 1;
			}
			else
			{
				CONSEC_ATTACKS = 0;
			}
			OLD_MELEE_TARG = MELEE_TARG;
			if (CONSEC_ATTACKS == 5)
			{
				if ((GetEntityProperty(param3, "scriptvar")))
				{
					CONSEC_ATTACKS = 0;
					string L_DOT = OWNER_SKILL;
					L_DOT *= DOT_RATIO;
					ApplyEffect(param3, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				string L_MAX_HP = GetEntityMaxHealth(GetOwner());
				L_MAX_HP *= 3.0;
				if (L_MAX_HP < 2000)
				{
					int L_MAX_HP = 2000;
				}
				if (GetEntityHealth(param3) < L_MAX_HP)
				{
				}
				if (GetEntityMP(GetOwner()) > 30)
				{
				}
				GiveMP(GetOwner());
				ApplyEffect(param3, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), 0, "spellcasting.ice", L_MAX_HP);
				CONSEC_ATTACKS = 0;
			}
			else
			{
				string L_DOT = OWNER_SKILL;
				L_DOT *= DOT_RATIO;
				ApplyEffect(param3, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
				if ((GetEntityProperty(param3, "scriptvar")))
				{
					CONSEC_ATTACKS = 0;
				}
			}
			LogDebug("attack_bolt_strike CONSEC_ATTACKS");
		}
		MELEE_ATTACK = 0;
	}

	void attack_lance_start()
	{
		PlayViewAnim(9);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
	}

	void attack_lance_strike()
	{
		if ((IsEntityAlive(param3)))
		{
			if (GetEntityRange(param3) < 150)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EmitSound(GetOwner(), 0, "magic/ice_strike.wav", 10);
		CallExternal(GetOwner(), "ext_tossprojectile", "proj_staff_icelance", "view", "none", 400, 0, 0, "none");
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(OWNER_SKILL > BASE_LEVEL_REQ)) return;
		if (!(CanAttack(GetOwner()))) return;
		if ((ICEMAN_ON)) return;
		if (!(GetGameTime() > NEXT_ICEMAN)) return;
		NEXT_ICEMAN = GetGameTime();
		NEXT_ICEMAN += 0.25;
		ICEMAN_ON = 1;
		if (GetEntityMP(GetOwner()) < ICEMAN_MP)
		{
			SendColoredMessage(GetOwner(), "Ice Staff: Not enough MP for Ice Slide ICEMAN_MP");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EmitSound(GetOwner(), 0, "magic/frost_pulse.wav", 10);
		CallExternal(GetOwner(), "ext_ice_staff_on");
		ClientEvent("new", "all", "items/blunt_staff_i_cl", GetEntityIndex(GetOwner()));
		CL_ICEMAN_FX_INDEX = "game.script.last_sent_id";
		ICEMAN_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		CallExternal(GetOwner(), "ext_removed_effects", "nojump");
		ApplyEffect(GetOwner(), "effects/effect_nojump", GetEntityIndex(GetOwner()));
		PlayOwnerAnim("hold", "nod_yes");
		do_iceman_loop();
	}

	void do_iceman_loop()
	{
		if (!(ICEMAN_ON)) return;
		if (GetEntityMP(GetOwner()) > ICEMAN_MP)
		{
			if ((GetEntityProperty(GetOwner(), "inhand")))
			{
				ScheduleDelayedEvent(0.1, "do_iceman_loop");
			}
			else
			{
				end_iceman();
			}
		}
		else
		{
			end_iceman();
		}
		if (!(IsOnGround(GetOwner())))
		{
			string ORG_VEL = GetEntityVelocity(GetOwner());
			string CUR_VEL = ORG_VEL;
			CUR_VEL *= 0.75;
			if ((ORG_VEL).z < 0)
			{
				CUR_VEL = "z";
			}
			SetVelocity(GetOwner(), CUR_VEL);
		}
		else
		{
			string L_LAST_PUSH = GetEntityProperty(GetOwner(), "scriptvar");
			L_LAST_PUSH += 3.0;
			LogDebug("do_iceman_loop L_LAST_PUSH");
			if (GetGameTime() < L_LAST_PUSH)
			{
				string ORG_VEL = GetEntityVelocity(GetOwner());
				string CUR_VEL = ORG_VEL;
				CUR_VEL *= 0.25;
				if ((ORG_VEL).z < 0)
				{
					CUR_VEL = "z";
				}
				SetVelocity(GetOwner(), CUR_VEL);
			}
			else
			{
				GiveMP(GetOwner());
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, ICEMAN_YAW, 0), Vector3(0, 1000, 0)));
			}
		}
	}

	void game__attack2()
	{
		if (!(true)) return;
		if (!(ICEMAN_ON)) return;
		end_iceman();
	}

	void end_iceman()
	{
		PlayOwnerAnim("break", "nod_yes");
		CallExternal(GetOwner(), "ext_ice_staff_off");
		ICEMAN_ON = 0;
		ClientEvent("update", "all", CL_ICEMAN_FX_INDEX, "end_fx");
		RemoveEffect(GetOwner(), "effect_nojump");
		if (!(IsEntityAlive(GetOwner()))) return;
		SLOW_LOOP_ACTIVE = 1;
		slow_down();
		ScheduleDelayedEvent(1.0, "end_slow_down");
	}

	void slow_down()
	{
		if ((ICEMAN_ON)) return;
		if (!(SLOW_LOOP_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "slow_down");
		string L_LAST_PUSH = GetEntityProperty(GetOwner(), "scriptvar");
		L_LAST_PUSH += 3.0;
		if (GetGameTime() < L_LAST_PUSH)
		{
			int SLOW_DOWN = 1;
		}
		if (!(IsOnGround(GetOwner())))
		{
			int SLOW_DOWN = 1;
		}
		if ((SLOW_DOWN))
		{
			string ORG_VEL = GetEntityVelocity(GetOwner());
			string CUR_VEL = ORG_VEL;
			CUR_VEL *= 0.75;
			if ((ORG_VEL).z < 0)
			{
				CUR_VEL = "z";
			}
			SetVelocity(GetOwner(), CUR_VEL);
		}
	}

	void end_slow_down()
	{
		SLOW_LOOP_ACTIVE = 0;
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(GetEntityIndex(GetOwner()) == param1)) return;
		if (!(ICEMAN_ON)) return;
		end_iceman();
	}

	void register_charge1()
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
		int reg.attack.priority = 1;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "attack2_bolt";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void attack2_bolt_start()
	{
		if (!(true)) return;
		LogDebug("attack2_bolt_start");
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		string OWNER_TARGET = GetEntityProperty(GetOwner(), "target");
		if ((IsEntityAlive(OWNER_TARGET)))
		{
			if (GetEntityRange(OWNER_TARGET) <= MELEE_RANGE)
			{
			}
			LogDebug("attack_bolt_start GetEntityProperty(GetOwner(), "target") GetEntityRange(OWNER_TARGET)");
			MELEE_ATTACK = 1;
			// TODO: splayviewanim ent_me 2
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((BITEM_UNDERSKILLED))
		{
			MELEE_ATTACK = 1;
			// TODO: splayviewanim ent_me 2
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		MELEE_ATTACK = 0;
		// TODO: splayviewanim ent_me 9
	}

	void attack2_bolt_strike()
	{
		if (!(OWNER_SKILL > BASE_LEVEL_REQ)) return;
		if (!(MELEE_ATTACK))
		{
			if ((IsEntityAlive(param3)))
			{
				if (GetEntityRange(param3) < 150)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			EmitSound(GetOwner(), 0, "magic/ice_strike.wav", 10);
			CallExternal(GetOwner(), "ext_tossprojectile", "proj_staff_ice_bolt2", "view", "none", 400, 0, 0, "none");
		}
		else
		{
			if ((IsEntityAlive(param3)))
			{
			}
			MELEE_TARG = param3;
			if ((IsValidPlayer(MELEE_TARG)))
			{
				if (!(GAME_PVP))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetRelationship(MELEE_TARG) == "enemy")
			{
			}
			if (MELEE_TARG == OLD_MELEE_TARG)
			{
				CONSEC_ATTACKS += 1;
			}
			else
			{
				CONSEC_ATTACKS = 0;
			}
			OLD_MELEE_TARG = MELEE_TARG;
			if (CONSEC_ATTACKS == 5)
			{
				if ((GetEntityProperty(param3, "scriptvar")))
				{
					CONSEC_ATTACKS = 0;
					string L_DOT = OWNER_SKILL;
					L_DOT *= DOT_RATIO;
					ApplyEffect(param3, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				string L_MAX_HP = GetEntityMaxHealth(GetOwner());
				L_MAX_HP *= 3.0;
				if (L_MAX_HP < 2000)
				{
					int L_MAX_HP = 2000;
				}
				if (GetEntityHealth(param3) < L_MAX_HP)
				{
				}
				if (GetEntityMP(GetOwner()) > 30)
				{
				}
				GiveMP(GetOwner());
				ApplyEffect(param3, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()), 0, "spellcasting.ice", L_MAX_HP);
				CONSEC_ATTACKS = 0;
			}
			else
			{
				string L_DOT = OWNER_SKILL;
				L_DOT *= DOT_RATIO;
				ApplyEffect(param3, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), L_DOT);
				if ((GetEntityProperty(param3, "scriptvar")))
				{
					CONSEC_ATTACKS = 0;
				}
			}
			LogDebug("attack_bolt_strike CONSEC_ATTACKS");
		}
		MELEE_ATTACK = 0;
	}

	void game_putinpack()
	{
		if (!(ICEMAN_ON)) return;
		end_iceman();
	}

}

}
