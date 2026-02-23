#pragma context server

namespace MS
{

class BaseCompanion : CGameScript
{
	string ACT_NAME;
	string BCOMP_LAST_TELEPORT;
	string BCOMP_START_CATCHUP;
	int BCOMP_UPDATE_XP;
	int COMPANION_CONFIRM_DISMISS;
	string COMPANION_HP;
	int COMPANION_LR;
	string COMPANION_NAME;
	string COMPANION_NEXT_REGEN;
	string COMPANION_XP;
	int CONVERTING_COMPANION;
	int IS_HIRED;
	int I_R_COMPANION;
	int I_R_PET;
	string NAMEPREFIX;
	int NO_SPAWN_STUCK_CHECK;
	string PET_LAST_ATTACK;
	string SUMMON_MASTER;
	string companion.save.health;
	string companion.save.xp;

	BaseCompanion()
	{
		I_R_COMPANION = 1;
		I_R_PET = 1;
		COMPANION_LR = 0;
		NO_SPAWN_STUCK_CHECK = 1;
		const int COMPANION_NEW_TYPE = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if ((COMPANION_NEW_TYPE))
		{
		}
		if ((BCOMP_UPDATE_XP))
		{
		}
		string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
		SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		MY_SCRIPT += "_hp";
		LogDebug("update_hp MY_SCRIPT GetEntityHealth(GetOwner())");
		SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		BCOMP_UPDATE_XP = 0;
	}

	void OnSpawn() override
	{
		pet_spawn();
		COMPANION_NAME = ACT_NAME;
		ext_companion_update_name();
	}

	void ext_companion_update_name()
	{
		string MY_NAME = GetEntityProperty(GetOwner(), "itemname");
		MY_NAME += "_name";
		string MY_NAME = GetPlayerQuestData(SUMMON_MASTER, MY_NAME);
		if (MY_NAME != 0)
		{
			string L_NEW_NAME = MY_NAME;
			COMPANION_NAME = MY_NAME;
			L_NEW_NAME += " (";
			L_NEW_NAME += GetEntityName(SUMMON_MASTER);
			L_NEW_NAME += "s";
			L_NEW_NAME += ")";
			SetName(L_NEW_NAME);
		}
		else
		{
			ACT_NAME = GetEntityName(GetOwner());
			NAMEPREFIX = GetEntityName(SUMMON_MASTER);
			NAMEPREFIX += "s";
			NAMEPREFIX += " ";
			NAMEPREFIX += GetEntityName(GetOwner());
			SetName(NAMEPREFIX);
		}
	}

	void game_companion_save()
	{
		companion.save.health = GetEntityHealth(GetOwner());
		companion.save.xp = COMPANION_XP;
		LogDebug("game_companion_save COMPANION_XP");
	}

	void game_companion_restore()
	{
		SUMMON_MASTER = GetEntityIndex(GetOwner());
		SetHealth(companion.save.health);
		COMPANION_XP = companion.save.xp;
		CONVERTING_COMPANION = 1;
		LogDebug("game_companion_restore COMPANION_XP");
	}

	void companion_update_hp()
	{
		if (COMPANION_XP == "COMPANION_XP")
		{
			COMPANION_XP = 0;
		}
		string FINAL_HP = BASE_HP;
		FINAL_HP += COMPANION_XP;
		if (FINAL_HP > COMPANION_MAXHP)
		{
			string FINAL_HP = COMPANION_MAXHP;
		}
		SetHealth(GetEntityHealth(GetOwner()));
		LogDebug("companion_update_hp GetEntityHealth(GetOwner()) GetEntityMaxHealth(GetOwner())");
	}

	void game_dodamage()
	{
		PET_LAST_ATTACK = GetGameTime();
		PET_LAST_ATTACK += 10.0;
	}

	void bs_set_follow_mode()
	{
		basecompanion_catchup(1);
	}

