#pragma context server

#include "ms_soccer/base_soccer.as"
#include "monsters/base_monster_new.as"

namespace MS
{

class Troll1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;

	Troll1()
	{
		ANIM_IDLE = "idle0";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		const string ANIM_KICK = "kick_ball";
		ANIM_ATTACK = "kick_ball";
		const string ANIM_SCOOP_BALL = "throw_rock";
		const string ANIM_ROUND_WIN1 = "idle2";
		const string ANIM_ROUND_WIN2 = "idle2";
		const string ANIM_ROUND_LOST1 = "idle3";
		const string ANIM_ROUND_LOST2 = "idle3";
		ATTACK_MOVERANGE = 20;
		MOVE_RANGE = 20;
		ATTACK_RANGE = 38;
		ATTACK_HITRANGE = 56;
		const string SOUND_STRUCK = "weapons/cbar_hitbod1.wav";
		const string SOUND_PAIN = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		const string SOUND_IDLE = "monsters/troll/trollidle2.wav";
		const int NPC_FIGHTS_NPCS = 1;
		const int AM_GOALIE = 1;
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
