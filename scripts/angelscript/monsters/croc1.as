#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Croc1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_CUSTOM_FLINCH;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_NORMAL;
	string ANIM_SWIM;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DID_INTRO;
	int DMG_BITE;
	int FISH_VRANGE;
	int FISH_VSPEED_DOWN;
	int FISH_VSPEED_UP;
	string HALF_HP;
	int MOVE_RANGE;
	string NEXT_FLINCH;
	string NEXT_IDLE_SOUND;
	string NEXT_VICTORY;
	int NPC_GIVE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int STEP_COUNT;

	Croc1()
	{
		ANIM_SWIM = "swim";
		ANIM_RUN_NORMAL = "Run";
		ANIM_RUN = "Run";
		ANIM_WALK = "Walk";
		ANIM_IDLE = "idle";
		ANIM_DEATH = "diesimple";
		ANIM_CUSTOM_FLINCH = "Sflinch";
		ANIM_ATTACK = "biteattack";
		DMG_BITE = 300;
		NPC_GIVE_EXP = 600;
		MOVE_RANGE = 50;
		ATTACK_MOVERANGE = 50;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 90;
		FISH_VSPEED_UP = 25;
		FISH_VSPEED_DOWN = -25;
		FISH_VRANGE = 50;
		SOUND_STEP1 = "monsters/gator/Gator_Footstep1.wav";
		SOUND_STEP2 = "monsters/gator/Gator_Footstep2.wav";
		SOUND_IDLE1 = "monsters/gator/Gator_IdleNormal_F0.wav";
		SOUND_IDLE2 = "monsters/gator/Gator_IdleRoarLow_F0.wav";
		SOUND_ATTACK1 = "monsters/gator/Gator_BiteAttack.wav";
		SOUND_ATTACK2 = "monsters/gator/Gator_BiteAttack_1.wav";
		SOUND_ATTACK3 = "monsters/gator/Gator_BiteAttack_2_f0.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_DEATH = "monsters/Gator_DieSimple.wav";
	}

	void OnSpawn() override
	{
		SetName("Crocodile");
		SetModel("monsters/gator.mdl");
		SetWidth(32);
		SetHeight(32);
		SetRace("wildanimal");
		SetHealth(3000);
		SetDamageResistance("cold", 1.25);
		SetRoam(true);
		SetHearingSensitivity(4);
		STEP_COUNT = 0;
		ScheduleDelayedEvent(2.0, "finalize_me");
	}

	void finalize_me()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		npcatk_suspend_roam(2.0);
		EmitSound(GetOwner(), 0, "monsters/gator/Gator_SeePlayer_f0.wav", 10);
		PlayAnim("critical", "idleroarlow");
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_VICTORY)) return;
		npcatk_suspend_roam(2.0);
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += 20.0;
		EmitSound(GetOwner(), 0, "monsters/gator/Gator_IdleRoarLow_F0.wav", 10);
		PlayAnim("critical", "idleroarlow");
	}

	void cycle_down()
	{
		DID_INTRO = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (m_hAttackTarget == "unset")
		{
			if (GetGameTime() > NEXT_IDLE_SOUND)
			{
			}
			NEXT_IDLE_SOUND = GetGameTime();
			NEXT_IDLE_SOUND += Random(5.0, 15.0);
			// PlayRandomSound from: SOUND_IDLE1
			array<string> sounds = {SOUND_IDLE1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((IsInWater(GetOwner())))
		{
			ANIM_RUN = ANIM_SWIM;
			SetMoveAnim(ANIM_RUN);
			string MOVE_DEST_Z = (GetMonsterProperty("movedest.origin")).z;
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			SetGravity(0);
			if (MOVE_DEST_Z > MY_Z)
			{
				if ((IsInWater(GetOwner())))
				{
				}
				string Z_DIFF = MOVE_DEST_Z;
				Z_DIFF -= MY_Z;
				if (Z_DIFF > FISH_VRANGE)
				{
				}
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, FISH_VSPEED_UP));
			}
			if (MOVE_DEST_Z < MY_Z)
			{
				string Z_DIFF = MY_Z;
				Z_DIFF -= MOVE_DEST_Z;
				if (Z_DIFF > FISH_VRANGE)
				{
				}
				AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, FISH_VSPEED_DOWN));
			}
		}
		else
		{
			SetGravity(1);
			ANIM_RUN = "Run";
			SetMoveAnim(ANIM_RUN);
		}
	}

	void frame_step()
	{
		STEP_COUNT += 1;
		if (STEP_COUNT == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_STEP2, 10);
		}
	}

	void frame_bite()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.8, "pierce");
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 250, 110));
	}

	void OnDamage(int damage) override
	{
		if (!(GetEntityHealth(GetOwner()) < HALF_HP)) return;
		if (!(GetGameTime() > NEXT_FLINCH)) return;
		NEXT_FLINCH = GetGameTime();
		NEXT_FLINCH += 20.0;
		npcatk_suspend_roam(2.0);
		PlayAnim("critical", ANIM_CUSTOM_FLINCH);
		EmitSound(GetOwner(), 0, "monsters/gator/Gator_Sflinch_f0.wav", 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

}

}
