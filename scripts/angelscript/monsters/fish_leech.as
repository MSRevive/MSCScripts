#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_propelled.as"

namespace MS
{

class FishLeech : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_RETALIATE;
	string FISH_LASTYAW;
	int HUNT_AGRO;
	string L_ANIM;
	string L_NEGATIVE;
	int MOVE_RANGE;
	int NO_STUCK_CHECKS;
	int NPC_EXTRA_VALIDATIONS;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int TARGET_INVALID;

	FishLeech()
	{
		NPC_EXTRA_VALIDATIONS = 1;
		NO_STUCK_CHECKS = 1;
		const int DELETE_ON_DEATH = 1;
		ANIM_IDLE = "swim";
		ANIM_WALK = "swim";
		ANIM_RUN = "swim2";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		const string SOUND_IDLE1 = "none";
		const string SOUND_IDLE2 = "none";
		const string SOUND_ATTACK1 = "leech/leech_bite1.wav";
		const string SOUND_ATTACK2 = "leech/leech_bite2.wav";
		const string SOUND_STRUCK1 = "leech/leech_alert2.wav";
		const string SOUND_STRUCK2 = "leech/leech_alert1.wav";
		const string SOUND_STRUCK3 = "leech/leech_alert2.wav";
		const string SOUND_STRUCK4 = "leech/leech_alert1.wav";
		const string SOUND_STRUCK5 = "leech/leech_alert2.wav";
		const string SOUND_DEATH = "none";
		MOVE_RANGE = 40;
		ATTACK_RANGE = 65;
		ATTACK_HITRANGE = 80;
		const float ATTACK_HITCHANCE = 0.8;
		CAN_HEAR = 1;
		HUNT_AGRO = 1;
		CAN_FLINCH = 0;
		NPC_HACKED_MOVE_SPEED = 100;
		NPC_GIVE_EXP = 1;
		const float ATK_DMG_LOW = 0.2;
		const float ATK_DMG_HIGH = 0.8;
		const string ANIM_TURN_RIGHT = "leftturn";
		const string ANIM_TURN_LEFT = "rightturn";
		const int TURN_ANIM_THRESHOLD = 90;
		CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
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
		SetHealth(5);
		SetName("Leech");
		SetHearingSensitivity(2);
		SetGravity(0.02);
		SetModel("monsters/leech.mdl");
		SetBBox(Vector3(-5, -5, -5), Vector3(5, 5, 5));
		SetRace("wildanimal");
		SetRoam(true);
		SetHearingSensitivity(3);
		1 = float(1);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void OnPostSpawn() override
	{
		if (!((StringToLower(GetMapName())).findFirst("lostcastle") == 0)) return;
		NPC_EXTRA_VALIDATIONS = 0;
	}

	void bite()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {"game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(ATK_DMG_LOW, ATK_DMG_HIGH), ATTACK_HITCHANCE, "slash");
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
		if ((CanSee(NPC_MOVE_TARGET, ATTACK_RANGE)))
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
	}

	void npc_targetvalidate()
	{
		if (!(IsInWater(param1) == 0)) return;
		TARGET_INVALID = 1;
	}

}

}
