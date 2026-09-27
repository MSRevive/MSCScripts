#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceShield : CGameScript
{
	float ICESHIELD_FORMULA;
	int ICESHIELD_RANGE;
	string LAST_ATTACK;
	int MANA_COST;
	float MELEE_ATK_DURATION;
	int NO_REGISTER;
	string SOUND_SHOOT;
	string SPELL_SCRIPT;

	MagicHandIceShield()
	{
		NO_REGISTER = 1;
		SOUND_SHOOT = "magic/cast.wav";
		ICESHIELD_RANGE = 389;
		MELEE_ATK_DURATION = 0.65;
		MANA_COST = 50;
		ICESHIELD_FORMULA = 0.5;
		SPELL_SCRIPT = "effects/iceshield";
	}

	void spell_spawn()
	{
		SetName("Ice Shield");
		SetDescription("Provides 50% damage reduction for you or allies, for a time.");
		LAST_ATTACK = (GetGameTime() + MELEE_ATK_DURATION);
	}

	void game_attack1()
	{
		float TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_ATTACK;
		if (!(TIME_DIFF > MELEE_ATK_DURATION)) return;
		LAST_ATTACK = GetGameTime();
		PlayViewAnim(ANIM_CAST);
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		if (GetEntityMP(GetOwner()) < MANA_COST)
		{
			SendColoredMessage(GetOwner(), "Insufficient mana.");
		}
		if (!(GetEntityMP(GetOwner()) >= MANA_COST)) return;
		string SPELL_TARGET = "func_get_ray_target"(GetOwner(), ICESHIELD_RANGE);
		if (!(IsEntityAlive(SPELL_TARGET)))
		{
			string SPELL_TARGET = GetEntityIndex(GetOwner());
		}
		if (!(IsValidPlayer(SPELL_TARGET)))
		{
			if (GetRelationship(GetOwner()) != "ally")
			{
			}
			string SPELL_TARGET = GetEntityIndex(GetOwner());
		}
		int FINAL_DURATION = 150;
		if (GetEntityIndex(SPELL_TARGET) != GetEntityIndex(GetOwner()))
		{
			int FINAL_DURATION = 412;
		}
		GiveMP(/* TODO: $neg */ $neg(MANA_COST));
		CallExternal(GetOwner(), "mana_drain");
		string ALREADY_SHIELDED = GetEntityProperty(SPELL_TARGET, "haseffect");
		if ((ALREADY_SHIELDED))
		{
			CallExternal(SPELL_TARGET, "ext_refresh_ice_shield", FINAL_DURATION, GetEntityIndex(GetOwner()));
		}
		else
		{
			ApplyEffect(SPELL_TARGET, SPELL_SCRIPT, FINAL_DURATION, GetEntityIndex(GetOwner()), ICESHIELD_FORMULA);
		}
	}

	void func_get_ray_target()
	{
		string PLR = param1;
		string PLR_ID = GetEntityIndex(PLR);
		string PLR_ORG = GetEntityProperty(PLR, "eyepos");
		string PLR_ANG = GetEntityProperty(PLR, "viewangles");
		if (GetEntityProperty(PLR, "sitting") == 1)
		{
			PLR_ORG += "z";
		}
		string TRACE_START = PLR_ORG;
		string TRACE_END = PLR_ORG;
		TRACE_END += /* TODO: $relpos */ $relpos(PLR_ANG, Vector3(0, param2, 0));
		string TRACED_LINE = TraceLine(TRACE_START, TRACE_END);
		return;
		return;
	}

}

}
