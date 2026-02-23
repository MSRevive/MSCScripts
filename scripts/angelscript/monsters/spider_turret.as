#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class SpiderTurret : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int FIRE_DELAY;
	int MOVE_RANGE;
	int NO_STEP_ADJ;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;
	float RETALIATE_CHANCE;

	SpiderTurret()
	{
		const string PROJ_TYPE = "proj_poison";
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SND_STRUCK4 = SOUND_PAIN;
		const string SND_STRUCK5 = SOUND_PAIN;
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const string ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		ATTACK_RANGE = 128;
		const int ATTACK_SPEED = 650;
		const int ATTACK_DAMAGE_LOW = 12;
		const int ATTACK_DAMAGE_HIGH = 24;
		const float ATTACK_ACCURACY = 0.6;
		ATTACK_RANGE = 128;
		MOVE_RANGE = 75;
		const int SPIDER_IDLE_VOL = 3;
		const float SPIDER_IDLE_DELAY = 3.6;
		const int SPIDER_VOLUME = 10;
		const float SPIT_FREQ = 1.0;
		const int AIM_RATIO = 50;
		NO_STEP_ADJ = 1;
		NO_STUCK_CHECKS = 1;
		NPC_MOVE_TARGET = "enemy";
		RETALIATE_CHANCE = 0.75;
	}

	void OnSpawn() override
	{
		spider_spawn();
	}

	void spider_spawn()
	{
		SetHealth(150);
		SetWidth(64);
		SetHeight(64);
		SetRoam(false);
		SetMoveSpeed(0.0);
		SetName("Spitting Spider");
		SetHearingSensitivity(10);
		SetModel("monsters/fer_spider_large.mdl");
		SetModelBody(0, 1);
		SetDamageResistance("all", ".8");
		NPC_GIVE_EXP = 80;
	}

	void debug_props()
	{
		SetSayTextRange(1024);
		if ((false))
		{
			SayText("I see enemy: GetEntityName(m_hLastSeen)");
		}
		if ((IS_HUNTING))
		{
			SayText("I am hunting: GetEntityName(ENTITY_ENEMY)");
		}
		if ((HUNTING_PLAYER))
		{
			SayText("I am hunting a player.");
		}
		if (!(false))
		{
			SayText("I see NO enemy.");
		}
		if (!(IS_HUNTING))
		{
			SayText("I am NOT hunting.");
		}
		if (!(HUNTING_PLAYER))
		{
			SayText("I am NOT hunting a player.");
		}
		SayText("My cycle time is CYCLE_TIME");
	}

	void bite1()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_ACCURACY, "slash");
		SetMoveDest(ENTITY_ENEMY);
		TossProjectile(PROJ_TYPE, /* TODO: $relpos */ $relpos(0, 48, 0), HUNT_LASTTARGET, ATTACK_SPEED, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), 2, "none");
	}

	void reset_fire_delay()
	{
		FIRE_DELAY = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((FIRE_DELAY)) return;
		FIRE_DELAY = 1;
		SPIT_FREQ("reset_fire_delay");
		if (!(false)) return;
		PlayAnim("once", ANIM_ATTACK);
	}

}

}
