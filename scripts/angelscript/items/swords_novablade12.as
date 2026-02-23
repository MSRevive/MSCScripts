#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsNovablade12 : CGameScript
{
	int PARRY_ON;
	string SWING_ANIM;
	int VOLCANO_ON;

	SwordsNovablade12()
	{
		const string SOUND_CHARGE = "magic/fireball_powerup.wav";
		const string SOUND_SHOOT = "magic/fireball_strike.wav";
		const string SPECIAL01_SND = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_PARRY = "weapons/parry.wav";
		const int SWORD_MANUAL_PARRY = 1;
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
		const int ANIM_PARRY_DEBUG = 4;
		const int ANIM_UNPARRY_DEBUG = 5;
		const string MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int BASE_LEVEL_REQ = 15;
		const int MODEL_BODY_OFS = 104;
		const string ANIM_PREFIX = "khopesh";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 200;
		const int MELEE_DMG_RANGE = 140;
		const string MELEE_DMG_TYPE = "fire";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 3;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.6;
		const int MELEE_NEW_PARRY_CHANCE = 50;
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "sword_double_swing";
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
		string SWING = RandomInt(1, 3);
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
