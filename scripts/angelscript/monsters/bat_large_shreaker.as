#pragma context server

#include "monsters/bat_base.as"

namespace MS
{

class BatLargeShreaker : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BAT_STATUS;
	int CAN_HUNT;
	string MOVE_MODE;
	int MOVE_RANGE;
	string NEXT_RETREAT;
	string NEXT_SHREAK;
	int NPC_GIVE_EXP;

	BatLargeShreaker()
	{
		const int BAT_NO_FAKE_DEATH = 1;
		const int DMG_SHREAK = 150;
		const float FREQ_SHREAK = 5.0;
		const string SOUND_SHREAK = "monsters/bat/zoobat.wav";
		const string ANIM_SHREAK = "";
		ANIM_WALK = "IdleFlyNormal";
		ANIM_RUN = ANIM_WALK;
		ANIM_ATTACK = "bite";
		ANIM_IDLE_HANG = "IdleHang";
		ANIM_IDLE_FLY = "IdleFlyNormal";
		ANIM_DEATH = "IdleFlyNormal";
		const string ANIM_HOVER = "IdleFlyFace";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/rat/squeak1.wav";
		const string SOUND_IDLE = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		MOVE_RANGE = 128;
		ATTACK_RANGE = 65;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.8;
		const int ATTACK_DAMAGE = 50;
		NPC_GIVE_EXP = 75;
		const string SOUND_ALERT = "monsters/bat/alert.wav";
		Precache("monsters/zubat_sphere.mdl");
	}

	void bat_spawn()
	{
		SetName("Shrieker Bat");
		SetHealth(300);
		SetWidth(32);
		SetHeight(32);
		SetHearingSensitivity(3.5);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
		SetModel("monsters/bat_large.mdl");
		SetProp(GetOwner(), "skin", 2);
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
		DoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner());
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(GetGameTime() > NEXT_RETREAT)) return;
		NEXT_RETREAT = GetGameTime();
		NEXT_RETREAT += Random(3.0, 5.0);
		string RND_LR = Random(-300.0, 300.0);
		string RND_FB = Random(-1500.0, 500.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 0));
	}

	void npc_targetsighted()
	{
		if (!(GetEntityRange(m_hAttackTarget) < 256)) return;
		if (!(GetGameTime() > NEXT_SHREAK)) return;
		NEXT_SHREAK = GetGameTime();
		if ((I_R_FROZEN))
		{
			RemoveEffect(GetOwner(), "debuff_frozen");
		}
		NEXT_SHREAK += FREQ_SHREAK;
		EmitSound(GetOwner(), 2, SOUND_SHREAK, 10);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 32, 3.0, 2.0);
		ClientEvent("new", "all", "effects/sfx_pulse_sphere", GetEntityOrigin(GetOwner()), 10.0, GetEntityIndex(GetOwner()), 2, 2, 0);
		ScheduleDelayedEvent(0.5, "shreak_blast");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 512, 90, 3.0, 512);
	}

	void shreak_blast()
	{
		XDoDamage(GetEntityOrigin(GetOwner()), 256, DMG_SHREAK, 0.1, GetOwner(), GetOwner(), "none", "magic_effect", "dmgevent:shreak");
	}

	void shreak_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (GetEntityRange(m_hAttackTarget) < 256)
		{
			SetMoveAnim(ANIM_HOVER);
			PlayAnim("once", ANIM_HOVER);
			SetAnimMoveSpeed(0);
			MOVE_MODE = 0;
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 0)));
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 2.0;
		}
		else
		{
			SetAnimMoveSpeed(1);
			SetMoveAnim(ANIM_WALK);
			if (!(MOVE_MODE))
			{
			}
			PlayAnim("once", "break");
			MOVE_MODE = 1;
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("new", "all", "monsters/bat_large_corpse_cl", GetEntityOrigin(GetOwner()), 2);
	}

}

}
