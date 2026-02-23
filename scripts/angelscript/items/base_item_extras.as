#pragma context server

#include "items/item_debug.as"

namespace MS
{

class BaseItemExtras : CGameScript
{
	int IS_RESERVED;
	string ITEM_BASE_SPEED;
	string ITEM_BASE_STRIKE;
	int ITEM_RESERVED;
	int ITEM_SWIFT_BLADE;

	BaseItemExtras()
	{
		const float BWEAPON_BASE_ANIM_SPEED = 1.0;
		array<string> PICKUP_ALLOW_LIST;
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "vanish_item");
	}

	void vanish_item()
	{
		string L_OWNER = GetEntityProperty(GetOwner(), "owner");
		if (((L_OWNER !is null)))
		{
			SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		}
	}

	void game_fall()
	{
		if (!(true)) return;
		if (!(ITEM_RESERVE_FOR_STRONGEST)) return;
		bitem_reserve_for_strongest();
	}

	void bitem_reserve_for_strongest()
	{
		ITEM_RESERVED = 1;
		ScheduleDelayedEvent(0.1, "bitem_get_strongest");
	}

	void game_restricted()
	{
		if (!(true)) return;
		if (!(ITEM_RESERVED)) return;
		LogDebug("game_restricted");
		string OUT_MSG = "This trophy is reserved for ";
		string ITEM_RESERVER = /* TODO: $get_array */ $get_array(PICKUP_ALLOW_LIST, 0);
		OUT_MSG += GetEntityName(ITEM_RESERVER);
		SendInfoMsg(param1, "Item Damagepoint Restricted OUT_MSG");
	}

	void bitem_reserve()
	{
		ITEM_RESERVED = 1;
	}

	void bitem_get_strongest()
	{
		if (!(true)) return;
		if ((IsEntityAlive(GetOwner())))
		{
			PICKUP_ALLOW_LIST.resize(0);
		}
		else
		{
			CallExternal(GAME_MASTER, "gm_find_strongest_reset");
			string WINNING_PLAYER = GetEntityProperty(GAME_MASTER, "scriptvar");
			PICKUP_ALLOW_LIST.insertLast(WINNING_PLAYER);
			LogDebug("bitem_get_strongest GetEntityName(WINNING_PLAYER)");
		}
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		if (QUEST_ITEM_CAT != "QUEST_ITEM_CAT")
		{
			string QUEST_CAT_DATA = GetPlayerQuestData(GetOwner(), QUEST_ITEM_CAT);
			if ((QUEST_CAT_DATA).findFirst(QUEST_ITEM_ID) >= 0)
			{
				int DO_NOT_ADD = 1;
			}
			if (!(DO_NOT_ADD))
			{
			}
			if (QUEST_CAT_DATA == 0)
			{
				SetPlayerQuestData(GetOwner(), QUEST_ITEM_CAT);
			}
			else
			{
				if (QUEST_CAT_DATA.length() > 0) QUEST_CAT_DATA += ";";
				QUEST_CAT_DATA += QUEST_ITEM_ID;
				SetPlayerQuestData(GetOwner(), QUEST_ITEM_CAT);
			}
		}
	}

	void ext_activate_items()
	{
		if (!(true)) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (!(BEW_IS_WEILDED)) return;
		bweapon_effect_activate();
	}

	void OnDeploy() override
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		bweapon_effect_activate();
		ScheduleDelayedEvent(0.01, "bweapon_fixprops");
	}

	void bweapon_fixprops()
	{
		// TODO: setviewmodelprop ent_me rendermode 0
		// TODO: setviewmodelprop ent_me renderamt 255
	}

	void game_wear()
	{
		if ((true))
		{
			bweapon_effect_remove();
		}
	}

	void game_putinpack()
	{
		CancelAttack();
		if (!(true)) return;
		bweapon_effect_remove("game_putinpack");
	}

	void game_remove()
	{
		if (!(true)) return;
		bweapon_effect_remove("game_remove");
	}

	void game_sheath()
	{
		if (!(true)) return;
		bweapon_effect_remove("game_sheath");
	}

	void OnDrop() override
	{
		CancelAttack();
		if (!(true)) return;
		bweapon_effect_remove("game_drop");
	}

	void game_deleted()
	{
		LogDebug("game_deleted");
		CancelAttack();
		if (!(true)) return;
		if ((GetEntityProperty(GetOwner(), "inhand")))
		{
			int L_REM_EFFECTS = 1;
		}
		if ((GetEntityProperty(GetOwner(), "is_worn")))
		{
			int L_REM_EFFECTS = 1;
		}
		if (!(L_REM_EFFECTS)) return;
		bweapon_effect_remove("game_deleted");
	}

	void ext_render_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		SetProp(GetOwner(), "rendermode", param2);
		SetProp(GetOwner(), "renderamt", param3);
	}

	void ext_playowneranim()
	{
		PlayOwnerAnim("PARAM1", param2);
	}

	void item_banked()
	{
		game_putinpack();
	}

	void ext_item_swift_blade()
	{
		LogDebug("ext_item_swift_blade PARAM1 PARAM2");
		ITEM_SWIFT_BLADE = 1;
		if (param1 != "remove")
		{
			ITEM_BASE_SPEED = param1;
			ITEM_BASE_STRIKE = param2;
		}
		else
		{
			ITEM_SWIFT_BLADE = 0;
			// TODO: setviewmodelprop ent_me animspeed 1.0
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
		}
	}

	void ext_viewanim_test()
	{
		LogDebug("ext_viewanim_test");
		// TODO: setviewmodelprop ent_me animspeed 5.0
	}

	void OnDeploy() override
	{
		if (!(IS_CONTAINER)) return;
		if ((IS_RESERVED)) return;
		IS_RESERVED = 1;
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(GetEntityIndex(GetOwner()));
	}

	void game_fall()
	{
		if (!(IS_CONTAINER)) return;
		if ((IS_RESERVED)) return;
		IS_RESERVED = 1;
		array<string> PICKUP_ALLOW_LIST;
		PICKUP_ALLOW_LIST.insertLast(GetEntityIndex(GetOwner()));
	}

	void game_restricted()
	{
		if (!(IS_CONTAINER)) return;
		if (!(IS_RESERVED)) return;
		string OUT_MSG = "This container is reserved for ";
		string ITEM_RESERVER = /* TODO: $get_array */ $get_array(PICKUP_ALLOW_LIST, 0);
		OUT_MSG += GetEntityName(ITEM_RESERVER);
		SendInfoMsg(param1, "Item Restricted OUT_MSG");
	}

	void bweapon_effect_activate()
	{
	}

	void bweapon_effect_remove()
	{
		int L_SET_ID = 0;
		int L_HAND = -1;
		string L_ID = GetEntityProperty(GetOwner(), "scriptvar");
		if (L_ID == GetEntityIndex(GetOwner()))
		{
			if (GetEntityProperty(L_ID, "hand_index") == GetEntityProperty(GetOwner(), "hand_index"))
			{
				string L_HAND = GetEntityProperty(L_ID, "hand_index");
			}
		}
		string L_ID = GetEntityProperty(GetOwner(), "scriptvar");
		if (L_ID == GetEntityIndex(GetOwner()))
		{
			if (GetEntityProperty(L_ID, "hand_index") == GetEntityProperty(GetOwner(), "hand_index"))
			{
				string L_HAND = GetEntityProperty(L_ID, "hand_index");
			}
		}
		if (!(L_HAND >= 0)) return;
		if (!(L_HAND <= 3)) return;
		CallExternal(GetOwner(), "ext_set_hand_id", L_HAND, 0);
	}

}

}
