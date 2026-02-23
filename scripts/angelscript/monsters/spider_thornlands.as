#pragma context server

#include "monsters/spider_base_new.as"

namespace MS
{

class SpiderThornlands : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string PUSH_VEL;

	SpiderThornlands()
	{
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
		MOVE_RANGE = 50;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		const float ATTACK_DAMAGE_LOW = 9.0;
		const float ATTACK_DAMAGE_HIGH = 12.0;
		const float ATTACK_ACCURACY = 0.85;
		NPC_GIVE_EXP = 100;
		NPC_MUST_SEE_TARGET = 0;
		const int SPIDER_IDLE_VOL = 4;
		const float SPIDER_IDLE_DELAY = 3.6;
		const int SPIDER_VOLUME = 10;
	}

	void OnSpawn() override
	{
		SetHealth(500);
		SetWidth(120);
		SetHeight(64);
		SetName("Gigantic Cave Spider");
		SetHearingSensitivity(6);
		SetModel("monsters/giant_spider.mdl");
		NPC_GIVE_EXP = 100;
		SetDamageResistance("all", ".85");
		CatchSpeech("debug_props", "debug");
	}

	void debug_props()
	{
		SetSayTextRange(1024);
		if ((false))
		{
			SayText("I see enemy. GetEntityName(m_hLastSeen)");
		}
		if ((IS_HUNTING))
		{
			SayText("I am hunting: GetEntityName(HUNT_LASTTARGET)");
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
		if (RandomInt(0, 1) == 0)
		{
			// PlayRandomSound from: SPIDER_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SPIDER_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		PUSH_VEL = /* TODO: $relvel */ $relvel(0, 100, 0);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), 0.85);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

}

}
