#pragma context server

#include "monsters/swamp_reaver.as"

namespace MS
{

class CorruptedReaver : CGameScript
{
	string BREATH_TYPE;
	string DOT_ACID_BOMB;
	string DOT_DMG;
	string DOT_DURATION;
	string DOT_EFFECT;
	string EFFECT_ACID_BOMB;
	string ERRUPT_TYPE;
	string MIX_COUNT;
	string PROJECTILE_SCRIPT;

	CorruptedReaver()
	{
		const string REAVER_NAME = "Corrupted Reaver";
		const int REAVER_MAXHP = 5000;
		const int REAVER_XP = 3750;
		const int REAVER_SKIN = 2;
		const string REAVER_MODEL = "monsters/firereaver2.mdl";
		const int REAVER_WIDTH = 90;
		const int REAVER_HEIGHT = 72;
		const string FIREBALL1_SCRIPT = "monsters/summon/fire_ball_guided";
		const string FIREBALL2_SCRIPT = "monsters/summon/acid_ball_guided";
		const float FIREBALL1_DURATION = 15.0;
		const float FIREBALL2_DURATION = 8.0;
		const int MIXED_REAVER = 1;
	}

	void game_precache()
	{
		Precache("monsters/summon/fire_ball_guided");
		Precache("monsters/summon/acid_ball_guided");
		Precache("effects/sfx_acid_splash");
		Precache("xfireball3.spr");
	}

	void mixed_reaver_switch()
	{
		MIX_COUNT += 1;
		if (MIX_COUNT == 1)
		{
			DOT_EFFECT = "effects/dot_fire";
			DOT_DURATION = 5.0;
			DOT_DMG = 60.0;
			ERRUPT_TYPE = "fire";
			BREATH_TYPE = "fire";
			PROJECTILE_SCRIPT = "proj_fire_bomb";
			DOT_ACID_BOMB = 200;
			EFFECT_ACID_BOMB = "effects/dot_fire";
			SetBloodType("red");
		}
		if (MIX_COUNT == 2)
		{
			DOT_EFFECT = "effects/dot_poison";
			DOT_DURATION = 10.0;
			DOT_DMG = 30.0;
			ERRUPT_TYPE = "poison";
			BREATH_TYPE = "poison";
			PROJECTILE_SCRIPT = "proj_acid_bomb";
			DOT_ACID_BOMB = 150;
			EFFECT_ACID_BOMB = "effects/dot_acid";
			SetBloodType("green");
			MIX_COUNT = 0;
		}
	}

	void reaver_immunes()
	{
		SetDamageResistance("lightning", 1.25);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 0.5);
	}

}

}
