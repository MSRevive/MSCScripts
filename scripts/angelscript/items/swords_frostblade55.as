#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsFrostblade55 : CGameScript
{
	int ATTACK_DELAY;
	int ATTACK_ON;
	string NEXT_DELAY_MSG;
	int PARRY_ON;

	SwordsFrostblade55()
	{
		Precache("magic/spawn.wav");
		Precache("magic/frost_forward.wav");
		Precache("magic/frost_reverse.wav");
		const int MELEE_OVERRIDE = 1;
		const int SPECIAL_OVERRIDE = 1;
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const string SOUND_CHARGE = "magic/ice_powerup.wav";
		const string SOUND_SHOOT = "magic/ice_strike2.wav";
		const string SPECIAL01_SND = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_PARRY = "weapons/parry.wav";
		const string RANGED_HOLD_MINMAX = "1.1;1.3";
		const float RANGED_ATK_DURATION = 0.3;
		const string RANGED_PROJECTILE = "proj_icelance";
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const Vector3 RANGED_STARTPOS = Vector3(0, 38, 0);
		const float RANGED_PULLTIME = 0.8;
		const int RANGED_MP = 15;
		const int CIRCLE_DRAIN = 40;
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
		const int MODEL_VIEW_IDX = 5;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const int BASE_LEVEL_REQ = 20;
		const int MODEL_BODY_OFS = 4;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 350;
		const int MELEE_DMG_RANGE = 75;
		const string MELEE_DMG_TYPE = "cold";
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
	}

	void weapon_spawn()
	{
		SetName("Hoarfrost Shard");
		SetDescription("A gigantic blade of pure elemental ice");
		SetWeight(75);
		SetSize(9);
		SetValue(4000);
		SetHUDSprite("trade", 124);
		SetHand("both");
	}

	void melee_start()
	{
		string SWING = RandomInt(1, 3);
		if (SWING == 1)
		{
			string SWING_ANIM = ANIM_ATTACK1;
		}
		if (SWING == 2)
		{
			string SWING_ANIM = ANIM_ATTACK2;
		}
		if (SWING == 3)
		{
			string SWING_ANIM = ANIM_ATTACK3;
		}
		PlayOwnerAnim("once", "sword_double_swing");
		PlayViewAnim(SWING_ANIM);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SWIPE);
	}

	void melee_strike()
	{
		if (!(true)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		if (!(IsEntityAlive(param3))) return;
		if (!(GetRelationship(param3) == "enemy")) return;
		if ((IsValidPlayer(param3)))
		{
			string PVP_SET = "game.pvp";
			if (PVP_SET == 0)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(param3, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), Random(5, 15), "swordsmanship");
	}

	void ice_shard_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		if (!(GetEntityMP(GetOwner()) > RANGED_MP)) return;
		EmitSound(GetOwner(), "const.snd.weapon", SOUND_SHOOT, "const.snd.maxvol");
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

	void parryanim()
	{
		PlayViewAnim(ANIM_PARRY1);
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
		ScheduleDelayedEvent(0.75, "unparryanim");
	}

	void unparryanim()
	{
		PlayViewAnim(ANIM_PARRY1_RETRACT);
	}

	void register_charge1()
	{
		string reg.attack.mpdrain = RANGED_MP;
		int reg.attack.ammodrain = 0;
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.hold_min&max = "1;1";
		string reg.attack.dmg.type = "cold";
		int reg.attack.range = 500;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = "swordsmanship";
		int reg.attack.COF = 0;
		string reg.attack.projectile = "proj_icelance";
		int reg.attack.priority = 1;
		string reg.attack.delay.strike = RANGED_DMG_DELAY;
		string reg.attack.delay.end = RANGED_ATK_DURATION;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		string reg.attack.noise = RANGED_NOISE;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "ice_shard";
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 22;
		RegisterAttack();
	}

	void game_+attack2()
	{
		if (GetGameTime() > NEXT_DELAY_MSG)
		{
			if ((ATTACK_DELAY))
			{
			}
			SendColoredMessage(GetOwner(), "Hoarfrost Shard: Needs time to recharge.");
			NEXT_DELAY_MSG = GetGameTime();
			NEXT_DELAY_MSG += 0.5;
		}
		if ((ATTACK_DELAY)) return;
		ATTACK_DELAY = 1;
		ScheduleDelayedEvent(10.0, "attack_delay_reset");
		ATTACK_ON = 1;
	}

	void attack_delay_reset()
	{
		ATTACK_DELAY = 0;
	}

	void game__attack2()
	{
		if (!(ATTACK_ON)) return;
		ATTACK_ON = 0;
		if ((true))
		{
			int DO_ATTACK = 1;
			if (GetEntityMP(GetOwner()) <= CIRCLE_DRAIN)
			{
				int DO_ATTACK = 0;
			}
			if (!(DO_ATTACK))
			{
				SendColoredMessage(GetOwner(), "Hoarfrost Shard: Insufficient mana.");
			}
			if (!(CanAttack(GetOwner())))
			{
				SendColoredMessage(GetOwner(), "Can't attack now...");
				int DO_ATTACK = 0;
			}
		}
		if ((false))
		{
			PlayViewAnim(5);
		}
		if (!(DO_ATTACK)) return;
		GiveMP(/* TODO: $neg */ $neg(CIRCLE_DRAIN));
		CallExternal(GetOwner(), "mana_drain");
		PlayOwnerAnim("once", "throw_fireball");
		if (!(true)) return;
		string CFROST_DAMAGE = GetSkillLevel(GetOwner(), "swordsmanship");
		CFROST_DAMAGE *= 1.25;
		SpawnNPC("monsters/summon/circle_of_ice_player", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 15, 5, CFROST_DAMAGE, "swordsmanship"
	}

}

}
