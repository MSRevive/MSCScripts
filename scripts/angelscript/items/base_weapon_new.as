#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseWeaponNew : CGameScript
{
	int ATK1_ACCURACY;
	int ATK1_AMMODRAIN;
	int ATK1_ANG;
	string ATK1_CALLBACK;
	int ATK1_COF;
	float ATK1_DELAY_STRIKE;
	int ATK1_DMG;
	int ATK1_DMG_MULTI;
	int ATK1_DMG_RANGE;
	string ATK1_DMG_TYPE;
	float ATK1_DURATION;
	int ATK1_IS_PROJECTILE;
	string ATK1_KEYS;
	int ATK1_MPDRAIN;
	int ATK1_NOISE;
	int ATK1_NO_AUTOAIM;
	int ATK1_OFS;
	string ATK1_PANIM;
	string ATK1_PROJECTILE;
	int ATK1_RANGE;
	string ATK1_SKILL;
	string ATK1_SKILL_LEVEL;
	int ATK1_STAMINA;
	string ATK1_TYPE;
	int ATK1_VANIM;
	string ATK2_ACCURACY;
	int ATK2_ADD_SKILL_REQ;
	int ATK2_AMMODRAIN;
	int ATK2_ANG;
	string ATK2_CALLBACK;
	int ATK2_COF;
	string ATK2_DELAY_STRIKE;
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
	string BITEM_UNDERSKILLED;
	string BITEM_WAS_UNDERSKILLED;
	string BWEAPON_CHARGE_PERCENT;
	float BWEAPON_DBL_CHARGE_ADJ;
	string GAME_PVP;
	int PITCH_ATK1;
	int PITCH_ATK2;
	string SOUND_ATK1;
	string SOUND_ATK2;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string WEAPON_PRIMARY_SKILL;

	BaseWeaponNew()
	{
		BWEAPON_DBL_CHARGE_ADJ = 2.0;
		ATK1_TYPE = "strike-land";
		ATK1_KEYS = "+attack1";
		ATK1_RANGE = 90;
		ATK1_DMG = 120;
		ATK1_DMG_RANGE = 10;
		ATK1_DMG_TYPE = "blunt";
		ATK1_STAMINA = 1;
		ATK1_SKILL = "polearms";
		ATK1_ACCURACY = 85;
		ATK1_DELAY_STRIKE = 0.6;
		ATK1_DURATION = 1.1;
		ATK1_OFS = 0;
		ATK1_ANG = 0;
		ATK1_CALLBACK = "atk1";
		ATK1_NOISE = 650;
		ATK1_SKILL_LEVEL = BASE_LEVEL_REQ;
		ATK1_MPDRAIN = 0;
		ATK1_DMG_MULTI = 0;
		ATK1_NO_AUTOAIM = 0;
		ATK1_PANIM = "pole_swing";
		ATK1_VANIM = 4;
		SOUND_ATK1 = "weapons/cbar_miss1.wav";
		PITCH_ATK1 = 100;
		ATK1_IS_PROJECTILE = 0;
		ATK1_PROJECTILE = "arrow";
		ATK1_AMMODRAIN = 1;
		ATK1_COF = 0;
		ATK2_TYPE = ATK1_TYPE;
		ATK2_KEYS = "-attack1";
		ATK2_RANGE = ATK1_RANGE;
		ATK2_DMG = ATK1_DMG;
		ATK2_DMG_RANGE = ATK1_DMG_RANGE;
		ATK2_DMG_TYPE = AT1_DMG_TYPE;
		ATK2_STAMINA = ATK1_STAMINA;
		ATK2_SKILL = ATK1_SKILL;
		ATK2_ACCURACY = ATK1_ACCURACY;
		ATK2_DELAY_STRIKE = ATK1_DELAY_STRIKE;
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
		PITCH_ATK2 = 100;
		SOUND_HITWALL1 = "weapons/bullet_hit1.wav";
		SOUND_HITWALL2 = "weapons/bullet_hit2.wav";
	}

	void OnSpawn() override
	{
		SetName(BWEAPON_NAME);
		SetDescription("BWEAPON_DESC");
		SetWeight(BWEAPON_WEIGHT);
		SetSize(1);
		SetValue(BWEAPON_VALUE);
		SetHUDSprite("trade", BWEAPON_INV_SPRITE_IDX);
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetHand(BWEAPON_HANDS);
		bitem_register_attacks();
	}

	void OnDeploy() override
	{
		bitem_draw();
		if (!(true)) return;
		GAME_PVP = "game.pvp";
		ScheduleDelayedEvent(0.01, "bitem_check_skill");
		ScheduleDelayedEvent(0.01, "bitem_setup_model");
	}

	void game_show()
	{
		bweapon_show();
	}

	void bweapon_show()
	{
		SetViewModel(VMODEL_FILE);
		SetModel(PMODEL_FILE);
		if ("game.item.hand_index" == 0)
		{
			SetModelBody(0, PMODEL_IDX_HAND_LEFT);
		}
		else
		{
			SetModelBody(0, PMODEL_IDX_HAND_RIGHT);
		}
	}

	void game_switchhands()
	{
		if ((BWEAPON_CUSTOM_SWITCHHANDS)) return;
		PlayViewAnim(VANIM_IDLE);
	}

	void OnPickup(CBaseEntity@ player) override
	{
		bitem_draw();
	}

	void game_fall()
	{
		SetModelBody(0, PMODEL_IDX_FLOOR);
		PlayAnim("once", WANIM_FLOOR);
	}

	void OnDrop() override
	{
		string RL_HAND = "game.item.hand_index";
		CallExternal(GetOwner(), "ext_set_hand_id", RL_HAND, 0);
	}

	void bitem_draw()
	{
		if ((BWEAPON_CUSTOM_DRAW)) return;
		PlayViewAnim("break");
		PlayAnim("once", "break");
		bweapon_show();
		SetAnimExt(PANIM_EXT);
		if (!(false)) return;
		PlayViewAnim(VANIM_DRAW);
		PlayAnim("once", WANIM_HAND);
	}

	void bitem_setup_model()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") VMODEL_IDX
		ScheduleDelayedEvent(1.0, "bitem_setup_model2");
	}

	void bitem_setup_model2()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		LogDebug("bi_setup_model2");
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") VMODEL_IDX
	}

	void bitem_register_attacks()
	{
		if (!(BITEM_CUSTOM_ATK1_REGISTER))
		{
			int reg.attack.priority = 0;
			string reg.attack.type = ATK1_TYPE;
			string reg.attack.keys = ATK1_KEYS;
			string reg.attack.range = ATK1_RANGE;
			string reg.attack.dmg = ATK1_DMG;
			string reg.attack.dmg.range = ATK1_DMG_RANGE;
			string reg.attack.dmg.type = ATK1_DMG_TYPE;
			string reg.attack.energydrain = ATK1_STAMINA;
			string reg.attack.stat = ATK1_SKILL;
			string reg.attack.hitchance = ATK1_ACCURACY;
			string reg.attack.delay.strike = ATK1_DELAY_STRIKE;
			string reg.attack.delay.end = ATK1_DURATION;
			string reg.attack.ofs.startpos = ATK1_OFS;
			string reg.attack.ofs.aimang = ATK1_ANG;
			string reg.attack.callback = ATK1_CALLBACK;
			string reg.attack.noise = ATK1_NOISE;
			string reg.attack.mpdrain = ATK1_MPDRAIN;
			string reg.attack.dmg.multi = ATK1_DMG_MULTI;
			string reg.attack.noautoaim = ATK1_NO_AUTOAIM;
			string reg.attack.reqskill = ATK1_SKILL_LEVEL;
			WEAPON_PRIMARY_SKILL = reg.attack.stat;
			if ((ATK1_IS_PROJECTILE))
			{
				string reg.attack.ammodrain = ATK1_AMMODRAIN;
				string reg.attack.projectile = ATK1_PROJECTILE;
				string reg.attack.COF = ATK1_COF;
			}
			RegisterAttack();
		}
		if (!(BITEM_CUSTOM_ATK2_REGISTER))
		{
			int reg.attack.priority = 1;
			int reg.attack.chargeamt = 100;
			string reg.attack.type = ATK2_TYPE;
			string reg.attack.keys = ATK2_KEYS;
			string reg.attack.range = ATK2_RANGE;
			string reg.attack.dmg = ATK2_DMG;
			string reg.attack.dmg.range = ATK2_DMG_RANGE;
			string reg.attack.dmg.type = ATK2_DMG_TYPE;
			string reg.attack.energydrain = ATK2_STAMINA;
			string reg.attack.stat = ATK2_SKILL;
			string reg.attack.hitchance = ATK2_ACCURACY;
			string reg.attack.delay.strike = ATK2_DELAY_STRIKE;
			string reg.attack.delay.end = ATK2_DURATION;
			string reg.attack.ofs.startpos = ATK2_OFS;
			string reg.attack.ofs.aimang = ATK2_ANG;
			string reg.attack.callback = ATK2_CALLBACK;
			string reg.attack.noise = ATK2_NOISE;
			string reg.attack.mpdrain = ATK2_MPDRAIN;
			string reg.attack.dmg.multi = ATK2_DMG_MULTI;
			LogDebug("GetEntityName(GetOwner()) multi ATK2_DMG_MULTI");
			if (ATK2_DMG_MULTI != 0)
			{
				reg.attack.dmg *= ATK2_DMG_MULTI;
			}
			string reg.attack.noautoaim = ATK2_NO_AUTOAIM;
			string reg.attack.reqskill = ATK2_SKILL_LEVEL;
			reg.attack.reqskill += ATK2_ADD_SKILL_REQ;
			if ((ATK2_IS_PROJECTILE))
			{
				string reg.attack.ammodrain = ATK2_AMMODRAIN;
				string reg.attack.projectile = ATK2_PROJECTILE;
				string reg.attack.COF = ATK2_COF;
			}
			RegisterAttack();
		}
	}

	void game_attack_cancel()
	{
		PlayOwnerAnim("once", PANIM_IDLE);
	}

	void game_hitworld()
	{
		if ((BWEAPON_CUSTOM_HITWALL)) return;
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void atk1_start()
	{
		if ((BITEM_CUSTOM_ATK1_EVENT)) return;
		PlayViewAnim(ATK1_VANIM);
		PlayOwnerAnim("critical", ATK1_PANIM);
		EmitSound(GetOwner(), 1, SOUND_ATK1, 10);
	}

	void atk2_start()
	{
		if ((BITEM_CUSTOM_ATK2_EVENT)) return;
		PlayViewAnim(ATK2_VANIM);
		PlayOwnerAnim("critical", ATK2_PANIM);
		EmitSound(GetOwner(), 1, SOUND_ATK2, 10);
	}

	void bitem_check_skill()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += ATK1_SKILL;
		string L_OWNER_SKILL = GetEntityProperty(GetOwner(), "find_melee_stat");
		LogDebug("bitem_check_skill FIND_MELEE_STAT L_OWNER_SKILL");
		if (L_OWNER_SKILL < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += ATK1_SKILL;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill " + OUT_STR);
			BITEM_UNDERSKILLED = 1;
			BITEM_WAS_UNDERSKILLED = 1;
			SetAttackProp("ent_me", 0);
		}
		else
		{
			BITEM_UNDERSKILLED = 0;
			if ((BITEM_WAS_UNDERSKILLED))
			{
			}
			SetAttackProp("ent_me", 0);
			BITEM_WAS_UNDERSKILLED = 0;
		}
	}

	void game_setchargepercent()
	{
		BWEAPON_CHARGE_PERCENT = param1;
	}

	void atk1_damaged_other()
	{
		if (BWEAPON_CHARGE_PERCENT > 0.25)
		{
			BWEAPON_CHARGE_PERCENT -= 0.25;
			string L_CHARGE_RATIO = /* TODO: $ratio */ $ratio(BWEAPON_CHARGE_PERCENT, 1.25, BWEAPON_DBL_CHARGE_ADJ);
			string NEW_DMG = param2;
			NEW_DMG *= L_CHARGE_RATIO;
			SetDamage("dmg");
			return;
			LogDebug("Adjusted dmg x L_CHARGE_RATIO");
			BWEAPON_CHARGE_PERCENT = 0;
			string CUR_DRAIN = MELEE_ENERGY;
			CUR_DRAIN *= BWEAPON_CHARGE_PERCENT;
			DrainStamina(GetOwner());
		}
	}

}

}
