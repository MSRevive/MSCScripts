#pragma context server

namespace MS
{

class ArmorBaseHybrid : CGameScript
{
	int IN_WORLD;
	int IS_REGISTERED;

	ArmorBaseHybrid()
	{
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "none";
		const int ARMOR_GROUP = 4;
		const string NEW_ARMOR_MODEL = "armor/p_armorvest_new.mdl";
		const int EXPAR = 1;
	}

	void OnSpawn() override
	{
		SetWorldModel(MODEL_WORLD);
		SetHUDSprite("hand", "armor");
		SetHUDSprite("trade", "leather");
		if ((true))
		{
			if (!(GetEntityProperty(GetOwner(), "is_worn")))
			{
				SetModelBody(0, 10);
			}
			if ((GetEntityProperty(GetOwner(), "is_worn")))
			{
				if (!(IS_HELM))
				{
					string L_MODEL_WEAR = ARMOR_BODY;
					L_MODEL_WEAR += 1;
					SetModelBody(ARMOR_GROUP, L_MODEL_WEAR);
				}
				if ((IS_HELM))
				{
					SetModelBody(ARMOR_GROUP, ARMOR_BODY);
				}
			}
		}
		SetHand("any");
		if ((true))
		{
			ScheduleDelayedEvent(1.0, "armor_spec_effect");
		}
		register_armor();
	}

	void register_armor()
	{
		ScheduleDelayedEvent(0.1, "register_loop");
	}

	void OnDeploy() override
	{
		IN_WORLD = 0;
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		int L_SUBMODEL = 16;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		CallExternal(GetEntityIndex(GetOwner()), "wearing_armor", 0);
		SetModel("null.mdl");
		if (!(IS_HELM))
		{
			clear_armor_body();
		}
	}

	void game_wear()
	{
		IN_WORLD = 0;
		if (!(IS_HELM))
		{
			SetModel(NEW_ARMOR_MODEL);
			set_armor_body();
		}
		else
		{
			SetModel(ARMOR_MODEL);
			SetModelBody(ARMOR_GROUP, ARMOR_BODY);
		}
		// TODO: playermessagecl ARMOR_TEXT
		register_armor();
		if ((IS_HELM)) return;
		set_armor_body();
		if (!(true)) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(0.1, "failed_str_req_loop");
	}

	void game_fall()
	{
		IN_WORLD = 1;
		SetModelBody(0, 17);
		PlayAnim("once", "package_floor_idle");
	}

	void game_remove()
	{
	}

	void register_loop()
	{
		IS_REGISTERED = 0;
		if ((IsEntityAlive(GetOwner())))
		{
			if (!(IN_WORLD))
			{
			}
			if ((IS_HELM))
			{
				SetModel(ARMOR_MODEL);
				if ((GetEntityProperty(GetOwner(), "is_worn")))
				{
				}
				SetModelBody(ARMOR_GROUP, ARMOR_BODY);
			}
			if (!(IS_HELM))
			{
			}
			SetModel(NEW_ARMOR_MODEL);
			set_armor_body(1);
		}
		ScheduleDelayedEvent(10.7, "register_loop");
	}

	void OnDrop() override
	{
		SetModel("misc/p_misc.mdl");
		SetModelBody(0, 16);
	}

	void set_armor_body()
	{
		LogDebug("set_armor_body NEW_ARMOR_OFS");
		SetModelBody(0, NEW_ARMOR_OFS);
		CallExternal(GetOwner(), "ext_setbodytype", BARMOR_TYPE);
	}

	void armor_spec_effect()
	{
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if ((IS_HELM)) return;
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			if (GetEntityRace(param1) == "spider")
			{
			}
			string OUT_DMG = param3;
			OUT_DMG *= PLR_SPIDER_AMT;
			SetDamage("hit");
			SetDamage("dmg");
		}
	}

	void failed_str_req_loop()
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(10.0, "failed_str_req_loop");
		string ALRT_STR = "You are too weak to move freely in this armor. (Min Strength ";
		ALRT_STR += ARMOR_STR_REQ;
		ALRT_STR += ")";
		SendInfoMsg(GetOwner(), "Insufficient Strength for Armor ALRT_STR");
		ApplyEffect(GetOwner(), "effects/effect_slow", 10.0, 0.5, GetEntityIndex(GetOwner()));
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetStat(GetOwner(), "strength") < ARMOR_STR_REQ)) return;
		ScheduleDelayedEvent(0.1, "failed_str_req_loop");
	}

}

}
