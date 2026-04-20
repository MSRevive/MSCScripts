#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class BaseMedal : CGameScript
{
	int BM_OWNER_SET;
	float FREQ_EFFECT;
	string MEDAL_DEPLOY_TIME;
	string MEDAL_NEXT_EFFECT;
	string MODEL_HANDS;
	string MODEL_WORLD;

	BaseMedal()
	{
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		FREQ_EFFECT = 21.0;
	}

	void OnSpawn() override
	{
		SetHUDSprite("trade", 80);
		medal_spawn();
	}

	void game_fall()
	{
		if (!(true)) return;
		if ((BM_OWNER_SET)) return;
		BM_OWNER_SET = 1;
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(GetEntityIndex(GetOwner()));
	}

	void game_restricted()
	{
		string OUT_MSG = "This trophy is reserved for ";
		string ITEM_OWNER = PICKUP_ALLOW_LIST[int(0)];
		OUT_MSG += GetEntityName(ITEM_OWNER);
		SendInfoMsg(param1, "Item Damagepoint Restricted " + OUT_MSG);
	}

	void ext_set_owner()
	{
		LogDebug("Owner set GetEntityName(param1)");
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(param1);
		BM_OWNER_SET = 1;
	}

	void OnDeploy() override
	{
		MEDAL_DEPLOY_TIME = GetGameTime();
		MEDAL_DEPLOY_TIME += 1.0;
	}

	void game_attack1()
	{
		if (!(true)) return;
		if (!(GetGameTime() > MEDAL_DEPLOY_TIME)) return;
		if (GetGameTime() > MEDAL_NEXT_EFFECT)
		{
			MEDAL_NEXT_EFFECT = GetGameTime();
			MEDAL_NEXT_EFFECT += FREQ_EFFECT;
			medal_activate();
		}
		else
		{
			SendColoredMessage(GetOwner(), "You must wait a bit before showing off this medal again.");
		}
	}

}

}
