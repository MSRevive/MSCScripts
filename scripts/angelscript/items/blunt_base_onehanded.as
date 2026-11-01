#pragma context server

#include "items/base_melee.as"

namespace MS
{

class BluntBaseOnehanded : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	string EFFECT_SCRIPT;
	string MELEE_DMG_TYPE;
	float MELEE_PARRY_AUGMENT;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWIPE;
	string SPECIAL_02_CALLBACK;
	float SPECIAL_02_DELAY_END;
	float SPECIAL_02_DELAY_STRIKE;
	string SPECIAL_02_RANGE;

	BluntBaseOnehanded()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_STAT = "bluntarms";
		MELEE_DMG_TYPE = "blunt";
		MELEE_SOUND = SOUND_SWIPE;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		PLAYERANIM_AIM = "blunt";
		PLAYERANIM_SWING = "swing_blunt";
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_AUGMENT = 0.0;
		ANIM_PREFIX = "rustedaxe";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		MODEL_HANDS = MODEL_WORLD;
		EFFECT_SCRIPT = "effects/debuff_stun";
		SPECIAL_02_CALLBACK = "special_02";
		SPECIAL_02_DELAY_STRIKE = 1.5;
		SPECIAL_02_DELAY_END = 2.0;
		SPECIAL_02_RANGE = MELEE_RANGE;
		SOUND_HITWALL1 = "weapons/xbow_hitbod1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
	}

	void weapon_spawn()
	{
		SetHand("right");
		if ((CUSTOM_REGISTER_BLUNT)) return;
		if (SECONDARY_DMG == "SECONDARY_DMG")
		{
			string SECONDARY_DMG = MELEE_DMG;
		}
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = SPECIAL_02_RANGE;
		string reg.attack.dmg = SECONDARY_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		reg.attack.hitchance += 0.1;
		int reg.attack.priority = 2;
		string reg.attack.delay.strike = SPECIAL_02_DELAY_STRIKE;
		string reg.attack.delay.end = SPECIAL_02_DELAY_END;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = SPECIAL_02_CALLBACK;
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		if (SPECIAL_02_MP != "SPECIAL_02_MP")
		{
			string reg.attack.mpdrain = SPECIAL_02_MP;
		}
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void special_02_start()
	{
		ScheduleDelayedEvent(0.9, "bash");
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SWORDREADY')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void bash()
	{
		if (!("game.item.attacking")) return;
		PlayViewAnim(MELEE_VIEWANIM_ATK);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_damaged_other()
	{
		if ((BLUNT_NO_STUN)) return;
		string maxstun = GetSkillLevel(GetOwner(), "bluntarms.prof");
		maxstun += 1;
		maxstun = max(1, min(45, maxstun));
		float stuntime = Random(1, maxstun);
		ApplyEffect(param1, EFFECT_SCRIPT, stuntime, GetEntityIndex(GetOwner()));
	}

}

}
