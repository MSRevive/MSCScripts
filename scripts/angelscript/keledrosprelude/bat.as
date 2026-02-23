#pragma context server

#include "monsters/bat_base.as"

namespace MS
{

class Bat : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BAT_STATUS;
	int CAN_FLEE;
	int CAN_HUNT;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Bat()
	{
		ANIM_WALK = "IdleFlyNormal";
		ANIM_RUN = ANIM_WALK;
		ANIM_ATTACK = "bite";
		ANIM_IDLE_HANG = "IdleHang";
		ANIM_IDLE_FLY = "IdleFlyNormal";
		ANIM_DEATH = "die";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/rat/squeak1.wav";
		const string SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		MOVE_RANGE = 54;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 100;
		const int ATTACK_DAMAGE = 5;
		NPC_GIVE_EXP = 20;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 1;
		const float FLEE_CHANCE = 1.0;
	}

	void bat_spawn()
	{
		SetName("Fire Bat");
		SetHealth(50);
		SetWidth(32);
		SetHeight(32);
		SetHearingSensitivity(5);
		SetVolume(5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 2.0);
		SetModel("monsters/bat.mdl");
		ScheduleDelayedEvent(1, "start_flaming");
	}

	void OnPostSpawn() override
	{
		ATTACK_HITCHANCE = 0.6;
		if (StringToLower(GetMapName()) != "keledrosprelude2")
		{
			ATTACK_HITCHANCE = 0.9;
		}
	}

	void game_postspawn()
	{
	}

	void bat_drop_down()
	{
		CAN_HUNT = 1;
		BAT_STATUS = BAT_FLYING;
		SetIdleAnim(ANIM_IDLE_FLY);
	}

	void bite1()
	{
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		XDoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void start_flaming()
	{
		SetRepeatDelay(5.0);
		ApplyEffect(GetOwner(), "effects/torch_flame", 5);
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		if (!(IsEntityAlive(param2))) return;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), ATTACK_DAMAGE);
	}

}

}
