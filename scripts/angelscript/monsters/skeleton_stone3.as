#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonStone3 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	string SET_GREEK;
	int STUN_ATTACK;
	string WAS_SLEEPING;

	SkeletonStone3()
	{
		NPC_ALLY_RESPONSE_RANGE = 6000;
		ANIM_RUN = "run";
		const int SKEL_HP = 2000;
		const float ATTACK_HITCHANCE = 0.95;
		const int ATTACK_DAMAGE_LOW = 30;
		const int ATTACK_DAMAGE_HIGH = 60;
		NPC_GIVE_EXP = 200;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 35;
		DROP_GOLD_MAX = 65;
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
		const string SOUND_STRUCK1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK2 = "weapons/axemetal2.wav";
		const string SOUND_STRUCK3 = "debris/concrete1.wav";
		const string SOUND_PUSH = "monsters/skeleton/calrain3.wav";
		const int STUN_ATK_CHANCE = 10;
		const int STONE_SKELETON = 1;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 7);
		SetModelBody(1, 7);
		SetWidth(32);
		SetHeight(80);
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
		SetName("Petrified Blademaster");
		SetRoam(true);
		SetBloodType("none");
		SetDamageResistance("all", ".6");
		ANIM_ATTACK = "attack3";
		SetHearingSensitivity(3);
	}

	void attack_1()
	{
		STUN_ATTACK = 1;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack3";
	}

	void attack_3()
	{
		STUN_ATTACK = 0;
		attack_snd();
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		if (!(RandomInt(1, 100) < STUN_ATK_CHANCE)) return;
		ANIM_ATTACK = "attack1";
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(STUN_ATTACK)) return;
		EmitSound(GetOwner(), 0, SOUND_PUSH, 10);
		ApplyEffect(param2, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
		STUN_ATTACK = 0;
	}

}

}
