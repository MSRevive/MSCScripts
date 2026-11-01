#pragma context server

#include "monsters/troll_lobber.as"

namespace MS
{

class DjinnTrollLesserFire : CGameScript
{
	string BURST_ELEMENT;
	int DMG_AOE;
	int DOT_DMG;
	float DOT_DUR;
	string EFFECT_DOT;
	string ELEMENT_COLOR;
	string FX_BURST_SCRIPT;
	string PROJ_SCRIPT;
	int ROCK_DAMAGE;
	int TROLL_EXP;
	string TROLL_MODEL;
	string TROLL_NAME;

	DjinnTrollLesserFire()
	{
		TROLL_EXP = 200;
		PROJ_SCRIPT = "proj_troll_rock_fire";
		TROLL_MODEL = "monsters/troll_fire.mdl";
		TROLL_NAME = "Lesser Fire Djinn";
		ROCK_DAMAGE = 0;
		DMG_AOE = RandomInt(300, 500);
		DOT_DMG = RandomInt(40, 60);
		DOT_DUR = 5.0;
		FX_BURST_SCRIPT = "effects/sfx_fire_burst";
		EFFECT_DOT = "effects/dot_fire";
		ELEMENT_COLOR = Vector3(255, 0, 0);
		BURST_ELEMENT = "fire_effect";
	}

	void game_precache()
	{
		Precache(FX_BURST_SCRIPT);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 1.5);
	}

	void ext_proj_landed()
	{
		string L_BURST_POS = param1;
		XDoDamage(param1, 256, DMG_AOE, 0.01, GetOwner(), GetOwner(), "none", BURST_ELEMENT, "dmgevent:proj");
		ClientEvent("new", "all", FX_BURST_SCRIPT, L_BURST_POS, 256, 1, ELEMENT_COLOR);
	}

	void proj_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		ApplyEffect(param2, EFFECT_DOT, DUR_DOT, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void game_dodamage()
	{
		if (!((param5).findFirst("effect") >= 0)) return;
		if (!(param1)) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param2, EFFECT_DOT, DUR_DOT, GetEntityIndex(GetOwner()), DOT_DMG);
	}

}

}
