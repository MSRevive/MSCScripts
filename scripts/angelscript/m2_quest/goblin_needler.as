#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class GoblinNeedler : CGameScript
{
	string ANIM_ATTACK;
	string ARROW_SCRIPT;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FIREBALL;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DMG_BOW;
	int DMG_KICK;
	int DROPS_CONTAINER;
	int DROP_GOLD_AMT;
	float FREQ_KICK;
	int GOB_CHARGER;
	int GOB_JUMPER;
	int KICK_ATTACK;
	int KICK_HITCHANCE;
	int KICK_RANGE;
	int MOVE_RANGE;
	int NEW_MODEL;
	string NEXT_KICK;
	int NPC_BASE_EXP;
	int NPC_RANGED;
	string SOUND_BOW;

	GoblinNeedler()
	{
		NEW_MODEL = 1;
		NPC_BASE_EXP = 50;
		SOUND_BOW = "weapons/bow/bow.wav";
		GOB_JUMPER = 0;
		GOB_CHARGER = 0;
		DMG_BOW = RandomInt(15, 25);
		DMG_KICK = RandomInt(5, 10);
		KICK_RANGE = 64;
		KICK_HITCHANCE = 90;
		FREQ_KICK = 10.0;
		CAN_FIREBALL = 0;
		NPC_RANGED = 1;
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_gpoison";
		ARROW_SCRIPT = "proj_arrow_npc";
		ANIM_ATTACK = "shootorcbow";
	}

	void goblin_spawn()
	{
		SetName("Goblin Needler");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(100);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
			SetModelBody(0, 3);
			SetModelBody(1, 4);
			SetModelBody(2, 2);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 0);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
			SetModelBody(0, 1);
			SetModelBody(1, 2);
			SetModelBody(2, 2);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 0);
		}
		SetRoam(true);
		SetHearingSensitivity(2);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(0.01, "gob_extras");
	}

	void gob_extras()
	{
		MOVE_RANGE = 2000;
		ATTACK_RANGE = 2000;
		ATTACK_HITRANGE = 2000;
		DROP_GOLD_AMT = RandomInt(10, 30);
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
		TossProjectile(ARROW_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 4), "none", 900, DMG_BOW, 2, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
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
		}
		KICK_ATTACK = 0;
	}

}

}
