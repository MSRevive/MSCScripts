#pragma context server

#include "items/base_weapon_new.as"
#include "items/base_vampire.as"

namespace MS
{

class SwordsVb : CGameScript
{
	int BLOCK_ON;
	int C_VANIM_DRAW;
	int C_VANIM_IDLE;
	string GAVE_MATCH_SET_MSG;
	int HANDS_SINGLE;
	string LAST_KEY_CHECK;
	int MATCHED_SET;
	int MATCHED_SET_ACTIVE;
	string MATCHED_SET_TYPE;
	string NEXT_BLOCK;
	string OTHER_HAND;

	SwordsVb()
	{
		MATCHED_SET = 1;
		MATCHED_SET_TYPE = "vsword";
		const string BWEAPON_NAME = "Blood Blade";
		const string BWEAPON_DESC = "A sinuous blade of dark steel (matched set)";
		const int BWEAPON_WEIGHT = 1;
		const int BWEAPON_VALUE = 3000;
		const int BWEAPON_INV_SPRITE_IDX = 190;
		const string BWEAPON_HANDS = "right";
		const int BASE_LEVEL_REQ = 30;
		const int BWEAPON_CUSTOM_DRAW = 1;
		const int BWEAPON_CUSTOM_SWITCHHANDS = 1;
		const int BITEM_CUSTOM_ATK2_EVENT = 1;
		const int BITEM_CUSTOM_ATK1_EVENT = 1;
		const string VMODEL_FILE = "viewmodels/v_1hswords.mdl";
		const int VMODEL_IDX = 7;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 45;
		const int PMODEL_IDX_HAND_RIGHT = 43;
		const int PMODEL_IDX_HAND_LEFT = 44;
		const int PMODEL_IDX_HANDS = 43;
		const string PANIM_IDLE = "aim_axe_onehand";
		const string PANIM_EXT = "axe_onehand";
		const int VANIM_DRAW = 0;
		const int VANIM_IDLE = 20;
		C_VANIM_DRAW = 0;
		C_VANIM_IDLE = 20;
		const int VANIM_DRAW_SNG = 6;
		const int VANIM_IDLE_SNG = 7;
		const int VANIM_BLOCK = 16;
		const int VANIM_BLOCK_OFH = 18;
		const string WANIM_FLOOR = "standard_floor_idle";
		const string WANIM_HAND = "standard_idle";
		const string ATK1_TYPE = "strike-land";
		const string ATK1_KEYS = "+attack1";
		const int ATK1_RANGE = 80;
		const int ATK1_DMG = 250;
		const int ATK1_DMG_RANGE = 10;
		const string ATK1_DMG_TYPE = "dark";
		const float ATK1_STAMINA = 0.1;
		const string ATK1_SKILL = "swordsmanship";
		const float ATK1_ACCURACY = 0.85;
		const float ATK1_DELAY_STRIKE = 0.2;
		const float ATK1_DURATION = 0.7;
		const int ATK1_OFS = 0;
		const int ATK1_ANG = 0;
		const string ATK1_CALLBACK = "atk1";
		const int ATK1_NOISE = 650;
		const string ATK1_SKILL_LEVEL = BASE_LEVEL_REQ;
		const int ATK1_MPDRAIN = 0;
		const int ATK1_DMG_MULTI = 0;
		const int ATK1_NO_AUTOAIM = 0;
		const string ATK1_PANIM = "axe_onehand_swing";
		const int ATK1_VANIM = 2;
		const string SOUND_ATK1 = "weapons/cbar_miss1.wav";
		const string PITCH_ATK1 = Random(100, 125);
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const int ATK2_RANGE = 110;
		const int ATK2_DMG_MULTI = 2;
		const float ATK2_DELAY_STRIKE = 0.4;
		const float ATK2_DURATION = 0.8;
		const string SOUND_ATK2 = SOUND_ATK1;
		const string PITCH_ATK2 = Random(80, 100);
		const string SOUND_BLOCK1 = "weapons/cbar_hit2.wav";
	}

	void bitem_draw()
	{
		PlayViewAnim("break");
		PlayAnim("once", "break");
		SetViewModel(VMODEL_FILE);
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		string L_PMODEL_IDX_HANDS = PMODEL_IDX_HANDS;
		if (BWEAPON_HANDS == "right")
		{
			L_PMODEL_IDX_HANDS += "game.item.hand_index";
		}
		SetModelBody(0, L_PMODEL_IDX_HANDS);
		SetAnimExt(PANIM_EXT);
		PlayAnim("once", WANIM_HAND);
		NEXT_BLOCK = GetGameTime();
		NEXT_BLOCK += 2.0;
		ScheduleDelayedEvent(0.1, "set_anims");
	}

