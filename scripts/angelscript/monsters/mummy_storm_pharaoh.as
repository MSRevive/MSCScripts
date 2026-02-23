#pragma context server

#include "monsters/mummy_base.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class MummyStormPharaoh : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BASE_MOVESPEED;
	int FLINCH_DAMAGE_THRESHOLD;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;

	MummyStormPharaoh()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk1";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 4500;
		ATTACK_RANGE = 130;
		ATTACK_HITRANGE = 150;
		ATTACK_MOVERANGE = 100;
		ANIM_ATTACK = "stab";
		FLINCH_DAMAGE_THRESHOLD = 200;
		const float AS_STUCK_FREQ = 0.5;
		const string ANIM_ATTACK_SHORT = "steelpipe";
		const string ANIM_ATTACK_LONG = "stab";
		const string ATTACK_TYPE = "long";
		const int ATTACK_HITCHANCE = 80;
		const int DMG_STEELPIPE = 300;
		const int DMG_STAB = 800;
		const int MUMMY_STARTING_LIVES = 1;
		const int ATTACK_RANGE_SHORT = 64;
		const int ATTACK_HITRANGE_SHORT = 96;
		const int ATTACK_RANGE_LONG = 130;
		const int ATTACK_HITRANGE_LONG = 150;
		const int LIGHTNING_SHIELD = 1;
		const int LIGHTNING_SHIELD_RADIUS = 96;
		const int DMG_LIGHTNING_SHIELD = 200;
		const int LIGHTNING_SHIELD_REPELL_STRENGTH = 1000;
		const int LIGHTNING_SHIELD_V_CENTER = 36;
		const int MUMMY_BREATH_ATTACK = 1;
		const string MUMMY_BREATH_ATTACK_TYPE = "lightning";
		const int MUMMY_BREATH_DOT = 250;
		const float MUMMY_BREATH_DOT_DURATION = 10.0;
		const int MUMMY_BREATH_ATTACK_RANGE = 400;
		const int MUMMY_BREATH_ATTACK_OFS = 150;
		const int MUMMY_BREATH_CONE = 15;
		const float MUMMY_BREATH_DURATION = 8.0;
		const string MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_lightning_breath_cl";
		const int MUMMY_BEAM_ATTACK = 1;
		const int DMG_PUSH_BEAM = 100;
		const int MUMMY_DOUBLE_CYCLE = 1;
		const string MUMMY_FREQ_DOUBLE_CYCLE = Random(5.0, 10.0);
		if (StringToLower(GetMapName()) == "umulak")
		{
			NPC_IS_BOSS = 1;
		}
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 0), 128, 10.0);
	}

	void mummy_spawn()
	{
		SetName("Pharaoh of Storms");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 0.5);
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetModelBody(2, 6);
		SetModelBody(3, 0);
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 0), 128, 10.0);
		SetMoveSpeed(2.0);
		SetAnimMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
	}

	void ext_lshield_on()
	{
		string SHIELD_DURATION = param1;
		if (SHIELD_DURATION == 0)
		{
			float SHIELD_DURATION = 10.0;
		}
		npcatk_suspend_ai(SHIELD_DURATION);
		SetRoam(false);
		lshield_activate(SHIELD_DURATION);
		SetIdleAnim("crazyshit");
		SetMoveAnim("crazyshit");
		SHIELD_DURATION("ext_end_shield");
	}

	void ext_end_shield()
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_resume_ai();
		SetRoam(true);
	}

}

}
