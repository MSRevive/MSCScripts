#pragma context server

#include "monsters/swamp_ogre.as"

namespace MS
{

class OgreStone : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_HEADBUTT;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LEAP;
	string ANIM_RUN;
	string ANIM_RUN_DEFAULT;
	string ANIM_SEARCH;
	string ANIM_SWIPE;
	string ANIM_WALK;
	string ANIM_WALK_DEFAULT;
	string ANIM_WARCRY;
	float ATTACK_HITCHANCE;
	int CAN_FLINCH;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	float HEADBUTT_CHANCE;
	int HEADBUTT_DAMAGE;
	float HEADBUTT_FREQ;
	int LEAP_AWAY_INTERVAL;
	int LEAP_DAMAGE;
	int LEAP_RANGE_TOOCLOSE;
	int LEAP_RANGE_TOOFAR;
	float LEAP_STUNCHANCE;
	string MONSTER_MODEL;
	int NEXT_LEAP_AWAY;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	float ORC_HOP_DELAY;
	int ORC_JUMP_THRESH;
	int RUN_STEP;
	string SOUND_DEATH;
	string SOUND_FLINCH;
	string SOUND_HEADBUTT;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_IDLE4;
	string SOUND_IDLE5;
	string SOUND_LEAP;
	string SOUND_LEAP_LAND;
	string SOUND_PAIN_STRONG;
	string SOUND_PAIN_WEAK;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWIPEHIT1;
	string SOUND_SWIPEHIT2;
	string SOUND_SWIPEMISS1;
	string SOUND_SWIPEMISS2;
	string SOUND_WARCRY;
	int SWIPE_DAMAGE;
	int WEAK_THRESHOLD;

	OgreStone()
	{
		ORC_HOP_DELAY = 1.0;
		ORC_JUMP_THRESH = 80;
		NPC_GIVE_EXP = 2000;
		if (StringToLower(GetMapName()) == "phlames")
		{
			NPC_GIVE_EXP = 3000;
		}
		ANIM_SEARCH = "idle_look";
		ANIM_IDLE = "idle1";
		ANIM_SWIPE = "attack1";
		ANIM_HEADBUTT = "attack2";
		ANIM_JUMP = "jump";
		ANIM_LEAP = "jump";
		ANIM_WALK_DEFAULT = "walk";
		ANIM_RUN_DEFAULT = "run1";
		ANIM_DEATH = "dieforward";
		ANIM_WARCRY = "warcry";
		ANIM_FLINCH = "bigflinch";
		ANIM_WALK = ANIM_WALK_DEFAULT;
		ANIM_RUN = ANIM_RUN_DEFAULT;
		ANIM_ATTACK = ANIM_SWIPE;
		SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		SOUND_IDLE2 = "bullchicken/bc_idle2.wav";
		SOUND_IDLE3 = "bullchicken/bc_idle3.wav";
		SOUND_IDLE4 = "bullchicken/bc_idle4.wav";
		SOUND_IDLE5 = "bullchicken/bc_idle5.wav";
		SOUND_DEATH = "bullchicken/bc_die1.wav";
		SOUND_HEADBUTT = "bullchicken/bc_spithit1.wav";
		SOUND_SWIPEHIT1 = "zombie/claw_strike1.wav";
		SOUND_SWIPEHIT2 = "zombie/claw_strike2.wav";
		SOUND_SWIPEMISS1 = "zombie/claw_miss1.wav";
		SOUND_SWIPEMISS2 = "zombie/claw_miss2.wav";
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STEP1 = "player/pl_dirt1.wav";
		SOUND_STEP2 = "player/pl_dirt2.wav";
		SOUND_PAIN_WEAK = "debris/concrete1.wav";
		SOUND_PAIN_STRONG = "debris/concrete1.wav";
		SOUND_WARCRY = "bullchicken/bc_attackgrowl3.wav";
		SOUND_LEAP = "bullchicken/bc_attackgrowl2.wav";
		SOUND_LEAP_LAND = "weapons/g_bounce2.wav";
		SOUND_FLINCH = "bullchicken/bc_pain3.wav";
		Precache(SOUND_DEATH);
		WEAK_THRESHOLD = 1000;
		SWIPE_DAMAGE = "$rand(75,125)";
		HEADBUTT_CHANCE = 1.0;
		HEADBUTT_FREQ = 7.0;
		HEADBUTT_DAMAGE = "$rand(50,100)";
		LEAP_DAMAGE = "$rand(10,60)";
		LEAP_STUNCHANCE = 0.3;
		LEAP_RANGE_TOOFAR = 512;
		LEAP_RANGE_TOOCLOSE = 128;
		LEAP_AWAY_INTERVAL = 500;
		NEXT_LEAP_AWAY = 1800;
		NPC_BASE_EXP = 700;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 100;
		DROP_GOLD_MAX = 250;
		ATTACK_HITCHANCE = 0.95;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 0.2;
		FLINCH_DELAY = 10.0;
		FLINCH_HEALTH = 1500;
		MONSTER_MODEL = "monsters/swamp_ogre.mdl";
	}

	void OnSpawn() override
	{
		SetName("Stone Ogre");
		SetHealth(4000);
		SetRoam(true);
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetMoveAnim(ANIM_WALK);
		SetHeight(64);
		SetWidth(32);
		SetHearingSensitivity(8);
		SetIdleAnim(ANIM_IDLE);
		SetProp(GetOwner(), "skin", 2);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		RUN_STEP = 0;
		ScheduleDelayedEvent(1.0, "idle_sounds");
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 2.0);
	}

}

}
