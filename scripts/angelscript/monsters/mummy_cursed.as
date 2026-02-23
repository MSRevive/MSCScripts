#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyCursed : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
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
		const float AS_STUCK_FREQ = 0.5;
		const string ANIM_ATTACK_SHORT = "slash";
		const string ANIM_ATTACK_LONG = "longslash";
		const int AURA_TYPE = 1;
		const int AURA_RANGE = 100;
		const string ATTACK_TYPE = "long";
		const int ATTACK_HITCHANCE = 80;
		const int DMG_SLASH = 200;
		const int DMG_LONGSLASH = 400;
		const int MUMMY_STARTING_LIVES = 1;
		const int MUMMY_BREATH_ATTACK = 1;
		const string MUMMY_BREATH_ATTACK_TYPE = "bile";
		const int MUMMY_BREATH_DOT = 50;
		const float MUMMY_BREATH_DOT_DURATION = 10.0;
		const int MUMMY_BREATH_ATTACK_RANGE = 250;
		const int MUMMY_BREATH_ATTACK_OFS = 125;
		const string FREQ_MUMMY_BREATH_ATTACK = Random(20.0, 35.0);
		const int MUMMY_BREATH_CONE = 30;
		const float MUMMY_BREATH_DURATION = 4.0;
		const string MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_bile_attack_cl";
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
