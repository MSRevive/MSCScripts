#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class GoblinLatch : CGameScript
{
	string CL_FX;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string GOBLIN_ID;
	int game.effect.movespeed;

	GoblinLatch()
	{
		EFFECT_ID = "goblin_latch";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		GOBLIN_ID = param2;
		game.effect.movespeed = 90;
		if ((IsValidPlayer(GetOwner())))
		{
			ClientEvent("new", GetOwner(), "effects/sfx_drunk", EFFECT_DURATION);
			CL_FX = "game.script.last_sent_id";
		}
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		string L_ACTIVE_SKILL = "none";
		if ((IsValidPlayer(param1)))
		{
			string L_ACTIVE_SKILL = param5;
		}
		XDoDamage(GOBLIN_ID, "direct", param2, param4, param1, param1, L_ACTIVE_SKILL, param3);
	}

	void game_applyeffect()
	{
		if (!((param3).findFirst("dot_") >= 0)) return;
		string L_RETURN = "redirect";
		if (L_RETURN.length() > 0) L_RETURN += ";";
		L_RETURN += GOBLIN_ID;
		return;
	}

	void effect_die()
	{
		if ((CL_FX))
		{
			ClientEvent("update", GetOwner(), CL_FX, "effect_die");
		}
	}

	void ext_goblin_died()
	{
		RemoveScript();
	}

}

}
