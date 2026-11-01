#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjWeb : CGameScript
{
	int CLFX_ARROW;
	int CLFX_ARROW_NOSTICK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	int PROJ_STICK_ON_NPC;
	int PROJ_STICK_ON_WALL_NEW;
	float SCALE_SIZE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjWeb()
	{
		MODEL_HANDS = "none";
		SOUND_HITWALL1 = "none";
		SOUND_HITWALL2 = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 62;
		PROJ_ANIM_IDLE = "axis_spin";
		PROJ_DAMAGE_TYPE = "magic";
		PROJ_DAMAGE = 100;
		CLFX_ARROW = 0;
		CLFX_ARROW_NOSTICK = 1;
		PROJ_STICK_ON_NPC = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_MOTIONBLUR = 0;
		PROJ_STICK_ON_WALL_NEW = 0;
	}

	void OnSpawn() override
	{
		SetName("Web");
		SetDescription("Ew, it's sticky");
		SetGravity(0.07);
		SCALE_SIZE = 0.1;
		SetProp(GetOwner(), "scale", 0.1);
	}

	void game_tossprojectile()
	{
		expand_loop();
	}

	void expand_loop()
	{
		if (!(SCALE_SIZE < 1)) return;
		SCALE_SIZE += 0.01;
		SetProp(GetOwner(), "scale", SCALE_SIZE);
		ScheduleDelayedEvent(0.1, "expand_loop");
	}

	void game_projectile_hitnpc()
	{
		if ((IsValidPlayer("ent_expowner")))
		{
			string L_DUR = GetSkillLevel("ent_expowner", "spellcasting.affliction");
			L_DUR /= 30;
			L_DUR = max(0, min(1, L_DUR));
			string L_DUR = /* TODO: $ratio */ $ratio(L_DUR, 1.5, 2.5);
			if ((IsValidPlayer(param1)))
			{
				if (!("game.pvp"))
				{
					return;
				}
			}
		}
		else
		{
			float L_DUR = 2.5;
		}
		string L_RELATIONSHIP = GetRelationship("ent_expowner");
		if (!(L_RELATIONSHIP != "ally")) return;
		if (!(L_RELATIONSHIP != "neutral")) return;
		if (!(L_RELATIONSHIP != "none")) return;
		ApplyEffect(param1, "effects/webbed", L_DUR, GetEntityIndex("ent_expowner"));
	}

}

}
