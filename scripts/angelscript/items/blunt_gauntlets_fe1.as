#pragma context server

#include "items/base_melee.as"
#include "items/base_vampire.as"

namespace MS
{

class BluntGauntletsFe1 : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_HANDS_DOWN;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LOWER;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ANIM_SPEC_ATTACK;
	float AURA_DOT_RATIO;
	int AURA_RADIUS;
	int BASE_LEVEL_REQ;
	int CAN_VAMPIRE_TARGET;
	float GOUGE_LIFESTEAL_RATIO;
	int GOUGE_MPDRAIN;
	int GOUGE_MPSTEAL;
	int MELEE_ACCURACY;
	int MELEE_AFFLICDMG_MIN;
	float MELEE_AFFLIC_RATIO;
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
	int NO_BANK;
	int NO_WORLD_MODEL;
	string PLAYERANIM_AIM;
	string PUNCH_ATTACK;
	int REACH_MELEE_RANGE;
	string SOUND_DEPLOY;
	string SOUND_GAS_ON;
	string SOUND_GOUGE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWING;
	string SOUND_SWIPE;
	int SPELL_SKILL_REQUIRED;

	BluntGauntletsFe1()
	{
		NO_BANK = 1;
		SPELL_SKILL_REQUIRED = 20;
		BASE_LEVEL_REQ = 20;
		ANIM_HANDS_DOWN = 20;
		ANIM_LIFT1 = 12;
		ANIM_LOWER = 11;
		ANIM_IDLE1 = 11;
		ANIM_IDLE_TOTAL = 12;
		ANIM_ATTACK1 = 16;
		ANIM_ATTACK2 = 17;
		ANIM_ATTACK3 = 18;
		ANIM_ATTACK4 = 19;
		ANIM_SPEC_ATTACK = 14;
		ANIM_SHEATH = 16;
		MODEL_VIEW = "viewmodels/v_martialarts_claws.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 60;
		MELEE_DMG = 200;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "acid";
		MELEE_ACCURACY = 100;
		MELEE_DMG_DELAY = 0.35;
		MELEE_ATK_DURATION = 0.45;
		MELEE_AFFLIC_RATIO = 0.5;
		MELEE_AFFLICDMG_MIN = 10;
		GOUGE_MPDRAIN = 15;
		GOUGE_MPSTEAL = 10;
		GOUGE_LIFESTEAL_RATIO = 0.10;
		AURA_DOT_RATIO = 0.3;
		AURA_RADIUS = 80;
		SOUND_SWIPE = "zombie/claw_miss1.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_SWING = "zombie/claw_miss2.wav";
		SOUND_DEPLOY = "monsters/skeleton/calrain3.wav";
		SOUND_GOUGE = "monsters/gonome/gonome_jumpattack.wav";
		ANIM_PREFIX = "gauntlets";
		NO_WORLD_MODEL = 1;
		MELEE_RANGE = 50;
		REACH_MELEE_RANGE = 100;
		MELEE_ENERGY = 1;
		MELEE_STAT = "spellcasting.affliction";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		PLAYERANIM_AIM = "axe_onehand";
		SOUND_GAS_ON = "ambience/steamburst1.wav";
	}

	void game_precache()
	{
		Precache("poison_cloud.spr");
	}

	void OnPickup(CBaseEntity@ player) override
	{
		ScheduleDelayedEvent(0.1, "facid_aura");
	}

	void weapon_spawn()
	{
		SetName("Venom Claws");
		SetDescription("Vicious claws have burst from your hands!");
		SetWeight(3);
		SetSize(1);
		SetValue(1500);
		SetHand("both");
		SetHUDSprite("hand", "gauntlets");
		SetHUDSprite("trade", "gauntlets");
		string reg.spell.reqskill = BASE_LEVEL_REQ;
		int reg.spell.fizzletime = 99999;
		float reg.spell.castsuccess = 1.0;
		int reg.spell.preparetime = 1;
		// TODO: registerspell
		int CHARGE2_REQ = 22;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = REACH_MELEE_RANGE;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "pierce";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "spellcasting.affliction";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "gouge";
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.mpdrain = 0;
		float reg.attack.chargeamt = 1.0;
		string reg.attack.reqskill = CHARGE2_REQ;
		RegisterAttack();
	}

