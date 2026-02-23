#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BowsSxbow : CGameScript
{
	int BOW_CHAMBER;
	string HITSCAN_DMG_MULTI;
	string NEXT_ATTACK;
	string RELOAD_DONE_AT;
	string UNDER_SKILLED;
	string WEAPON_PRIMARY_SKILL;

	BowsSxbow()
	{
		const int ITEM_NEVER_DELETE = 1;
		const int BASE_LEVEL_REQ = 35;
		const string RANGED_STAT = "archery";
		const float RANGED_DMG_MULTI = 1.5;
		WEAPON_PRIMARY_SKILL = RANGED_STAT;
		const string MODEL_VIEW = "viewmodels/v_steambow.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 80;
		const string VMODEL_FILE = "viewmodels/v_steambow.mdl";
		const string PMODEL_FILE = "weapons/p_weapons3.mdl";
		const int PMODEL_IDX_HANDS = 80;
		const int PMODEL_IDX_FLOOR = 82;
		const int VANIM_IDLE0 = 1;
		const int VANIM_FIRE = 7;
		const int VANIM_RELOAD1 = 14;
		const int VANIM_RELOAD2 = 15;
		const int VANIM_DRAW = 0;
		const string WANIM_HAND = "standard_idle";
		const string WANIM_FLOOR = "standard_floor_idle";
		BOW_CHAMBER = 0;
		Precache("weapons/reload1.wav");
		Precache("weapons/reload2.wav");
		Precache("weapons/reload3.wav");
		Precache("weapons/357_cock1.wav");
	}

	void OnSpawn() override
	{
		SetName("Steam Crossbow");
		SetDescription("A strange dwarven contraption");
		SetWeight(50);
		SetValue(4000);
		SetAnimExt("bow");
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetPlayerModel(MODEL_HANDS);
		SetHand("both");
		SetHUDSprite("trade", 147);
		register_attack();
	}

	void register_attack()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "0;0";
		int reg.attack.noautoaim = 1;
		string reg.attack.dmg.type = "pierce";
		int reg.attack.range = 1000;
		int reg.attack.energydrain = 0;
		string reg.attack.stat = "archery";
		int reg.attack.COF = 0;
		string reg.attack.projectile = "bolt";
		int reg.attack.priority = 10;
		float reg.attack.delay.strike = 0.0;
		float reg.attack.delay.end = 0.2;
		Vector3 reg.attack.ofs.startpos = Vector3(10, 10, -15);
		Vector3 reg.attack.ofs.aimang = Vector3(8, -4, 0);
		string reg.attack.callback = "ranged";
		string reg.attack.dmg.multi = RANGED_DMG_MULTI;
		int reg.attack.noise = 10;
		HITSCAN_DMG_MULTI = RANGED_DMG_MULTI;
		RegisterAttack();
	}

	void ranged_start()
	{
		CancelAttack();
	}

	void game_attack1_down()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		string L_ARROW_MENU_TIME = GetEntityProperty(GetOwner(), "scriptvar");
		if (L_ARROW_MENU_TIME > 0)
		{
			L_ARROW_MENU_TIME += 1.0;
		}
		if (GetGameTime() < L_ARROW_MENU_TIME)
		{
			NEXT_ATTACK = L_ARROW_MENU_TIME;
		}
		if (!(GetGameTime() > NEXT_ATTACK)) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > RELOAD_DONE_AT)) return;
		if (BOW_CHAMBER < 7)
		{
			int L_COF = 0;
			int L_SPEED = 1000;
			if ((UNDER_SKILLED))
			{
				int L_COF = 20;
				int L_SPEED = 300;
				string RND_LOCK = RandomInt(1, 3);
			}
			if (RND_LOCK == 1)
			{
				if (BOW_CHAMBER < 6)
				{
				}
				EmitSound(GetOwner(), 0, "weapons/357_reload1.wav", 10);
				SendColoredMessage(GetOwner(), "Your lack of proficiency causes you to jam the weapon.");
				NEXT_ATTACK = GetGameTime();
				NEXT_ATTACK += 4.0;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			BOW_CHAMBER += 1;
			string FIRE_ANIM = BOW_CHAMBER;
			FIRE_ANIM += VANIM_FIRE;
			// TODO: splayviewanim ent_me FIRE_ANIM
			string PLR_ARROW = GetEntityProperty(GetOwner(), "findbolt");
			LogDebug("arrowtype: PLR_ARROW");
			CallExternal(GetOwner(), "ext_tossprojectile", PLR_ARROW, "view", "none", L_SPEED, 0, L_COF, "archery");
			PlayOwnerAnim("hold", "xbow_idle");
			EmitSound(GetOwner(), 0, "weapons/xbow_reload1.wav", 10);
			EmitSound(GetOwner(), 0, "weapons/bow/crossbow.wav", 10);
		}
		LogDebug("chamber BOW_CHAMBER");
		if (BOW_CHAMBER >= 6)
		{
			do_reload();
		}
		else
		{
			ScheduleDelayedEvent(0.5, "do_idle");
			NEXT_ATTACK = GetGameTime();
			NEXT_ATTACK += 0.6;
		}
	}

	void game_+attack2()
	{
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_ATTACK)) return;
		if (BOW_CHAMBER == 0)
		{
			// TODO: splayviewanim ent_me IDLE_ANIM
		}
		if (!(BOW_CHAMBER > 0)) return;
		do_reload();
	}

	void do_reload()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		if (!(GetGameTime() > RELOAD_DONE_AT)) return;
		PlayOwnerAnim("once", "xbow_reload");
		EmitSound(GetOwner(), 0, "weapons/357_reload1.wav", 10);
		BOW_CHAMBER = 7;
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 5.0;
		// TODO: splayviewanim ent_me VANIM_RELOAD1
		RELOAD_DONE_AT = GetGameTime();
		RELOAD_DONE_AT += 3.35;
		RELOAD_DONE_AT += 2.515;
		ScheduleDelayedEvent(3.35, "do_reload2");
	}

	void do_reload2()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		PlayOwnerAnim("once", "xbow_reload");
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 2.515;
		// TODO: splayviewanim ent_me VANIM_RELOAD2
		BOW_CHAMBER = 0;
		ScheduleDelayedEvent(2.0, "pilot_light");
	}

	void pilot_light()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		// svplaysound: svplaysound 0 10 weapons/bow/steam.wav
		EmitSound(0, 10, "weapons/bow/steam.wav");
	}

	void do_idle()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar") == GetEntityIndex(GetOwner()))) return;
		string IDLE_ANIM = BOW_CHAMBER;
		IDLE_ANIM += VANIM_IDLE0;
		if (GetGameTime() < RELOAD_DONE_AT)
		{
			int IDLE_ANIM = 7;
		}
		if (BOW_CHAMBER == 7)
		{
			int IDLE_ANIM = 7;
		}
		// TODO: splayviewanim ent_me IDLE_ANIM
	}

	void OnDeploy() override
	{
		item_deploy();
		SetViewModel(VMODEL_FILE);
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetModelBody(0, PMODEL_IDX_HANDS);
		SetAnimExt("xbow");
		PlayViewAnim(VANIM_DRAW);
		PlayAnim("once", WANIM_HAND);
		if (!(true)) return;
		check_skill();
		if (BOW_CHAMBER > 0)
		{
			ScheduleDelayedEvent(0.1, "redeploy_idle");
		}
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 0.6;
	}

	void redeploy_idle()
	{
		string IDLE_ANIM = BOW_CHAMBER;
		IDLE_ANIM += VANIM_IDLE0;
		if (GetGameTime() < RELOAD_DONE_AT)
		{
			int IDLE_ANIM = 7;
		}
		// TODO: splayviewanim ent_me IDLE_ANIM
	}

	void game_show()
	{
		SetModel(PMODEL_FILE);
		SetWorldModel(PMODEL_FILE);
		SetModelBody(0, PMODEL_IDX_HANDS);
	}

	void OnDrop() override
	{
		item_drop();
	}

	void game_fall()
	{
		SetModelBody(0, PMODEL_IDX_FLOOR);
		PlayAnim("once", WANIM_FLOOR);
		weapon_fall();
	}

	void game_switchhands()
	{
		PlayViewAnim(IDLE_ANIM);
		item_switchhands();
	}

	void check_skill()
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += RANGED_STAT;
		if (GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += RANGED_STAT;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill OUT_STR");
			UNDER_SKILLED = 1;
		}
		else
		{
			if ((UNDER_SKILLED))
			{
				HITSCAN_DMG_MULTI = RANGED_DMG_MULTI;
			}
			UNDER_SKILLED = 0;
		}
		if (!(UNDER_SKILLED))
		{
			HITSCAN_DMG_MULTI = RANGED_DMG_MULTI;
		}
		else
		{
			HITSCAN_DMG_MULTI = 0.1;
		}
	}

}

}
