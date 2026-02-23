#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_aim_proj.as"

namespace MS
{

class BanditHard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK1_DAMAGE;
	int ATTACK_COF;
	float ATTACK_PERCENTAGE;
	string ATTACK_RANGE;
	int ATTACK_SPEED;
	int CAN_ATTACK;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	string CHANGE_POSITION;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string FINAL_DAMAGE;
	int HUNT_AGRO;
	string MOVE_RANGE;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	string PURE_FLEE;
	int TOO_CLOSE;
	string WEAPON;

	BanditHard()
	{
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_poison";
		const string SOUND_PAIN = "player/chesthit1.wav";
		const string SOUND_PAIN2 = "player/armhit1.wav";
		const string SOUND_BOW = "weapons/bow/bow.wav";
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk2";
		ANIM_DEATH = "die_simple";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_ATTACK = 1;
		CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_HEAR = 1;
		NPC_GIVE_EXP = 120;
		const int AIM_RATIO = 50;
		const string ARROW_DAMAGE = "$rand(15,40)";
		bowey();
		fistey();
		daggerey();
		swordey();
		axey();
		macey();
	}

	void OnSpawn() override
	{
		if (WEAPON == "WEAPON")
		{
			WEAPON = RandomInt(0, 5);
		}
		SetGold(RandomInt(23, 37));
		SetWidth(32);
		SetHeight(92);
		SetRace("rogue");
		SetDamageResistance("all", 0.6);
		SetHearingSensitivity(3);
		SetRoam(true);
		SetModel("npc/rogue.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void bowey()
	{
		if (!(WEAPON == 0)) return;
		SetName("Trained Bandit Archer");
		SetHealth(190);
		ATTACK_SPEED = 1200;
		MOVE_RANGE = ATTACK_SPEED;
		ATTACK_RANGE = ATTACK_SPEED;
		ATTACK_COF = 0;
		ANIM_ATTACK = "shootbow";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 5);
		TOO_CLOSE = 0;
		DROPS_CONTAINER = 1;
		NO_STUCK_CHECKS = 1;
	}

	void daggerey()
	{
		if (!(WEAPON == 1)) return;
		SetName("Trained Bandit Rogue");
		SetHealth(190);
		MOVE_RANGE = 50;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = Random(10.5, 12.0);
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "swordjab1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 1);
		DROP_ITEM1 = "smallarms_fangstooth";
		DROP_ITEM1_CHANCE = 0.05;
	}

	void fistey()
	{
		if (!(WEAPON == 2)) return;
		SetName("Trained Bandit Martial Artist");
		SetHealth(220);
		MOVE_RANGE = 50;
		ATTACK_RANGE = 80;
		ATTACK1_DAMAGE = Random(8.5, 10.0);
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "aim_punch1";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 0);
	}

	void swordey()
	{
		if (!(WEAPON == 3)) return;
		SetName("Trained Bandit Swordsman");
		SetHealth(220);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 120;
		ATTACK1_DAMAGE = Random(10.5, 12.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "swordswing2_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 4);
	}

	void axey()
	{
		if (!(WEAPON == 4)) return;
		SetName("Trained Bandit Axeman");
		SetHealth(260);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 120;
		ATTACK1_DAMAGE = Random(11.5, 13.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 3);
	}

	void macey()
	{
		if (!(WEAPON == 5)) return;
		SetName("Trained Bandit Berserker");
		SetHealth(260);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 130;
		ATTACK1_DAMAGE = Random(11.5, 13.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 2);
	}

	void attack()
	{
		if ((IS_FLEEING)) return;
		if (WEAPON == 0)
		{
			SetAngles("add_view.pitch");
			FINAL_DAMAGE = ARROW_DAMAGE;
			npcatk_adj_attack();
			AS_ATTACKING = GetGameTime();
			TossProjectile("proj_arrow_poison", /* TODO: $relpos */ $relpos(0, 0, 2), "none", ATTACK_SPEED, FINAL_DAMAGE, ATTACK_COF, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
			EmitSound(GetOwner(), SOUND_BOW);
		}
		else
		{
			DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
			if (WEAPON == 1)
			{
				if (RandomInt(1, 3) == 1)
				{
					ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", 5, GetOwner(), RandomInt(3, 5));
				}
			}
		}
	}

	void check_attack()
	{
		if (!(WEAPON == 0)) return;
		if ((IS_FLEEING)) return;
		if (CHANGE_POSITION > 3)
		{
			CHANGE_POSITION = 0;
			PlayAnim("once", "break");
			PlayAnim("critical", ANIM_RUN);
			chicken_run(3);
		}
		if (!(false)) return;
		if (GetEntityRange(m_hLastSeen) < 100)
		{
			TOO_CLOSE += 0.1;
		}
		if (TOO_CLOSE > 5)
		{
			TOO_CLOSE = 0;
			PURE_FLEE = 1;
			npcatk_flee(m_hLastSeen, 600, 5);
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string L_DEATHANIM = RandomInt(0, 6);
		if (L_DEATHANIM == 0)
		{
			ANIM_DEATH = "die_simple";
		}
		if (L_DEATHANIM == 1)
		{
			ANIM_DEATH = "die_backwards1";
		}
		if (L_DEATHANIM == 2)
		{
			ANIM_DEATH = "die_backwards";
		}
		if (L_DEATHANIM == 3)
		{
			ANIM_DEATH = "die_forwards";
		}
		if (L_DEATHANIM == 4)
		{
			ANIM_DEATH = "headshot";
		}
		if (L_DEATHANIM == 5)
		{
			ANIM_DEATH = "die_spin";
		}
		if (L_DEATHANIM == 6)
		{
			ANIM_DEATH = "gutshot";
		}
	}

	void game_dodamage()
	{
		if (!(WEAPON == 0)) return;
		if (!(param1))
		{
			CHANGE_POSITION += 1;
		}
		if ((param1))
		{
			if (IsValidPlayer(param2) == 1)
			{
				CHANGE_POSITION = -2;
			}
			if (CHANGE_POSITION < -5)
			{
				CHANGE_POSITION = 0;
			}
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (!(WEAPON == 0)) return;
		if (!(IsValidPlayer(m_hLastStruck) + "add" + CHANGE_POSITION + 1)) return;
	}

	void npc_targetsighted()
	{
		if (!(WEAPON == 0)) return;
		if ((IS_FLEEING)) return;
		if (!(false)) return;
		PlayAnim("once", ANIM_ATTACK);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetSolid("none");
	}

}

}
