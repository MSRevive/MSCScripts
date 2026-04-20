#pragma context server

#include "items/base_weapon_new.as"

namespace MS
{

class SmallarmsCre : CGameScript
{
	float ATK1_ACCURACY;
	int ATK1_ANG;
	string ATK1_CALLBACK;
	float ATK1_DELAY_STRIKE;
	int ATK1_DMG;
	int ATK1_DMG_MULTI;
	int ATK1_DMG_RANGE;
	string ATK1_DMG_TYPE;
	float ATK1_DURATION;
	string ATK1_KEYS;
	int ATK1_MPDRAIN;
	int ATK1_NOISE;
	int ATK1_NO_AUTOAIM;
	int ATK1_OFS;
	string ATK1_PANIM;
	int ATK1_RANGE;
	string ATK1_SKILL;
	string ATK1_SKILL_LEVEL;
	float ATK1_STAMINA;
	string ATK1_TYPE;
	int ATK1_VANIM;
	string ATK2_ACCURACY;
	int ATK2_ADD_SKILL_REQ;
	int ATK2_AMMODRAIN;
	int ATK2_ANG;
	string ATK2_CALLBACK;
	int ATK2_COF;
	float ATK2_DELAY_STRIKE;
	string ATK2_DMG;
	int ATK2_DMG_MULTI;
	string ATK2_DMG_RANGE;
	string ATK2_DMG_TYPE;
	string ATK2_DURATION;
	int ATK2_IS_PROJECTILE;
	string ATK2_KEYS;
	int ATK2_MPDRAIN;
	string ATK2_NOISE;
	int ATK2_NO_AUTOAIM;
	int ATK2_OFS;
	string ATK2_PANIM;
	string ATK2_PROJECTILE;
	string ATK2_RANGE;
	string ATK2_SKILL;
	string ATK2_SKILL_LEVEL;
	string ATK2_STAMINA;
	string ATK2_TYPE;
	int ATK2_VANIM;
	int BASE_LEVEL_REQ;
	int BITEM_CUSTOM_ATK2_EVENT;
	int BLOCK_ON;
	int BWEAPON_CUSTOM_DRAW;
	int BWEAPON_CUSTOM_SWITCHHANDS;
	string BWEAPON_DESC;
	string BWEAPON_HANDS;
	int BWEAPON_INV_SPRITE_IDX;
	string BWEAPON_NAME;
	int BWEAPON_VALUE;
	int BWEAPON_WEIGHT;
	string CRE_TYPE;
	int C_VANIM_DRAW;
	int C_VANIM_IDLE;
	string GAVE_MATCH_SET_MSG;
	int HANDS_SINGLE;
	string LAST_KEY_CHECK;
	int MATCHED_SET;
	int MATCHED_SET_ACTIVE;
	string MATCHED_SET_TYPE;
	int MP_THROW;
	string NEXT_BLOCK;
	string OTHER_HAND;
	string PANIM_EXT;
	string PANIM_IDLE;
	float PITCH_ATK1;
	int PITCH_ATK2;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	string SOUND_ATK1;
	string SOUND_ATK2;
	string SOUND_BLOCK1;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	int VANIM_DRAW;
	int VANIM_DRAW_SNG;
	int VANIM_IDLE;
	int VANIM_IDLE_SNG;
	string VMODEL_FILE;
	int VMODEL_IDX;
	string WANIM_FLOOR;
	string WANIM_HAND;

