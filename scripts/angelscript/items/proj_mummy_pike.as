#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjMummyPike : CGameScript
{
	ProjMummyPike()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 46;
		const int ARROW_BODY_OFS = 46;
		const string SOUND_HITWALL1 = "weapons/axemetal1.wav";
		const string SOUND_HITWALL2 = "weapons/axemetal1.wav";
		const string SOUND_BURN = "magic/ice_powerup.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string ITEM_NAME = "watermana";
		const string PROJ_DAMAGE_TYPE = "dark";
		const string PROJ_DAMAGESTAT = "spellcasting.ice";
		const string PROJ_ANIM_IDLE = "idle_icebolt";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 50;
		const int PROJ_AOE_RANGE = 30;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_COLLIDEHITBOX = 32;
	}

	void arrow_spawn()
	{
		SetName("Cursed Pike");
		SetDescription("A cursed polearm");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.0);
		SetGroupable(25);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		string ENT_HIT = GetEntityIndex(param2);
		if ((OWNER_ISPLAYER))
		{
			if (!("game.pvp"))
			{
			}
			if ((IsValidPlayer(ENT_HIT)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		ApplyEffect(ENT_HIT, "effects/debuff_hold", 10.0);
		CallExternal(MY_OWNER, "ext_projectile_hit");
	}

}

}
