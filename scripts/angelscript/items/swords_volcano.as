#pragma context server

#include "items/swords_base_onehanded.as"

namespace MS
{

class SwordsVolcano : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	float LEVEL_INC;
	int LOOP_SOUND;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
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
	int MP_REQ1;
	int MP_REQ2;
	int MP_REQ3;
	int MP_REQ4;
	int MP_REQ5;
	int SECONDARY_DMG;
	string SOUND_SHOUT;
	string SOUND_SWIPE;

	SwordsVolcano()
	{
		MP_REQ1 = 5;
		MP_REQ2 = 10;
		MP_REQ3 = 15;
		MP_REQ4 = 20;
		MP_REQ5 = 30;
		LEVEL_INC = 1.5;
		BASE_LEVEL_REQ = 10;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "viewmodels/v_1hswords.mdl";
		MODEL_VIEW_IDX = 5;
		MODEL_HANDS = "weapons/p_weapons1.mdl";
		MODEL_WORLD = "weapons/p_weapons1.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 110;
		ANIM_PREFIX = "darksword";
		MELEE_RANGE = 64;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 240;
		SECONDARY_DMG = 500;
		MELEE_DMG_RANGE = 10;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.77;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.3;
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
			SendColoredMessage(GetOwner(), "Dark Sword: Not enough " + MP + "for Soul Pierce " + param2);
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
