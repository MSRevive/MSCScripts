#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsNovablade12 : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT;
	int ANIM_LUNGE;
	int ANIM_PARRY1;
	int ANIM_PARRY1_RETRACT;
	int ANIM_PARRY_DEBUG;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ANIM_UNPARRY_DEBUG;
	int ANIM_UNSHEATH;
	int ATTACK_ANIMS;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	int MELEE_ALIGN_BASE;
	int MELEE_ALIGN_TIP;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_NEW_PARRY_CHANCE;
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
	int PARRY_ON;
	string PLAYERANIM_AIM;
	string PLAYERANIM_SWING;
	string SOUND_CHARGE;
	string SOUND_DRAW;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_PARRY;
	string SOUND_SHOOT;
	string SOUND_SHOUT;
	string SOUND_SWIPE;
	string SPECIAL01_SND;
	string SWING_ANIM;
	int SWORD_MANUAL_PARRY;
	int VOLCANO_ON;

	SwordsNovablade12()
	{
		SOUND_CHARGE = "magic/fireball_powerup.wav";
		SOUND_SHOOT = "magic/fireball_strike.wav";
		SPECIAL01_SND = GetEntityProperty(GetOwner(), "scriptvar");
		SOUND_PARRY = "weapons/parry.wav";
		SWORD_MANUAL_PARRY = 1;
		ANIM_LIFT = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 2;
		ANIM_ATTACK3 = 2;
		ATTACK_ANIMS = 1;
		ANIM_LUNGE = 3;
		ANIM_PARRY1 = 4;
		ANIM_PARRY1_RETRACT = 5;
		ANIM_UNSHEATH = 6;
		ANIM_SHEATH = 7;
		ANIM_PARRY_DEBUG = 4;
		ANIM_UNPARRY_DEBUG = 5;
		MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_DRAW = "weapons/swords/sworddraw.wav";
		SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		BASE_LEVEL_REQ = 15;
		MODEL_BODY_OFS = 104;
		ANIM_PREFIX = "khopesh";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.3;
		MELEE_ENERGY = 1;
		MELEE_DMG = 200;
		MELEE_DMG_RANGE = 140;
		MELEE_DMG_TYPE = "fire";
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "swordsmanship";
		MELEE_ALIGN_BASE = 3;
		MELEE_ALIGN_TIP = 0;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.6;
		MELEE_NEW_PARRY_CHANCE = 50;
		PLAYERANIM_AIM = "sword_double_idle";
		PLAYERANIM_SWING = "sword_double_swing";
		Precache("magic/spookie1.wav");
	}

	void weapon_spawn()
	{
		SetName("Novablade");
		SetDescription("This is a twisted blade of elemental fire");
		SetWeight(75);
		SetSize(9);
		SetValue(3750);
		SetHUDSprite("trade", 115);
		register_charge2();
		register_charge3();
		SetHand("both");
	}

	void melee_start()
	{
		int SWING = RandomInt(1, 3);
		if (SWING == 1)
		{
			SWING_ANIM = ANIM_ATTACK1;
		}
		if (SWING == 2)
		{
			SWING_ANIM = ANIM_ATTACK2;
		}
		if (SWING == 3)
		{
			SWING_ANIM = ANIM_ATTACK3;
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(SWING_ANIM);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SWIPE);
	}

	void special_01_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void special_01_strike()
	{
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		if (!(GetRelationship(param3) == "enemy")) return;
		if ("game.pvp" == 0)
		{
			if ((IsValidPlayer(param3)))
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		string DMG_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		ApplyEffect(param3, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DMG_FIRE, "swordsmanship");
	}

	void blockmode_start()
	{
		PlayViewAnim(ANIM_PARRY1);
		PlayOwnerAnim("once", "sword_swing");
		PARRY_ON = 1;
	}

	void blockmode_end()
	{
		PlayViewAnim(ANIM_PARRY1_RETRACT);
		PARRY_ON = 0;
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = "spellcasting.fire";
		string reg.attack.hitchance = MELEE_ACCURACY;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 10;
		RegisterAttack();
	}

	void register_charge2()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = "spellcasting.fire";
		string reg.attack.hitchance = MELEE_ACCURACY;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.priority = 2.5;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_02";
		reg.attack.dmg *= 3;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 20;
		RegisterAttack();
	}

	void register_charge3()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = "spellcasting.fire";
		string reg.attack.hitchance = MELEE_ACCURACY;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "melee";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 3;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_03";
		reg.attack.dmg *= 3;
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 30;
		RegisterAttack();
	}

	void special_02_start()
	{
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void special_02_strike()
	{
		if (GetEntityMP(GetOwner()) < 100)
		{
			SendPlayerMessage("Novablade:", "Flaming Skull - insufficient mana!");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(-100);
		CallExternal(GetOwner(), "mana_drain");
		EmitSound(GetOwner(), 0, SOUND_SHOOT, 10);
		string DMG_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DMG_FIRE *= 0.4;
		SpawnNPC("monsters/summon/flame_skull", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIRE, 256, "spellcasting.fire"
	}

	void special_03_start()
	{
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void special_03_strike()
	{
		if (GetEntityMP(GetOwner()) < 100)
		{
			SendPlayerMessage("Novablade:", "Volcano - insufficient mana!");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((VOLCANO_ON))
		{
			SendPlayerMessage("Novablade", "can only generate one volcano at a time");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		VOLCANO_ON = 1;
		ScheduleDelayedEvent(30.0, "volcano_reset");
		GiveMP(-100);
		CallExternal(GetOwner(), "mana_drain");
		string pos = GetEntityOrigin(GetOwner());
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		SpawnNPC("monsters/summon/preset_volcano", pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 0, 20, "spellcasting.fire"
	}

	void volcano_reset()
	{
		VOLCANO_ON = 0;
	}

}

}
