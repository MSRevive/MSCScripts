#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class SkeletonSoulEater : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	string DID_PUSH;
	int LAST_STOLE_HP;
	int LEGIT_MAP;
	int MOVE_RANGE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_HEAL;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_PUSH;
	string SOUND_SPAWN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	SkeletonSoulEater()
	{
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack1";
		ATTACK_DAMAGE = 30;
		ATTACK_RANGE = 150;
		MOVE_RANGE = 125;
		ATTACK_HITRANGE = 175;
		ATTACK_HITCHANCE = 0.85;
		SOUND_STRUCK1 = "controller/con_pain3.wav";
		SOUND_STRUCK2 = "controller/con_pain3.wav";
		SOUND_STRUCK3 = "none";
		SOUND_PAIN = "zombie/zo_pain2.wav";
		SOUND_ATTACK1 = "controller/con_attack1.wav";
		SOUND_HEAL = "monsters/skeleton/calrian2.wav";
		SOUND_ATTACK2 = "controller/con_attack2.wav";
		SOUND_DEATH = "controller/con_die1.wav";
		SOUND_IDLE1 = "controller/con_attack3.wav";
		SOUND_SPAWN = "monsters/skeleton/calrian2.wav";
		SOUND_PUSH = "monsters/skeleton/calrain3.wav";
		MY_ENEMY = "enemy";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(1500);
		SetWidth(32);
		SetHeight(80);
		SetName("Soul Eater");
		SetRoam(true);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 200;
		SetRace("undead");
		SetModel("monsters/skeleton2.mdl");
		SetModelBody(1, 0);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("stun", 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		string MAP_NAME = GetMapName();
		LEGIT_MAP = 0;
		LAST_STOLE_HP = 10;
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		string ENEMY_HP = GetEntityHealth(m_hLastStruckByMe);
		string DIV_ATTACK_DAMAGE = ATTACK_DAMAGE;
		DIV_ATTACK_DAMAGE *= 0.6;
		if (LAST_STOLE_HP > 0)
		{
			LAST_STOLE_HP -= 1;
		}
		if (ENEMY_HP <= DIV_ATTACK_DAMAGE)
		{
			if (LAST_STOLE_HP < 1)
			{
				if (GetRelationship(m_hLastStruckByMe) == "enemy")
				{
				}
				string ENEMY_MAXHP = GetEntityMaxHealth(m_hLastStruckByMe);
				string ICE_CREAM_NAME = "Ice Wall";
				string NME_NAME = GetEntityName(m_hLastStruckByMe);
				SendInfoMsg(m_hLastStruckByMe, SOUL_EATER + " Beware, soul eaters gain double their victim's health when they slay a living opponent.");
				SetSayTextRange(1024);
				if (NME_NAME == ICE_CREAM_NAME)
				{
					SayText("Mmmmmmm... Ice cream!");
				}
				if (NME_NAME != ICE_CREAM_NAME)
				{
					SayText("I'll swallow your soul!");
				}
				SetVolume(10);
				EmitSound(GetOwner(), SOUND_HEAL);
				ENEMY_MAXHP *= 2.0;
				HealEntity(GetOwner(), ENEMY_MAXHP);
				Effect("glow", GetOwner(), Vector3(0, 255, 0), 255, 2, 2);
				LAST_STOLE_HP = 10;
			}
		}
		int I_DID_PUSH = 0;
		if (DID_PUSH == 1)
		{
			DID_PUSH = 0;
			int I_DID_PUSH = 1;
		}
		if ((I_DID_PUSH)) return;
		if (RandomInt(0, 1) == 0)
		{
			SetVolume(5);
			if (LAST_STOLE_HP < 3)
			{
				// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
				array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
				EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (RandomInt(1, 30) == 1)
		{
			PlayAnim("critical", "attack2");
			SetVolume(10);
			EmitSound(GetOwner(), SOUND_PUSH);
			string MY_LOC = GetEntityOrigin(GetOwner());
			string NME_LOC = GetEntityOrigin(m_hLastStruckByMe);
			float NME_DISTANCE = Distance(MY_LOC, NME_LOC);
			if (NME_DISTANCE < ATTACK_HITRANGE)
			{
				ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
			}
			DID_PUSH = 1;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		bm_gold_spew(25, 1, 50, 4, 8);
	}

}

}
