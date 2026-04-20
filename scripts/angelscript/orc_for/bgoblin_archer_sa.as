#pragma context server

#include "orc_for/tiers2.as"
#include "orc_for/goblin_base.as"

namespace MS
{

class BgoblinArcherSa : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FIREBALL;
	int DMG_AOE;
	int DMG_BOW;
	int DMG_KICK;
	int DOT_FIRE;
	int DROP_GOLD_AMT;
	float FREQ_KICK;
	int GOB_CHARGER;
	int GOB_JUMPER;
	int KICK_ATTACK;
	int KICK_HITCHANCE;
	int KICK_RANGE;
	int MOVE_RANGE;
	string NEXT_KICK;
	int NPC_BASE_EXP;
	int NPC_CAP_EXP;
	int NPC_RANGED;
	string SOUND_BOW;

	BgoblinArcherSa()
	{
		NPC_BASE_EXP = 75;
		NPC_CAP_EXP = 2000;
		SOUND_BOW = "weapons/bow/bow.wav";
		GOB_JUMPER = 0;
		GOB_CHARGER = 0;
		DMG_BOW = 20;
		DMG_KICK = 10;
		DOT_FIRE = 10;
		DMG_AOE = 40;
		KICK_RANGE = 64;
		KICK_HITCHANCE = 90;
		FREQ_KICK = 10.0;
		CAN_FIREBALL = 0;
		NPC_RANGED = 1;
		ANIM_ATTACK = "shootorcbow";
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin Needler");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(125);
		SetModel("monsters/goblin_new.mdl");
		SetWidth(24);
		SetHeight(50);
		SetProp(GetOwner(), "skin", 1);
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetModelBody(2, 2);
		SetModelBody(3, 0);
		SetRoam(true);
		SetHearingSensitivity(2);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(0.01, "gob_extras");
	}

	void gob_extras()
	{
		MOVE_RANGE = 2000;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 2000;
		DROP_GOLD_AMT = RandomInt(30, 50);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void shoot_arrow()
	{
		string TARGET_DIST = GetEntityRange(m_hLastSeen);
		string FINAL_TARGET = GetEntityOrigin(m_hLastSeen);
		FINAL_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, TARGET_DIST));
		TARGET_DIST /= 100;
		SetAngles("add_view.pitch");
		TossProjectile("proj_arrow_npc_dyn", /* TODO: $relpos */ $relpos(0, 0, 7), "none", 900, DMG_BOW, 2, "none");
		CallExternal("ent_lastprojectile", "ext_lighten", 0.4, 1, Vector3(255, 0, 0));
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SOUND_BOW);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(3, 0);
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < KICK_RANGE)) return;
		if (!(GetGameTime() > NEXT_KICK)) return;
		NEXT_KICK = GetGameTime();
		PlayAnim("once", "break");
		SetModelBody(3, 0);
		NEXT_KICK += FREQ_KICK;
		ANIM_ATTACK = ANIM_KICK;
	}

	void kick_land()
	{
		DoDamage(m_hAttackTarget, KICK_RANGE, DMG_KICK, KICK_HITCHANCE, "blunt");
		KICK_ATTACK = 1;
		ANIM_ATTACK = ANIM_BOW;
		npcatk_flee(m_hAttackTarget, 1024, 3.0);
	}

	void OnFlee()
	{
		SetMoveSpeed(2.0);
	}

	void npcatk_stopflee()
	{
		SetMoveSpeed(1.0);
	}

	void game_dodamage()
	{
		if ((KICK_ATTACK))
		{
			if ((param1))
			{
			}
			if (GetEntityRange(param2) < KICK_RANGE)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			if (NPC_ADJ_LEVEL > 2)
			{
				AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 600, 110));
			}
		}
		KICK_ATTACK = 0;
	}

	void ext_arrow_hit()
	{
		if (NPC_ADJ_LEVEL > 2)
		{
			if (GetRelationship(GetOwner()) == "enemy")
			{
			}
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 600, 110));
		}
		if (NPC_ADJ_LEVEL < 3)
		{
			if (GetRelationship(GetOwner()) == "enemy")
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		else
		{
			string ARROW_POS = param3;
			if ((IsEntityAlive(param2)))
			{
				string ARROW_POS = GetEntityOrigin(param2);
			}
			ARROW_POS = "z";
			ClientEvent("new", "all", "effects/sfx_fire_burst", ARROW_POS, 128, 1, Vector3(255, 0, 0));
			XDoDamage(ARROW_POS, 128, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "fire_effect");
		}
	}

}

}
