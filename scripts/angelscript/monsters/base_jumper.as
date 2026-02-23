#pragma context server

namespace MS
{

class BaseJumper : CGameScript
{
	string AS_ATTACKING;
	string FWD_NPC_JUMP_STR;
	int NPC_JUMPER;
	string NPC_LAST_JUMP;
	string NPC_NEXT_JUMP_CHECK;
	string NPC_UP_JUMP_STR;

	BaseJumper()
	{
		const int BJUMPER_FACTOR = 5;
		const string FREQ_NPC_JUMP = Random(2.0, 5.0);
		const int NPC_JUMPER_MAX_RANGE = 600;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if ((NPC_MOVEMENT_SUSPENDED)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(NPC_JUMPER)) return;
		if (!(GetGameTime() > NPC_NEXT_JUMP_CHECK)) return;
		string L_NEXT_JUMP = FREQ_NPC_JUMP;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 3.0;
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) < NPC_JUMPER_MAX_RANGE)
			{
			}
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				TARG_Z -= 38;
			}
			string Z_DIFF = TARG_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > ATTACK_RANGE)
			{
				npcatk_jump(Z_DIFF);
			}
			else
			{
				float L_NEXT_JUMP = 1.0;
			}
		}
		NPC_NEXT_JUMP_CHECK = GetGameTime();
		NPC_NEXT_JUMP_CHECK += L_NEXT_JUMP;
		L_NEXT_JUMP("npcatk_jump_cycle");
	}

	void npcatk_jump()
	{
		if (SOUND_NPC_JUMP != "SOUND_NPC_JUMP")
		{
			EmitSound(GetOwner(), 0, SOUND_NPC_JUMP, 10);
		}
		NPC_UP_JUMP_STR = param1;
		NPC_UP_JUMP_STR *= BJUMPER_FACTOR;
		if (NPC_UP_JUMP_STR > 300)
		{
			ScheduleDelayedEvent(0.75, "npcatk_jump_forward_adj");
		}
		npcatk_suspend_ai(1.0);
		FWD_NPC_JUMP_STR = GetEntityRange(m_hAttackTarget);
		PlayAnim("critical", ANIM_NPC_JUMP);
		NPC_LAST_JUMP = GetGameTime();
		if ((BJUMPER_CUSTOM_BOOST)) return;
		ScheduleDelayedEvent(0.1, "npcatk_jump_boost");
	}

	void npcatk_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_NPC_JUMP_STR, NPC_UP_JUMP_STR));
	}

	void npcatk_jump_forward_adj()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_NPC_JUMP_STR, 0));
	}

	void set_no_jump()
	{
		NPC_JUMPER = 0;
	}

	void set_jump()
	{
		NPC_JUMPER = 1;
	}

}

}
