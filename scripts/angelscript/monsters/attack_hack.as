#pragma context server

namespace MS
{

class AttackHack : CGameScript
{
	string ATTACK_COUNTER;
	string ATTACK_DAMAGE;
	string ATTACK_FREQUENCY;

	void npcatk_attackenemy()
	{
		if (ATTACK_DAMAGE == "ATTACK_DAMAGE")
		{
			ATTACK_DAMAGE = 5;
		}
		if (ATTACK_FREQUENCY == "ATTACK_FREQUENCY")
		{
			ATTACK_FREQUENCY = 10;
		}
		can_reach_nme();
		npc_attack();
		npc_selectattack();
		SetMoveDest(m_hLastSeen);
		PlayAnim("once", ANIM_ATTACK);
		ScheduleDelayedEvent(1, "do_stuff");
		ATTACK_COUNTER += 1;
		if (ATTACK_COUNTER == ATTACK_FREQUENCY)
		{
			DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
			if (ATTACK_HACK_STUN == 1)
			{
				if (RandomInt(1, ATTACK_HACK_STUNCHANCE) == 1)
				{
					ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
				}
			}
			ATTACK_COUNTER = 0;
		}
	}

	void do_stuff()
	{
	}

}

}
