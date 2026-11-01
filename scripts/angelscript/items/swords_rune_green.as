#pragma context server

#include "items/base_elemental_resist.as"
#include "items/swords_base_onehanded.as"
#include "items/base_varied_attacks.as"

namespace MS
{

class SwordsRuneGreen : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_ATTACK5;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	int ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int ELM_WEAPON;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
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
	string SOUND_CHARGE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SHOOT;
	string SOUND_SHOUT;
	string SOUND_SPAWN_CLOUD;
	string SOUND_SWIPE;
	string SWING_ANIM;

	SwordsRuneGreen()
	{
		ELM_NAME = "possw";
		ELM_TYPE = "poison";
		ELM_AMT = 50;
		ELM_WEAPON = 1;
		SOUND_CHARGE = "bullchicken/bc_attack1.wav";
		SOUND_SHOOT = "bullchicken/bc_attack3.wav";
		SOUND_SPAWN_CLOUD = "ambience/steamburst1.wav";
		BASE_LEVEL_REQ = 15;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_ATTACK4 = 5;
		ANIM_ATTACK5 = 6;
		ANIM_SHEATH = 7;
		ATTACK_ANIMS = 4;
		MODEL_VIEW = "viewmodels/v_1hswordssb.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "bullchicken/bc_acid1.wav";
		SOUND_HITWALL2 = "bullchicken/bc_acid2.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		MODEL_BODY_OFS = 108;
		ANIM_PREFIX = "dagger";
		MELEE_RANGE = 64;
		MELEE_DMG_DELAY = 0.4;
		MELEE_ATK_DURATION = 0.8;
		MELEE_ENERGY = 1;
		MELEE_DMG = 150;
		MELEE_DMG_RANGE = 70;
		MELEE_DMG_TYPE = "acid";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 4;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
	}

	void weapon_spawn()
	{
		SetName("Rune Blade of Affliction");
		SetDescription("A blade of vile magics");
		SetWeight(35);
		SetSize(5);
		SetValue(3500);
		SetHUDSprite("trade", 116);
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.hold_min&max = "2;2";
		string reg.attack.dmg.type = "acid";
		int reg.attack.range = 600;
		int reg.attack.COF = 0;
		string reg.attack.stat = "spellcasting.affliction";
		string reg.attack.keys = "-attack1";
		int reg.attack.noise = 1000;
		int reg.attack.energydrain = 5;
		int reg.attack.noautoaim = 0;
		string reg.attack.projectile = "proj_acid_bolt";
		int reg.attack.priority = 2;
		int reg.attack.delay.strike = 0;
		int reg.attack.delay.end = 0;
		Vector3 reg.attack.ofs.startpos = Vector3(5, 10, -5);
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.ammodrain = 0;
		string reg.attack.callback = "bolt";
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 5;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 800;
		int reg.attack.dmg = 1;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = "poison";
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = "spellcasting.affliction";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "cloudon";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 20;
		RegisterAttack();
	}

	void cloudon_start()
	{
		PlayViewAnim(ANIM_ATTACK4);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		ScheduleDelayedEvent(0.5, "cloud_spawn");
	}

	void cloud_spawn()
	{
		EmitSound(GetOwner(), 0, SOUND_SPAWN_CLOUD, 10);
		string MY_OWNER = GetEntityIndex(GetOwner());
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		string EFFECT_DURATION = GetStat(MY_OWNER, "concentration");
		EFFECT_DURATION /= 2;
		EFFECT_DURATION += EFFECT_DMG;
		string OWNER_TARGET = GetEntityProperty(GetOwner(), "target");
		if ((IsEntityAlive(OWNER_TARGET)))
		{
			string TARGET_POS = GetEntityOrigin(OWNER_TARGET);
		}
		if (!(IsEntityAlive(OWNER_TARGET)))
		{
			string TARGET_POS = GetEntityOrigin(MY_OWNER);
		}
		if ((IsValidPlayer(OWNER_TARGET)))
		{
			TARGET_POS += "z";
		}
		SpawnNPC("monsters/summon/poison_cloud2", TARGET_POS, ScriptMode::Legacy); // params: MY_OWNER, 180, EFFECT_DMG, EFFECT_DURATION, "spellcasting.affliction"
	}

	void bolt_start()
	{
		PlayViewAnim(ANIM_ATTACK4);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		ScheduleDelayedEvent(1.2, "fire_bolt");
	}

	void fire_bolt()
	{
		PlayViewAnim(ANIM_ATTACK5);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		ScheduleDelayedEvent(0.5, "fire_sound");
	}

	void fire_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_SHOOT, 10);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		ScheduleDelayedEvent(0.1, "elm_activate_effect");
	}

	void melee_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SWIPE, 10);
		if (!(true)) return;
		PlayOwnerAnim("once", "sword_swing");
		check_attack_anim();
		SWING_ANIM = CUR_ATTACK_ANIM;
		// TODO: splayviewanim ent_me SWING_ANIM
	}

}

}
