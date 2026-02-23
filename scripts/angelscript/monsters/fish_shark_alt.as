#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"
#include "monsters/base_fish2.as"

namespace MS
{

class FishSharkAlt : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HEAR;
	float FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string PUSH_VEL;

	FishSharkAlt()
	{
		const int DELETE_ON_DEATH = 1;
		ANIM_IDLE = "idle";
		ANIM_WALK = "swim";
		ANIM_RUN = "thrust";
		ANIM_DEATH = "die1";
		const string ANIM_ATK_BIG = "srattack1";
		const string ANIM_ATK_RIGHT = "bite_r";
		const string ANIM_ATK_LEFT = "bite_l";
		ANIM_FLINCH = "bgflinch";
		const string SOUND_IDLE1 = "ichy/ichy_idle1.wav";
		const string SOUND_IDLE2 = "ichy/ichy_idle2.wav";
		const string SOUND_ATTACK1 = "ichy/ichy_bite1.wav";
		const string SOUND_ATTACK2 = "ichy/ichy_bite2.wav";
		const string SOUND_STRUCK1 = "ichy/ichy_pain2.wav";
		const string SOUND_STRUCK2 = "ichy/ichy_pain3.wav";
		const string SOUND_STRUCK3 = "ichy/ichy_pain5.wav";
		const string SOUND_STRUCK4 = "ichy/ichy_pain3.wav";
		const string SOUND_STRUCK5 = "ichy/ichy_pain5.wav";
		const string SOUND_DEATH = "ichy/ichy_die2.wav";
		ATTACK_MOVERANGE = 32;
		ATTACK_RANGE = 120;
		ATTACK_HITRANGE = 150;
		const float ATTACK_HITCHANCE = 0.75;
		CAN_HEAR = 1;
		HUNT_AGRO = 1;
		CAN_FLINCH = 1;
		FLINCH_ANIM = 0.15;
		FLINCH_CHANCE = 0.9;
		FLINCH_DELAY = 4;
		NPC_HACKED_MOVE_SPEED = 250;
		NPC_GIVE_EXP = 12;
		const float ATK_DMG_LOW = 5.0;
		const float ATK_DMG_HIGH = 10.0;
	}

	void OnSpawn() override
	{
		SetHealth(50);
		SetWidth(64);
		SetHeight(32);
		SetName("Shark");
		SetHearingSensitivity(10);
		SetRoam(true);
		SetRace("wildanimal");
		SetModel("monsters/shark1.mdl");
	}

	void npc_selectattack()
	{
		string NEXT_ATTACK = RandomInt(0, 2);
		if (NEXT_ATTACK == 0)
		{
			ANIM_ATTACK = ANIM_ATK_BIG;
		}
		else
		{
			if (NEXT_ATTACK == 1)
			{
				ANIM_ATTACK = ANIM_ATK_LEFT;
			}
			else
			{
				if (NEXT_ATTACK == 2)
				{
					ANIM_ATTACK = ANIM_ATK_RIGHT;
				}
			}
		}
	}

	void frame_attack()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {"game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(ATK_DMG_LOW, ATK_DMG_HIGH), ATTACK_HITCHANCE, "slash");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		Vector3 PUSH_VEL = Vector3(0, 0, 0);
		if (ANIM_ATTACK == ANIM_ATK_BIG)
		{
			PUSH_VEL = /* TODO: $relvel */ $relvel(0, 200, 0);
		}
		else
		{
			if (ANIM_ATTACK == ANIM_ATK_LEFT)
			{
				PUSH_VEL = /* TODO: $relvel */ $relvel(-100, 100, 0);
			}
			else
			{
				if (ANIM_ATTACK == ANIM_ATK_RIGHT)
				{
					PUSH_VEL = /* TODO: $relvel */ $relvel(100, 100, 0);
				}
			}
		}
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

	void OnFlinch()
	{
		PlayAnim("critical", ANIM_FLINCH);
	}

}

}
