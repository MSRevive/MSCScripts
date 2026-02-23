#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class OrcCataWinder : CGameScript
{
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string FINAL_KICK_TARG;
	int KICK_DELAY;
	string MY_YAW;
	string NEW_NAME;
	int NPC_DMG_MULTI;
	int NPC_HP_MULTI;
	string TRIG_PREFIX;
	int WIND_ON;

	OrcCataWinder()
	{
		const string ANIM_IDLE = "idle1";
		const string ANIM_ATTACK = "kick";
		const string ANIM_WIND = "turn_valve";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die_fallback";
		const int FLINCH_CHANCE = 50;
		const int KICK_RANGE = 180;
		const int DMG_KICK = 80;
		const int ATTACK_HITCHANCE = 90;
		const float FREQ_KICK = 7.0;
		const string SOUND_ATTACK1 = "voices/orc/attack.wav";
		const string SOUND_ATTACK2 = "voices/orc/attack2.wav";
		const string SOUND_ATTACK3 = "voices/orc/attack3.wav";
		const string SOUND_HIT = "voices/orc/hit.wav";
		const string SOUND_HIT2 = "voices/orc/hit2.wav";
		const string SOUND_HIT3 = "voices/orc/hit3.wav";
		const string SOUND_PAIN = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/orc/battlecry.wav";
		const string SOUND_DEATH = "voices/orc/die.wav";
		const string SOUND_HELP = "voices/orc/help.wav";
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(7.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if (!(WIND_ON))
		{
			wind_toggle();
		}
		face_cata();
		PlayAnim("once", ANIM_WIND);
		SetIdleAnim(ANIM_WIND);
	}

	void OnSpawn() override
	{
		SetName("Orc Catapult Winder");
		SetRace("orc");
		SetModel("monsters/orc_big.mdl");
		SetWidth(38);
		SetHeight(72);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 0);
		SetSkillLevel(80);
		SetGold(RandomInt(10, 30));
		SetHealth(2000);
		SetDamageResistance("all", 0.5);
		SetStat("parry", 40);
		SetDamageResistance("stun", 0);
		WIND_ON = 0;
		ScheduleDelayedEvent(1.0, "get_yaw");
	}

	void get_yaw()
	{
		MY_YAW = GetMonsterProperty("angles.yaw");
		MY_YAW += -90;
		SetAngles("face");
		SetOrigin(/* TODO: $relpos */ $relpos(0, -18, 0));
	}

	void game_postspawn()
	{
		NEW_NAME = param1;
		if (NEW_NAME != "default")
		{
			SetName(NEW_NAME);
		}
		NPC_DMG_MULTI = 1;
		if (param2 > 1)
		{
			NPC_DMG_MULTI += param2;
			SetDamageMultiplier(param2);
		}
		NPC_HP_MULTI = 1;
		if (param3 > 1)
		{
			string MY_HP = GetEntityMaxHealth(GetOwner());
			MY_HP *= param3;
			SetHealth(MY_HP);
		}
		TRIG_PREFIX = param4;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (param1 > 20)
		{
			if (RandomInt(1, 100) < FLINCH_CHANCE)
			{
			}
			PlayAnim("critical", ANIM_FLINCH);
		}
		if ((KICK_DELAY)) return;
		KICK_DELAY = 1;
		FREQ_KICK("reset_kick_delay");
		// PlayRandomSound from: "game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {"game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(param1 > 20)) return;
		string KICK_TARG = GetEntityIndex(m_hLastStruck);
		if (!(GetEntityRange(KICK_TARG) < KICK_RANGE)) return;
		SetMoveDest(KICK_TARG);
		FINAL_KICK_TARG = KICK_TARG;
		PlayAnim("critical", ANIM_ATTACK);
		ScheduleDelayedEvent(2.0, "face_cata");
	}

	void face_cata()
	{
		SetAngles("face");
	}

	void reset_kick_delay()
	{
		KICK_DELAY = 0;
	}

	void kick_land()
	{
		LogDebug("kick_landed: GetEntityName(FINAL_KICK_TARG) GetEntityRange(FINAL_KICK_TARG)");
		baseorc_yell();
		DoDamage(FINAL_KICK_TARG, KICK_RANGE, DMG_KICK, 1.0, "blunt");
	}

	void baseorc_yell()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {"game.sound.maxvol", SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 64, 1, 1);
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 800)));
	}

	void fire_cata()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string TRIG_STRING = TRIG_PREFIX;
		TRIG_STRING += "_fire";
		UseTrigger(TRIG_STRING);
		SetIdleAnim(ANIM_IDLE);
		if ((WIND_ON))
		{
			ScheduleDelayedEvent(2.0, "wind_toggle");
		}
	}

	void wind_toggle()
	{
		if (!(WIND_ON))
		{
			WIND_ON = 1;
		}
		else
		{
			WIND_ON = 0;
		}
		string TRIG_STRING = TRIG_PREFIX;
		TRIG_STRING += "_wind";
		UseTrigger(TRIG_STRING);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string TRIG_STRING = TRIG_PREFIX;
		TRIG_STRING += "_died";
		UseTrigger(TRIG_STRING);
		if ((WIND_ON))
		{
			wind_toggle();
		}
	}

}

}
