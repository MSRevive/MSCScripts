#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Spidqueen : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_ACCURACY;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int MOVE_RANGE;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Spidqueen()
	{
		if ((StringToLower(GetMapName())).findFirst("calruin") == 0)
		{
			NPC_GIVE_EXP = 500;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 200;
		}
		NPC_BOSS_REGEN_RATE = 0.1;
		NPC_BOSS_RESTORATION = 1.0;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ATTACK_DAMAGE = Random(8.5, 10.0);
		ATTACK_RANGE = 250;
		ATTACK_HITRANGE = 350;
		MOVE_RANGE = 50;
		ATTACK_ACCURACY = 0;
		ATTACK_HITCHANCE = 1.0;
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		CAN_FLEE = 0;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 25;
		DROP_GOLD_MAX = 50;
		Precache(SOUND_STRUCK1);
		Precache(SOUND_STRUCK2);
		Precache(SOUND_STRUCK3);
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(900);
		SetWidth(120);
		SetHeight(80);
		SetName("Veneficus Arachnidia");
		SetRoam(true);
		SetHearingSensitivity(6);
		SetRace("spider");
		if (StringToLower(GetMapName()) != "helena")
		{
			SetModel("monsters/fer_spider_giant.mdl");
			SetModelBody(0, 2);
		}
		else
		{
			SetModel("monsters/giant_spider.mdl");
		}
		SetIdleAnim("idle");
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", ".7");
	}

	void bite1()
	{
		if (RandomInt(0, 1) == 0)
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(9.5, 11.0), ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
