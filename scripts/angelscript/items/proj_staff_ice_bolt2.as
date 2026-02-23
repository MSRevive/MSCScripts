#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjStaffIceBolt2 : CGameScript
{
	int IS_ACTIVE;
	string MY_TARG;
	string TARG_HALF_HEIGHT;
	string TARG_LIST;

	ProjStaffIceBolt2()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 7;
		const int ARROW_BODY_OFS = 7;
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "weapons/axemetal1.wav";
		const string SOUND_BURN = "magic/ice_powerup.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "cold";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 0;
	}

	void arrow_spawn()
	{
		SetName("Guided Ice Bolt");
		SetDescription("A sharp bolt of ice");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		LogDebug("game_tossprojectile");
		ScheduleDelayedEvent(0.1, "pick_target");
	}

	void pick_target()
	{
		LogDebug("pick_target");
		CallExternal("ent_expowner", "ext_sphere_token_byrange", "enemy", 768, GetEntityOrigin(GetOwner()));
		TARG_LIST = GetEntityProperty("ent_expowner", "scriptvar");
		LogDebug("pick_target list TARG_LIST");
		if (!(TARG_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(TARG_LIST, ";"); i++)
		{
			pick_target_loop();
		}
		LogDebug("pick_target GetEntityName(MY_TARG)");
		if (!(IsValidPlayer(MY_TARG)))
		{
			TARG_HALF_HEIGHT = GetEntityHeight(MY_TARG);
			TARG_HALF_HEIGHT *= 0.5;
		}
		else
		{
			TARG_HALF_HEIGHT = 0;
		}
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "orient_on_target");
	}

	void pick_target_loop()
	{
		string L_TARG = GetToken(TARG_LIST, i, ";");
		string L_POS = GetEntityOrigin(L_TARG);
		if (!(TraceLine(GetEntityOrigin(GetOwner()), L_POS) == L_POS)) return;
		if ((IsValidPlayer(L_TARG)))
		{
			if ((IsValidPlayer(GetOwner())))
			{
				if (!("game.pvp"))
				{
					return;
				}
			}
		}
		if (!(IsEntityAlive(L_TARG))) return;
		if (!(/* TODO: $get_takedmg */ $get_takedmg(L_TARG, "cold"))) return;
		MY_TARG = L_TARG;
		break;
	}

	void orient_on_target()
	{
		if (!(IS_ACTIVE)) return;
		if (!(IsEntityAlive(MY_TARG))) return;
		ScheduleDelayedEvent(0.25, "orient_on_target");
		string TARG_ORG = GetEntityOrigin(MY_TARG);
		TARG_ORG += "z";
		string MY_ORG = GetEntityOrigin(GetOwner());
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
		ANG_TO_TARG = "x";
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, 300, 0)));
		SetProp(GetOwner(), "movedir", ANG_TO_TARG);
	}

	void game_projectile_landed()
	{
		IS_ACTIVE = 0;
	}

	void game_projectile_hitnpc()
	{
		IS_ACTIVE = 0;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENT_HIT = param1;
		if (OWNER_ISPLAYER == 1)
		{
			if (!("game.pvp"))
			{
			}
			if ((IsValidPlayer(ENT_HIT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		XDoDamage(ENT_HIT, "direct", GetSkillLevel(MY_OWNER, "spellcasting.ice"), 1.0, MY_OWNER, GetOwner(), "spellcasting.ice", "cold");
		string EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		string DOT_ICE = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DURATION *= 0.5;
		DOT_ICE *= 0.5;
		// TODO: capvar EFFECT_DURATION 3 5
		ApplyEffect(ENT_HIT, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, DOT_ICE, "spellcasting.ice");
	}

}

}
