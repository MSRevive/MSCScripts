#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsFlamelick : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_UNWIELD;
	int ANIM_WIELD;
	int ANIM_WIELDEDIDLE1;
	int BASE_LEVEL_REQ;
	string BURST_DAMAGE;
	string CHARGE_COUNTER;
	float MELEE_ACCURACY;
	float MELEE_ALIGN_BASE;
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
	string SOUND_HITWALL2;
	string TARG_LIST;

	SmallarmsFlamelick()
	{
		BASE_LEVEL_REQ = 20;
		MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		MODEL_VIEW_IDX = 5;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_WIELD = 2;
		ANIM_UNWIELD = 3;
		ANIM_WIELDEDIDLE1 = 4;
		ANIM_ATTACK1 = 5;
		ANIM_ATTACK2 = 6;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MELEE_RANGE = 50;
		MELEE_DMG_DELAY = 0.2;
		MELEE_ATK_DURATION = 0.9;
		MELEE_ENERGY = 0.6;
		MELEE_DMG_TYPE = "fire";
		MELEE_DMG = 250;
		MELEE_DMG_RANGE = 50;
		MELEE_ACCURACY = 0.85;
		MELEE_ALIGN_BASE = 3.6;
		MELEE_ALIGN_TIP = 0;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
		PLAYERANIM_AIM = "knife";
		PLAYERANIM_SWING = "swing_knife";
		SOUND_HITWALL2 = "ambience/steamburst1.wav";
		MODEL_BODY_OFS = 32;
		ANIM_PREFIX = "firedagger";
	}

	void weapon_spawn()
	{
		SetName("Flamelick");
		SetDescription("A magical dagger forged from the tongue of an Efreeti");
		SetWeight(3);
		SetSize(3);
		SetValue(1000);
		SetHUDSprite("hand", 107);
		SetHUDSprite("trade", 107);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		BURN_DAMAGE /= 3;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "smallarms");
	}

	void register_secondary()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 1;
		string reg.attack.dmg.type = "fire";
		int reg.attack.energydrain = 9999;
		string reg.attack.stat = "spellcasting.fire";
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.0;
		float reg.attack.delay.end = 1.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 10;
		int reg.attack.dmg.ignore = 1;
		RegisterAttack();
	}

	void special_02_start()
	{
		EmitSound(GetOwner(), 0, "magic/fireball_powerup.wav", 10);
		Effect("glow", GetOwner(), Vector3(255, 75, 0), 128, 5.0, 5.0);
	}

	void special_02_strike()
	{
		if (CHARGE_COUNTER == "CHARGE_COUNTER")
		{
			CHARGE_COUNTER = 10;
		}
		if (CHARGE_COUNTER <= 0)
		{
			SendPlayerMessage(GetOwner(), "The flamelick's magic is exhausted, for now.");
		}
		if (!(CHARGE_COUNTER > 0)) return;
		CHARGE_COUNTER -= 1;
		int INT_COUNTER = int(CHARGE_COUNTER);
		SendPlayerMessage("The", "flamelick has " + INT_COUNTER + " charges remaining.");
		ClientEvent("new", "all", "monsters/summon/flame_burst_cl", GetEntityIndex(GetOwner()));
		BURST_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		CallExternal(GetOwner(), "ext_sphere_token_x", "enemy", 256);
		TARG_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		if (!(TARG_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(TARG_LIST, ";"); i++)
		{
			burst_affect_targets();
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(TARG_LIST, i, ";");
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), BURST_DAMAGE, "smallarms");
	}

}

}
