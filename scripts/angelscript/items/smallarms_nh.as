#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsNh : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_DELAY_HIGH;
	int ANIM_IDLE_DELAY_LOW;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_UNWIELD;
	int ANIM_WIELD;
	int ANIM_WIELDEDIDLE1;
	int BASE_LEVEL_REQ;
	string CL_IDX;
	string CL_SCRIPT;
	int CUSTOM_REGISTER_CHARGE1;
	int CUSTOM_REGISTER_NORMAL;
	int CUSTOM_REGISTER_SECONDARY;
	string GAME_PVP;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND_DELAY;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	float SPRITE_SCALE;
	string WEAPON_PRIMARY_SKILL;

	SmallarmsNh()
	{
		CUSTOM_REGISTER_NORMAL = 1;
		CUSTOM_REGISTER_CHARGE1 = 1;
		CUSTOM_REGISTER_SECONDARY = 1;
		ANIM_LIFT1 = 31;
		ANIM_IDLE1 = 32;
		ANIM_IDLE_TOTAL = 1;
		ANIM_WIELD = 21;
		ANIM_UNWIELD = 38;
		ANIM_WIELDEDIDLE1 = 32;
		ANIM_ATTACK1 = 34;
		ANIM_ATTACK2 = 34;
		ANIM_IDLE_DELAY_LOW = 0;
		ANIM_IDLE_DELAY_HIGH = 0;
		BASE_LEVEL_REQ = 30;
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 37;
		MODEL_VIEW_IDX = 11;
		MELEE_DMG_TYPE = "slash";
		MELEE_RANGE = 600;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_DMG = 225;
		MELEE_DMG_RANGE = 50;
		MELEE_ACCURACY = 0.85;
		MELEE_ALIGN_BASE = 0;
		MELEE_ALIGN_TIP = 0;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.35;
		PLAYERANIM_AIM = "knife";
		PLAYERANIM_SWING = "swing_knife";
		SOUND_HITWALL1 = "none";
		SOUND_HITWALL2 = "none";
		ANIM_PREFIX = "standard";
		CL_SCRIPT = "items/smallarms_nh_cl";
	}

	void game_precache()
	{
		Precache(CL_SCRIPT);
	}

	void weapon_spawn()
	{
		SetName("Neck Hunter");
		SetDescription("An evil enchanted blade with unusual reach");
		SetWeight(3);
		SetSize(3);
		SetValue(3000);
		SetHUDSprite("hand", 134);
		SetHUDSprite("trade", 134);
	}

	void OnDeploy() override
	{
		SPRITE_SCALE = 0.1;
		GAME_PVP = "game.pvp";
		if (!(CL_IDX == "CL_IDX")) return;
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()));
		CL_IDX = "game.script.last_sent_id";
	}

	void game_putinpack()
	{
		if (!(CL_IDX != "CL_IDX")) return;
		ClientEvent("remove", "all", CL_IDX);
		CL_IDX = "CL_IDX";
	}

	void OnDrop() override
	{
		if (!(CL_IDX != "CL_IDX")) return;
		ClientEvent("remove", "all", CL_IDX);
		CL_IDX = "CL_IDX";
	}

	void melee_strike()
	{
		string BONE_POS = GetEntityProperty(GetOwner(), "eyepos");
		string OWNER_VIEWANG = GetEntityProperty(GetOwner(), "viewangles");
		string HIT_TYPE = param1;
		string ATTACK_END = param2;
		BONE_POS += /* TODO: $relpos */ $relpos(OWNER_VIEWANG, Vector3(0, 28, 0));
		ClientEvent("update", "all", CL_IDX, "shadow_knife", BONE_POS, GetEntityProperty(GetOwner(), "viewangles"), ATTACK_END, HIT_TYPE, SPRITE_SCALE);
		SPRITE_SCALE = 0.1;
		SPRITE_SCALE = 0.1;
	}

	void special_01_strike()
	{
		string CUR_TARG = param3;
		if ((IsEntityAlive(CUR_TARG)))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
				if (!(GAME_PVP))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityMaxHealth(CUR_TARG) < 1250)
			{
			}
			string PUSH_VEL = /* TODO: $relvel */ $relvel(0, 300, 120);
			AddVelocity(CUR_TARG, PUSH_VEL);
		}
		string OUT_PAR1 = param1;
		string OUT_PAR2 = param2;
		string OUT_PAR3 = param3;
		SPRITE_SCALE = 2.0;
		melee_strike(OUT_PAR1, OUT_PAR2, OUT_PAR3);
	}

	void register_normal()
	{
		string F_BASE_LEVEL_REQ = BASE_LEVEL_REQ;
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
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
		string reg.attack.callback = "melee";
		string reg.attack.noise = MELEE_NOISE;
		string reg.attack.reqskill = F_BASE_LEVEL_REQ;
		WEAPON_PRIMARY_SKILL = reg.attack.stat;
		RegisterAttack();
		register_charge1();
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "+attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = "magic";
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 1;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "melee";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 3;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

}

}
