#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_monster_explode.as"
#include "monsters/base_damage_stack.as"

namespace MS
{

class Chumtoad : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	int ANIM_IDLE3_CHANCE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BLINK_CYCLE;
	int BLINK_STEP;
	int CANT_FLEE;
	int CAN_FLINCH;
	int CAN_RETALIATE;
	int DO_IDLE_NOISES;
	int HACKING_ATK_DIST;
	int NPC_GIVE_EXP;
	int NPC_NO_ATTACK;
	string SOUND_CHANNEL;
	int SUICIDE_CHANCE;
	int SUICIDING;
	int TRIED_SUICIDE;

	Chumtoad()
	{
		ANIM_RUN = "hop_1";
		ANIM_WALK = "hop_1";
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "flinch2";
		NPC_NO_ATTACK = 0;
		ATTACK_MOVERANGE = 10;
		ATTACK_RANGE = 50;
		ATTACK_HITRANGE = 70;
		const int ATTACK_HITCHANCE = 80;
		const int FLEE_HEALTH = 0;
		const int FLEE_CHANCE = 0;
		CANT_FLEE = 1;
		CAN_RETALIATE = 1;
		CAN_FLINCH = 0;
		const int EXPLOSION_DAMAGE = 65;
		const string ANIM_CHARGE = "idle2";
		const string ANIM_SUICIDE = "flinch1";
		ANIM_IDLE3_CHANCE = 5;
		const int LONG_ATTACK = 35;
		const int SHORT_ATTACK = 15;
		const string MONSTER_HEALTH = GetEntityMaxHealth(GetOwner());
		const string GIB_BURSTER_SCRIPT = "effects/sfx_gib_burst";
		const int GIB_BURSTER_FORCE = 200;
		const string EXPLOSION_SFX = "effects/sfx_sprite";
		const string EXPLOSION_SPRITE = "oculus/exp_green.spr";
		const string EXPLOSION_SFX_SOUND = "monsters/tube/Tube_ExplodingDeath.wav";
		const string IDLE_SOUND1 = "monsters/ogre_welp/bc_idle2.wav";
		const string IDLE_SOUND2 = "monsters/ogre_welp/bc_idle3.wav";
		const string IDLE_SOUND3 = "monsters/ogre_welp/bc_idle4.wav";
		const string DEATH_SOUND1 = "monsters/bat/pain1.wav";
		const string DEATH_SOUND2 = "monsters/bat/pain2.wav";
		const string DEATH_SOUND3 = "monsters/beetle/idle.wav2";
		const string DEATH_SOUND4 = "monsters/beetle/idle3.wav";
		const string PAIN_SOUND1 = "monsters/ogre_welp/bc_pain1.wav";
		const string PAIN_SOUND2 = "monsters/ogre_welp/bc_pain2.wav";
		const string PAIN_SOUND3 = "monsters/ogre_welp/bc_pain3.wav";
		const string HIT_SOUNDS = "monsters/tube/TubeCritter_Hit1.wav;monsters/tube/TuberCritter_Hit2.wav;monsters/tube/TubeCritter_Hit3.wav";
		const int PITCH_MIN = 30;
		const int PITCH_MAX = 200;
		SUICIDE_CHANCE = 5;
		const float SUICIDE_THRESHOLD = 0.7;
		const int SUICIDE_DISTANCE = 100;
		SUICIDING = 0;
		TRIED_SUICIDE = 0;
		const int BLINK_FREQ = 5;
		const float BLINK_DUR = 0.2;
		BLINK_STEP = 0;
		const int BLINK_MAX = 2;
		BLINK_CYCLE = 1;
		HACKING_ATK_DIST = 0;
		DO_IDLE_NOISES = 1;
		const int IDLE_NOISE_FREQ = 5;
		NPC_GIVE_EXP = 200;
	}

	void game_precache()
	{
		Precache("monsters/chumtoad.mdl");
		Precache(EXPLOSION_SPRITE);
		Precache("agibs.mdl");
	}

	void OnSpawn() override
	{
		SetName("Chumtoad");
		SetRace("vermin");
		SetHealth(300);
		SetModel("monsters/chumtoad.mdl");
		SetWidth(20);
		SetHeight(8);
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetBloodType("green");
		SetRoam(false);
		PlayAnim("once", ANIM_IDLE);
		SOUND_CHANNEL = CHAN_VOICE;
		BLINK_FREQ("do_blinking");
		IDLE_NOISE_FREQ("play_idle");
	}

