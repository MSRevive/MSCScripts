#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyIce : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_LONG;
	string ANIM_ATTACK_SHORT;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float AS_STUCK_FREQ;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int AURA_DOT;
	int AURA_RANGE;
	int AURA_TYPE;
	int DMG_LONGSLASH;
	int DMG_SLASH;
	float FREQ_MUMMY_BITE;
	float FREQ_MUMMY_BREATH_ATTACK;
	int MUMMY_BREATH_ATTACK;
	string MUMMY_BREATH_ATTACK_CLSCRIPT;
	int MUMMY_BREATH_ATTACK_OFS;
	int MUMMY_BREATH_ATTACK_RANGE;
	string MUMMY_BREATH_ATTACK_TYPE;
	int MUMMY_BREATH_CONE;
	int MUMMY_BREATH_DOT;
	float MUMMY_BREATH_DOT_DURATION;
	float MUMMY_BREATH_DURATION;
	int MUMMY_MUNCHES;
	int MUMMY_STARTING_LIVES;
	int NPC_GIVE_EXP;
	string SOUND_BREATH_LOOP;

	MummyIce()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk1";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 2000;
		ATTACK_RANGE = 140;
		ATTACK_HITRANGE = 175;
		ATTACK_MOVERANGE = 128;
		ANIM_ATTACK = "longslash";
		AS_STUCK_FREQ = 0.5;
		ANIM_ATTACK_SHORT = "slash";
		ANIM_ATTACK_LONG = "longslash";
		AURA_TYPE = 2;
		AURA_RANGE = 100;
		AURA_DOT = 25;
		ATTACK_TYPE = "long";
		ATTACK_HITCHANCE = 80;
		DMG_SLASH = 300;
		DMG_LONGSLASH = 600;
		MUMMY_STARTING_LIVES = 1;
		FREQ_MUMMY_BITE = 1.0;
		MUMMY_BREATH_ATTACK = 1;
		MUMMY_BREATH_ATTACK_TYPE = "ice";
		MUMMY_BREATH_DOT = 100;
		MUMMY_BREATH_DOT_DURATION = 10.0;
		MUMMY_BREATH_ATTACK_RANGE = 300;
		MUMMY_BREATH_ATTACK_OFS = 150;
		FREQ_MUMMY_BREATH_ATTACK = Random(20.0, 35.0);
		MUMMY_BREATH_CONE = 15;
		MUMMY_BREATH_DURATION = 8.0;
		MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_ice_breath_cl";
		SOUND_BREATH_LOOP = "ambience/steamjet1.wav";
		MUMMY_MUNCHES = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 128, 15.0);
	}

	void mummy_spawn()
	{
		SetName("Mummified Ice Lord");
		SetHealth(6000);
		SetDamageResistance("all", 0.75);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 1.75);
		SetModelBody(0, 1);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetModelBody(3, 1);
		SetProp(GetOwner(), "skin", 1);
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 128, 15.0);
	}

}

}
