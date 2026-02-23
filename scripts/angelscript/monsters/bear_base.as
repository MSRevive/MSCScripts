#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class BearBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int CAN_FLEE;
	int CAN_HEAR;
	int CAN_RETALIATE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int HUNT_AGRO;
	string NPC_HEAR_TARGET;

	BearBase()
	{
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		const string SOUND_ATTACK1 = "monsters/bear/cubattack.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_ATTACK3 = "none";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_STRUCK4 = "monsters/bear/cubpain.wav";
		const string SOUND_STRUCK5 = "none";
		const string SOUND_DEATH = "monsters/bear/cubdeath.wav";
		HUNT_AGRO = 1;
		CAN_FLEE = 0;
		CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.2;
		CAN_HEAR = 1;
		NPC_HEAR_TARGET = "enemy";
		DROP_ITEM1 = "skin_bear";
		DROP_ITEM1_CHANCE = 0.5;
		const string BEAR_VOLUME = "game.sound.maxvol";
	}

	void OnSpawn() override
	{
		SetRoam(true);
		SetRace("wildanimal");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void game_postspawn()
	{
		if ((StringToLower(GetMapName())).findFirst("skycastle") == 0)
		{
			DROP_ITEM1_CHANCE = 0.0;
		}
	}

	void bite1()
	{
		// PlayRandomSound from: BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: BEAR_VOLUME, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {BEAR_VOLUME, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
