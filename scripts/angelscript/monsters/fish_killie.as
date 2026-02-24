#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"
#include "monsters/base_fish2.as"

namespace MS
{

class FishKillie : CGameScript
{
	string ANIM_ATK_BIG;
	string ANIM_ATK_LEFT;
	string ANIM_ATK_RIGHT;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATK_DMG_HIGH;
	float ATK_DMG_LOW;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int DELETE_ON_DEATH;
	string NPCATK_TARGET;
	int NPC_EXTRA_VALIDATIONS;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string PUSH_VEL;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STRUCK4;
	string SOUND_STRUCK5;

	FishKillie()
	{
		NPC_EXTRA_VALIDATIONS = 1;
		DELETE_ON_DEATH = 1;
		ANIM_IDLE = "idle";
		ANIM_WALK = "swim";
		ANIM_RUN = "thrust";
		ANIM_DEATH = "die1";
		ANIM_ATK_BIG = "srattack1";
		ANIM_ATK_RIGHT = "bite_r";
		ANIM_ATK_LEFT = "bite_l";
		ANIM_FLINCH = "bgflinch";
		SOUND_IDLE1 = "ichy/ichy_idle1.wav";
		SOUND_IDLE2 = "ichy/ichy_idle2.wav";
		SOUND_ATTACK1 = "ichy/ichy_bite1.wav";
		SOUND_ATTACK2 = "ichy/ichy_bite2.wav";
		SOUND_STRUCK1 = "ichy/ichy_pain2.wav";
		SOUND_STRUCK2 = "ichy/ichy_pain3.wav";
		SOUND_STRUCK3 = "ichy/ichy_pain5.wav";
		SOUND_STRUCK4 = "ichy/ichy_pain3.wav";
		SOUND_STRUCK5 = "ichy/ichy_pain5.wav";
		SOUND_DEATH = "ichy/ichy_die2.wav";
		ATTACK_MOVERANGE = 64;
		ATTACK_RANGE = 120;
		ATTACK_HITRANGE = 180;
		ATTACK_HITCHANCE = 0.75;
		NPC_HACKED_MOVE_SPEED = 250;
		NPC_GIVE_EXP = 1000;
		ATK_DMG_LOW = 200.0;
		ATK_DMG_HIGH = 500.0;
	}

	void OnSpawn() override
	{
		SetHealth(2000);
		SetWidth(64);
		SetHeight(32);
		SetName("Orca");
		SetHearingSensitivity(10);
		SetRoam(true);
		SetRace("wildanimal");
		SetDamageResistance("pierce", 3.0);
		SetDamageResistance("slash", 0.5);
		SetDamageResistance("blunt", 0.25);
		SetDamageResistance("cold", 0.0);
		SetModel("monsters/killie.mdl");
	}

	void npc_selectattack()
	{
		int NEXT_ATTACK = RandomInt(0, 2);
		if (NEXT_ATTACK == 0)
		{
			ANIM_ATTACK = ANIM_ATK_BIG;
		}
		else
		{
			if (NEXT_ATTACK == 1)
			{
				ANIM_ATTACK = ANIM_ATK_LEFT;
			}
			else
			{
				if (NEXT_ATTACK == 2)
				{
					ANIM_ATTACK = ANIM_ATK_RIGHT;
				}
			}
		}
	}

	void frame_attack()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, Random(ATK_DMG_LOW, ATK_DMG_HIGH), ATTACK_HITCHANCE, "slash");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		Vector3 PUSH_VEL = Vector3(0, 0, 0);
		if (ANIM_ATTACK == ANIM_ATK_BIG)
		{
			PUSH_VEL = /* TODO: $relvel */ $relvel(0, 200, 0);
		}
		else
		{
			if (ANIM_ATTACK == ANIM_ATK_LEFT)
			{
				PUSH_VEL = /* TODO: $relvel */ $relvel(-100, 100, 0);
			}
			else
			{
				if (ANIM_ATTACK == ANIM_ATK_RIGHT)
				{
					PUSH_VEL = /* TODO: $relvel */ $relvel(100, 100, 0);
				}
			}
		}
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

	void npc_targetvalidate()
	{
		if (IsInWater(m_hAttackTarget) < 1)
		{
			NPCATK_TARGET = "unset";
		}
	}

}

}
