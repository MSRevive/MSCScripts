#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class BluntGauntletsDemon : CGameScript
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
	int ATTACK_DELAY;
	int BASE_LEVEL_REQ;
	int DEBUG_ATTACK;
	float DEMON_MELEE_ATK_DURATION;
	float DEMON_MELEE_DMG_DELAY;
	int DEMON_MODE;
	float DEMON_STRIKE_RATIO;
	string FISTS_LAST_ATTACK;
	float MELEE_ACCURACY;
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
	string MODEL_WORLD;
	int NO_IDLE;
	int NO_WORLD_MODEL;
	string PLAYERANIM_AIM;
	string PUNCH_ATTACK;
	int REACH_MELEE_RANGE;
	string SOUND_DEPLOY;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_LUNGE;
	string SOUND_SWING;
	string SOUND_SWIPE;

	BluntGauntletsDemon()
	{
		BASE_LEVEL_REQ = 15;
		DEMON_STRIKE_RATIO = 3.0;
		NO_IDLE = 1;
		ANIM_HANDS_DOWN = 9;
		ANIM_LIFT1 = 1;
		ANIM_LOWER = 0;
		ANIM_IDLE1 = 0;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 5;
		ANIM_ATTACK2 = 6;
		ANIM_ATTACK3 = 7;
		ANIM_ATTACK4 = 8;
		ANIM_SPEC_ATTACK = 3;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "viewmodels/v_martialarts_claws.mdl";
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_BODY_OFS = 116;
		MELEE_DMG = 180;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.85;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.9;
		DEMON_MELEE_DMG_DELAY = 0.1;
		DEMON_MELEE_ATK_DURATION = 0.3;
		SOUND_SWIPE = "zombie/claw_miss1.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_SWING = "zombie/claw_miss2.wav";
		SOUND_DEPLOY = "weapons/swords/sworddraw.wav";
		SOUND_LUNGE = "zombie/claw_miss1.wav";
		ANIM_PREFIX = "gauntlets";
		NO_WORLD_MODEL = 1;
		MELEE_RANGE = 50;
		REACH_MELEE_RANGE = 100;
		MELEE_ENERGY = 1;
		MELEE_DMG_RANGE = 0;
		MELEE_STAT = "martialarts";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		PLAYERANIM_AIM = "axe_onehand";
	}

	void weapon_spawn()
	{
		SetName("Demon Claws");
		SetDescription("These infernal claws can inflict massive wounds");
		SetWeight(3);
		SetSize(1);
		SetValue(3000);
		SetHand("both");
		SetHUDSprite("hand", 119);
		SetHUDSprite("trade", 119);
		if ((CUSTOM_CLAWS)) return;
		register_demon_toggle();
		DEMON_MODE = 0;
	}

	void weapon_deploy()
	{
		PlayViewAnim(ANIM_LIFT1);
		EmitSound(GetOwner(), 0, SOUND_DEPLOY, 10);
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
		FISTS_LAST_ATTACK = GetGameTime();
		punch1_done();
	}

	void punch1_done()
	{
		SetRepeatDelay(1);
		if (!(FISTS_LAST_ATTACK)) return;
		float l_elapsedtime = GetGameTime();
		l_elapsedtime -= FISTS_LAST_ATTACK;
		if (!(l_elapsedtime > 5)) return;
		PlayViewAnim(ANIM_LOWER);
		FISTS_LAST_ATTACK = 0;
	}

	void hitwall()
	{
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void register_demon_toggle()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = REACH_MELEE_RANGE;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "magic";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "martialarts";
		float reg.attack.hitchance = 0.9;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "demon";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 15;
		RegisterAttack();
	}

	void demon_start()
	{
		if (GetEntityMP(GetOwner()) < 10)
		{
			SendColoredMessage(GetOwner(), "Demon Claws: Insufficient mana for soul drain.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// TODO: splayviewanim ent_me ANIM_SPEC_ATTACK
		EmitSound(GetOwner(), 0, SOUND_LUNGE, 10);
		DEBUG_ATTACK = 1;
	}

	void demon_strike()
	{
		if (!(IsEntityAlive(param3))) return;
		if ("game.pvp" == 0)
		{
			if ((IsValidPlayer(param3)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string OWNER_TARG = GetEntityProperty(GetOwner(), "target");
		string OWNER_MP = GetEntityMP(GetOwner());
		OWNER_MP *= 0.5;
		string NEG_OWNER_MP = /* TODO: $neg */ $neg(OWNER_MP);
		EmitSound(GetOwner(), 0, "magic/eraticlightfail.wav", 10);
		GiveMP(NEG_OWNER_MP);
		CallExternal(GetOwner(), "mana_drain");
		OWNER_MP *= DEMON_STRIKE_RATIO;
		XDoDamage(OWNER_TARG, REACH_MELEE_RANGE, OWNER_MP, 1.0, GetOwner(), GetOwner(), "martialarts", "magic");
		Effect("screenfade", GetOwner(), 0.25, 3, Vector3(0, 0, 255), 96, "fadeout");
		DEBUG_ATTACK = 0;
	}

	void game_+attack2()
	{
		if ((ATTACK_DELAY)) return;
		ATTACK_DELAY = 1;
		ScheduleDelayedEvent(0.25, "attack_delay_reset");
		if ((true))
		{
			int DO_ATTACK = 1;
			if (GetEntityMP(GetOwner()) <= 10)
			{
				int DO_ATTACK = 0;
			}
			if (!(DO_ATTACK))
			{
				SendColoredMessage(GetOwner(), "Demon Claws: Insufficient mana for speed attack.");
			}
			if (!(CanAttack(GetOwner())))
			{
				SendColoredMessage(GetOwner(), "Can't attack now...");
				int DO_ATTACK = 0;
			}
			if ((DO_ATTACK))
			{
			}
			int RND_ATTACK = RandomInt(1, 4);
			if (RND_ATTACK == 1)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK1
			}
			if (RND_ATTACK == 2)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK2
			}
			if (RND_ATTACK == 3)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK3
			}
			if (RND_ATTACK == 4)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK4
			}
		}
		if (!(DO_ATTACK)) return;
		// PlayRandomSound from: SOUND_SWING, SOUND_SWIPE
		array<string> sounds = {SOUND_SWING, SOUND_SWIPE};
		EmitSound(GetOwner(), "const.sound.item", sounds[RandomInt(0, sounds.length() - 1)], 10);
		GiveMP(-10);
		CallExternal(GetOwner(), "mana_drain");
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
		FISTS_LAST_ATTACK = GetGameTime();
		punch1_done();
		if (!(true)) return;
		string DMG_SET = GetSkillLevel(GetOwner(), "martialarts.ratio");
		DMG_SET *= MELEE_DMG;
		DMG_SET *= 2;
		string OWNER_TARG = GetEntityProperty(GetOwner(), "target");
		string OWNER_POS = GetEntityOrigin(GetOwner());
		string TARG_POS = GetEntityOrigin(OWNER_TARG);
		XDoDamage(OWNER_TARG, MELEE_RANGE, DMG_SET, 0.9, GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), "martialarts", "magic");
	}

	void attack_delay_reset()
	{
		ATTACK_DELAY = 0;
	}

}

}
