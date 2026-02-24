#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectQuake : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	int QUAKE_ACTIVE;
	string QUAKE_AOE;
	string QUAKE_DMG;
	string QUAKE_DMGSRC;
	string QUAKE_FALLOFF;
	string QUAKE_MOBILE;
	string QUAKE_ORIGIN;
	string QUAKE_SKILL;
	float game.effect.anim.framerate;
	int game.effect.canjump;
	float game.effect.movespeed;

	EffectQuake()
	{
		EFFECT_ID = "DOT_quake";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		QUAKE_DMGSRC = param2;
		QUAKE_AOE = param3;
		QUAKE_DMG = param4;
		QUAKE_ORIGIN = param5;
		QUAKE_FALLOFF = param6;
		if ((IsEntityAlive(QUAKE_ORIGIN)))
		{
			QUAKE_MOBILE = 1;
		}
		QUAKE_SKILL = "none";
		if ((IsValidPlayer(QUAKE_ORIGIN)))
		{
			QUAKE_SKILL = "spellcasting.earth";
		}
		game.effect.canjump = 0;
		game.effect.movespeed = 0.1;
		game.effect.anim.framerate = 0.1;
		string L_SHAKE_AOE = QUAKE_AOE;
		L_SHAKE_AOE *= 1.5;
		if ((IsValidPlayer(GetOwner())))
		{
			SendPlayerMessage("You", "are caught in a quake!");
		}
		QUAKE_ACTIVE = 1;
		quake_loop();
	}

	void quake_loop()
	{
		if (!(QUAKE_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "quake_loop");
		if ((QUAKE_MOBILE))
		{
			string L_QPOS = GetEntityOrigin(QUAKE_ORIGIN);
		}
		else
		{
			string L_QPOS = QUAKE_ORIGIN;
		}
		string L_MY_POS = GetEntityOrigin(GetOwner());
		float L_QUAKE_DIST = Distance(L_QPOS, L_MY_POS);
		if ((QUAKE_FALLOFF))
		{
			int L_DIST_RATIO = 1;
			L_DIST_RATIO -= (L_QUAKE_DIST / QUAKE_AOE);
		}
		if (L_QUAKE_DIST <= QUAKE_AOE)
		{
			if (QUAKE_DMG > 0)
			{
				string L_DMG = QUAKE_DMG;
				if ((QUAKE_FALLOFF))
				{
					string L_DMG = /* TODO: $ratio */ $ratio(L_DIST_RATIO, 1, QUAKE_DMG);
					L_DMG *= 2;
					if ((IsValidPlayer(GetOwner())))
					{
						if ((GetEntityProperty(GetOwner(), "nopush")))
						{
						}
						L_DMG *= 5;
					}
				}
				XDoDamage(GetOwner(), "direct", L_DMG, 1.0, QUAKE_DMGSRC, QUAKE_DMGSRC, QUAKE_SKILL, "blunt_effect");
			}
			float L_SLOW = 0.3;
			if ((QUAKE_FALLOFF))
			{
				string L_SLOW = /* TODO: $ratio */ $ratio(L_DIST_RATIO, 0.9, 0.1);
			}
			game.effect.movespeed = (100 * L_SLOW);
			game.effect.anim.framerate = L_SLOW;
		}
		else
		{
			game.effect.movespeed = 100;
			game.effect.anim.framerate = 1.0;
		}
	}

}

}
