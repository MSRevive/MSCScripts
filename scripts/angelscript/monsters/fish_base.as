#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_propelled.as"

namespace MS
{

class FishBase : CGameScript
{
	string ANIM_TURN_LEFT;
	string ANIM_TURN_RIGHT;
	int CAN_RETALIATE;
	string FISH_LASTYAW;
	string FISH_WANDER_DEST;
	string L_ANIM;
	string L_NEGATIVE;
	int NPC_MUST_SEE_TARGET;
	float RETALIATE_CHANGETARGET_CHANCE;
	int TURN_ANIM_THRESHOLD;

	FishBase()
	{
		NPC_MUST_SEE_TARGET = 0;
		ANIM_TURN_RIGHT = "rturn";
		ANIM_TURN_LEFT = "lturn";
		TURN_ANIM_THRESHOLD = 90;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(10, 25));
		if (!(IS_HUNTING))
		{
		}
		if (!(IS_FLEEING))
		{
		}
		// PlayRandomSound from: "game.sound.maxvol", SOUND_IDLE1, SOUND_IDLE2
		array<string> sounds = {"game.sound.maxvol", SOUND_IDLE1, SOUND_IDLE2};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		SetRace("wildanimal");
		SetRoam(true);
		SetHearingSensitivity(3);
		1 = float(1);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {"game.sound.maxvol", SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_targetsighted()
	{
		// TODO: roamdelay 2
		if (GetEntityRange(HUNT_LASTTARGET) < MOVE_RANGE)
		{
			SetMoveDest("none");
		}
	}

	void game_stopmoving()
	{
		FISH_LASTYAW = GetMonsterProperty("angles.yaw");
	}

	void game_movingto_dest()
	{
		if ((IS_HUNTING))
		{
			SetAngles("face.x");
		}
		if ((IS_HUNTING)) return;
		if ((IS_ATTACKING)) return;
		string L_CURRENT_YAW = GetMonsterProperty("angles.yaw");
		string L_DIFF = /* TODO: $anglediff */ $anglediff((param1).y, L_CURRENT_YAW);
		int L_NEGATIVE = 0;
		if (L_DIFF < 0)
		{
			L_NEGATIVE = 1;
			L_DIFF *= -1;
		}
		if (!(L_DIFF > TURN_ANIM_THRESHOLD)) return;
		string L_ANIM = ANIM_TURN_LEFT;
		if ((L_NEGATIVE))
		{
			L_ANIM = ANIM_TURN_RIGHT;
		}
		PlayAnim("once", L_ANIM);
	}

	void npc_wander()
	{
		SetTurnRate(".175");
		SetAngles("face.x");
		// TODO: roamdelay 0
		FISH_WANDER_DEST = GetMonsterProperty("movedest.origin");
		FISH_WANDER_DEST += Vector3(0, 0, Random(32, 256));
		SetMoveDest(FISH_WANDER_DEST);
	}

}

}
