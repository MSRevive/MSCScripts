#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class Metalspider : CGameScript
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
	int IMMUNE_VAMPIRE;
	int MOVE_RANGE;
	int NPC_BASE_EXP;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string PUSH_VEL;
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

	Metalspider()
	{
		if ((StringToLower(GetMapName())).findFirst("keledros") == 0)
		{
			NPC_IS_BOSS = 1;
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 1.0;
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SND_STRUCK1 = "weapons/axemetal1.wav";
		SND_STRUCK2 = "weapons/axemetal2.wav";
		SND_STRUCK3 = "doors/doorstop5.wav";
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
		MOVE_RANGE = 100;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		ATTACK_DAMAGE_LOW = 14.0;
		ATTACK_DAMAGE_HIGH = 20.0;
		ATTACK_ACCURACY = 0.6;
		NPC_GIVE_EXP = 800;
		NPC_BASE_EXP = 300;
		SPIDER_IDLE_VOL = 4;
		SPIDER_IDLE_DELAY = 3.6;
		SPIDER_VOLUME = 10;
		IMMUNE_VAMPIRE = 1;
		Precache("monsters/fer_spider_chrome.mdl");
	}

	void OnSpawn() override
	{
		SetHealth(750);
		SetWidth(120);
		SetHeight(64);
		SetName("Iron Spider");
		SetHearingSensitivity(6);
		SetModel("monsters/fer_spider_chrome.mdl");
		SetModelBody(0, 1);
		SetDamageResistance("all", 0.25);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("poison", 0.0);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 2.0);
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
		if (RandomInt(1, 10) == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), 0.85, "slash");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

	void check_attack()
	{
		if ((IS_FLEEING)) return;
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if (GetEntityRange(HUNT_LASTTARGET) <= ATTACK_RANGE)
		{
			int L_ATTACK = 1;
		}
		if (!(L_ATTACK)) return;
		npcatk_attackenemy();
	}

}

}
