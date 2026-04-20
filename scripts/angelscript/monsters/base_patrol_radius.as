#pragma context server

namespace MS
{

class BasePatrolRadius : CGameScript
{
	float BPATROL_AGRO_RATIO;
	float BPATROL_ATK_COOLDOWN;
	string BPATROL_CENTER;
	float BPATROL_COOL_DOWN;
	int BPATROL_DEF_HEARING;
	string BPATROL_LAST_ATK;
	string BPATROL_MOVEPROX;
	string BPATROL_NEXT_REGEN;
	string BPATROL_OUTSIDE_RANGE;
	int BPATROL_RAD;
	float BPATROL_REGEN_AMT;
	float BPATROL_REGEN_FREQ;
	string BPATROL_ROT;
	string BPATROL_STRUCK_DELAY;
	int BPATROL_TARGET_VALIDATED;
	string BPATRON_NEXT_BEAM;
	int NPC_EXTRA_VALIDATIONS;

	BasePatrolRadius()
	{
		BPATROL_RAD = 512;
		BPATROL_AGRO_RATIO = 2.0;
		BPATROL_COOL_DOWN = Random(10.0, 15.0);
		BPATROL_ATK_COOLDOWN = 10.0;
		BPATROL_MOVEPROX = GetMonsterProperty("moveprox");
		BPATROL_DEF_HEARING = 10;
		NPC_EXTRA_VALIDATIONS = 1;
		BPATROL_REGEN_FREQ = 10.0;
		BPATROL_REGEN_AMT = 0.01;
	}

	void OnSpawn() override
	{
		BPATROL_CENTER = GetEntityOrigin(GetOwner());
	}

