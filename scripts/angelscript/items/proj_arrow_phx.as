#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjArrowPhx : CGameScript
{
	string BURN_DMG;
	string GAME_PVP;
	string IS_UNDERSKILLED;
	string MY_DAMAGE;
	string MY_RADIUS;
	string TARGET_LIST;

	ProjArrowPhx()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 48;
		const int ARROW_BODY_OFS = 48;
		const int PROJ_IGNORENPC = 1;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const int MAX_DIST = 1024;
		const int MIN_RADIUS = 32;
		const int MAX_RADIUS = 256;
		const int PROJ_DAMAGE = 1;
		const string SOUND_PHOENIX = "monsters/birds/hawkcaw.wav";
		Precache("ambience/steamburst1.wav");
	}

	void OnSpawn() override
	{
		SetName("Phoenix Arrow");
		SetMonsterClip(0);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		GAME_PVP = "game.pvp";
		SetGravity(1);
	}

	void game_tossprojectile()
	{
		// svplaysound: svplaysound 0 5 SOUND_PHOENIX
		EmitSound(0, 5, SOUND_PHOENIX);
	}

	void game_projectile_hitwall()
	{
		string USER_ORG = GetEntityOrigin("ent_expowner");
		string MY_ORG = GetEntityOrigin(GetOwner());
		MY_ORG = "z";
		string DISTANCE_TRAVELED = Distance(USER_ORG, MY_ORG);
		string DISTANCE_RATIO = DISTANCE_TRAVELED;
		string OWNER_SKILL = GetSkillLevel("ent_expowner", "archery.power");
		string MIN_DMG = OWNER_SKILL;
		string MAX_DMG = OWNER_SKILL;
		MAX_DMG *= 3.0;
		if (DISTANCE_TRAVELED >= MAX_DIST)
		{
			string MY_DAMAGE = MAX_DMG;
			string MY_RADIUS = MAX_RADIUS;
		}
		else
		{
			DISTANCE_RATIO /= MAX_DIST;
			MY_DAMAGE = /* TODO: $get_skill_ratio */ $get_skill_ratio(DISTANCE_RATIO, MIN_DMG, MAX_DMG);
			MY_RADIUS = /* TODO: $get_skill_ratio */ $get_skill_ratio(DISTANCE_RATIO, MIN_RADIUS, MAX_RADIUS);
		}
		if ((IsValidPlayer("ent_expowner")))
		{
			if (GetSkillLevel("ent_expowner", "archery") < 25)
			{
			}
			IS_UNDERSKILLED = 1;
			MY_DAMAGE *= 0.1;
			MY_RADIUS *= 0.5;
		}
		ClientEvent("new", "all", "items/proj_arrow_phx_cl", MY_ORG, MY_RADIUS);
		LogDebug("game_projectile_hitwall dmg MY_DAMAGE rad MY_RADIUS");
		XDoDamage(MY_ORG, MY_RADIUS, MY_DAMAGE, 0, "ent_expowner", "ent_expowner", "archery", "fire");
		TARGET_LIST = FindEntitiesInSphere("any", MY_RADIUS);
		if (!(TARGET_LIST != "none")) return;
		BURN_DMG = GetSkillLevel("ent_expowner", "spellcasting.fire");
		BURN_DMG *= 0.5;
		if ((IS_UNDERSKILLED))
		{
			BURN_DMG *= 0.1;
		}
		for (int i = 0; i < GetTokenCount(TARGET_LIST, ";"); i++)
		{
			burn_them();
		}
	}

	void burn_them()
	{
		string CUR_TARGET = GetToken(TARGET_LIST, i, ";");
		if (!(GetRelationship("ent_expowner") == "enemy")) return;
		if ((IsValidPlayer("ent_expowner")))
		{
			if (GAME_PVP == 0)
			{
			}
			if ((IsValidPlayer(CUR_TARGET)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 5, GetEntityIndex("ent_expowner"), BURN_DMG, "archery");
	}

}

}
