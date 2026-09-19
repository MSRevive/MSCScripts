#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoleSl : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_LIGHT_IDX;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjPoleSl()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 73;
		ARROW_BODY_OFS = 73;
		ARROW_STICK_DURATION = 0;
		ARROW_EXPIRE_DELAY = 0;
		SOUND_HITWALL1 = "magic/dburst_sdr_blackout.wav";
		SOUND_HITWALL2 = "magic/dburst_sdr_blackout.wav";
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "dark";
		PROJ_DAMAGESTAT = "spellcasting.affliction";
		PROJ_ANIM_IDLE = "idle_icebolt";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDE = 1;
	}

	void game_precache()
	{
		Precache("monsters/summon/affliction_lance");
	}

	void arrow_spawn()
	{
		SetName("Shadow Lance");
		SetDescription("You have been afflicted by this lance");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_tossprojectile()
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 255), 128, 1.5);
		MY_LIGHT_IDX = "game.script.last_sent_id";
		// TODO: projectiletouch 0
	}

	void game_projectile_landed()
	{
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_MY_Z = (L_MY_ORG).z;
		string L_MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(L_MY_ORG);
		if (L_MY_GROUND > (L_MY_Z - 128))
		{
			if (L_MY_GROUND < (L_MY_Z + 128))
			{
			}
			L_MY_ORG = "z";
		}
		ClientEvent("new", "all", "items/proj_pole_sl_cl", GetEntityIndex(GetOwner()));
		CallExternal("ent_expowner", "ext_dburst", L_MY_ORG, 96, 0, 0);
		ClientEvent("update", "all", MY_LIGHT_IDX, "remove_light");
		if ((G_DEVELOPER_MODE))
		{
			string L_BEAM_START = GetEntityOrigin(GetOwner());
			string L_BEAM_END = L_BEAM_START;
			string L_MY_ANG = GetEntityAngles(GetOwner());
			L_MY_ANG = "x";
			L_BEAM_END += /* TODO: $relpos */ $relpos(L_MY_ANG, Vector3(0, -128, 0));
			Effect("beam", "point", "lgtning.spr", 20, L_BEAM_START, L_BEAM_END, Vector3(255, 255, 0), 200, 0, 5.0);
		}
	}

}

}
