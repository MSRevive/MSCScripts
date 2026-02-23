#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjSnowBall : CGameScript
{
	string EFFECT_DURATION;

	ProjSnowBall()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 2;
		const string PROJ_ANIM_IDLE = "idle_iceball";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "cold";
		const int PROJ_DAMAGE = 100;
		const int PROJ_AOE_RANGE = 256;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_COLLIDEHITBOX = 16;
		const string SOUND_WOOSH = "doors/aliendoor3.wav";
		const string SOUND_SMOOSH = "debris/beamstart14.wav";
		Precache("xflare1.spr");
	}

	void projectile_spawn()
	{
		SetName("Snow Ball of Dewm");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0.05);
		SetGroupable(25);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void game_tossprojectile()
	{
		// svplaysound: svplaysound 0 10 SOUND_WOOSH
		EmitSound(0, 10, SOUND_WOOSH);
	}

	void projectile_landed()
	{
		EmitSound(GetOwner(), 0, SOUND_SMOOSH, 10);
		Effect("tempent", "trail", "xflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 1, 1), 1, 1.0, 15.0, 1.0, 0);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string MY_OWNER_PLAYER = IsValidPlayer("ent_expowner");
		string ENT_HIT = GetEntityIndex(param2);
		string EFFECT_DURATION = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DURATION *= 0.5;
		if (!(MY_OWNER_PLAYER))
		{
			string EFFECT_DURATION = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		if (EFFECT_DURATION < 3)
		{
			EFFECT_DURATION = 3;
		}
		if ((MY_OWNER_PLAYER))
		{
			string OUT_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.ice");
		}
		if (!(MY_OWNER_PLAYER))
		{
			float OUT_DAMAGE = 20.0;
		}
		ApplyEffect(ENT_HIT, "effects/dot_cold", EFFECT_DURATION, GetEntityIndex(GetOwner()), OUT_DAMAGE, "spellcasting.ice");
	}

}

}
