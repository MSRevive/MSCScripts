#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class EffectRejuv2 : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	EffectRejuv2()
	{
		EFFECT_ID = "effect_rejuvenate";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		string HEAL_AMT = param2;
		string CASTER_ID = param3;
		string MY_ID = GetEntityIndex(GetOwner());
		string MY_MAX_HEALTH = GetEntityMaxHealth(MY_ID);
		string MY_CUR_HEALTH = GetEntityHealth(MY_ID);
		if (MY_ID != CASTER_ID)
		{
			int HEALING_OTHER = 1;
		}
		if (MY_CUR_HEALTH < MY_MAX_HEALTH)
		{
			HealEntity(GetOwner(), HEAL_AMT);
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 256, 1, 1);
			if ((HEALING_OTHER))
			{
				SendColoredMessage(CASTER_ID, "You heal " + GetEntityName(MY_ID) + "for " + HEAL_AMT + " hp");
				SendColoredMessage(MY_ID, GetEntityName(CASTER_ID) + "heals you for " + HEAL_AMT + " hp");
			}
			else
			{
				SendColoredMessage(CASTER_ID, "You heal yourself for " + HEAL_AMT + " hp");
			}
		}
		else
		{
			if ((HEALING_OTHER))
			{
				SendColoredMessage(CASTER_ID, GetEntityName(MY_ID) + " is at maximum health");
			}
			else
			{
				SendColoredMessage(MY_ID, "You are at maximum health");
			}
		}
		RemoveScript();
	}

}

}
