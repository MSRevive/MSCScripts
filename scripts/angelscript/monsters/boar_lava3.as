#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class BoarLava3 : CGameScript
{
	float ATTACK_HITCHANCE;
	string BOAR_MODEL;
	int BOAR_SIZE;
	int BOAR_SKIN;
	string BURST_TARGS;
	string CL_CHARGE_SCRIPT;
	int DMG_CHARGE;
	float DMG_GORE_FORWARD;
	float DMG_GORE_LEFT;
	float DMG_GORE_RIGHT;
	int DOT_FIRE;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	BoarLava3()
	{
		BOAR_SIZE = 3;
		BOAR_SKIN = 2;
		BOAR_MODEL = "monsters/boar3.mdl";
		NPC_GIVE_EXP = 1000;
		DMG_GORE_FORWARD = Random(60.0, 80.0);
		DMG_GORE_LEFT = Random(60.0, 80.0);
		DMG_GORE_RIGHT = Random(60.0, 80.0);
		DMG_CHARGE = RandomInt(300, 500);
		DOT_FIRE = 75;
		ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		CL_CHARGE_SCRIPT = "monsters/boar_lava_cl";
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
