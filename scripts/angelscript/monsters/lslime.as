#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Lslime : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	float FLEE_CHANCE;
	string LIGHTNING_SPRITE;
	int MOVE_RANGE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANGETARGET_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Lslime()
	{
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_ATTACK1 = "weapons/electro4.wav";
		SOUND_ATTACK2 = "weapons/electro5.wav";
		SOUND_ATTACK3 = "weapons/electro6.wav";
		SOUND_DEATH = "monsters/sludge/bio.wav";
		SOUND_IDLE1 = "weapons/gauss2.wav";
		ANIM_IDLE = "walk";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 150;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 230;
		ATTACK_HITCHANCE = 0.8;
		ATTACK_DAMAGE = 10;
		FLEE_CHANCE = 0.25;
		MY_ENEMY = "enemy";
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_FLEE = 0;
		LIGHTNING_SPRITE = "lgtning.spr";
		Precache(SOUND_DEATH);
		Precache(SOUND_ATTACK1);
		Precache(SOUND_ATTACK2);
		Precache(SOUND_ATTACK3);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (RandomInt(0, 1) == 0)
		{
		}
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_IDLE1, 5);
	}

	void OnSpawn() override
	{
		SetHealth(15);
		SetWidth(40);
		SetHeight(64);
		SetRace("wildanimal");
		SetName("Electrified slime");
		if (!(ME_NO_WANDER))
		{
			SetRoam(true);
		}
		if ((ME_NO_WANDER))
		{
			SetRoam(false);
		}
		SetHearingSensitivity(4);
		NPC_GIVE_EXP = 20;
		SetBloodType("green");
		SetDamageResistance("lightning", 0.0);
		SetModel("monsters/slime.mdl");
		SetModelBody(0, 4);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, -1, 0);
	}

	void bite1()
	{
		if (!(false)) return;
		XDoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "lightning", "dmgevent:bite");
	}

	void bite_dodamage()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		Effect("beam", "point", LIGHTNING_SPRITE, 30, /* TODO: $relpos */ $relpos(0, 0, -22), param4, Vector3(255, 255, 0), 150, 50, 0.2);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void cycle_up()
	{
		if (!(ME_NO_WANDER)) return;
		SetRoam(true);
	}

}

}
