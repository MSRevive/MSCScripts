#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyCursed : CGameScript
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
	int AURA_RANGE;
	int AURA_TYPE;
	int DMG_LONGSLASH;
	int DMG_SLASH;
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
	int MUMMY_STARTING_LIVES;
	int NPC_GIVE_EXP;

	MummyCursed()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk1";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 500;
		ATTACK_RANGE = 140;
		ATTACK_HITRANGE = 175;
		ATTACK_MOVERANGE = 128;
		ANIM_ATTACK = "longslash";
		AS_STUCK_FREQ = 0.5;
		ANIM_ATTACK_SHORT = "slash";
		ANIM_ATTACK_LONG = "longslash";
		AURA_TYPE = 1;
		AURA_RANGE = 100;
		ATTACK_TYPE = "long";
		ATTACK_HITCHANCE = 80;
		DMG_SLASH = 200;
		DMG_LONGSLASH = 400;
		MUMMY_STARTING_LIVES = 1;
		MUMMY_BREATH_ATTACK = 1;
		MUMMY_BREATH_ATTACK_TYPE = "bile";
		MUMMY_BREATH_DOT = 50;
		MUMMY_BREATH_DOT_DURATION = 10.0;
		MUMMY_BREATH_ATTACK_RANGE = 250;
		MUMMY_BREATH_ATTACK_OFS = 125;
		FREQ_MUMMY_BREATH_ATTACK = Random(20.0, 35.0);
		MUMMY_BREATH_CONE = 30;
		MUMMY_BREATH_DURATION = 4.0;
		MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_bile_attack_cl";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 128, 15.0);
	}

	void mummy_spawn()
	{
		SetName("Cursed Crypt Fiend");
		SetHealth(2000);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetModelBody(3, 1);
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 128, 15.0);
	}

}

}
