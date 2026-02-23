#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleHornedGiant : CGameScript
{
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string SLAM_POS;
	string STUN_TARGS;

	BeetleHornedGiant()
	{
		NPC_GIVE_EXP = 600;
		const int BBET_SIZE = 2;
		const int BBET_CAN_FLY = 0;
		const int BBET_CAN_LEAP = 0;
		const int BBET_CAN_SLAM = 1;
		const int BBET_GORE_PUSH_STR = 800;
		const int BBET_FAKE_DEATH = 0;
		const int DMG_SLASH = 80;
		const int DMG_GORE = 100;
		const int DMG_SLAM = 300;
		NPC_MUST_SEE_TARGET = 0;
		const string SOUND_ATTACK1 = "monsters/beetle/attack_double1.wav";
		const string SOUND_ATTACK2 = "monsters/beetle/attack_double2.wav";
		const string SOUND_ATTACK3 = "monsters/beetle/attack_double3.wav";
	}

	void game_precache()
	{
		Precache("monsters/beetles_giant.mdl");
		Precache("magic/boom.wav");
	}

	void beetle_spawn()
	{
		SetName("Giant Horned Beetle");
		SetHealth(2000);
		SetDamageResistance("all", 0.75);
		SetModelBody(0, 0);
	}

	void beetle_slam()
	{
		SLAM_POS = GetEntityProperty(GetOwner(), "attachpos");
		SLAM_POS = "z";
		DoDamage(SLAM_POS, BBET_SLAM_RADIUS, DMG_SLAM, 1.0, 0);
		ClientEvent("new", "all", "effects/sfx_stun_burst", SLAM_POS, 256, 0);
		STUN_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(STUN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(STUN_TARGS, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CUR_TARG = GetToken(STUN_TARGS, i, ";");
		if (!(IsOnGround(CUR_TARG))) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 8.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(SLAM_POS, TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

}

}
