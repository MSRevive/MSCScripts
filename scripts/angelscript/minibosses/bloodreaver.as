#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Bloodreaver : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	int I_AM_TURNABLE;
	int MOVE_RANGE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;

	Bloodreaver()
	{
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		CAN_HUNT = 1;
		HUNT_AGRO = 0;
		ANIM_ATTACK = "attack1";
		MOVE_RANGE = 40;
		const int ATTACK_DAMAGE = 30;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 200;
		const float ATTACK_HITCHANCE = 0.85;
		const string SOUND_STRUCK1 = "garg/gar_pain1.wav";
		const string SOUND_STRUCK2 = "garg/gar_pain2.wav";
		const string SOUND_STRUCK3 = "garg/gar_pain3.wav";
		const string SOUND_PAIN = "garg/gar_pain3.wav";
		const string SOUND_ATTACK1 = "controller/con_attack1.wav";
		const string SOUND_ATTACK2 = "controller/con_attack2.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_IDLE1 = "controller/con_attack3.wav";
		const string SOUND_SPAWN = "monsters/skeleton/calrian2.wav";
		MY_ENEMY = "enemy";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 100;
		DROP_GOLD_MAX = 240;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetName("Blood Reaver");
		SetRoam(false);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 200;
		SetRace("undead");
		SetModel("monsters/skeleton3.mdl");
		SetModelBody(1, 0);
		SetHealth(2000);
		SetWidth(64);
		SetHeight(128);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("blunt", 0.5);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(false);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SPAWN);
		GiveItem(GetOwner(), "scroll2_summon_undead");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		SetRoam(true);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		if (RandomInt(0, 1) == 0)
		{
			SetVolume(5);
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetRoam(true);
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), SOUND_DEATH);
		EmitSound(GetOwner(), SND_DEATH2);
		UseTrigger("bloodreaver_die");
		SetSayTextRange(1024);
		SayText("After all this time , alas... I can rest.");
	}

}

}
