#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonStone1 : CGameScript
{
	string ANIM_RUN;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	string SET_GREEK;
	string WAS_SLEEPING;

	SkeletonStone1()
	{
		ANIM_RUN = "run";
		const int SKEL_HP = 500;
		const float ATTACK_HITCHANCE = 0.85;
		const int ATTACK_DAMAGE_LOW = 8;
		const int ATTACK_DAMAGE_HIGH = 13;
		NPC_GIVE_EXP = 100;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 25;
		DROP_GOLD_MAX = 35;
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
		const string SOUND_STRUCK1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK2 = "weapons/axemetal2.wav";
		const string SOUND_STRUCK3 = "debris/concrete1.wav";
		const int STONE_SKELETON = 1;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 7);
		SetModelBody(1, 4);
		SetWidth(32);
		SetHeight(80);
		SetStat("parry", 110);
		if (!(SLEEPER))
		{
			animate_stone();
		}
		if ((SLEEPER))
		{
			SetInvincible(true);
			WAS_SLEEPING = 1;
			npcatk_suspend_ai();
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_IDLE);
			SetAnimFrameRate(0.0);
		}
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
	}

	void animate_stone()
	{
		SetName("Petrified Paladin");
		SetRoam(true);
		SetBloodType("none");
		SetDamageResistance("all", ".6");
		SetHearingSensitivity(3);
	}

}

}