	void melee_start()
	{
		// PlayRandomSound from: SOUND_SWING, SOUND_SWIPE
		array<string> sounds = {SOUND_SWING, SOUND_SWIPE};
		EmitSound(GetOwner(), "const.sound.item", sounds[RandomInt(0, sounds.length() - 1)], 10);
		int RND_ATTACK = RandomInt(1, 4);
		if (RND_ATTACK == 1)
		{
			PlayViewAnim(ANIM_ATTACK1);
		}
		if (RND_ATTACK == 2)
		{
			PlayViewAnim(ANIM_ATTACK2);
		}
		if (RND_ATTACK == 3)
		{
			PlayViewAnim(ANIM_ATTACK3);
		}
		if (RND_ATTACK == 4)
		{
			PlayViewAnim(ANIM_ATTACK4);
		}
		if (PUNCH_ATTACK == 0)
		{
			string l.punch_anim = "stance_normal_lowjab_r1";
			PUNCH_ATTACK = 1;
		}
		else
		{
			if (PUNCH_ATTACK == 1)
			{
				string l.punch_anim = "stance_normal_lowjab_r2";
				PUNCH_ATTACK = 0;
			}
		}
		PlayOwnerAnim("once", l.punch_anim);
		EmitSound(GetOwner(), "const.sound.item", SOUND_SWING, 5);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string HIT_TARG = param2;
		do_special_damage(HIT_TARG);
	}

	void do_special_damage()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string AFFLIC_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		AFFLIC_DAMAGE *= MELLEE_AFFLIC_RATIO;
		AFFLIC_DAMAGE += Random(3, 6);
		if (AFFLIC_DAMAGE < 10)
		{
			string AFFLIC_DAMAGE = MELEE_AFFLICDMG_MIN;
		}
		ApplyEffect(param1, "effects/dot_poison", 5, GetEntityIndex(GetOwner()), AFFLIC_DAMAGE, "spellcasting.affliction");
	}

	void gouge_start()
	{
		if (GetEntityMP(GetOwner()) < GOUGE_MPDRAIN)
		{
			SendColoredMessage(GetOwner(), "Flesheater Gauntlets: Insufficient mana for Gouge Attack.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// TODO: splayviewanim ent_me ANIM_SPEC_ATTACK
		EmitSound(GetOwner(), 0, SOUND_GOUGE, 10);
	}

	void gouge_strike()
	{
		if (GetEntityMP(GetOwner()) < GOUGE_MPDRAIN)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsEntityAlive(param3))) return;
		if ("game.pvp" == 0)
		{
			if ((IsValidPlayer(param3)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(/* TODO: $can_damage */ $can_damage(GetOwner(), param3))) return;
		string DMG_SET = GetSkillLevel(GetOwner(), "spellcasting.affliction.ratio");
		DMG_SET *= MELEE_DMG;
		DMG_SET *= 3;
		string OWNER_TARG = param3;
		XDoDamage(OWNER_TARG, REACH_MELEE_RANGE, DMG_SET, 1.0, GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), "spellcasting.affliction", "acid");
		CAN_VAMPIRE_TARGET = 0;
		check_can_vampire(GetEntityIndex(GetOwner()), param3);
		if ((CAN_VAMPIRE_TARGET))
		{
			string LIFE_STOLEN = DMG_SET;
			LIFE_STOLEN *= /* TODO: $get_takedmg */ $get_takedmg(param3, "all");
			LIFE_STOLEN *= /* TODO: $get_takedmg */ $get_takedmg(param3, "acid");
			LIFE_STOLEN *= GOUGE_LIFESTEAL_RATIO;
			HealEntity(GetOwner(), LIFE_STOLEN);
			GiveMP(GetOwner());
		}
		else
		{
			GiveMP(GetOwner());
		}
		CallExternal(GetOwner(), "mana_drain");
	}

	void facid_aura()
	{
		string AURA_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		AURA_DOT *= AURA_DOT_RATIO;
		CallExternal(GetOwner(), "ext_acid_feaura_activate", AURA_DOT, AURA_RADIUS);
		EmitSound(GetOwner(), 3, SOUND_GAS_ON, 10);
	}

	void game_removefromowner()
	{
		CallExternal(GetOwner(), "ext_acid_feaura_remove");
	}

	void game_fall()
	{
		DeleteEntity(GetOwner());
	}

}

}
