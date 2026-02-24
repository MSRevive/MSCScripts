#pragma context server

#include "monsters/mummy_base.as"

namespace MS
{

class MummyNecro : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int AURA_TYPE;
	int DMG_AURA;
	int DMG_STEELPIPE;
	int FLINCH_DAMAGE_THRESHOLD;
	float FLINCH_HEALTH_RATIO;
	float FREQ_MUMMY_SUMMON;
	int MUMMY_IS_NECRO;
	string MUMMY_MELEE_DMG_TYPE;
	int MUMMY_STARTING_LIVES;
	float MUMMY_STUN_CHANCE;
	string MUMMY_SUMMON_SCRIPT;
	int NPC_GIVE_EXP;

	MummyNecro()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk2";
		ANIM_IDLE = "idle1";
		NPC_GIVE_EXP = 1000;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 96;
		ATTACK_MOVERANGE = 80;
		ANIM_ATTACK = "steelpipe";
		FLINCH_DAMAGE_THRESHOLD = 50;
		FLINCH_HEALTH_RATIO = 0.75;
		AURA_TYPE = 3;
		ATTACK_TYPE = "melee";
		ATTACK_HITCHANCE = 80;
		DMG_STEELPIPE = 400;
		MUMMY_STARTING_LIVES = 1;
		MUMMY_MELEE_DMG_TYPE = "blunt";
		MUMMY_IS_NECRO = 1;
		MUMMY_STUN_CHANCE = 0.2;
		DMG_AURA = 100;
		FREQ_MUMMY_SUMMON = 15.0;
		MUMMY_SUMMON_SCRIPT = "monsters/wraith_summoned";
	}

	void game_precache()
	{
		Precache("monsters/wraith_summoned");
	}

	void mummy_spawn()
	{
		SetName("Mummified Necromonger");
		SetHealth(7000);
		SetDamageResistance("holy", 1.5);
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 4);
		SetModelBody(3, 2);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal("all", "ext_master_died", GetEntityIndex(GetOwner()));
	}

}

}
