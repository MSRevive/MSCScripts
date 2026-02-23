#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseCrest : CGameScript
{
	int ARMOR_MODEL_BODY;
	string FINAL_OFS;

	BaseCrest()
	{
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_HOLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const string MODEL_WEAR = "armor/p_gowns.mdl";
		const int MODEL_BODY_OFS = 16;
		const string ANIM_PREFIX = "package";
	}

	void OnSpawn() override
	{
		SetWorldModel(MODEL_WORLD);
		SetHUDSprite("trade", "crestedana");
		SetAnimExt("holditem1");
		FINAL_OFS = MODEL_CREST_OFS;
		FINAL_OFS -= 1;
		if (MODEL_OFS_FEMALE > 0)
		{
			if ((false))
			{
				string OWNER_RACE = /* TODO: $get_local_prop */ $get_local_prop("race");
				string OWNER_GENDER = /* TODO: $get_local_prop */ $get_local_prop("gender");
			}
			else
			{
				if ((true))
				{
				}
				string OWNER_RACE = GetEntityRace(GetOwner());
				string OWNER_GENDER = GetGender(GetOwner());
			}
			string OWNER_RACE = StringToLower(OWNER_RACE);
			string OWNER_GENDER = StringToLower(OWNER_GENDER);
			if (OWNER_RACE == 0)
			{
				string OWNER_RACE = param1;
			}
			if (OWNER_GENDER == 0)
			{
				string OWNER_GENDER = param2;
			}
			if (OWNER_GENDER == "female")
			{
				if (OWNER_RACE == "human")
				{
				}
			}
		}
		SetWeight(0);
		SetSize(0);
		SetWearable(1);
		SetValue(1200);
		SetModelBody(0, MODEL_BODY_OFS);
		crest_spawn();
		register_armor();
	}

	void game_show()
	{
		SetModel(MODEL_WEAR);
		string REALLY_FINAL_OFS = FINAL_OFS;
		SetModelBody(0, REALLY_FINAL_OFS);
	}

	void register_armor()
	{
		ARMOR_MODEL_BODY = -1;
		// TODO: registerarmor
	}

	void OnDeploy() override
	{
		SetModel(MODEL_HOLD);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		crest_deploy();
	}

	void game_fall()
	{
		SetModel(MODEL_HOLD);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 1;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
		crest_fall();
	}

	void game_removefromowner()
	{
		SetModelBody(0, 0);
		crest_remove();
	}

	void OnDrop() override
	{
		game_fall();
	}

	void game_wear()
	{
		if (MODEL_OFS_FEMALE > 0)
		{
			if ((false))
			{
				string OWNER_RACE = /* TODO: $get_local_prop */ $get_local_prop("race");
				string OWNER_GENDER = /* TODO: $get_local_prop */ $get_local_prop("gender");
			}
			else
			{
				if ((true))
				{
				}
				string OWNER_RACE = GetEntityRace(GetOwner());
				string OWNER_GENDER = GetGender(GetOwner());
			}
			string OWNER_RACE = StringToLower(OWNER_RACE);
			string OWNER_GENDER = StringToLower(OWNER_GENDER);
			if (OWNER_RACE == 0)
			{
				string OWNER_RACE = param1;
			}
			if (OWNER_GENDER == 0)
			{
				string OWNER_GENDER = param2;
			}
			if (OWNER_GENDER == "female")
			{
				if (OWNER_RACE == "human")
				{
					FINAL_OFS = MODEL_OFS_FEMALE;
				}
			}
		}
		SetModel(MODEL_WEAR);
		string FINAL_CREST_OFS = MODEL_CREST_OFS;
		FINAL_CREST_OFS -= 1;
		SetModelBody(0, FINAL_CREST_OFS);
		// TODO: playermessagecl You place the crest over your head.
		crest_remove();
	}

}

}
