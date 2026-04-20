#pragma context server

namespace MS
{

class OrcBaseMelee : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	int ORC_HOP_DELAY;
	int ORC_JUMPER;
	int ORC_JUMPING;
	int ORC_JUMP_CUTOFF;
	int ORC_JUMP_POWER;
	int ORC_JUMP_RANGE;
	int ORC_JUMP_THRESH;
	int ORC_SUPERJUMPER;
	string TARGET_Z_DIFFERENCE;

	OrcBaseMelee()
	{
		MOVE_RANGE = 32;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		ORC_JUMP_RANGE = 512;
		ORC_JUMP_CUTOFF = 400;
		ORC_JUMP_POWER = RandomInt(350, 450);
		ORC_HOP_DELAY = RandomInt(2, 4);
		ORC_JUMP_THRESH = 80;
	}

	void orc_spawn()
	{
		SetWidth(32);
		SetHeight(72);
		SetHearingSensitivity(4);
	}

	void swing_axe()
	{
		baseorc_yell();
		float L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		XDoDamage(m_hLastSeen, ATTACK_HITRANGE, L_DMG, ATTACK_ACCURACY, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swing");
	}

	void swing_sword()
	{
		swing_axe();
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(ORC_JUMPER)) return;
		if ((ORC_JUMPING)) return;
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		ORC_JUMPING = 1;
		ScheduleDelayedEvent(1.0, "orc_jump_check");
	}

	void orc_jump_check()
	{
		if (!(ORC_JUMPING)) return;
		ORC_HOP_DELAY("orc_jump_check");
		if ((IS_FLEEING)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) < ORC_JUMP_RANGE)) return;
		string ME_POS = GetMonsterProperty("origin");
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
		string TARGET_Z = (TARGET_POS).z;
		TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (TARGET_Z_DIFFERENCE > ORC_JUMP_THRESH)
		{
			if (!(ORC_SUPERJUMPER))
			{
				if (TARGET_Z_DIFFERENCE < ORC_JUMP_CUTOFF)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			PlayAnim("critical", ANIM_ATTACK);
			ScheduleDelayedEvent(0.1, "orc_hop");
		}
	}

	void orc_hop()
	{
		EmitSound(GetOwner(), 0, "monsters/orc/attack1.wav", 10);
		string JUMP_HEIGHT = ORC_JUMP_POWER;
		if ((GetMapName()).findFirst("helena") >= 0)
		{
			int JUMP_HEIGHT = RandomInt(450, 550);
		}
		int FWD_BOOST = 250;
		if ((ORC_SUPERJUMPER))
		{
			string JUMP_HEIGHT = TARGET_Z_DIFFERENCE;
			JUMP_HEIGHT *= 5;
			string FWD_BOOST = GetEntityRange(m_hAttackTarget);
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_BOOST, JUMP_HEIGHT));
	}

	void my_target_died()
	{
		if ((false)) return;
		ORC_JUMPING = 0;
	}

	void make_jumper()
	{
		ORC_JUMPER = 1;
	}

	void make_superjumper()
	{
		ORC_JUMPER = 1;
		ORC_SUPERJUMPER = 1;
	}

}

}
