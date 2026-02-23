#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsUb : CGameScript
{
	int CHANT_VOL;
	int DARK_SHIELD_ON;
	string DS_START_TIME;
	string DS_STILL_IN_RECHARGE;
	string NEXT_DARK_SHIELD_ATTEMPT;
	string NEXT_PARRY;
	int PARRY_ON;
	string SHADOW_PROJ_ID;
	int SWORD_FLYING;

	SwordsUb()
	{
		const string SOUND_MODE_SWITCH = "magic/energy1_loud.wav";
		const float HP_RETURN_RATIO = 0.02;
		const int DARK_SHIELD_MP = 50;
		const float DARK_SHIELD_DURATION = 40.0;
		const int RANGED_MP = 30;
		const float RANGED_ATK_DURATION = 0.3;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const Vector3 RANGED_STARTPOS = Vector3(4, 0, -3);
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
		const int MODEL_VIEW_IDX = 12;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 63;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string SOUND_DEPLOY = "magic/chant_loop.wav";
		const string SOUND_BLOCK = "weapons/axemetal1.wav";
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 650;
		const int MELEE_DMG_RANGE = 80;
		const string MELEE_DMG_TYPE = "dark";
		const float MELEE_ACCURACY = 0.85;
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
		SetName("Unholy Blade");
		SetDescription("A corrupted blade of Felewyn");
		SetWeight(100);
		SetSize(10);
		SetValue(7000);
		SetHUDSprite("trade", 140);
		SetHand("both");
		custom_register();
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		EmitSound(GetOwner(), 3, SOUND_DEPLOY, 10);
		CHANT_VOL = 10;
		ScheduleDelayedEvent(1.0, "cycle_sound_down");
	}

	void cycle_sound_down()
	{
		if (!(CHANT_VOL > 0)) return;
		ScheduleDelayedEvent(0.5, "cycle_sound_down");
		CHANT_VOL -= 1;
		EmitSound(GetOwner(), 3, SOUND_DEPLOY, CHANT_VOL);
	}

	void custom_register()
	{
		string reg.attack.mpdrain = RANGED_MP;
		int reg.attack.ammodrain = 0;
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.hold_min&max = "1;1";
		string reg.attack.dmg.type = "dark";
		int reg.attack.range = 100;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		int reg.attack.COF = 0;
		string reg.attack.projectile = "proj_ub";
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.chargeamt = 2.0;
		float reg.attack.delay.end = 0.1;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		string reg.attack.noise = RANGED_NOISE;
		string reg.attack.callback = "dark_shard";
		int reg.attack.reqskill = 34;
		string reg.attack.keys = "-attack1";
		RegisterAttack();
	}

	void dark_shard_start()
	{
		if ((true))
		{
			end_parry("shard_fire");
		}
		PlayViewAnim(ANIM_ATTACK1);
		PlayOwnerAnim("once", "axe_twohand_swing");
		ScheduleDelayedEvent(0.3, "vanish_sword");
	}

	void vanish_sword()
	{
		// TODO: setviewmodelprop ent_me rendermode 1
		// TODO: setviewmodelprop ent_me renderamt 0
		SWORD_FLYING = 1;
	}

	void melee_start()
	{
		if ((true))
		{
			end_parry("melee_start");
		}
	}

	void dark_shard_end()
	{
		if (("game.item.attacking")) return;
		PlayViewAnim(ANIM_IDLE1);
	}

	void special_01_start()
	{
		if ((true))
		{
			end_parry("special_01_start");
		}
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void ext_register_projectile()
	{
		SHADOW_PROJ_ID = param1;
		LogDebug("ext_register_projectile SHADOW_PROJ_ID");
	}

	void ext_projectile_landed()
	{
		LogDebug("ext_projectile_landed");
		if (param1 != "remote")
		{
			// TODO: splayviewanim ent_me ANIM_IDLE1
		}
		// TODO: setviewmodelprop ent_me rendermode 1
		// TODO: setviewmodelprop ent_me renderamt 255
		SWORD_FLYING = 0;
	}

	void end_parry()
	{
		if (((SHADOW_PROJ_ID !is null)))
		{
			SWORD_FLYING = 0;
			if (param1 != "shard_fire")
			{
			}
			LogDebug("remove SHADOW_PROJ_ID");
			CallExternal(SHADOW_PROJ_ID, "remove_me", "remote");
			ext_projectile_landed("remote");
		}
		if (!(PARRY_ON)) return;
		PARRY_ON = 0;
		NEXT_PARRY = GetGameTime();
		NEXT_PARRY += 2.0;
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(PARRY_ON))
		{
			if (GetSkillLevel(GetOwner(), "swordsmanship") >= BASE_LEVEL_REQ)
			{
			}
			if (GetGameTime() > NEXT_PARRY)
			{
			}
			PARRY_ON = 1;
			// TODO: splayviewanim ent_me ANIM_PARRY1
			if (((SHADOW_PROJ_ID !is null)))
			{
				LogDebug("remove SHADOW_PROJ_ID");
				CallExternal(SHADOW_PROJ_ID, "remove_me", "remote");
				ext_projectile_landed("remote");
			}
		}
		if (!(GetSkillLevel(GetOwner(), "swordsmanship") > 34)) return;
		if ((DARK_SHIELD_ON)) return;
		if (DS_START_TIME == "DS_START_TIME")
		{
			DS_START_TIME = GetGameTime();
			DS_START_TIME += 5.0;
		}
		if (!(GetGameTime() > DS_START_TIME)) return;
		if (GetGameTime() < NEXT_DARK_SHIELD_ATTEMPT)
		{
			DS_START_TIME = "DS_START_TIME";
			SendColoredMessage(GetOwner(), "Unholy Blade: Shield of Darkness not ready");
		}
		if (!(GetGameTime() > NEXT_DARK_SHIELD_ATTEMPT)) return;
		NEXT_DARK_SHIELD_ATTEMPT = GetGameTime();
		NEXT_DARK_SHIELD_ATTEMPT += 3.0;
		if (GetEntityMP(GetOwner()) < DARK_SHIELD_MP)
		{
			SendColoredMessage(GetOwner(), "Unholy Blade: Not enough mana for Shield of Darkness");
		}
		if (!(GetEntityMP(GetOwner()) >= DARK_SHIELD_MP)) return;
		do_dark_shield();
	}

	void game__attack2()
	{
		if (!(true)) return;
		if (!(PARRY_ON)) return;
		if (!("game.item.attacking"))
		{
			// TODO: splayviewanim ent_me ANIM_PARRY1_RETRACT
		}
		PARRY_ON = 0;
		DS_START_TIME = "DS_START_TIME";
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string L_RELATIONSHIP = GetRelationship(param2);
		if (!(L_RELATIONSHIP == "ally")) return;
		if (!(L_RELATIONSHIP == "neutral")) return;
		if (param2 == GetEntityIndex(GetOwner()))
		{
			SetDamage("dmg");
			return;
			return;
		}
		if (!(/* TODO: $can_damage */ $can_damage(GetOwner(), param2))) return;
		if (!(GetEntityRace(param2) != "undead")) return;
		if ((GetEntityProperty(param2, "scriptvar"))) return;
		if (!(GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))) return;
		string HP_TO_GIVE = GetEntityMaxHealth(GetOwner());
		HP_TO_GIVE *= HP_RETURN_RATIO;
		HealEntity(GetOwner(), HP_TO_GIVE);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if ((PARRY_ON))
		{
			if ((param4).findFirst("effect") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if ((param4).findFirst("target") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string PROJECTILE_FIRED = GetEntityProperty(param2, "is_projectile");
			if ((PROJECTILE_FIRED))
			{
				string BLOCK_TARG = param1;
			}
			else
			{
				string BLOCK_TARG = param2;
			}
			string OWNER_ORG = GetEntityOrigin(GetOwner());
			string OWNER_ANG = GetEntityAngles(GetOwner());
			string ATTACK_ORG = GetEntityOrigin(BLOCK_TARG);
			if ((WithinCone2D(ATTACK_ORG, OWNER_ORG, OWNER_ANG)))
			{
			}
			string DMG_TAKEN = param3;
			string ORIG_DMG = param3;
			DMG_TAKEN *= 0.5;
			SetDamage("dmg");
			ORIG_DMG -= DMG_TAKEN;
			SendPlayerMessage("Unholy", "Blade absorbed int(ORIG_DMG) damage");
			EmitSound(GetOwner(), 3, SOUND_BLOCK, 5);
		}
	}

	void do_dark_shield()
	{
		NEXT_DARK_SHIELD_ATTEMPT = GetGameTime();
		NEXT_DARK_SHIELD_ATTEMPT += 30.0;
		DARK_SHIELD_ON = 1;
		CallExternal(GetOwner(), "ext_repel_shield", 20.0, 128, "darkfire");
		DARK_SHIELD_DURATION("dark_shield_end");
	}

	void bweapon_effect_remove()
	{
		LogDebug("bweapon_effect_remove [ DARK_SHIELD_ON ]");
		end_parry("bweapon_effect_remove");
		if (!(DARK_SHIELD_ON)) return;
		dark_shield_abort();
	}

	void dark_shield_end()
	{
		DARK_SHIELD_ON = 0;
		DS_START_TIME = "DS_START_TIME";
		DS_STILL_IN_RECHARGE = GetGameTime();
		DS_STILL_IN_RECHARGE += 10.0;
	}

	void dark_shield_abort()
	{
		LogDebug("dark_shield_abort");
		dark_shield_end();
		CallExternal(GetOwner(), "ext_end_repel_shield");
	}

	void ext_player_sit()
	{
		LogDebug("ext_player_sit");
		if ((DARK_SHIELD_ON))
		{
			dark_shield_abort();
		}
	}

}

}
