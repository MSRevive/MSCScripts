#pragma context server

#include "items/smallarms_eth.as"

namespace MS
{

class SmallarmsVt : CGameScript
{
	string BURST_DAMAGE;
	string GAME_PVP;
	string TARG_LIST;

	SmallarmsVt()
	{
		const int BASE_LEVEL_REQ = 30;
		const int CUSTOM_REGISTER_SECONDARY = 1;
		const int CUSTOM_SWING = 1;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_WIELD = 2;
		const int ANIM_UNWIELD = 3;
		const int ANIM_WIELDEDIDLE1 = 4;
		const int ANIM_ATTACK1 = 23;
		const int ANIM_ATTACK2 = 6;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_smallarms.mdl";
		const int MODEL_VIEW_IDX = 13;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 66;
		const int MELEE_DMG = 250;
		const float MELEE_DMG_DELAY = 0.2;
		const float MELEE_ATK_DURATION = 0.5;
	}

	void weapon_spawn()
	{
		SetName("Vorpal Tongue");
		SetDescription("Layers of magic have been sewn into this ethereal dagger");
		SetWeight(3);
		SetSize(2);
		SetValue(5000);
		SetHUDSprite("hand", 141);
		SetHUDSprite("trade", 141);
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void register_secondary()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 1;
		string reg.attack.dmg.type = "ice";
		int reg.attack.energydrain = 9999;
		string reg.attack.stat = "spellcasting.ice";
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 1.8;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "freeze_burst";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 1;
		int reg.attack.dmg.ignore = 1;
		int reg.attack.mpdrain = 75;
		RegisterAttack();
	}

	void special_01_start()
	{
		if ((SPECIAL1_OVERRIDE)) return;
		PlayViewAnim(ANIM_ATTACK2);
		if (!(true)) return;
		// svplaysound: svplaysound 1 10 $get(ent_owner,scriptvar,'PLR_SOUND_JAB2')
		EmitSound(1, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void freeze_burst_start()
	{
		PlayViewAnim(2);
		EmitSound(GetOwner(), 0, "magic/frost_reverse.wav", 10);
		Effect("glow", GetOwner(), Vector3(0, 75, 255), 128, 5.0, 5.0);
	}

	void freeze_burst_strike()
	{
		ClientEvent("new", "all", "monsters/summon/ice_burst_cl", GetEntityIndex(GetOwner()));
		BURST_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.ice");
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
		string FREEZE_ON_CHANCE = RandomInt(1, 2);
		if (FREEZE_ON_CHANCE == 1)
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), RandomInt(10, BURST_DAMAGE), "smallarms");
		}
		if (FREEZE_ON_CHANCE == 2)
		{
			if (GetEntityHealth(CUR_TARG) > 1500)
			{
				ApplyEffect(CUR_TARG, "effects/dot_cold", 10, MY_OWNER, RandomInt(10, BURST_DAMAGE), "smallarms");
			}
			if (GetEntityHealth(CUR_TARG) <= 1500)
			{
				ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 5, GetEntityIndex(GetOwner()), RandomInt(10, 20));
			}
		}
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
		DOT_BURN *= 0.5;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BURN, "smallarms");
	}

}

}