	void bpatrol_debug_beams()
	{
		if (!(BPATROL_ACTIVE)) return;
		string BEAM_START = BPATROL_CENTER;
		string BEAM_END = BPATROL_CENTER;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, BPATROL_ROT, 0), Vector3(0, BPATROL_RAD, 32));
		BPATROL_ROT += 22.5;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BPATROL_ROT, 0), Vector3(0, BPATROL_RAD, 32));
		Effect("beam", "point", "lgtning.spr", 20, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 0, 20.0);
		string BEAM_START = BPATROL_CENTER;
		string BEAM_END = BPATROL_CENTER;
		string L_BPATROL_RAD = BPATROL_RAD;
		L_BPATROL_RAD *= BPATROL_AGRO_RATIO;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, BPATROL_ROT, 0), Vector3(0, L_BPATROL_RAD, 32));
		BPATROL_ROT += 22.5;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, BPATROL_ROT, 0), Vector3(0, L_BPATROL_RAD, 32));
		Effect("beam", "point", "lgtning.spr", 20, BEAM_START, BEAM_END, Vector3(255, 0, 0), 200, 0, 20.0);
		BPATROL_ROT -= 22.5;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(BPATROL_ACTIVE)) return;
		if (GetGameTime() > BPATROL_NEXT_REGEN)
		{
			if (!(BPATROL_TARGET_VALIDATED))
			{
			}
			BPATROL_NEXT_REGEN = GetGameTime();
			BPATROL_NEXT_REGEN += BPATROL_REGEN_FREQ;
			if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
			{
			}
			string HP_TO_GIVE = GetEntityMaxHealth(GetOwner());
			HP_TO_GIVE *= BPATROL_REGEN_AMT;
			HealEntity(GetOwner(), HP_TO_GIVE);
		}
		if ((G_DEVELOPER_MODE))
		{
			if (GetGameTime() > BPATRON_NEXT_BEAM)
			{
			}
			BPATRON_NEXT_BEAM = GetGameTime();
			BPATRON_NEXT_BEAM += 20.0;
			string BEAM_START = BPATROL_CENTER;
			string BEAM_END = BEAM_START;
			BEAM_END += "z";
			Effect("beam", "point", "lgtning.spr", 20, BEAM_START, BEAM_END, Vector3(255, 0, 255), 200, 0, 20.0);
			BPATROL_ROT = 0;
			for (int i = 0; i < 16; i++)
			{
				bpatrol_debug_beams();
			}
		}
		string MY_POS = GetEntityOrigin(GetOwner());
		float L_PATROL_DIST = Distance(MY_POS, BPATROL_CENTER);
		string L_BPATROL_RAD = BPATROL_RAD;
		if (m_hAttackTarget != "unset")
		{
			if ((BPATROL_TARGET_VALIDATED))
			{
			}
			L_BPATROL_RAD *= BPATROL_AGRO_RATIO;
		}
		if (L_PATROL_DIST > L_BPATROL_RAD)
		{
			BPATROL_OUTSIDE_RANGE = 1;
		}
		if (L_PATROL_DIST <= L_BPATROL_RAD)
		{
			BPATROL_OUTSIDE_RANGE = 0;
		}
		if ((BPATROL_OUTSIDE_RANGE))
		{
			if (m_hAttackTarget == "unset")
			{
				npcatk_setmovedest(BPATROL_CENTER, BPATROL_MOVEPROX);
			}
			if (m_hAttackTarget != "unset")
			{
			}
			if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetGameTime() > BPATROL_STRUCK_DELAY)
			{
				string TARG_POS = GetEntityOrigin(m_hAttackTarget);
				if (Distance(TARG_POS, BPATROL_CENTER) > BPATROL_RAD)
				{
				}
				LogDebug("targ_outside_patrol_hunt Distance(TARG_POS, BPATROL_CENTER)");
				BPATROL_LAST_TARGET = m_hAttackTarget;
				npc_bpatrol_target_invalid(BPATROL_LAST_TARGET);
				if ((IsEntityAlive(m_hAttackTarget)))
				{
					npcatk_clear_targets("beyond_patrol_range");
				}
				npcatk_setmovedest(BPATROL_CENTER, BPATROL_MOVEPROX);
			}
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(BPATROL_ACTIVE)) return;
		BPATROL_STRUCK_DELAY = GetGameTime();
		BPATROL_STRUCK_DELAY += BPATROL_COOL_DOWN;
		SetHearingSensitivity(BPATROL_DEF_HEARING);
		BPATROL_TARGET_VALIDATED = 1;
	}

	void npcatk_clear_targets()
	{
		if (!(BPATROL_ACTIVE)) return;
		SetHearingSensitivity(0);
		BPATROL_TARGET_VALIDATED = 0;
	}

	void npc_selectattack()
	{
		if (!(BPATROL_ACTIVE)) return;
		BPATROL_LAST_ATK = GetGameTime();
	}

	void npc_targetvalidate()
	{
		if (!(BPATROL_ACTIVE)) return;
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			BPATROL_TARGET_VALIDATED = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > BPATROL_STRUCK_DELAY)
		{
			string TARG_POS = GetEntityOrigin(m_hAttackTarget);
			float L_TARG_DIST_FROM_PATROLPOINT = Distance(TARG_POS, BPATROL_CENTER);
			string MY_POS = GetEntityOrigin(GetOwner());
			float L_MY_DIST_FROM_PATROLPOINT = Distance(MY_POS, BPATROL_CENTER);
			string L_BPATROL_RAD = BPATROL_RAD;
			string L_BPATROL_LAST_ATK = BPATROL_LAST_ATK;
			L_BPATROL_LAST_ATK += BPATROL_ATK_COOLDOWN;
			if (GetGameTime() < L_BPATROL_LAST_ATK)
			{
				L_BPATROL_RAD *= BPATROL_AGRO_RATIO;
			}
			if (L_TARG_DIST_FROM_PATROLPOINT > L_BPATROL_RAD)
			{
				if (L_MY_DIST_FROM_PATROLPOINT < L_TARG_DIST_FROM_PATROLPOINT)
				{
					LogDebug("targ_outside_patrol Distance(TARG_POS, BPATROL_CENTER)");
					BPATROL_LAST_TARGET = m_hAttackTarget;
					npc_bpatrol_target_invalid(BPATROL_LAST_TARGET);
					npcatk_clear_targets("beyond_patrol_range");
				}
				else
				{
					LogDebug("targ_between_me_and_home");
					SetHearingSensitivity(BPATROL_DEF_HEARING);
					BPATROL_TARGET_VALIDATED = 1;
				}
			}
			else
			{
				SetHearingSensitivity(BPATROL_DEF_HEARING);
				BPATROL_TARGET_VALIDATED = 1;
			}
		}
		else
		{
			SetHearingSensitivity(BPATROL_DEF_HEARING);
			BPATROL_TARGET_VALIDATED = 1;
		}
		if (!(BPATROL_TARGET_VALIDATED)) return;
		npc_bpatrol_target_valid();
	}

}

}