	SmallarmsCre()
	{
		MATCHED_SET = 1;
		MATCHED_SET_TYPE = "crescent";
		MP_THROW = 10;
		CRE_TYPE = "slash";
		BWEAPON_NAME = "Crescent Blade";
		BWEAPON_DESC = "A viscious pair of curving blades (matched set)";
		BWEAPON_WEIGHT = 1;
		BWEAPON_VALUE = 3000;
		BWEAPON_INV_SPRITE_IDX = 193;
		BWEAPON_HANDS = "right";
		BASE_LEVEL_REQ = 30;
		BWEAPON_CUSTOM_DRAW = 1;
		BWEAPON_CUSTOM_SWITCHHANDS = 1;
		BITEM_CUSTOM_ATK2_EVENT = 1;
		VMODEL_FILE = "viewmodels/v_1hswords.mdl";
		VMODEL_IDX = 6;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 42;
		PMODEL_IDX_HANDS = 41;
		PANIM_IDLE = "aim_axe_onehand";
		PANIM_EXT = "knife";
		VANIM_DRAW = 0;
		VANIM_IDLE = 1;
		C_VANIM_DRAW = 0;
		C_VANIM_IDLE = 1;
		VANIM_DRAW_SNG = 6;
		VANIM_IDLE_SNG = 7;
		WANIM_FLOOR = "standard_floor_idle";
		WANIM_HAND = "standard_idle";
		ATK1_TYPE = "strike-land";
		ATK1_KEYS = "+attack1";
		ATK1_RANGE = 60;
		ATK1_DMG = 275;
		ATK1_DMG_RANGE = 5;
		ATK1_DMG_TYPE = "slash";
		ATK1_STAMINA = 0.1;
		ATK1_SKILL = "smallarms";
		ATK1_ACCURACY = 0.85;
		ATK1_DELAY_STRIKE = 0.5;
		ATK1_DURATION = 1.1;
		ATK1_OFS = 0;
		ATK1_ANG = 0;
		ATK1_CALLBACK = "atk1";
		ATK1_NOISE = 650;
		ATK1_SKILL_LEVEL = BASE_LEVEL_REQ;
		ATK1_MPDRAIN = 0;
		ATK1_DMG_MULTI = 0;
		ATK1_NO_AUTOAIM = 0;
		ATK1_PANIM = "axe_onehand_swing";
		ATK1_VANIM = 3;
		SOUND_ATK1 = "weapons/cbar_miss1.wav";
		PITCH_ATK1 = Random(125, 150);
		ATK2_TYPE = ATK1_TYPE;
		ATK2_KEYS = "-attack1";
		ATK2_RANGE = ATK1_RANGE;
		ATK2_DMG = ATK1_DMG;
		ATK2_DMG_RANGE = ATK1_DMG_RANGE;
		ATK2_DMG_TYPE = ATK1_DMG_TYPE;
		ATK2_STAMINA = ATK1_STAMINA;
		ATK2_SKILL = ATK1_SKILL;
		ATK2_ACCURACY = ATK1_ACCURACY;
		ATK2_DELAY_STRIKE = 0.3;
		ATK2_DURATION = ATK1_DURATION;
		ATK2_OFS = 0;
		ATK2_ANG = 0;
		ATK2_CALLBACK = "atk2";
		ATK2_NOISE = ATK1_NOISE;
		ATK2_SKILL_LEVEL = BASE_LEVEL_REQ;
		ATK2_ADD_SKILL_REQ = 2;
		ATK2_MPDRAIN = 0;
		ATK2_DMG_MULTI = 2;
		ATK2_NO_AUTOAIM = 0;
		ATK2_PANIM = "pole_swing";
		ATK2_VANIM = 5;
		ATK2_IS_PROJECTILE = 0;
		ATK2_PROJECTILE = "arrow";
		ATK2_AMMODRAIN = 1;
		ATK2_COF = 0;
		SOUND_ATK2 = "zombie/claw_miss2.wav";
		PITCH_ATK2 = 80;
		SOUND_HITWALL1 = "weapons/dagger/daggermetal1.wav";
		SOUND_HITWALL2 = "weapons/dagger/daggermetal2.wav";
		SOUND_BLOCK1 = "body/armour3.wav";
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
			int AMT_BLOCKED = int(AMT_BLOCKED);
		}
		EmitSound(GetOwner(), 4, SOUND_BLOCK1, 10);
		SendColoredMessage(GetOwner(), "Crescents blocked " + AMT_BLOCKED + " hp");
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
