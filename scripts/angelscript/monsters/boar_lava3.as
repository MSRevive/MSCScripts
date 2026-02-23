#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class BoarLava3 : CGameScript
{
	string BURST_TARGS;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	BoarLava3()
	{
		const int BOAR_SIZE = 3;
		const int BOAR_SKIN = 2;
		const string BOAR_MODEL = "monsters/boar3.mdl";
		NPC_GIVE_EXP = 1000;
		const string DMG_GORE_FORWARD = Random(60.0, 80.0);
		const string DMG_GORE_LEFT = Random(60.0, 80.0);
		const string DMG_GORE_RIGHT = Random(60.0, 80.0);
		const string DMG_CHARGE = RandomInt(300, 500);
		const int DOT_FIRE = 75;
		const float ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
		const string SOUND_STRUCK1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK2 = "weapons/axemetal2.wav";
		const string SOUND_STRUCK3 = "debris/concrete1.wav";
		const string CL_CHARGE_SCRIPT = "monsters/boar_lava_cl";
	}

	void game_precache()
	{
		Precache("fire1_fixed2.spr");
	}

	void boar_spawn()
	{
		SetName("Great Lava Boar");
		SetRace("demon");
		SetHealth(3000);
		SetHearingSensitivity(4);
		SetRoam(true);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("holy", 0.5);
	}

	void OnPostSpawn() override
	{
		DROP_ITEM1_CHANCE = 0.0;
	}

	void game_dodamage()
	{
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

	void boar_charge_sequence()
	{
		string BURST_ORG = GetEntityOrigin(GetOwner());
		BURST_ORG += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, -50, 0));
		ClientEvent("new", "all", "effects/sfx_fire_burst", BURST_ORG, 196, 1, Vector3(255, 128, 0));
		BURST_TARGS = FindEntitiesInSphere("enemy", 196);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			burst_affect_targets();
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 2000, 400)));
	}

}

}
