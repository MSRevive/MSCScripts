#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesGoldenRef : CGameScript
{
	int BROKEN;
	string HOLY_DMG;
	int SPEC_ATTACK;

	AxesGoldenRef()
	{
		const int THIS_NO_BREAK = 1;
		const int BASE_LEVEL_REQ = 15;
		const int CUSTOM_AXE_SECONDARY = 1;
		const int FINAL_VALUE = 5000;
		const string BREAK_SOUND = "debris/bustmetal1.wav";
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string SOUND_SWIPE = "magic/energy4.wav";
		const int MODEL_BODY_OFS = 80;
		const string ANIM_PREFIX = "khopesh";
		const int BREAK_CHANCE = 2;
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 3;
		const int MELEE_DMG = 400;
		const int MELEE_DMG_RANGE = 100;
		const string MELEE_DMG_TYPE = "holy";
		const float MELEE_ACCURACY = 0.24;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Unbreakable Golden Axe");
		SetHUDSprite("trade", 110);
		SetDescription("A holy axe , forged by the dwarves of Urdual");
		SetWeight(90);
		SetSize(25);
		SetValue(FINAL_VALUE);
		SetHand("both");
	}

	void OnSpawn() override
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 90;
		string reg.attack.dmg = MELEE_DMG;
		reg.attack.dmg *= 8;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		int reg.attack.aoe.range = 100;
		float reg.attack.aoe.falloff = 1.5;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		reg.attack.hitchance += 0.1;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.7;
		float reg.attack.delay.end = 2.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void special_02_start()
	{
		SPEC_ATTACK = 1;
		EmitSound(GetOwner(), 0, "magic/energy1.wav", 10);
	}

	void special_02_strike()
	{
		break_check();
	}

	void hitwall()
	{
		if ((BROKEN)) return;
		break_check();
	}

	void melee_start()
	{
		SPEC_ATTACK = 0;
	}

	void melee_strike()
	{
		string TARGET_ID = GetEntityProperty(GetOwner(), "target");
		if (!(IsEntityAlive(TARGET_ID))) return;
		break_check();
		if ((BROKEN)) return;
		string WACKING_RACE = /* TODO: $get_takedmg */ $get_takedmg(TARGET_ID, "holy");
		if (!(WACKING_RACE == 0)) return;
		SendPlayerMessage("This", "weapon is only effective against the undead and unholy");
	}

	void break_check()
	{
		if ((THIS_NO_BREAK)) return;
		if ((BROKEN)) return;
		if (!(RandomInt(1, 100) < BREAK_CHANCE)) return;
		BROKEN = 1;
		SetViewModel("none");
		EmitSound(GetOwner(), 0, BREAK_SOUND, 10);
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 0.3, 30, 10, 5, 1.0);
		SendPlayerMessage(YOUR, "GOLDEN AXE HAS BROKEN!");
		ScheduleDelayedEvent(0.2, "break_msg2");
	}

	void break_msg2()
	{
		SendPlayerMessage("You", "might want to ask the mayor of Gatecity about this.");
		SpawnNPC("monsters/companion/giver", /* TODO: $replos */ $replos(0, 0, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "item_gaxe_handle"
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(SPEC_ATTACK)) return;
		SPEC_ATTACK = 0;
		string MY_OWNER = GetEntityIndex(GetOwner());
		string MY_TARGET = param2;
		HOLY_DMG = GetSkillLevel(GetOwner(), "spellcasting.divination");
		HOLY_DMG *= 8.0;
		CallExternal(MY_TARGET, "turn_undead", HOLY_DMG, MY_OWNER);
	}

}

}
