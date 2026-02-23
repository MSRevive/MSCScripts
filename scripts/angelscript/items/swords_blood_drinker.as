#pragma context server

#include "items/swords_base_twohanded.as"
#include "items/base_vampire.as"

namespace MS
{

class SwordsBloodDrinker : CGameScript
{
	int FIST_MODE;
	int SENT_RETURN_REQ;
	int SWORD_CAN_PARRY;
	string SWORD_ID;

	SwordsBloodDrinker()
	{
		const int NO_IDLE = 1;
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const int SPECIAL_OVERRIDE = 1;
		const int SWORD_MANUAL_PARRY = 1;
		const float HP_RETURN_RATIO = 0.01;
		const int THROW_MP = 40;
		const int BASE_LEVEL_REQ = 30;
		const int ANIM_LIFT = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 2;
		const int ANIM_ATTACK3 = 2;
		const int ATTACK_ANIMS = 1;
		const int ANIM_LUNGE = 3;
		const int ANIM_PARRY1 = 4;
		const int ANIM_PARRY1_RETRACT = 5;
		const int ANIM_UNSHEATH = 6;
		const int ANIM_SHEATH = 7;
		const string MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		const int MODEL_VIEW_IDX = 6;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const int MODEL_BODY_OFS = 114;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string ANIM_PREFIX = "longsword";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 425;
		const int MELEE_DMG_RANGE = 80;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.65;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 3;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MELEE_NEW_PARRY_CHANCE = 30;
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "sword_double_swing";
	}

	void weapon_spawn()
	{
		SetName("Blood Drinker");
		SetDescription("A gigantic dancing blade with a thirst for blood");
		SetWeight(100);
		SetSize(10);
		SetValue(4000);
		SetHUDSprite("trade", 105);
		SetHand("both");
		FIST_MODE = 0;
		SWORD_CAN_PARRY = 1;
	}

	void game_dodamage()
	{
		if ((FIST_MODE)) return;
		if (!(param1)) return;
		string HP_TO_GIVE = GetEntityMaxHealth(GetOwner());
		HP_TO_GIVE *= HP_RETURN_RATIO;
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param2), HP_TO_GIVE);
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		reg.attack.delay.strike += 0.5;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		reg.attack.delay.end += 0.5;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 32;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 0;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "slash";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "throwsword";
		string reg.attack.noise = MELEE_NOISE;
		string reg.attack.mpdrain = THROW_MP;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 34;
		RegisterAttack();
	}

	void throwsword_start()
	{
		SetViewModel("none");
		PlayOwnerAnim("critical", "bow_release");
		SetModel("none");
		SetWorldModel("none");
		SetHand("undroppable");
		PlayViewAnim(4);
		FIST_MODE = 1;
		SWORD_CAN_PARRY = 0;
		if (!(true)) return;
		if (!(GetEntityMP(GetOwner()) < THROW_MP)) return;
		FIST_MODE = 0;
		SWORD_CAN_PARRY = 1;
		sword_return();
		SendColoredMessage(GetOwner(), "Blood Drinker: Insufficient mana for Blood Dance");
	}

	void throwsword_strike()
	{
		PlayOwnerAnim("critical", "bow_release");
		if (!(true)) return;
		if (!(FIST_MODE)) return;
		SENT_RETURN_REQ = 0;
		string DMG_BASE = GetSkillLevel(GetOwner(), "spellcasting");
		DMG_BASE /= 2;
		SpawnNPC("monsters/summon/blood_drinker", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "target"), DMG_BASE, DMG_BASE, GetEntityIndex(GetOwner())
		SWORD_ID = GetEntityIndex(m_hLastCreated);
		ApplyEffect(GetOwner(), "effects/effect_templock");
	}

	void restore_sword_cl()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		FIST_MODE = 0;
		SWORD_CAN_PARRY = 1;
	}

	void melee_start()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		FIST_MODE = 0;
		SWORD_CAN_PARRY = 1;
		bw_setup_model();
	}

	void sword_return()
	{
		CallExternal(GetOwner(), "ext_end_templock");
		// TODO: setviewmodelprop ent_me model MODEL_VIEW
		if ((FIST_MODE))
		{
			SendColoredMessage(GetOwner(), "Blood Drinker returns.");
		}
		FIST_MODE = 0;
		SWORD_CAN_PARRY = 1;
		SetViewModel(MODEL_VIEW);
		SetHand("both");
		bw_setup_model();
	}

	void special_01_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(FIST_MODE)) return;
		if ((SENT_RETURN_REQ)) return;
		SendPlayerMessage("Sent", "return request to GetEntityName(SWORD_ID)");
		SENT_RETURN_REQ = 1;
		CallExternal(SWORD_ID, "return_to_owner");
	}

}

}