	void play_idle()
	{
		if ((DO_IDLE_NOISES))
		{
			// PlayRandomSound from: IDLE_SOUND1, IDLE_SOUND2, IDLE_SOUND3
			array<string> sounds = {IDLE_SOUND1, IDLE_SOUND2, IDLE_SOUND3};
			EmitSound(GetOwner(), SOUND_CHANNEL, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		IDLE_NOISE_FREQ("play_idle");
	}

	void do_blinking()
	{
		string L_PROPS = GetEntityProperty(GetOwner(), "renderprops");
		string L_SKIN = GetToken(L_PROPS, 4, ";");
		BLINK_STEP = /* TODO: $math(add) */ BLINK_STEP;
		if (BLINK_STEP >= BLINK_MAX)
		{
			BLINK_CYCLE = -1;
		}
		else
		{
			if (BLINK_STEP <= 0)
			{
				BLINK_CYCLE = 1;
			}
		}
		if (L_SKIN < 3)
		{
			SetProp(GetOwner(), "skin", BLINK_STEP);
		}
		if (BLINK_STEP == 0)
		{
			BLINK_FREQ("do_blinking");
		}
		else
		{
			BLINK_DUR("do_blinking");
		}
	}

	void OnDamage(int damage) override
	{
		string L_HP = GetEntityHealth(GetOwner());
		if (L_HP <= /* TODO: $math(multiply) */ MONSTER_HEALTH)
		{
			if (!(TRIED_SUICIDE))
			{
				TRIED_SUICIDE = 1;
				if (RandomInt(1, 100) <= SUICIDE_CHANCE)
				{
					do_suicide_charge();
				}
			}
		}
		// PlayRandomSound from: PAIN_SOUND1, PAIN_SOUND2, PAIN_SOUND3
		array<string> sounds = {PAIN_SOUND1, PAIN_SOUND2, PAIN_SOUND3};
		EmitSound(GetOwner(), SOUND_CHANNEL, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void dmgstk_dodamage()
	{
		if ((param1))
		{
			string L_TARGET = param2;
			HACKING_ATK_DIST = 1;
			string L_MULT = /* TODO: $get_scriptflag */ $get_scriptflag(L_TARGET, STACK_FLAG_NAME, "name_value");
			L_MULT -= 0.1;
			string L_PITCH = /* TODO: $ratio */ $ratio(/* TODO: $math(divide) */ L_MULT, PITCH_MIN, PITCH_MAX);
			EmitSound(GetOwner(), SOUND_CHANNEL, GetRandomToken(HIT_SOUNDS, ";"), 10);
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		LogDebug("chumtoad-game_damaged_other PARAM4");
		if ((HACKING_ATK_DIST))
		{
			string L_HACK_START = GetEntityOrigin(GetOwner());
			string L_HACK_END = GetEntityOrigin(param1);
			string L_HACK_HITRANGE = ATTACK_HITRANGE;
			L_HACK_HITRANGE += /* TODO: $math(divide) */ GetEntityWidth(param1);
			if ((IsValidPlayer(param1)))
			{
				L_HACK_HITRANGE += /* TODO: $math(divide) */ GetEntityHeight(param1);
			}
			if (Distance(L_HACK_START, L_HACK_END) >= L_HACK_HITRANGE)
			{
				return;
			}
			else
			{
				if ((TraceLine(L_HACK_START, L_HACK_END)))
				{
					return;
				}
			}
			HACKING_ATK_DIST = 0;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: DEATH_SOUND1, DEATH_SOUND2, DEATH_SOUND3, DEATH_SOUND4
		array<string> sounds = {DEATH_SOUND1, DEATH_SOUND2, DEATH_SOUND3, DEATH_SOUND4};
		EmitSound(GetOwner(), SOUND_CHANNEL, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void do_suicide_charge()
	{
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_CHARGE);
		SUICIDING = 1;
	}

	void finish_charge()
	{
		PlayAnim("critical", ANIM_SUICIDE);
	}

	void finish_suicide()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		do_explode();
		npc_suicide();
	}

	void do_explode()
	{
		string L_VEC = GetEntityOrigin(GetOwner());
		L_VEC += Vector3(0, 0, 30);
		string L_COL = /* TODO: $clcol */ $clcol(0, 0, 0);
		string L_STR = "0;3;255;add;";
		L_STR += L_COL;
		L_STR += ";20;10";
		ClientEvent("new", "all", EXPLOSION_SFX, L_VEC, EXPLOSION_SPRITE, L_STR, 0.5);
		ClientEvent("new", "all", GIB_BURSTER_SCRIPT, L_VEC, "agibs.mdl", "0;1;2;3", "1;0.5;255;normal", 4, GIB_BURSTER_FORCE, 5);
		EmitSound(GetOwner(), 0, EXPLOSION_SFX_SOUND, 10);
	}

	void beam_dodamage()
	{
		if ((param1))
		{
			string L_TARGET = param2;
			if (GetRelationship(L_TARGET) == "enemy")
			{
				string L_PASS_PARAM = param6;
				do_stack(L_TARGET, L_PASS_PARAM);
			}
		}
	}

	void npc_selectattack()
	{
		if (RandomInt(0, 100) <= ANIM_IDLE3_CHANCE)
		{
			ANIM_ATTACK = "idle3";
		}
		else
		{
			ANIM_ATTACK = "flinch2";
		}
	}

	void attack_1()
	{
		do_attack(LONG_ATTACK);
	}

	void attack_2()
	{
		do_attack(SHORT_ATTACK);
	}

	void do_attack()
	{
		XDoDamage(m_hAttackTarget, "direct", param1, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:dmgstk");
	}

	void dmgstk_damaged_other()
	{
		LogDebug("dmgstk_damaged_other PARAM1 PARAM2 PARAM3");
	}

	void cycle_up()
	{
		DO_IDLE_NOISES = 0;
	}

	void cycle_down()
	{
		DO_IDLE_NOISES = 1;
	}

	void ext_suicide_chance()
	{
		SUICIDE_CHANCE = param1;
	}

}

}
