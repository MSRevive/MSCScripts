#pragma context server

#include "items/smallarms_base.as"

namespace MS
{

class SmallarmsFrozentongueonflagpole : CGameScript
{
	string TARG_LIST;

	SmallarmsFrozentongueonflagpole()
	{
		const int BASE_LEVEL_REQ = 23;
		const int CUSTOM_REGISTER_SECONDARY = 1;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 6;
		const int ANIM_LIFT1 = 31;
		const int ANIM_IDLE1 = 32;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 31;
		const int ANIM_UNWIELD = 38;
		const int ANIM_WIELDEDIDLE1 = 32;
		const int ANIM_ATTACK1 = 33;
		const int ANIM_ATTACK2 = 34;
		const int ANIM_ATTACK3 = 35;
		const int ANIM_ATTACK4 = 36;
		const int ANIM_ATTACK5 = 37;
		const string MELEE_VIEWANIM_ATK = RandomInt(ANIM_ATTACK1, ANIM_ATTACK5);
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MELEE_DMG_TYPE = "cold";
		const int MELEE_RANGE = 50;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.9;
		const float MELEE_ENERGY = 0.6;
		const int MELEE_DMG = 275;
		const int MELEE_DMG_RANGE = 20;
		const float MELEE_ACCURACY = 1.0;
		const float MELEE_ALIGN_BASE = 3.6;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
		const string PLAYERANIM_AIM = "knife";
		const string PLAYERANIM_SWING = "swing_knife";
		const string SOUND_HITWALL1 = "debris/glass1.wav";
		const string SOUND_HITWALL2 = "debris/glass2.wav";
		const int MODEL_BODY_OFS = 17;
		const string ANIM_PREFIX = "standard";
		const int CUSTOM_REGISTER_CHARGE1 = 1;
	}

	void weapon_spawn()
	{
		SetName("Litch Tongue");
		SetDescription("A dagger carved from the bones of an ancient ice mage.");
		SetWeight(3);
		SetSize(3);
		SetValue(2500);
		SetHUDSprite("hand", 128);
		SetHUDSprite("trade", 128);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		if ((BITEM_UNDERSKILLED)) return;
		string FREEZE_DAMAGE = /* TODO: $math(multiply) */ /* TODO: $math(add) */ /* TODO: $math(multiply) */ GetSkillLevel(GetOwner(), "smallarms");
		FREEZE_DAMAGE += Random(1, /* TODO: $math(divide) */ GetSkillLevel(GetOwner(), "spellcasting.ice"));
		if (FREEZE_DAMAGE < 5)
		{
			int FREEZE_DAMAGE = 5;
		}
		EmitSound(GetOwner(), 0, "magic/frost_reverse.wav", 10);
		ApplyEffect(param2, "effects/dot_cold", 3, GetEntityIndex(GetOwner()), FREEZE_DAMAGE, "smallarms");
	}

	void register_secondary()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.dmg = 550;
		string reg.attack.range = MELEE_RANGE;
		int reg.attack.dmg.range = 1;
		string reg.attack.dmg.type = "cold";
		int reg.attack.energydrain = 0;
		string reg.attack.stat = "smallarms";
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.25;
		float reg.attack.delay.end = 1.3;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 25;
		int reg.attack.dmg.ignore = 0;
		int reg.attack.mpdrain = 0;
		RegisterAttack();
	}

	void special_02_start()
	{
		PlayViewAnim(ANIM_ATTACK1);
		Effect("glow", GetOwner(), Vector3(0, 75, 255), 128, 5.0, 5.0);
	}

	void special_02_strike()
	{
		if (GetGameTime() <= NEXT_LITCH_BURST)
		{
			SendColoredMessage(GetOwner(), "Special attack is on cooldown");
		}
		if (!(GetGameTime() > NEXT_LITCH_BURST)) return;
		CallExternal(GetOwner(), "ext_sphere_token_x", "enemy", 256);
		TARG_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		if (TARG_LIST == "none")
		{
			// TODO: UNCONVERTED: if ( TARG_LIST equals none ) {
		}
		SendColoredMessage(GetOwner(), "No targets in range , cooldown reset");
		EmitSound(GetOwner(), 0, "magic/frost_pulse.wav", 10);
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(TARG_LIST, i, ";");
		if (!("game.pvp"))
		{
			if ((IsValidPlayer(CUR_TARG)))
			{
				return;
			}
		}
		TARGETS_AFFECTED += 1;
		if (TARGETS_AFFECTED == 3)
		{
			break;
		}
		ApplyEffect(CUR_TARG, "effects/dot_cold", 7, GetEntityIndex(GetOwner()), BURST_DAMAGE, "smallarms");
	}

}

}
