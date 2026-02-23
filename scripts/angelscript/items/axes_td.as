#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class AxesTd : CGameScript
{
	int AXE_RESTORED;
	int THROWING_AXE;

	AxesTd()
	{
		const int BASE_LEVEL_REQ = 25;
		const int NO_IDLE = 1;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 9;
		const int ANIM_ATTACK2 = 10;
		const int ANIM_ATTACK3 = 11;
		const int ANIM_SHEATH = 5;
		const int MELEE_VIEWANIM_ATK = 9;
		const string MODEL_VIEW = "viewmodels/v_1haxes.mdl";
		const int MODEL_VIEW_IDX = 5;
		const int TOM_SKIN = 4;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 20;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 0.7;
		const float MELEE_ENERGY = 0.1;
		const int MELEE_DMG = 180;
		const int MELEE_DMG_RANGE = 70;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Dark Tomahawk");
		SetDescription("A cursed tomahawk of ancient times");
		SetWeight(30);
		SetSize(25);
		SetValue(2500);
		SetHUDSprite("hand", "axe");
		SetHUDSprite("trade", 175);
		bw_setup_model();
	}

	void OnDeploy() override
	{
		ScheduleDelayedEvent(0.1, "toma_setup_skin");
	}

	void toma_setup_skin()
	{
		SetProp(GetOwner(), "skin", TOM_SKIN);
	}

	void bw_setup_model()
	{
		// TODO: UNCONVERTED: setmodelskin TOM_SKIN
		// TODO: setviewmodelprop ent_me skin TOM_SKIN
		SetProp(GetOwner(), "skin", TOM_SKIN);
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 4096;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "slash";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "axehandling";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "axethrow";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 27;
		RegisterAttack();
	}

	void axethrow_start()
	{
		AXE_RESTORED = 0;
		SetModel("none");
		SetWorldModel("none");
		SetViewModel("viewmodels/v_martialarts.mdl");
		PlayViewAnim(4);
		if (!(true)) return;
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") 0
		// svplaysound: svplaysound 0 8 $get(ent_owner,scriptvar,'PLR_SOUND_JAB2')
		EmitSound(0, 8, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void axethrow_strike()
	{
		PlayOwnerAnim("critical", "bow_release");
		if (!(true)) return;
		string END_TARGET = param2;
		string MY_VIEW = GetEntityProperty(GetOwner(), "viewangles");
		LogDebug("axethrow_strike PARAM1");
		if (param1 != "world")
		{
			END_TARGET += /* TODO: $relpos */ $relpos(MY_VIEW, Vector3(0, 128, 0));
		}
		string DMG_AXE = GetSkillLevel(GetOwner(), "axehandling");
		DMG_AXE *= 1.5;
		SpawnNPC("monsters/summon/tomahawk", GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), END_TARGET, DMG_AXE, GetEntityIndex(GetOwner()), MELEE_DMG_TYPE
		ApplyEffect(GetOwner(), "effects/effect_templock");
	}

	void restore_axe_cl()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		if ((AXE_RESTORED)) return;
		PlayViewAnim(ANIM_LIFT1);
	}

	void catch_axe()
	{
		LogDebug("Caught Axe");
		if ((true))
		{
			CallClientItemEvent(GetOwner(), "restore_axe_cl");
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
		}
		CallExternal(GetOwner(), "ext_end_templock");
		THROWING_AXE = 0;
		ClientCommand(GetOwner(), "+attack");
		ScheduleDelayedEvent(0.5, "catch_axe2");
	}

	void catch_axe2()
	{
		ClientCommand(GetOwner(), "-attack");
	}

	void melee_start()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		AXE_RESTORED = 1;
	}

}

}
