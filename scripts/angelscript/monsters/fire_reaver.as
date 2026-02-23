#pragma context server

#include "monsters/swamp_reaver.as"

namespace MS
{

class FireReaver : CGameScript
{
	string BREATH_TYPE;
	int DOT_ACID_BOMB;
	float DOT_DMG;
	float DOT_DURATION;
	string DOT_EFFECT;
	string EFFECT_ACID_BOMB;
	string ERRUPT_TYPE;
	string PROJECTILE_SCRIPT;

	FireReaver()
	{
		const string REAVER_NAME = "Fire Reaver";
		const int REAVER_MAXHP = 4000;
		const int REAVER_XP = 1500;
		const int REAVER_SKIN = 0;
		const float FREQ_ERRUPT = 20.0;
		const string BLOOD_COLOR = "red";
		const string FIREBALL1_SCRIPT = "monsters/summon/fire_ball_guided";
		const string FIREBALL2_SCRIPT = "monsters/summon/fire_ball_guided";
		const float FIREBALL1_DURATION = 15.0;
		const float FIREBALL2_DURATION = 15.0;
		const string BOMB_DMG_TYPE = "blunt";
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
