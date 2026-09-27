#pragma context server

#include "monsters/swamp_ogre.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class OgreIce : CGameScript
{
	string ANIM_ATTACK;
	float CHANCE_FREEZE;
	int DOT_FREEZE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int FLINCH_HEALTH;
	int HEADBUTT_DAMAGE;
	string HEADBUTT_ON;
	int LEAP_DAMAGE;
	int NPC_BASE_EXP;
	int RUN_STEP;
	string SOUND_DEATH;
	string SOUND_FREEZE;
	int SWIPE_ATTACK;
	int SWIPE_DAMAGE;
	int WEAK_THRESHOLD;

	OgreIce()
	{
		NPC_BASE_EXP = 450;
		SOUND_DEATH = "bullchicken/bc_die1.wav";
		Precache(SOUND_DEATH);
		WEAK_THRESHOLD = 1500;
		SWIPE_DAMAGE = "$rand(50,90)";
		HEADBUTT_DAMAGE = "$rand(50,90)";
		LEAP_DAMAGE = "$rand(20,40)";
		CHANCE_FREEZE = 0.25;
		DOT_FREEZE = 30;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 40;
		DROP_GOLD_MAX = 60;
		FLINCH_HEALTH = 2000;
		SOUND_FREEZE = "magic/frost_reverse.wav";
	}

	void OnSpawn() override
	{
		SetName("Marogar Ogre");
		SetHealth(2500);
		SetDamageResistance("all", 0.5);
		SetRace("demon");
		SetRoam(true);
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(2);
		SetBloodType("green");
		SetIdleAnim(ANIM_IDLE);
		RUN_STEP = 0;
		SetProp(GetOwner(), "skin", 1);
		ScheduleDelayedEvent(1.0, "idle_sounds");
	}

	void game_dodamage()
	{
		if ((HEADBUTT_ON))
		{
			if ((param1))
			{
				EmitSound(GetOwner(), 0, SOUND_HEADBUTT, 10);
				ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
			if (!(param1))
			{
				// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
				array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			ANIM_ATTACK = ANIM_SWIPE;
			HEADBUTT_ON = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SWIPE_ATTACK)) return;
		SWIPE_ATTACK = 0;
		if ((param1))
		{
			// PlayRandomSound from: SOUND_SWIPEHIT1, SOUND_SWIPEHIT2
			array<string> sounds = {SOUND_SWIPEHIT1, SOUND_SWIPEHIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(-100, 130, 120));
			if (RandomInt(1, 100) < CHANCE_FREEZE)
			{
			}
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_FREEZE);
			EmitSound(GetOwner(), 0, SOUND_FREEZE, 10);
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_SWIPEMISS1, SOUND_SWIPEMISS2
			array<string> sounds = {SOUND_SWIPEMISS1, SOUND_SWIPEMISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

}

}
