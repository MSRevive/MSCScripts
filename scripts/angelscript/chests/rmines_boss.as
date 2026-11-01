#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RminesBoss : CGameScript
{
	string ANIM_CLOSE;
	string ANIM_IDLE;
	string ANIM_OPEN;
	string SOUND_OPEN;

	RminesBoss()
	{
		ANIM_IDLE = "base";
		ANIM_CLOSE = "base";
		ANIM_OPEN = "base";
		SOUND_OPEN = "debris/flesh5.wav";
	}

	void OnSpawn() override
	{
		SetName("Abyssal Nest");
		SetModel("tiod/ornest.mdl");
		SetProp(GetOwner(), "scale", 3.0);
		SetWidth(96);
		SetHeight(48);
		tc_add_artifact("polearms_sl", 5);
		tc_add_artifact("axes_c", 5);
	}

	void chest_additems()
	{
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= "game.playersnb";
		L_GOLD_TO_ADD *= 10;
		add_gold(int(L_GOLD_TO_ADD));
		AddStoreItem(STORENAME, "proj_bolt_poison", 25, 0, 0, 25);
		add_great_item();
		add_epic_item();
		add_great_arrows();
		add_epic_arrows();
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_great_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_paura", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "proj_bolt_poison", 75, 0, 0, 25);
		}
		offer_felewyn_symbol(20);
	}

}

}
