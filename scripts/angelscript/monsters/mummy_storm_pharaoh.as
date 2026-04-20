#pragma context server

#include "monsters/mummy_base.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class MummyStormPharaoh : CGameScript
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
	int ATTACK_HITRANGE_LONG;
	int ATTACK_HITRANGE_SHORT;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int ATTACK_RANGE_LONG;
	int ATTACK_RANGE_SHORT;
	string ATTACK_TYPE;
	float BASE_MOVESPEED;
	int DMG_LIGHTNING_SHIELD;
	int DMG_PUSH_BEAM;
	int DMG_STAB;
	int DMG_STEELPIPE;
	int FLINCH_DAMAGE_THRESHOLD;
	int LIGHTNING_SHIELD;
	int LIGHTNING_SHIELD_RADIUS;
	int LIGHTNING_SHIELD_REPELL_STRENGTH;
	int LIGHTNING_SHIELD_V_CENTER;
	int MUMMY_BEAM_ATTACK;
	int MUMMY_BREATH_ATTACK;
	string MUMMY_BREATH_ATTACK_CLSCRIPT;
	int MUMMY_BREATH_ATTACK_OFS;
	int MUMMY_BREATH_ATTACK_RANGE;
	string MUMMY_BREATH_ATTACK_TYPE;
	int MUMMY_BREATH_CONE;
	int MUMMY_BREATH_DOT;
	float MUMMY_BREATH_DOT_DURATION;
	float MUMMY_BREATH_DURATION;
	int MUMMY_DOUBLE_CYCLE;
	float MUMMY_FREQ_DOUBLE_CYCLE;
	int MUMMY_STARTING_LIVES;
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
		AS_STUCK_FREQ = 0.5;
		ANIM_ATTACK_SHORT = "steelpipe";
		ANIM_ATTACK_LONG = "stab";
		ATTACK_TYPE = "long";
		ATTACK_HITCHANCE = 80;
		DMG_STEELPIPE = 300;
		DMG_STAB = 800;
		MUMMY_STARTING_LIVES = 1;
		ATTACK_RANGE_SHORT = 64;
		ATTACK_HITRANGE_SHORT = 96;
		ATTACK_RANGE_LONG = 130;
		ATTACK_HITRANGE_LONG = 150;
		LIGHTNING_SHIELD = 1;
		LIGHTNING_SHIELD_RADIUS = 96;
		DMG_LIGHTNING_SHIELD = 200;
		LIGHTNING_SHIELD_REPELL_STRENGTH = 1000;
		LIGHTNING_SHIELD_V_CENTER = 36;
		MUMMY_BREATH_ATTACK = 1;
		MUMMY_BREATH_ATTACK_TYPE = "lightning";
		MUMMY_BREATH_DOT = 250;
		MUMMY_BREATH_DOT_DURATION = 10.0;
		MUMMY_BREATH_ATTACK_RANGE = 400;
		MUMMY_BREATH_ATTACK_OFS = 150;
		MUMMY_BREATH_CONE = 15;
		MUMMY_BREATH_DURATION = 8.0;
		MUMMY_BREATH_ATTACK_CLSCRIPT = "monsters/mummy_lightning_breath_cl";
		MUMMY_BEAM_ATTACK = 1;
		DMG_PUSH_BEAM = 100;
		MUMMY_DOUBLE_CYCLE = 1;
		MUMMY_FREQ_DOUBLE_CYCLE = Random(5.0, 10.0);
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
