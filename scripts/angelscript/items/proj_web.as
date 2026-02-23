#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjWeb : CGameScript
{
	float SCALE_SIZE;

	ProjWeb()
	{
		const string MODEL_HANDS = "none";
		const string SOUND_HITWALL1 = "none";
		const string SOUND_HITWALL2 = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 62;
		const string PROJ_ANIM_IDLE = "axis_spin";
		const string PROJ_DAMAGE_TYPE = "magic";
		const int PROJ_DAMAGE = 100;
		const int CLFX_ARROW = 0;
		const int CLFX_ARROW_NOSTICK = 1;
		const int PROJ_STICK_ON_NPC = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_STICK_ON_WALL_NEW = 0;
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
			// TODO: capvar L_DUR 0 1
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
