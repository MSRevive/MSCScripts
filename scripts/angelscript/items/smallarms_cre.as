#pragma context server

#include "items/base_weapon_new.as"

namespace MS
{

class SmallarmsCre : CGameScript
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

	SmallarmsCre()
	{
		MATCHED_SET = 1;
		MATCHED_SET_TYPE = "crescent";
		const int MP_THROW = 10;
		const string CRE_TYPE = "slash";
		const string BWEAPON_NAME = "Crescent Blade";
		const string BWEAPON_DESC = "A viscious pair of curving blades (matched set)";
		const int BWEAPON_WEIGHT = 1;
		const int BWEAPON_VALUE = 3000;
		const int BWEAPON_INV_SPRITE_IDX = 193;
		const string BWEAPON_HANDS = "right";
		const int BASE_LEVEL_REQ = 30;
		const int BWEAPON_CUSTOM_DRAW = 1;
		const int BWEAPON_CUSTOM_SWITCHHANDS = 1;
		const int BITEM_CUSTOM_ATK2_EVENT = 1;
		const string VMODEL_FILE = "viewmodels/v_1hswords.mdl";
		const int VMODEL_IDX = 6;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 42;
		const int PMODEL_IDX_HANDS = 41;
		const string PANIM_IDLE = "aim_axe_onehand";
		const string PANIM_EXT = "knife";
		const int VANIM_DRAW = 0;
		const int VANIM_IDLE = 1;
		C_VANIM_DRAW = 0;
		C_VANIM_IDLE = 1;
		const int VANIM_DRAW_SNG = 6;
		const int VANIM_IDLE_SNG = 7;
		const string WANIM_FLOOR = "standard_floor_idle";
		const string WANIM_HAND = "standard_idle";
		const string ATK1_TYPE = "strike-land";
		const string ATK1_KEYS = "+attack1";
		const int ATK1_RANGE = 60;
		const int ATK1_DMG = 275;
		const int ATK1_DMG_RANGE = 5;
		const string ATK1_DMG_TYPE = "slash";
		const float ATK1_STAMINA = 0.1;
		const string ATK1_SKILL = "smallarms";
		const float ATK1_ACCURACY = 0.85;
		const float ATK1_DELAY_STRIKE = 0.5;
		const float ATK1_DURATION = 1.1;
		const int ATK1_OFS = 0;
		const int ATK1_ANG = 0;
		const string ATK1_CALLBACK = "atk1";
		const int ATK1_NOISE = 650;
		const string ATK1_SKILL_LEVEL = BASE_LEVEL_REQ;
		const int ATK1_MPDRAIN = 0;
		const int ATK1_DMG_MULTI = 0;
		const int ATK1_NO_AUTOAIM = 0;
		const string ATK1_PANIM = "axe_onehand_swing";
		const int ATK1_VANIM = 3;
		const string SOUND_ATK1 = "weapons/cbar_miss1.wav";
		const string PITCH_ATK1 = Random(125, 150);
		const string ATK2_TYPE = ATK1_TYPE;
		const string ATK2_KEYS = "-attack1";
		const string ATK2_RANGE = ATK1_RANGE;
		const string ATK2_DMG = ATK1_DMG;
		const string ATK2_DMG_RANGE = ATK1_DMG_RANGE;
		const string ATK2_DMG_TYPE = ATK1_DMG_TYPE;
		const string ATK2_STAMINA = ATK1_STAMINA;
		const string ATK2_SKILL = ATK1_SKILL;
		const string ATK2_ACCURACY = ATK1_ACCURACY;
		const float ATK2_DELAY_STRIKE = 0.3;
		const string ATK2_DURATION = ATK1_DURATION;
		const int ATK2_OFS = 0;
		const int ATK2_ANG = 0;
		const string ATK2_CALLBACK = "atk2";
		const string ATK2_NOISE = ATK1_NOISE;
		const string ATK2_SKILL_LEVEL = BASE_LEVEL_REQ;
		const int ATK2_ADD_SKILL_REQ = 2;
		const int ATK2_MPDRAIN = 0;
		const int ATK2_DMG_MULTI = 2;
		const int ATK2_NO_AUTOAIM = 0;
		const string ATK2_PANIM = "pole_swing";
		const int ATK2_VANIM = 5;
		const int ATK2_IS_PROJECTILE = 0;
		const string ATK2_PROJECTILE = "arrow";
		const int ATK2_AMMODRAIN = 1;
		const int ATK2_COF = 0;
		const string SOUND_ATK2 = "zombie/claw_miss2.wav";
		const int PITCH_ATK2 = 80;
		const string SOUND_HITWALL1 = "weapons/dagger/daggermetal1.wav";
		const string SOUND_HITWALL2 = "weapons/dagger/daggermetal2.wav";
		const string SOUND_BLOCK1 = "body/armour3.wav";
	}

	void bitem_draw()
	{
		PlayViewAnim("break");
		PlayAnim("once", "break");
		SetViewModel(VMODEL_FILE);
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		string L_PMODEL_IDX_HANDS = PMODEL_IDX_HANDS;
		L_PMODEL_IDX_HANDS -= "game.item.hand_index";
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
				ShowHelpTip(GetOwner(), "crematch", "MATCHED SET WEAPON", "If you can find another crescent weapon, you'll have no dual weild penalty with it!");
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
		if (!(false)) return;
		cl_play_draw();
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
	}

	void game_switchhands()
	{
		set_idle();
	}

	void atk1_end()
	{
		if ((true))
		{
			check_matched();
		}
		if (!(false)) return;
		cl_play_idle();
	}

	void atk2_end()
	{
		if ((true))
		{
			check_matched();
		}
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

	void atk2_start()
	{
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < MP_THROW)
		{
			// TODO: splayviewanim ent_me 9
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// TODO: splayviewanim ent_me 15
		PlayOwnerAnim("critical", ATK2_PANIM);
		EmitSound(GetOwner(), 1, SOUND_ATK2, 10);
	}

	void atk2_strike()
	{
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < MP_THROW)
		{
			SendColoredMessage(GetOwner(), "Crescent Blade: Insufficient mana for shadow throw");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		CallExternal(GetOwner(), "ext_tosscre", int("game.item.hand_index"), CRE_TYPE);
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
		// TODO: splayviewanim ent_me 14
		BLOCK_ON = 1;
		PlayOwnerAnim("critical", "aim_fists");
		CallExternal(OTHER_HAND, "match_block_anim");
		lock_weapon();
		SetScriptFlags(GetOwner(), "add", "wcre", "nopush", 1, -1, "none");
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
		SetScriptFlags(GetOwner(), "remove", "wcre");
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
		SendColoredMessage(GetOwner(), "Crescents blocked AMT_BLOCKED hp");
	}

	void match_block_anim()
	{
		// TODO: splayviewanim ent_me 14
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
		if (GetEntityProperty(OTHER_HAND, "scriptvar") == "crescent")
		{
			MATCHED_SET_ACTIVE = 1;
		}
		else
		{
			MATCHED_SET_ACTIVE = 0;
		}
		LogDebug("check_matched MATCHED_SET_ACTIVE");
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
			SendInfoMsg(GetOwner(), "MATCHED SET ABILITY Hold +use to block with crescent blades");
		}
	}

	void ext_activate_items()
	{
		check_matched();
	}

	void bweapon_effect_remove()
	{
		if (!(BLOCK_ON)) return;
		SetScriptFlags(GetOwner(), "remove", "wcre");
	}

}

}
