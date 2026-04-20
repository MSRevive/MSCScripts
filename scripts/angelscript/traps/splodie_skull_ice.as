#pragma context server

#include "traps/splodie_skull.as"

namespace MS
{

class SplodieSkullIce : CGameScript
{
	int CUSTOM_DEATH;
	string DEATH_TIME;
	int IMMUNE_VAMPIRE;
	string SOUND_HATCH;

	SplodieSkullIce()
	{
		CUSTOM_DEATH = 1;
		SOUND_HATCH = "debris/bustflesh1.wav";
	}

	void skull_spawn()
	{
		SetName("Icey Skull");
		if (MONSTER_HP == "MONSTER_HP")
		{
			SetHealth(50);
		}
		else
		{
			SetHealth(MONSTER_HP);
		}
		SetRace("demon");
		SetModel("monsters/skull.mdl");
		SetProp(GetOwner(), "skin", 1);
		SetBloodType("none");
		SetWidth(16);
		SetHeight(16);
		SetModelBody(0, 1);
		SetBloodType("none");
		IMMUNE_VAMPIRE = 1;
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 128, -1, 0);
		IMMUNE_VAMPIRE = 1;
		ScheduleDelayedEvent(0.1, "scan_bounce");
		Random(10_0, 20_0)("self_destruct");
		ScheduleDelayedEvent(0.01, "bounce_about");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((IsEntityAlive(MY_OWNER)))
		{
			CallExternal(MY_OWNER, "skull_died");
		}
		xp_send();
		DEATH_TIME = GetGameTime();
		DEATH_TIME += 0.2;
		EmitSound(GetOwner(), 0, SOUND_HATCH, 10);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		string SPLODE_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		ClientEvent("new", "all", "effects/sfx_splodie", SPLODE_POS, Vector3(128, 128, 255));
		XDoDamage(SPLODE_POS, 128, DMG_SPLODE, 0, GetOwner(), GetOwner(), "none", "blunt");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(IsEntityAlive(param2))) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_COLD);
	}

}

}
