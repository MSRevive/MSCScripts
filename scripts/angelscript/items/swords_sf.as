#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsSf : CGameScript
{
	string BURST_DOT_BURN;
	string BURST_POS;
	string FAURA_ACTIVE;
	string FAURA_RAD;
	string FIRE_AURA_BEGIN;
	string FIRE_BURST_TARGS;
	string FIRE_WAVE_START_POS;
	string FIRE_WAVE_TARGS;
	string FIRE_WAVE_YAW;
	string GAME_PVP;
	string NEXT_PARRY;
	string OWNER_ANG;
	string OWNER_FIRESKILL;
	string OWNER_ORG;
	string OWNER_SWORDSKILL;
	string PARRY_ON;
	string WAVE_DOT_BURN;

	SwordsSf()
	{
		const int BASE_LEVEL_REQ = 25;
		const int FIRE_WAVE_MP = 20;
		const int FIRE_BURST_MP = 30;
		const int ANIM_LIFT = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 2;
		const int ANIM_ATTACK3 = 2;
		const int ATTACK_ANIMS = 1;
		const int ANIM_LUNGE = 3;
		const int ANIM_PARRY1 = 4;
		const int ANIM_PARRY1_RETRACT = 5;
		const int ANIM_UNSHEATH = 6;
		const int ANIM_SHEATH = 7;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		const int MODEL_VIEW_IDX = 11;
		const int MODEL_BODY_OFS = 84;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 275;
		const int MELEE_DMG_RANGE = 140;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 3;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.6;
		const int MELEE_NEW_PARRY_CHANCE = 50;
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "sword_double_swing";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string SPECIAL01_SND = GetEntityProperty(GetOwner(), "scriptvar");
	}

	void weapon_spawn()
	{
		SetName("Shadowfire Blade");
		SetDescription("This is a twisted blade of elemental fire");
		SetWeight(75);
		SetSize(9);
		SetValue(3750);
		SetHUDSprite("trade", 167);
		SetHand("both");
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
		OWNER_SWORDSKILL = GetSkillLevel(GetOwner(), "swordsmanship");
		OWNER_FIRESKILL = GetSkillLevel(GetOwner(), "spellcasting.fire");
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		reg.attack.range *= 3.0;
		int reg.attack.noautoaim = 1;
		string reg.attack.dmg = MELEE_DMG;
		reg.attack.dmg *= 4.0;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		float reg.attack.delay.strike = 1.4;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 2;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "fire_wave";
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 34;
		RegisterAttack();
	}

	void melee_start()
	{
		if ((PARRY_ON))
		{
			exit_parry("melee_start");
		}
		string R_SWING = RandomInt(1, 3);
		if (R_SWING == 1)
		{
			string SWING_ANIM = ANIM_ATTACK1;
		}
		if (R_SWING == 2)
		{
			string SWING_ANIM = ANIM_ATTACK2;
		}
		if (R_SWING == 3)
		{
			string SWING_ANIM = ANIM_ATTACK3;
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(SWING_ANIM);
		EmitSound(GetOwner(), 1, SOUND_SWIPE, 10);
	}

	void special_01_start()
	{
		if ((PARRY_ON))
		{
			exit_parry("special_01_start");
		}
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void fire_wave_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SOUND_SHOUT, "const.snd.maxvol");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DOT_BURN *= 0.75;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "swordsmanship");
	}

	void fire_wave_strike()
	{
		if (!(true)) return;
		string ATTACK_END_POS = param2;
		if (!((ATTACK_END_POS).z == /* TODO: $get_ground_height */ $get_ground_height(ATTACK_END_POS))) return;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 25)) return;
		if (GetEntityMP(GetOwner()) < FIRE_WAVE_MP)
		{
			SendColoredMessage(GetOwner(), "Shadowfire Blade: Insufficient MP for Fire Wave");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		do_fire_wave(GetEntityOrigin(GetOwner()));
	}

	void do_fire_wave()
	{
		EmitSound(GetOwner(), 0, "magic/flame_loop_start.wav", 7);
		FIRE_WAVE_START_POS = param1;
		FIRE_WAVE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_fire_wave", FIRE_WAVE_START_POS, FIRE_WAVE_YAW);
		string FIRE_WAVE_SCAN_POS = FIRE_WAVE_START_POS;
		FIRE_WAVE_SCAN_POS += /* TODO: $relpos */ $relpos(Vector3(0, FIRE_WAVE_YAW, 0), Vector3(0, 128, 32));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 1024, FIRE_WAVE_SCAN_POS);
		FIRE_WAVE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FIRE_WAVE_TARGS != "none")) return;
		WAVE_DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		WAVE_DOT_BURN *= 1.5;
		OWNER_ORG = FIRE_WAVE_START_POS;
		OWNER_ANG = Vector3(0, FIRE_WAVE_YAW, 0);
		for (int i = 0; i < GetTokenCount(FIRE_WAVE_TARGS, ";"); i++)
		{
			fire_wave_affect_targs();
		}
		ScheduleDelayedEvent(1.0, "do_fire_wave2");
	}

	void do_fire_wave2()
	{
		string FIRE_WAVE_SCAN_POS = FIRE_WAVE_START_POS;
		FIRE_WAVE_SCAN_POS += /* TODO: $relpos */ $relpos(Vector3(0, FIRE_WAVE_YAW, 0), Vector3(0, 128, 32));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 1024, FIRE_WAVE_SCAN_POS);
		FIRE_WAVE_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FIRE_WAVE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FIRE_WAVE_TARGS, ";"); i++)
		{
			fire_wave_affect_targs();
		}
	}

	void fire_wave_affect_targs()
	{
		string CUR_TARG = GetToken(FIRE_WAVE_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		LogDebug("fire_wave_affect_targs WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG) GetEntityName(CUR_TARG)");
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string TRACE_START = FIRE_WAVE_START_POS;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), WAVE_DOT_BURN, "swordsmanship");
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(PARRY_ON))
		{
			if (GetGameTime() > NEXT_PARRY)
			{
			}
			// TODO: splayviewanim ent_me ANIM_PARRY1
			FIRE_AURA_BEGIN = GetGameTime();
			FIRE_AURA_BEGIN += 2.0;
			PARRY_ON = 1;
			NEXT_PARRY = GetGameTime();
			NEXT_PARRY += 1.0;
		}
		if ((PARRY_ON))
		{
			if (!(FAURA_ACTIVE))
			{
			}
			if (OWNER_FIRESKILL >= 30)
			{
			}
			if (GetGameTime() > FIRE_AURA_BEGIN)
			{
			}
			FAURA_RAD = 64;
			FAURA_ACTIVE = 1;
			if (GetEntityMP(GetOwner()) <= 10)
			{
				SendColoredMessage(GetOwner(), "Shadowfire Blade: Insufficient mana for Shadowfire Aura");
				FIRE_AURA_BEGIN = GetGameTime();
				FIRE_AURA_BEGIN += 5.0;
				int EXIT_SUB = 1;
				if ((FAURA_ACTIVE))
				{
					end_faura();
				}
			}
			if (!(EXIT_SUB))
			{
			}
			FAURA_ACTIVE = 1;
			CallExternal(GetOwner(), "ext_sfaura_start", GetEntityIndex(GetOwner()));
		}
	}

	void game__attack2()
	{
		if ((PARRY_ON))
		{
			exit_parry();
		}
	}

	void bweapon_effect_remove()
	{
		if ((FAURA_ACTIVE))
		{
			end_faura();
		}
	}

	void exit_parry()
	{
		NEXT_PARRY = GetGameTime();
		NEXT_PARRY += 1.0;
		PARRY_ON = 0;
		if ((FAURA_ACTIVE))
		{
			end_faura();
		}
		if (!("game.item.attacking"))
		{
			// TODO: splayviewanim ent_me ANIM_PARRY1_RETRACT
		}
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if ((FAURA_ACTIVE))
		{
			end_faura();
		}
	}

	void end_faura()
	{
		FAURA_ACTIVE = 0;
		CallExternal(GetOwner(), "ext_sfaura_end", "remote");
	}

	void ext_faura_ended()
	{
		FAURA_ACTIVE = 0;
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if ((PARRY_ON))
		{
			if ((param4).findFirst("effect") >= 0)
			{
				int NO_ABSORB = 1;
			}
			if (!(NO_ABSORB))
			{
			}
			string IN_DMG = param3;
			IN_DMG *= 0.5;
			SetDamage("dmg");
			return;
		}
		if (!((param4).findFirst("fire") >= 0)) return;
		string IN_DMG = param3;
		IN_DMG *= 0.5;
		SetDamage("dmg");
		return;
	}

	void bweapon_effect_remove()
	{
		PARRY_ON = 0;
	}

	void special_01_strike()
	{
		if (GetEntityMP(GetOwner()) < FIRE_BURST_MP)
		{
			SendColoredMessage("Shadowfire", "Blade: Insufficient Mana for Flame Burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetSkillLevel(GetOwner(), "spellcasting.fire") >= 25)) return;
		BURST_POS = GetEntityOrigin(GetOwner());
		BURST_POS = "z";
		ClientEvent("new", "all", "effects/sfx_fire_burst", BURST_POS, 256, 1, Vector3(255, 128, 0));
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", 512, BURST_POS);
		FIRE_BURST_TARGS = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(FIRE_BURST_TARGS != "none")) return;
		BURST_DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURST_DOT_BURN *= 0.75;
		for (int i = 0; i < GetTokenCount(FIRE_BURST_TARGS, ";"); i++)
		{
			fire_burst_affect_targs();
		}
	}

	void fire_burst_affect_targs()
	{
		string CUR_TARG = GetToken(FIRE_BURST_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TRACE_START = BURST_POS;
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 0)));
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), BURST_DOT_BURN, "swordsmanship");
	}

	void ext_player_sit()
	{
		LogDebug("ext_player_sit");
		if ((FAURA_ACTIVE))
		{
			end_faura();
		}
	}

}

}
