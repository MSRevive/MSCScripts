#pragma context server

#include "items/base_melee.as"

namespace MS
{

class BluntRavenmace : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_CHARGE;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	string EFFECT_SCRIPT;
	int FIRST_ATK_ANIM;
	string HASTE_FX_ID;
	int IN_HASTE;
	int LAST_ATK_ANIM;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HEARTBEAT;
	string SOUND_SWIPE;

	BluntRavenmace()
	{
		BASE_LEVEL_REQ = 15;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_ATTACK4 = 5;
		FIRST_ATK_ANIM = 2;
		LAST_ATK_ANIM = 5;
		ANIM_CHARGE = 6;
		ANIM_SHEATH = 7;
		MELEE_STAT = "bluntarms";
		MELEE_DMG_TYPE = "blunt";
		MELEE_SOUND = SOUND_SWIPE;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		PLAYERANIM_AIM = "bluntdouble";
		PLAYERANIM_SWING = "swing_bluntdouble";
		MELEE_DMG = 140;
		MELEE_DMG_RANGE = 140;
		MELEE_ENERGY = 1;
		MELEE_RANGE = 70;
		MELEE_DMG_DELAY = 0.8;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ACCURACY = 0.6;
		MELEE_PARRY_AUGMENT = 0.0;
		EFFECT_SCRIPT = "effects/debuff_stun";
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 3;
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_BODY_OFS = 74;
		ANIM_PREFIX = "ravenmace";
		SOUND_HEARTBEAT = "amb/wind.wav";
		IN_HASTE = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(13);
		if ((IN_HASTE))
		{
		}
		// svplaysound: svplaysound 2 10 amb/wind.wav
		EmitSound(2, 10, "amb/wind.wav");
	}

	void game_precache()
	{
		Precache(MODEL_VIEW);
		Precache(MODEL_WORLD);
		Precache(MODEL_HANDS);
		Precache(SOUND_HEARTBEAT);
	}

	void weapon_spawn()
	{
		SetName("Raven Mace");
		SetDescription("An ornate maul hasted by infernal magics");
		SetWeight(100);
		SetSize(15);
		SetValue(1100);
		SetHand("both");
		SetHUDSprite("hand", 101);
		SetHUDSprite("trade", 101);
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		reg.attack.hitchance += 0.1;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		RegisterAttack();
	}

	void bweapon_effect_activate()
	{
		haste_go();
		IN_HASTE = 1;
	}

	void bweapon_effect_remove()
	{
		speed_remove();
		IN_HASTE = 0;
	}

	void special_01_start()
	{
		PlayViewAnim(ANIM_CHARGE);
		PlayOwnerAnim("once", "swing_bluntdouble");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void melee_start()
	{
		MELEE_VIEWANIM_ATK = RandomInt(FIRST_ATK_ANIM, LAST_ATK_ANIM);
		PlayViewAnim(MELEE_VIEWANIM_ATK);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void bash()
	{
		PlayViewAnim(ANIM_CHARGE);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void game_dodamage()
	{
		MELEE_VIEWANIM_ATK = RandomInt(FIRST_ATK_ANIM, LAST_ATK_ANIM);
	}

	void special_02_start()
	{
		PlayViewAnim(ANIM_CHARGE);
		PlayOwnerAnim("once", "swing_bluntdouble");
		ScheduleDelayedEvent(0.9, "bash");
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SWORDREADY')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_damaged_other()
	{
		string maxstun = GetSkillLevel(GetOwner(), "bluntarms.prof");
		maxstun += 1;
		maxstun = max(1, min(35, maxstun));
		float stuntime = Random(1, GetSkillLevel(GetOwner(), "bluntarms.prof"));
		ApplyEffect(param1, EFFECT_SCRIPT, stuntime, 0, 0, GetEntityIndex(GetOwner()));
	}

	void speed_remove()
	{
		// svplaysound: svplaysound 2 0 amb/wind.wav
		EmitSound(2, 0, "amb/wind.wav");
		// TODO: setgaitspeed 1.0
		string L_SCRIPTFLAG = GetEntityProperty(GetOwner(), "itemname");
		CallExternal(GetOwner(), "plr_update_speed_effects", "remove", L_SCRIPTFLAG);
		ClientEvent("update", "all", HASTE_FX_ID, "effect_die");
	}

	void speed_add()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		string L_SCRIPTFLAG = GetEntityProperty(GetOwner(), "itemname");
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), L_SCRIPTFLAG, "name_exists"))) return;
		// TODO: setgaitspeed 3.0
		CallExternal(GetOwner(), "plr_change_speed", -1, 5.0, L_SCRIPTFLAG);
		ClientEvent("new", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()));
		HASTE_FX_ID = "game.script.last_sent_id";
	}

	void haste_go()
	{
		speed_add();
	}

}

}
