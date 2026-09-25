#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class Thornlandspider : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DODGE;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_ACCURACY;
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DELETE_ON_DEATH;
	int MOVE_RANGE;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string SND_STRUCK1;
	string SND_STRUCK2;
	string SND_STRUCK3;
	string SND_STRUCK4;
	string SND_STRUCK5;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	float SPIDER_IDLE_DELAY;
	int SPIDER_IDLE_VOL;
	int SPIDER_VOLUME;

	Thornlandspider()
	{
		if (StringToLower(GetMapName()) == "thornlands")
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 200;
		}
		else
		{
			NPC_GIVE_EXP = 100;
		}
		DELETE_ON_DEATH = 1;
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SND_STRUCK1 = "body/flesh1.wav";
		SND_STRUCK2 = "body/flesh2.wav";
		SND_STRUCK3 = "body/flesh3.wav";
		SND_STRUCK4 = SOUND_PAIN;
		SND_STRUCK5 = SOUND_PAIN;
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		MOVE_RANGE = 80;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		ATTACK_DAMAGE_LOW = 9.0;
		ATTACK_DAMAGE_HIGH = 12.0;
		ATTACK_ACCURACY = 0.85;
		NPC_GIVE_EXP = 100;
		SPIDER_IDLE_VOL = 4;
		SPIDER_IDLE_DELAY = 3.6;
		SPIDER_VOLUME = 10;
	}

	void OnSpawn() override
	{
		SetHealth(500);
		SetWidth(100);
		SetHeight(64);
		SetName("Timidus Textor");
		SetHearingSensitivity(6);
		SetModel("monsters/giant_spider.mdl");
		SetDamageResistance("all", ".85");
	}

	void bite1()
	{
		if (RandomInt(0, 1) == 0)
		{
			// PlayRandomSound from: SPIDER_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SPIDER_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), 0.85, "slash");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

}

}
