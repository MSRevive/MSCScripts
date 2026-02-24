#pragma context server

#include "ms_soccer/base_soccer.as"
#include "monsters/base_monster_new.as"

namespace MS
{

class Troll1 : CGameScript
{
	int AM_GOALIE;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_KICK;
	string ANIM_ROUND_LOST1;
	string ANIM_ROUND_LOST2;
	string ANIM_ROUND_WIN1;
	string ANIM_ROUND_WIN2;
	string ANIM_RUN;
	string ANIM_SCOOP_BALL;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	int NPC_FIGHTS_NPCS;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_STRUCK;
	string SOUND_WALK1;
	string SOUND_WALK2;

	Troll1()
	{
		ANIM_IDLE = "idle0";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_KICK = "kick_ball";
		ANIM_ATTACK = "kick_ball";
		ANIM_SCOOP_BALL = "throw_rock";
		ANIM_ROUND_WIN1 = "idle2";
		ANIM_ROUND_WIN2 = "idle2";
		ANIM_ROUND_LOST1 = "idle3";
		ANIM_ROUND_LOST2 = "idle3";
		ATTACK_MOVERANGE = 20;
		MOVE_RANGE = 20;
		ATTACK_RANGE = 38;
		ATTACK_HITRANGE = 56;
		SOUND_STRUCK = "weapons/cbar_hitbod1.wav";
		SOUND_PAIN = "monsters/troll/trollpain.wav";
		SOUND_ATTACK = "monsters/troll/trollattack.wav";
		SOUND_DEATH = "monsters/troll/trolldeath.wav";
		SOUND_WALK1 = "monsters/troll/step1.wav";
		SOUND_WALK2 = "monsters/troll/step2.wav";
		SOUND_IDLE = "monsters/troll/trollidle2.wav";
		NPC_FIGHTS_NPCS = 1;
		AM_GOALIE = 1;
	}

	void OnSpawn() override
	{
		SetName("Soccer Troll");
		SetModel("soccer/soccer_troll.mdl");
		SetWidth(72);
		SetHeight(100);
		SetHealth(1000);
		SetRace("human");
		SetRoam(false);
		SetHearingSensitivity(0);
	}

	void frame_kick_land()
	{
		soc_kickball();
	}

	void rock_pickup()
	{
		soc_ball_scoop();
	}

	void rock_throw()
	{
		soc_ball_release();
	}

}

}
