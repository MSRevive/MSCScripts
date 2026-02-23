#pragma context server

#include "monsters/skeleton_base.as"
#include "monsters/base_propelled.as"

namespace MS
{

class SkeletonCrystal1 : CGameScript
{
	int AM_FADING;
	string ANIM_RUN;
	string ANIM_WALK;
	int FADE_COUNT;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string SINK_ORIGIN;

	SkeletonCrystal1()
	{
		ANIM_RUN = "idle1";
		ANIM_WALK = "idle1";
		NPC_HACKED_MOVE_SPEED = 150;
		const int SKEL_HP = 1;
		const float ATTACK_HITCHANCE = 0.8;
		const int ATTACK_DAMAGE_LOW = 10;
		const int ATTACK_DAMAGE_HIGH = 20;
		NPC_GIVE_EXP = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.7);
		if (!(AM_FADING))
		{
		}
		EmitSound(GetOwner(), 0, "magic/pulsemachine_noloop.wav", 5);
	}

	void skeleton_spawn()
	{
		SetName("Crystalline Skeleton");
		SetRoam(true);
		SetHearingSensitivity(8);
		SetModel("monsters/skeleton_boss1.mdl");
		SetInvincible(true);
		SetModelBody(0, 8);
	}

	void ext_crystal_remove()
	{
		AM_FADING = 1;
		NPC_HACKED_MOVE_SPEED = 0;
		SINK_ORIGIN = GetMonsterProperty("origin");
		SetSolid("none");
		npcatk_suspend_ai();
		game_stopmoving();
		SetMoveAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_IDLE);
		FADE_COUNT = 255;
		fade_out();
	}

	void fade_out()
	{
		FADE_COUNT -= 5;
		SINK_ORIGIN += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, -1.5));
		SetEntityOrigin(GetOwner(), SINK_ORIGIN);
		if (FADE_COUNT <= 0)
		{
			tele_out();
		}
		if (!(FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "fade_out");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", FADE_COUNT);
	}

	void tele_out()
	{
		SetEntityOrigin(GetOwner(), Vector3(20000, 10000, 20000));
		SetInvincible(false);
		ScheduleDelayedEvent(0.1, "npc_suicide");
	}

}

}
