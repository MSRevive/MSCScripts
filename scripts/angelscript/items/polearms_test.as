#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class PolearmsTest : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_IDLE1;
	int ANIM_LIFT;
	int ANIM_PARRY;
	int ANIM_POKE;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ANIM_SMASH;
	int ANIM_SWIPE;
	int ANIM_TRIP;
	int ANIM_UNSHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	string GAME_PVP;
	float MELEE_ACCURACY;
	float MELEE_ACCURACY2;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	float MELEE_ATK_DURATION_LONG;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	float MELEE_DMG_DELAY_LONG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string NEXT_PARRY;
	string OWNER_ANG;
	string OWNER_ORG;
	int PARRY_MODE;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	float POLEARM_DMG_FALLOFF;
	int POLEARM_OPTIMUM_RANGE;
	int RANGE_SWIPE;
	string SOUND_DRAW;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_PARRY;
	string SOUND_SHOUT;
	string SOUND_SWIPE;
	string SWIPE_LIST;
	int game.effect.canattack;

	PolearmsTest()
	{
		BASE_LEVEL_REQ = 0;
		RANGE_SWIPE = 64;
		POLEARM_OPTIMUM_RANGE = 80;
		POLEARM_DMG_FALLOFF = 0.05;
		SOUND_PARRY = "weapons/parry.wav";
		ANIM_LIFT = 1;
		ANIM_IDLE1 = 0;
		ANIM_ATTACK1 = 2;
		ATTACK_ANIMS = 1;
		ANIM_UNSHEATH = 1;
		ANIM_SHEATH = 1;
		ANIM_SWIPE = 6;
		ANIM_SMASH = 5;
		ANIM_POKE = 4;
		ANIM_TRIP = 3;
		ANIM_PARRY = 7;
		MODEL_VIEW = "viewmodels/v_polearms.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_DRAW = "weapons/swords/sworddraw.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 104;
		ANIM_PREFIX = "khopesh";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.4;
		MELEE_ATK_DURATION = 1.1;
		MELEE_DMG_DELAY_LONG = 1.0;
		MELEE_ATK_DURATION_LONG = 1.4;
		MELEE_ENERGY = 1;
		MELEE_DMG = 500;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "generic";
		MELEE_ACCURACY = 0.75;
		MELEE_ACCURACY2 = 0.9;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 3;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.6;
		PLAYERANIM_AIM = "sword_double_idle";
		PLAYERANIM_SWING = "sword_double_swing";
	}

	void weapon_spawn()
	{
		SetName("Polearm test");
		SetDescription("It s a polearm! Really it is!");
		SetWeight(75);
		SetSize(9);
		SetValue(0);
		SetHUDSprite("trade", "longsword");
		SetHand("both");
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void melee_start()
	{
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(ANIM_ATTACK1);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SWIPE);
		if ((PARRY_MODE))
		{
			end_parry();
		}
	}

	void melee_damaged_other()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		adjust_dmg(OUT_PAR1, OUT_PAR2);
	}

	void special_01_damaged_other()
	{
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		adjust_dmg(OUT_PAR1, OUT_PAR2);
	}

	void adjust_dmg()
	{
		if (!(IsEntityAlive(param1))) return;
		string OPTIMUM_RANGE = POLEARM_OPTIMUM_RANGE;
		string DMG_FALLOFF = POLEARM_DMG_FALLOFF;
		string TARG_RANGE = GetEntityRange(param1);
		if (!(TARG_RANGE != OPTIMUM_RANGE)) return;
		if (TARG_RANGE > OPTIMUM_RANGE)
		{
			string MISSED_AMT = TARG_RANGE;
			MISSED_AMT -= OPTIMUM_RANGE;
			int TOO_CLOSE = 0;
		}
		if (TARG_RANGE < OPTIMUM_RANGE)
		{
			string MISSED_AMT = OPTIMUM_RANGE;
			MISSED_AMT -= TARG_RANGE;
			int TOO_CLOSE = 1;
		}
		string DMG_PENALTY_FACTOR = DMG_FALLOFF;
		DMG_PENALTY_FACTOR *= MISSED_AMT;
		if (DMG_PENALTY_FACTOR >= 1)
		{
			float DMG_PENALTY_FACTOR = 0.9;
		}
		int OUT_DMG_FACTOR = 1;
		OUT_DMG_FACTOR -= DMG_PENALTY_FACTOR;
		string OUT_DMG = param2;
		OUT_DMG *= OUT_DMG_FACTOR;
		SetDamage("dmg");
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
		string reg.attack.hitchance = MELEE_ACCURACY2;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY_LONG;
		string reg.attack.delay.end = MELEE_ATK_DURATION_LONG;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "melee";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		reg.attack.reqskill += BASE_LEVEL_REQ;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "+attack1";
		string reg.attack.range = MELEE_RANGE;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "generic";
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY_LONG;
		string reg.attack.delay.end = MELEE_ATK_DURATION_LONG;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "melee";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 2;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_02";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 5;
		reg.attack.reqskill += BASE_LEVEL_REQ;
		RegisterAttack();
	}

	void special_01_start()
	{
		if ((PARRY_MODE))
		{
			end_parry();
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(ANIM_POKE);
		SetVolume(10);
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void special_02_start()
	{
		if ((PARRY_MODE))
		{
			end_parry();
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(ANIM_SWIPE);
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SWORDREADY')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_strike()
	{
		if (!(true)) return;
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", RANGE_SWIPE, GetEntityOrigin(GetOwner()));
		SWIPE_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		LogDebug("special_02_end SWIPE_LIST");
		if (!(SWIPE_LIST != "none")) return;
		string N_SWIPIES = GetTokenCount(SWIPE_LIST, ";");
		if (!(N_SWIPIES > 0)) return;
		OWNER_ORG = GetEntityOrigin(GetOwner());
		OWNER_ANG = GetEntityAngles(GetOwner());
		for (int i = 0; i < N_SWIPIES; i++)
		{
			swipe_targets();
		}
	}

	void swipe_targets()
	{
		string CUR_TARGET = GetToken(SWIPE_LIST, i, ";");
		if ((IsValidPlayer(CUR_TARGET)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string TRACE_START = OWNER_ORG;
		string TRACE_END = TARG_ORG;
		if (!(IsValidPlayer(CUR_TARGET)))
		{
			string HALF_MON_HEIGHT = GetEntityHeight(CUR_TARGET);
			HALF_MON_HEIGHT /= 2;
			TRACE_END += "z";
		}
		string TRACE_CHECK = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_CHECK == TRACE_END)) return;
		string STAT_STR = "skill.";
		STAT_STR += MELEE_STAT;
		string STAT_SKILL = GetEntityProperty(GetOwner(), "stat_str");
		string STAT_FLOAT = STAT_SKILL;
		STAT_FLOAT *= 0.01;
		int HIT_CHANCE = 100;
		HIT_CHANCE -= MELEE_ACCURACY;
		string HIT_CHANCE = /* TODO: $get_skill_ratio */ $get_skill_ratio(STAT_FLOAT, MELEE_ACCURACY, 100);
		string DMG_SWIPE = MELEE_DMG;
		string DMG_SWIPE = /* TODO: $get_skill_ratio */ $get_skill_ratio(STAT_FLOAT, 0, MELEE_DMG);
		DMG_SWIPE /= 2;
		LogDebug("swipe_targets Hitchance HIT_CHANCE dmg DMG_SWIPE");
		XDoDamage(CUR_TARGET, "direct", DMG_SWIPE, HIT_CHANCE, GetOwner(), GetOwner(), STAT_STR, MELEE_DMG_TYPE);
	}

	void game_+attack2()
	{
		if ((PARRY_MODE)) return;
		if (!(GetGameTime() > NEXT_PARRY)) return;
		PARRY_MODE = 1;
		game.effect.canattack = 0;
		// TODO: splayviewanim ent_me ANIM_PARRY
	}

	void game__attack2()
	{
		if (!(PARRY_MODE)) return;
		end_parry();
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(PARRY_MODE)) return;
		if ((param4).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((param4).findFirst("magic") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARG_ORG = GetEntityOrigin(param1);
		OWNER_ORG = GetEntityOrigin(GetOwner());
		OWNER_ANG = GetEntityAngles(GetOwner());
		if (!(WithinCone2D(TARG_ORG, OWNER_ORG, OWNER_ANG))) return;
		string DMG_TAKEN = param3;
		string DMG_BLOCKED = param3;
		DMG_TAKEN *= 0.25;
		DMG_BLOCKED *= 0.75;
		SetDamage("dmg");
		if (DMG_BLOCKED > 0)
		{
			int DMG_BLOCKED = int(DMG_BLOCKED);
		}
		DMG_BLOCKED += "pts";
		SendPlayerMessage("Polearm", "blocked " + DMG_BLOCKED + " damage.");
	}

	void item_idle()
	{
	}

	void end_parry()
	{
		NEXT_PARRY = GetGameTime();
		NEXT_PARRY += 1.0;
		PARRY_MODE = 0;
		game.effect.canattack = 1;
		// TODO: splayviewanim ent_me ANIM_IDLE
	}

}

}
