#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjBlizzard2 : CGameScript
{
	int ARROW_BODY_OFS;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjBlizzard2()
	{
		Precache("monsters/summon/summon_blizzard");
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 2;
		MODEL_BODY_OFS = 2;
		SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		SOUND_BURN = "items/torch1.wav";
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "cold";
		PROJ_DAMAGESTAT = "spellcasting.ice";
		PROJ_ANIM_IDLE = "idle_iceball";
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 256;
		PROJ_AOE_FALLOFF = 1;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
	}

	void projectile_spawn()
	{
		SetName("Blizzard Spawner");
		SetWeight(500);
		SetSize(1);
		SetValue(1);
		SetGravity(0.7);
		SetGroupable(25);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void projectile_landed()
	{
		frost_landed();
	}

	void game_hitnpc()
	{
		frost_hit();
	}

	void frost_hit()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.ice");
		EFFECT_DMG *= 1.25;
		int EFFECT_MAXDURATION = 10;
		int EFFECT_MINDURATION = 10;
		string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		ApplyEffect(m_hLastStruckByMe, "effects/dot_cold", EFFECT_DURATION, MY_OWNER, EFFECT_DMG, "spellcasting.ice");
		frost_landed();
	}

	void frost_landed()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string OWNER_ISPLAYER = IsValidPlayer("ent_expowner");
		string pos = GetEntityOrigin(GetOwner());
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		if ((OWNER_ISPLAYER))
		{
			string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			string EFFECT_DURATION_STAT = GetStat(MY_OWNER, "concentration.ratio");
			int EFFECT_MAXDURATION = 5;
			int EFFECT_MINDURATION = 15;
			string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
			EFFECT_DMG /= 2.0;
			SpawnNPC("monsters/summon/summon_blizzard", pos, ScriptMode::Legacy); // params: MY_OWNER, GetEntityProperty(GetOwner(), "angles.y"), EFFECT_DMG, EFFECT_DURATION, "spellcasting.ice"
			string LAST_ENT = GetEntityIndex(m_hLastCreated);
		}
		if (!(OWNER_ISPLAYER))
		{
			string EFFECT_DMG = GetEntityProperty(MY_OWNER, "scriptvar");
			string EFFECT_DURATION = GetEntityProperty(MY_OWNER, "scriptvar");
			SpawnNPC("monsters/summon/summon_blizzard", pos, ScriptMode::Legacy); // params: MY_OWNER, GetEntityProperty(GetOwner(), "angles.y"), EFFECT_DMG, EFFECT_DURATION, "spellcasting.ice"
		}
	}

}

}
