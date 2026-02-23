#pragma context server

#include "monsters/zombie.as"

namespace MS
{

class ZombieBile : CGameScript
{
	string ANIM_ATTACK;
	string AS_ATTACKING;
	int DOING_PROJECTILE;
	int I_ATTACKING;
	string I_DISEASE;
	string NEXT_BILE;

	ZombieBile()
	{
		const int DMG_PROJECTILE = 20;
		const int NPC_BASE_EXP = 80;
		const string ZOMBIE_NAME = "Byle Zombie";
		const string SOUND_SHOOT1 = "bullchicken/bc_attack2.wav";
		const string SOUND_SHOOT2 = "bullchicken/bc_attack3.wav";
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_BILE)) return;
		NEXT_BILE = GetGameTime();
		NEXT_BILE += 3.0;
		if (!(GetEntityRange(m_hAttackTarget) > 256)) return;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("critical", ANIM_DISEASE);
		DOING_PROJECTILE = 1;
	}

	void attack_2()
	{
		I_ATTACKING = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "blunt");
		if ((DOING_PROJECTILE))
		{
			// PlayRandomSound from: SOUND_SHOOT1, SOUND_SHOOT2
			array<string> sounds = {SOUND_SHOOT1, SOUND_SHOOT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (RandomInt(1, 5) == 1)
			{
				TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 10, 24), m_hAttackTarget, 300, DMG_PROJECTILE, 2, "none");
				Effect("glow", "ent_lastprojectile", Vector3(0, 255, 0), 64, -1, 0);
			}
			else
			{
				TossProjectile("proj_poison", /* TODO: $relpos */ $relpos(0, 10, 24), m_hAttackTarget, 300, DMG_PROJECTILE, 2, "none");
			}
		}
		if (!(DOING_PROJECTILE))
		{
			I_DISEASE = 1;
			ANIM_ATTACK = ANIM_SWIPE;
		}
		DOING_PROJECTILE = 0;
	}

}

}
