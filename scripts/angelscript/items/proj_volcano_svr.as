#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjVolcanoSvr : CGameScript
{
	string MY_LIGHT_IDX;

	ProjVolcanoSvr()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		const string SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		const string SOUND_BURN = "items/torch1.wav";
		const string ITEM_NAME = "firemana";
		const string PROJ_ANIM_IDLE = "idle_standard";
		const int PROJ_DAMAGE = 0;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const string PROJ_DAMAGESTAT = "spellcasting.fire";
		const string PROJ_DAMAGE_TYPE = "fire";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_AOE_RANGE = 128;
		const int LIGHT_RADIUS = 64;
		const Vector3 LIGHT_COLOR = Vector3(255, 0, 0);
		const float LIGHT_DURATION = 0.8;
	}

	void projectile_spawn()
	{
		SetName("Volcanic fireball");
		SetGravity(Random(0.3, 0.6));
		SetUseable(0);
		SetWidth(32);
		SetHeight(32);
		SetModel("none");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), LIGHT_RADIUS, LIGHT_COLOR, LIGHT_DURATION);
		MY_LIGHT_IDX = "game.script.last_sent_id";
	}

	void projectile_landed()
	{
		SetAngles("face");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 20, DURATION, 256);
	}

	void game_dodamage()
	{
		if ((param1)) return;
		string MY_TARGET = param2;
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green proj_volcano struck GetEntityName(m_hLastStruckByMe)");
		}
		string F_MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer(F_MY_OWNER);
		if ((IsValidPlayer(MY_TARGET)))
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if (!("game.pvp"))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((OWNER_ISPLAYER))
		{
			string DMG_FIRE = GetSkillLevel(F_MY_OWNER, "spellcasting.fire");
			DMG_FIRE *= 2.0;
			ApplyEffect(MY_TARGET, "effects/dot_fire", 5, F_MY_OWNER, DMG_FIRE, "spellcasting.fire");
		}
		if (!(OWNER_ISPLAYER))
		{
			string DMG_FIRE = GetEntityProperty(F_MY_OWNER, "scriptvar");
			string USE_DOT = GetEntityProperty(F_MY_OWNER, "scriptvar");
			if (DMG_FIRE == "DMG_VOLCANO")
			{
				int DMG_FIRE = 50;
			}
			if ((GetEntityName(MY_TARGET)).findFirst("Garonhroth") >= 0)
			{
				int DMG_FIRE = 500;
			}
			if (!(USE_DOT))
			{
				CallExternal(MY_OWNER, "send_damage", MY_TARGET, "direct", DMG_FIRE, 1.0, F_MY_OWNER, "fire");
			}
			else
			{
				ApplyEffect(MY_TARGET, "effects/dot_fire", 10, F_MY_OWNER, DMG_FIRE, "spellcasting.fire");
			}
		}
		ClientEvent("remove", "all", MY_LIGHT_IDX);
	}

	void client_activate()
	{
		string L_POS = param1;
		string L_RAD = param2;
		string L_COL = param3;
		string L_DUR = param4;
		ClientEffect("light", "new", L_POS, L_RAD, L_COL, L_DUR);
		L_DUR += 0.1;
		L_DUR("remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void game_removed()
	{
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green proj_volcano_svr game_removed");
		}
		ClientEvent("remove", "all", MY_LIGHT_IDX);
	}

	void game_removefromowner()
	{
		if ((G_DEVELOPER_MODE))
		{
			SendInfoMessageToAll("green proj_volcano_svr game_removefromowner");
		}
		ClientEvent("remove", "all", MY_LIGHT_IDX);
	}

}

}