	void basecompanion_catchup()
	{
		string L_EMERGENCY_TELEPORT = param1;
		if (!(L_EMERGENCY_TELEPORT))
		{
			if ((GUARD_MODE))
			{
				int EXIT_SUB = 1;
			}
			if (!(IS_HIRED))
			{
				int EXIT_SUB = 1;
			}
			if (m_hAttackTarget != "unset")
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		string L_POS = GetEntityOrigin(SUMMON_MASTER);
		if (!(L_EMERGENCY_TELEPORT))
		{
			L_POS = "z";
		}
		string L_TELE_PLUS10 = BCOMP_LAST_TELEPORT;
		L_TELE_PLUS10 += 1.0;
		if (GetGameTime() > L_TELE_PLUS10)
		{
			COMPANION_LR = GetEntityProperty(SUMMON_MASTER, "viewangles");
		}
		else
		{
			COMPANION_TELE_ANG += 16;
			if (COMPANION_TELE_ANG > 359)
			{
				COMPANION_TELE_ANG -= 359;
			}
		}
		BCOMP_LAST_TELEPORT = GetGameTime();
		string L_ANG = /* TODO: $vec.yaw */ $vec.yaw(COMPANION_LR);
		L_ANG += COMPANION_TELE_ANG;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_ANG, 0), Vector3(-48, 0, 0));
		string OLD_POS = GetEntityOrigin(GetOwner());
		SetEntityOrigin(GetOwner(), L_POS);
		string reg.npcmove.endpos = L_POS;
		reg.npcmove.endpos += "z";
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), SUMMON_MASTER);
		if ("game.ret.npcmove.dist" <= 0)
		{
			SetEntityOrigin(GetOwner(), OLD_POS);
		}
		else
		{
			if (GetGameTime() > COMPANION_NEXT_TELE_SOUND)
			{
				EmitSound(GetOwner(), 0, SOUND_TELE, 10);
				COMPANION_NEXT_TELE_SOUND = GetGameTime();
				COMPANION_NEXT_TELE_SOUND += 2.0;
			}
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((CONVERTING_COMPANION))
		{
			SUMMON_MASTER = GetEntityIndex(GetOwner());
			if (!(GetEntityProperty(SUMMON_MASTER, "scriptvar")))
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			COMPANION_XP = companion.save.xp;
			COMPANION_HP = companion.save.health;
			LogDebug("convert_companion GetEntityName(SUMMON_MASTER) COMPANION_XP COMPANION_HP GetEntityProperty(SUMMON_MASTER, "scriptvar")");
			string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
			string PET_LIST = GetPlayerQuestData(SUMMON_MASTER, "pets");
			if (PET_LIST == 0)
			{
				string ADD_PET = MY_SCRIPT;
				SetPlayerQuestData(SUMMON_MASTER, "pets");
			}
			else
			{
				if (PET_LIST.length() > 0) PET_LIST += ";";
				PET_LIST += MY_SCRIPT;
				SetPlayerQuestData(SUMMON_MASTER, "pets");
			}
			SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
			MY_SCRIPT += "_hp";
			SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
			// TODO: companion remove ent_me ent_owner
			SetAlive(0);
			CONVERTING_COMPANION = 0;
			int EXIT_SUB = 1;
			SendColoredMessage(SUMMON_MASTER, "Companion converted to new system");
			DeleteEntity(GetOwner());
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > BCOMP_START_CATCHUP)) return;
		if (!(IsEntityAlive(SUMMON_MASTER)))
		{
			companion_unsummon();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityDist(SUMMON_MASTER) > 512)) return;
		basecompanion_catchup();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((COMPANION_NEW_TYPE))
		{
			newtype_remove_pet(1);
		}
		if ((COMPANION_NEW_TYPE)) return;
		// TODO: companion remove ent_me ent_owner
	}

	void bcompanion_regme()
	{
		if ((COMPANION_NEW_TYPE))
		{
			if ((NEW_PET))
			{
			}
			CallExternal(SUMMON_MASTER, "ext_summon_register_pet", GetEntityIndex(GetOwner()));
			string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
			string PET_LIST = GetPlayerQuestData(SUMMON_MASTER, "pets");
			if (PET_LIST == 0)
			{
				string ADD_PET = MY_SCRIPT;
				SetPlayerQuestData(SUMMON_MASTER, "pets");
			}
			else
			{
				if (PET_LIST.length() > 0) PET_LIST += ";";
				PET_LIST += MY_SCRIPT;
				SetPlayerQuestData(SUMMON_MASTER, "pets");
			}
			if (COMPANION_XP == 0)
			{
				// TODO: UNCONVERTED: if ( COMPANION_XP == 0 ) quest.set SUMMON_MASTER MY_SCRIPT COMPANION_XP
			}
			string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
			MY_SCRIPT += "_hp";
			SetPlayerQuestData(MY_SCRIPT, GetEntityMaxHealth(GetOwner()));
		}
		if ((COMPANION_NEW_TYPE)) return;
		// TODO: companion add ent_me PARAM1
	}

	void game_dynamically_created()
	{
		if ((CONVERTING_COMPANION)) return;
		if ((COMPANION_NEW_TYPE))
		{
			BCOMP_START_CATCHUP = GetGameTime();
			BCOMP_START_CATCHUP += 3.0;
			SUMMON_MASTER = param1;
			string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
			COMPANION_XP = GetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
			if (param2 == 1)
			{
				NEW_PET = 1;
			}
			if (!(NEW_PET))
			{
				string FINAL_HP = BASE_HP;
				FINAL_HP += COMPANION_XP;
				if (FINAL_HP > COMPANION_MAXHP)
				{
					string FINAL_HP = COMPANION_MAXHP;
				}
				string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
				MY_SCRIPT += "_hp";
				COMPANION_HP = GetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
				SetHealth(COMPANION_HP);
				LogDebug("game_dynamically_created GetEntityHealth(GetOwner()) / GetEntityMaxHealth(GetOwner())");
				ScheduleDelayedEvent(0.1, "bcomp_restore_old_hp");
			}
			else
			{
				SetHealth(BASE_HP);
			}
		}
		bcompanion_regme(param1);
	}

	void bcomp_restore_old_hp()
	{
		string FINAL_HP = BASE_HP;
		FINAL_HP += COMPANION_XP;
		if (FINAL_HP > COMPANION_MAXHP)
		{
			string FINAL_HP = COMPANION_MAXHP;
		}
		string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
		MY_SCRIPT += "_hp";
		COMPANION_HP = GetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		if (COMPANION_HP == 0)
		{
			COMPANION_HP = FINAL_HP;
		}
		SetHealth(COMPANION_HP);
		LogDebug("bcomp_restore_old_hp GetEntityHealth(GetOwner()) GetEntityMaxHealth(GetOwner())");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		string TARG_VALUE = GetEntityProperty(param1, "skilllevel");
		if (!(TARG_VALUE > 0)) return;
		string MIN_VALUE = COMPANION_XP;
		MIN_VALUE *= 0.1;
		if (!(TARG_VALUE > MIN_VALUE)) return;
		string IN_DMG = param2;
		IN_DMG *= 0.01;
		COMPANION_XP += IN_DMG;
		BCOMP_UPDATE_XP = 1;
	}

	void ext_unreg_pets()
	{
		if (!(param1 == SUMMON_MASTER)) return;
		bcompanion_un_regme();
	}

	void OnDamage(int damage) override
	{
		BCOMP_UPDATE_XP = 1;
		if (!(IsValidPlayer(param1)))
		{
			if (GetEntityRange(SUMMON_MASTER) > 512)
			{
				SendPlayerMessage(SUMMON_MASTER, "COMPANION_NAME is under attack!");
			}
			string QUART_HEALTH = GetEntityMaxHealth(GetOwner());
			QUART_HEALTH *= 0.25;
			if (GetEntityHealth(GetOwner()) < QUART_HEALTH)
			{
				SendPlayerMessage(SUMMON_MASTER, "COMPANION_NAME is low on health! int(GetEntityHealth(GetOwner())) hp");
			}
			COMPANION_NEXT_REGEN = GetGameTime();
			COMPANION_NEXT_REGEN += 30.0;
		}
		if ((NEW_AI)) return;
		if (!(IsValidPlayer(param1))) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

	void my_target_died()
	{
		companion_update_hp();
	}

	void ext_givexp()
	{
		COMPANION_XP += param1;
		BCOMP_UPDATE_XP = 1;
	}

	void companion_abandon()
	{
		if (!(param2 == "from_menu")) return;
		COMPANION_CONFIRM_DISMISS = 1;
		ScheduleDelayedEvent(0.5, "companion_give_menu");
	}

	void companion_give_menu()
	{
		OpenMenu(SUMMON_MASTER);
	}

	void game_menu_cancel()
	{
		COMPANION_CONFIRM_DISMISS = 0;
	}

	void companion_release_cancel()
	{
		COMPANION_CONFIRM_DISMISS = 0;
	}

	void companion_release()
	{
		ShowHelpTip(SUMMON_MASTER, "generic", "PET DISMISSED", "This pet will continue to remain with you until map change or death.");
		SendPlayerMessage(SUMMON_MASTER, "Pet dismissed...");
		bs_set_defend_mode();
		IS_HIRED = 0;
		ScheduleDelayedEvent(0.1, "bcompanion_un_regme");
		if (!(COMPANION_NEW_TYPE)) return;
		newtype_remove_pet();
	}

	void companion_unsummon()
	{
		if (!(IS_HIRED)) return;
		if (param1 == "trigger_hurt")
		{
			EmitSound(GetOwner(), 0, SOUND_PAIN, 10);
			ShowHelpTip(SUMMON_MASTER, "generic", "PET UNSUMMONED DUE TO HAZARD", "You can re-summon your pet by using Summon Pet on the player menu [default: F11]");
		}
		else
		{
			ShowHelpTip(SUMMON_MASTER, "generic", "PET UNSUMMONED", "You can re-summon your pet by using Summon Pet on the player menu [default: F11]");
		}
		if (!(COMPANION_NEW_TYPE)) return;
		string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
		SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		MY_SCRIPT += "_hp";
		LogDebug("update_hp MY_SCRIPT GetEntityHealth(GetOwner())");
		SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		BCOMP_UPDATE_XP = 0;
		if (!(param3))
		{
			CallExternal(SUMMON_MASTER, "ext_unsummon_pets_new", SUMMON_MASTER, GetEntityIndex(GetOwner()), 1);
		}
		SetAlive(0);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void newtype_remove_pet()
	{
		string PET_LIST = GetPlayerQuestData(SUMMON_MASTER, "pets");
		string MY_SCRIPT = GetEntityProperty(GetOwner(), "itemname");
		string PET_IDX = FindToken(PET_LIST, MY_SCRIPT, ";");
		RemoveToken(PET_LIST, PET_IDX, ";");
		LogDebug("newtype_remove_pet PET_LIST");
		SetPlayerQuestData(SUMMON_MASTER, "pets");
		SetPlayerQuestData(SUMMON_MASTER, MY_SCRIPT);
		if (!(param1)) return;
		CallExternal(SUMMON_MASTER, "ext_unsummon_pets_new", SUMMON_MASTER, GetEntityIndex(GetOwner()));
	}

}

}
