#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Rogue : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_HUNT;
	int FLINCH_CHANCE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Rogue()
	{
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "player/armhit1.wav";
		const string SOUND_STRUCK3 = "player/leghit1.wav";
		const string SOUND_PAIN = "player/chesthit1.wav";
		const string SOUND_ATTACK1 = "player/jab1.wav";
		const string SOUND_ATTACK2 = "player/jab2.wav";
		const string SOUND_DEATH = "player/stomachhit1.wav";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		const int ATTACK1_DAMAGE = 4;
		MOVE_RANGE = 64;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 130;
		const float ATTACK_ACCURACY = 0.6;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		FLINCH_CHANCE = 12;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.25;
	}

	void OnSpawn() override
	{
		SetHealth(RandomInt(90, 200));
		SetWidth(32);
		SetHeight(85);
		SetRace("rogue");
		SetName("Rogue");
		SetGold(RandomInt(10, 90));
		SetHearingSensitivity(3);
		SetRoam(true);
		NPC_GIVE_EXP = 28;
		SetModel("npc/rogue.mdl");
		SetIdleAnim("aim_stance_normal");
		SetMoveAnim("aim_stance_normal");
		SetActionAnim("stance_normal_lowjab_r1");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK1_DAMAGE, ATTACK_ACCURACY, "slash");
		attackstrike();
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		flinch();
		retaliate();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetVolume(5);
		EmitSound(GetOwner(), SOUND_DEATH);
	}

}

}
