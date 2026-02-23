#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsVolcano : CGameScript
{
	int LOOP_SOUND;

	SwordsVolcano()
	{
		const int MP_REQ1 = 5;
		const int MP_REQ2 = 10;
		const int MP_REQ3 = 15;
		const int MP_REQ4 = 20;
		const int MP_REQ5 = 30;
		const float LEVEL_INC = 1.5;
		const int BASE_LEVEL_REQ = 10;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		const int MODEL_VIEW_IDX = 5;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int MODEL_BODY_OFS = 110;
		const string ANIM_PREFIX = "darksword";
		const int MELEE_RANGE = 64;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const float MELEE_ENERGY = 0.3;
		const int MELEE_DMG = 240;
		const int SECONDARY_DMG = 500;
		const int MELEE_DMG_RANGE = 10;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.77;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 4;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.3;
	}

	void weapon_spawn()
	{
		SetName("Dark Sword");
		SetDescription("This swords magic can help the skillful land deadly blows");
		SetWeight(30);
		SetSize(7);
		SetValue(3000);
		SetHUDSprite("trade", 104);
	}

	void register_charge1()
	{
		string TRI_DMG = MELEE_DMG;
		string F_DMG_RANGE = MELEE_DMG_RANGE;
		TRI_DMG *= LEVEL_INC;
		F_DMG_RANGE *= 2;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = TRI_DMG;
		string reg.attack.dmg.range = F_DMG_RANGE;
		string reg.attack.dmg.type = "dark";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 0.85;
		int reg.attack.priority = 1;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.callback = "dmgup1";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 10;
		string reg.attack.mpdrain = MP_REQ1;
		RegisterAttack();
		TRI_DMG *= LEVEL_INC;
		F_DMG_RANGE *= 2;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = TRI_DMG;
		string reg.attack.dmg.range = F_DMG_RANGE;
		string reg.attack.dmg.type = "dark";
		int reg.attack.energydrain = 4;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 0.85;
		int reg.attack.priority = 2;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.callback = "dmgup2";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 15;
		string reg.attack.mpdrain = MP_REQ2;
		RegisterAttack();
		TRI_DMG *= LEVEL_INC;
		F_DMG_RANGE *= 2;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = TRI_DMG;
		string reg.attack.dmg.range = F_DMG_RANGE;
		string reg.attack.dmg.type = "dark";
		int reg.attack.energydrain = 6;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 0.85;
		int reg.attack.priority = 3;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.callback = "dmgup3";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 20;
		string reg.attack.mpdrain = MP_REQ3;
		RegisterAttack();
		TRI_DMG *= LEVEL_INC;
		F_DMG_RANGE *= 2;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = TRI_DMG;
		string reg.attack.dmg.range = F_DMG_RANGE;
		string reg.attack.dmg.type = "dark";
		int reg.attack.energydrain = 8;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 0.85;
		int reg.attack.priority = 4;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.callback = "dmgup4";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 4.0;
		int reg.attack.reqskill = 25;
		string reg.attack.mpdrain = MP_REQ4;
		RegisterAttack();
		TRI_DMG *= LEVEL_INC;
		F_DMG_RANGE *= 2;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = TRI_DMG;
		string reg.attack.dmg.range = F_DMG_RANGE;
		string reg.attack.dmg.type = "dark";
		int reg.attack.energydrain = 10;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 0.85;
		int reg.attack.priority = 5;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.callback = "dmgup5";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 5.0;
		int reg.attack.reqskill = 30;
		string reg.attack.mpdrain = MP_REQ5;
		RegisterAttack();
	}

	void dmgup1_start()
	{
		if (!(true)) return;
		LogMessage("ent_owner darksword_Charge1");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 64, 1, 1);
		LOOP_SOUND = 1;
		play_sound_loop();
		atk_anim(MP_REQ1, "I");
	}

	void dmgup2_start()
	{
		if (!(true)) return;
		LogMessage("ent_owner darksword_Charge2");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 96, 1, 1);
		LOOP_SOUND = 2;
		play_sound_loop();
		atk_anim(MP_REQ2, "II");
	}

	void dmgup3_start()
	{
		if (!(true)) return;
		LogMessage("ent_owner darksword_Charge3");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 1, 1);
		LOOP_SOUND = 3;
		play_sound_loop();
		atk_anim(MP_REQ3, "III");
	}

	void dmgup4_start()
	{
		if (!(true)) return;
		LogMessage("ent_owner darksword_Charge4");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 1, 1);
		LOOP_SOUND = 4;
		play_sound_loop();
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
		atk_anim(MP_REQ4, "IV");
	}

	void dmgup5_start()
	{
		if (!(true)) return;
		LogMessage("ent_owner darksword_Charge5");
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 512, 1, 1);
		LOOP_SOUND = 5;
		play_sound_full();
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
		atk_anim(MP_REQ5, "V");
	}

	void atk_anim()
	{
		if (GetEntityMP(GetOwner()) < param1)
		{
			SendColoredMessage(GetOwner(), "Dark Sword: Not enough MP for Soul Pierce PARAM2");
		}
		if (!(GetEntityMP(GetOwner()) >= param1)) return;
		// TODO: splayviewanim ent_me 2
		if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
		{
			PlayOwnerAnim("once", PLAYERANIM_SWING);
		}
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void melee_start()
	{
		PlayViewAnim(3);
		if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
		{
			PlayOwnerAnim("once", PLAYERANIM_SWING);
		}
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void play_sound_loop()
	{
		LOOP_SOUND -= 1;
		EmitSound(GetOwner(), 0, "magic/spawn.wav", 5);
		if (!(LOOP_SOUND > 0)) return;
		ScheduleDelayedEvent(0.25, "play_sound_loop");
	}

	void play_sound_full()
	{
		EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
	}

}

}
