#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyIce : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int NPC_GIVE_EXP;

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
		const float AS_STUCK_FREQ = 0.5;
		const string ANIM_ATTACK_SHORT = "slash";
		const string ANIM_ATTACK_LONG = "longslash";
		const int AURA_TYPE = 2;
		const int AURA_RANGE = 100;
		const int AURA_DOT = 25;
		const string ATTACK_TYPE = "long";
		const int ATTACK_HITCHANCE = 80;
		const int DMG_SLASH = 300;
		const int DMG_LONGSLASH = 600;
		const int MUMMY_STARTING_LIVES = 1;
		const float FREQ_MUMMY_BITE = 1.0;
		const int MUMMY_BREATH_ATTACK = 1;
		const string MUMMY_BREATH_ATTACK_TYPE = "ice";
		const int MUMMY_BREATH_DOT = 100;
		const float MUMMY_BREATH_DOT_DURATION = 10.0;
		const int MUMMY_BREATH_ATTACK_RANGE = 300;
		const int MUMMY_BREATH_ATTACK_OFS = 150;
		const string FREQ_MUMMY_BREATH_ATTACK = Random(20.0, 35.0);
		const int MUMMY_BREATH_CONE = 15;
		const float MUMMY_BREATH_DURATION = 8.0;
		const string MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_ice_breath_cl";
		const string SOUND_BREATH_LOOP = "ambience/steamjet1.wav";
		const int MUMMY_MUNCHES = 1;
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