	void set_anims()
	{
		if ((true))
		{
			if (!(SENT_HELP_TIP))
			{
				ShowHelpTip(GetOwner(), "vswordmatch", "MATCHED SET WEAPON", "If you can find another vampyric sword, you'll have no dual wield penalty with it!");
				SENT_HELP_TIP = 1;
			}
			check_matched();
			if (GetEntityProperty(OTHER_HAND, "itemname") == "fist_bare")
			{
				int SINGLE_HANDED = 1;
			}
			if (GetEntityProperty(OTHER_HAND, "itemname") == 0)
			{
				int SINGLE_HANDED = 1;
			}
			if ((SINGLE_HANDED))
			{
				set_anims_single();
				CallClientItemEvent(GetOwner(), "set_anims_single", 1);
			}
			else
			{
				set_anims_double();
				CallClientItemEvent(GetOwner(), "set_anims_double", 1);
			}
		}
	}

	void cl_play_draw()
	{
		if (HANDS_SINGLE == "HANDS_SINGLE")
		{
			ScheduleDelayedEvent(0.1, "cl_play_draw");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayViewAnim(C_VANIM_DRAW);
	}

	void cl_play_idle()
	{
		if (("game.item.attacking")) return;
		if (HANDS_SINGLE == "HANDS_SINGLE")
		{
			ScheduleDelayedEvent(0.1, "cl_play_idle");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		PlayViewAnim(C_VANIM_IDLE);
	}

	void set_anims_single()
	{
		HANDS_SINGLE = 1;
		C_VANIM_DRAW = VANIM_DRAW_SNG;
		C_VANIM_IDLE = VANIM_IDLE_SNG;
		if (!(false)) return;
		string DONT_IDLE = param1;
		if ((DONT_IDLE)) return;
		PlayViewAnim(C_VANIM_IDLE);
		LogDebug("*** set_anims_single");
	}

	void set_anims_double()
	{
		HANDS_SINGLE = 0;
		C_VANIM_DRAW = VANIM_DRAW;
		C_VANIM_IDLE = VANIM_IDLE;
		if (!(false)) return;
		string DONT_IDLE = param1;
		if ((DONT_IDLE)) return;
		PlayViewAnim(C_VANIM_IDLE);
		LogDebug("*** set_anims_double");
	}

	void game_switchhands()
	{
		set_idle();
	}

	void set_idle()
	{
		if ((true))
		{
			if ("game.item.hand_index" == 0)
			{
				OTHER_HAND = GetEntityProperty(GetOwner(), "scriptvar");
			}
			else
			{
				OTHER_HAND = GetEntityProperty(GetOwner(), "scriptvar");
			}
			if (GetEntityProperty(OTHER_HAND, "itemname") == "fist_bare")
			{
				int SINGLE_HANDED = 1;
			}
			if (GetEntityProperty(OTHER_HAND, "itemname") == 0)
			{
				int SINGLE_HANDED = 1;
			}
			if ((SINGLE_HANDED))
			{
				set_anims_single();
				CallClientItemEvent(GetOwner(), "set_anims_single");
			}
			else
			{
				set_anims_double();
				CallClientItemEvent(GetOwner(), "set_anims_double");
			}
		}
	}

	void check_keys_loop()
	{
		if (!(MATCHED_SET_ACTIVE)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		ScheduleDelayedEvent(0.25, "check_keys_loop");
		LAST_KEY_CHECK = GetGameTime();
		if ((BLOCK_ON))
		{
			if (!(IsKeyDown(GetOwner(), "use")))
			{
			}
			block_end();
		}
		if ((BLOCK_ON)) return;
		if (!(GetGameTime() > NEXT_BLOCK)) return;
		if (!(IsKeyDown(GetOwner(), "use"))) return;
		NEXT_BLOCK = GetGameTime();
		NEXT_BLOCK += 1.0;
		check_matched();
		if (!(MATCHED_SET_ACTIVE)) return;
		// TODO: splayviewanim ent_me VANIM_BLOCK
		BLOCK_ON = 1;
		PlayOwnerAnim("critical", "aim_fists");
		CallExternal(OTHER_HAND, "match_block_anim");
		lock_weapon();
	}

	void block_end()
	{
		if (!(BLOCK_ON)) return;
		// TODO: splayviewanim ent_me C_VANIM_IDLE
		BLOCK_ON = 0;
		NEXT_BLOCK = GetGameTime();
		NEXT_BLOCK += 1.0;
		PlayOwnerAnim("once", PANIM_IDLE);
		unlock_weapon();
		CallExternal(OTHER_HAND, "match_unblock_anim");
	}

	void game_putinpack()
	{
		if ((BLOCK_ON))
		{
			SetScriptFlags(GetOwner(), "remove", "wcre");
		}
		BLOCK_ON = 0;
		MATCHED_SET_ACTIVE = 0;
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(BLOCK_ON)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if ((param4).findFirst("target") == 0)
		{
			int CANT_BLOCK = 1;
		}
		if ((param4).findFirst("effect") >= 0)
		{
			int CANT_BLOCK = 1;
		}
		if ((GetEntityProperty(param2, "itemname")).findFirst("proj_arrow") == 0)
		{
			int CANT_BLOCK = 1;
		}
		if ((CANT_BLOCK)) return;
		if (!(param1 != GetEntityIndex(GetOwner()))) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		string OWNER_POS = GetEntityOrigin(GetOwner());
		string OWNER_ANG = GetEntityAngles(GetOwner());
		string ATTACKER_POS = GetEntityOrigin(param1);
		if (!(WithinCone2D(ATTACKER_POS, OWNER_POS, OWNER_ANG))) return;
		string INC_DMG = param3;
		string OUT_DMG = param3;
		OUT_DMG *= 0.25;
		SetDamage("dmg");
		string AMT_BLOCKED = INC_DMG;
		AMT_BLOCKED -= OUT_DMG;
		if (AMT_BLOCKED > 1)
		{
			string AMT_BLOCKED = int(AMT_BLOCKED);
		}
		EmitSound(GetOwner(), 4, SOUND_BLOCK1, 10);
		SendColoredMessage(GetOwner(), "Vampyric Swords blocked AMT_BLOCKED hp");
	}

	void match_block_anim()
	{
		// TODO: splayviewanim ent_me VANIM_BLOCK_OFH
	}

	void match_unblock_anim()
	{
		// TODO: splayviewanim ent_me C_VANIM_IDLE
	}

	void lock_weapon()
	{
		ApplyEffect(GetOwner(), "effects/effect_templock");
	}

	void unlock_weapon()
	{
		CallExternal(GetOwner(), "ext_end_templock");
	}

	void check_matched()
	{
		if ("game.item.hand_index" == 0)
		{
			OTHER_HAND = GetEntityProperty(GetOwner(), "scriptvar");
		}
		else
		{
			OTHER_HAND = GetEntityProperty(GetOwner(), "scriptvar");
		}
		if (GetEntityProperty(OTHER_HAND, "scriptvar") == MATCHED_SET_TYPE)
		{
			MATCHED_SET_ACTIVE = 1;
		}
		else
		{
			MATCHED_SET_ACTIVE = 0;
		}
		if (GetEntityProperty(OTHER_HAND, "itemname") == "fist_bare")
		{
			int SINGLE_HANDED = 1;
		}
		if (GetEntityProperty(OTHER_HAND, "itemname") == 0)
		{
			int SINGLE_HANDED = 1;
		}
		if ((SINGLE_HANDED))
		{
			set_anims_single();
			CallClientItemEvent(GetOwner(), "set_anims_single", 1);
		}
		else
		{
			set_anims_double();
			CallClientItemEvent(GetOwner(), "set_anims_double", 1);
		}
		if (!(MATCHED_SET_ACTIVE)) return;
		string L_LAST_KEY_CHECK = LAST_KEY_CHECK;
		L_LAST_KEY_CHECK += 1;
		if (GetGameTime() > L_LAST_KEY_CHECK)
		{
			check_keys_loop();
		}
		if (!(GAVE_MATCH_SET_MSG))
		{
			GAVE_MATCH_SET_MSG = 1;
			SendInfoMsg(GetOwner(), "MATCHED SET ABILITY Hold +use to block with Vampyric Blades");
		}
	}

	void ext_activate_items()
	{
		check_matched();
	}

	void atk1_start()
	{
		LogDebug("hands HANDS_SINGLE");
		if (!(HANDS_SINGLE))
		{
			int L_VANIM = 19;
		}
		else
		{
			string L_VANIM = RandomInt(8, 11);
		}
		PlayViewAnim(L_VANIM);
		PlayOwnerAnim("critical", ATK1_PANIM);
		EmitSound(GetOwner(), 1, SOUND_ATK1, 10);
	}

	void atk2_start()
	{
		LogDebug("hands HANDS_SINGLE");
		if (!(HANDS_SINGLE))
		{
			int L_VANIM = 17;
		}
		else
		{
			int L_VANIM = 17;
		}
		PlayViewAnim(L_VANIM);
		PlayOwnerAnim("critical", ATK2_PANIM);
		EmitSound(GetOwner(), 1, SOUND_ATK2, 10);
	}

	void atk1_damaged_other()
	{
		string PASS_PAR1 = param1;
		string PASS_PAR2 = param2;
		blood_drain(PASS_PAR1, PASS_PAR2);
	}

	void atk2_damaged_other()
	{
		string PASS_PAR1 = param1;
		string PASS_PAR2 = param2;
		blood_drain(PASS_PAR1, PASS_PAR2);
	}

	void atk1_end()
	{
		if ((true))
		{
			check_matched();
		}
		if (!(false)) return;
		ScheduleDelayedEvent(1.0, "cl_play_idle");
	}

	void atk2_end()
	{
		if ((true))
		{
			check_matched();
		}
		if (!(false)) return;
		ScheduleDelayedEvent(1.0, "cl_play_idle");
	}

	void blood_drain()
	{
		string HEAL_AMT = param2;
		HEAL_AMT *= 0.1;
		Effect("glow", GetOwner(), Vector3(0, 100, 0), 60, 0.5, 0.5);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param1), HEAL_AMT);
	}

}

}
