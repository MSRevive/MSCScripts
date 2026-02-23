#pragma context server

#include "monsters/horror.as"

namespace MS
{

class HorrorLightningOld : CGameScript
{
	string ANIM_ATTACK;
	int AS_SUMMON_TELE_CHECK;
	int BALL_DMG;
	int BALL_SIZE;
	int FLIGHT_SCANNING;
	int IS_UNHOLY;
	int I_FLY;
	int NPC_GIVE_EXP;
	string SPITTING;
	int SPRAYING_GAS;

	HorrorLightningOld()
	{
		AS_SUMMON_TELE_CHECK = 1;
		IS_UNHOLY = 1;
		BALL_SIZE = 5;
		BALL_DMG = 50;
		const string SOUND_SPRAY = "debris/beamstart1.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void game_precache()
	{
		Precache("monsters/horror");
	}

	void OnSpawn() override
	{
		SetName("Electric Horror");
		SetHealth(500);
		SetWidth(22);
		SetHeight(22);
		SetRoam(true);
		SetFly(true);
		I_FLY = 1;
		0 = float(0);
		SetRace("demon");
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/edwardgorey.mdl");
		NPC_GIVE_EXP = 200;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FLIGHT_SCANNING = 1;
		SetModelBody(0, 2);
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 0.0);
	}

	void attack1()
	{
		if ((SPITTING))
		{
			TossProjectile("proj_lightning_ball", "view", "none", 500, SPIT_DAMAGE, 0.5, "none");
			SPITTING = 0;
			// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
			array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (SPIT_AMMO == 0)
			{
				fly_mode();
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_GORE;
		}
	}

	void breath_attack()
	{
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 768, 2, 2);
		EmitSound(GetOwner(), 0, SOUND_SPRAY, 10);
		SPRAYING_GAS = 1;
		ScheduleDelayedEvent(1.0, "stop_spraying");
		if (!(GetEntityRange(m_hLastSeen) <= ATTACK_BLIND_RANGE)) return;
		ApplyEffect(m_hLastSeen, "effects/dot_lightning", RandomInt(3, 8), GetEntityIndex(GetOwner()), RandomInt(10, 20));
		if (!(BREATH_AMMO <= 0)) return;
		ScheduleDelayedEvent(20.0, "breath_reload");
	}

}

}
