#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Guard : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int GORE_DAMAGE;
	int IS_FLEEING;
	int MY_ENEMY;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_PAIN;
	string SOUND_PAIN2;

	Guard()
	{
		SOUND_PAIN = "player/chesthit1.wav";
		SOUND_PAIN2 = "player/armhit1.wav";
		SOUND_ATTACK1 = "npc/prepdie1.wav";
		SOUND_ATTACK2 = "monsters/sludge/null.wav";
		SOUND_ATTACK3 = "monsters/sludge/null.wav";
		SOUND_DEATH = "player/stomachhit1.wav";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 140;
		ATTACK_HITCHANCE = 0.8;
		GORE_DAMAGE = 9;
		FLEE_HEALTH = 10;
		FLEE_CHANCE = 0.25;
		IS_FLEEING = 0;
		MY_ENEMY = 0;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 1;
		DROP_GOLD_MAX = 20;
	}

	void OnSpawn() override
	{
		SetHealth(100);
		SetWidth(32);
		SetHeight(72);
		SetRace("rogue");
		SetName("Renegade Guard");
		SetRoam(true);
		SetHearingSensitivity(4);
		SetDamageResistance("all", ".8");
		SetSkillLevel(35);
		SetModel("npc/guard1.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		SetActionAnim("swordswing1_L");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, GORE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

}

}
