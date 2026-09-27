#pragma context server

namespace MS
{

class OrcBaseRanged : CGameScript
{
	string AS_ATTACKING;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string MOVE_RANGE;
	string SOUND_BOW;

	OrcBaseRanged()
	{
		if (MOVE_RANGE == "MOVE_RANGE")
		{
			MOVE_RANGE = 1000;
		}
		if (ATTACK_RANGE == "ATTACK_RANGE")
		{
			ATTACK_RANGE = 1000;
		}
		if (ATTACK_HITRANGE == "ATTACK_HITRANGE")
		{
			ATTACK_HITRANGE = 1000;
		}
		SOUND_BOW = "weapons/bow/bow.wav";
	}

	void orc_spawn()
	{
		SetWidth(32);
		SetHeight(60);
	}

	void orc_death()
	{
		SetModelBody(3, 0);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void shoot_arrow()
	{
		AS_ATTACKING = GetGameTime();
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		float LCL_ATKDMG = Random(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 18), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SOUND_BOW);
	}

	void npc_targetsighted()
	{
		if ((ALT_ATTACKS)) return;
		if (GetEntityRange(param1) < ATTACK_RANGE)
		{
			PlayAnim("once", ANIM_ATTACK);
		}
	}

}

}
