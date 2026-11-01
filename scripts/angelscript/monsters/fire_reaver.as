#pragma context server

#include "monsters/swamp_reaver.as"

namespace MS
{

class FireReaver : CGameScript
{
	string BLOOD_COLOR;
	string BOMB_DMG_TYPE;
	string BREATH_TYPE;
	int DOT_ACID_BOMB;
	float DOT_DMG;
	float DOT_DURATION;
	string DOT_EFFECT;
	string EFFECT_ACID_BOMB;
	string ERRUPT_TYPE;
	float FIREBALL1_DURATION;
	string FIREBALL1_SCRIPT;
	float FIREBALL2_DURATION;
	string FIREBALL2_SCRIPT;
	float FREQ_ERRUPT;
	string PROJECTILE_SCRIPT;
	int REAVER_MAXHP;
	string REAVER_NAME;
	int REAVER_SKIN;
	int REAVER_XP;

	FireReaver()
	{
		REAVER_NAME = "Fire Reaver";
		REAVER_MAXHP = 4000;
		REAVER_XP = 1500;
		REAVER_SKIN = 0;
		FREQ_ERRUPT = 20.0;
		BLOOD_COLOR = "red";
		FIREBALL1_SCRIPT = "monsters/summon/fire_ball_guided";
		FIREBALL2_SCRIPT = "monsters/summon/fire_ball_guided";
		FIREBALL1_DURATION = 15.0;
		FIREBALL2_DURATION = 15.0;
		BOMB_DMG_TYPE = "blunt";
	}

	void game_precache()
	{
		Precache("monsters/summon/fire_ball_guided");
		Precache("xfireball3.spr");
	}

	void OnPostSpawn() override
	{
		DOT_EFFECT = "effects/dot_fire";
		DOT_DURATION = 5.0;
		DOT_DMG = 45.0;
		ERRUPT_TYPE = "fire";
		BREATH_TYPE = "fire";
		PROJECTILE_SCRIPT = "proj_fire_bomb";
		DOT_ACID_BOMB = 200;
		EFFECT_ACID_BOMB = "effects/dot_fire";
	}

}

}
