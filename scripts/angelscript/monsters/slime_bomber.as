#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeBomber : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int EXPLODED;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string SLIME_TARGETS;

	SlimeBomber()
	{
		ANIM_ATTACK = "attack";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die";
		MOVE_RANGE = 64;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 64;
		NPC_GIVE_EXP = 200;
		const string SOUND_DEATH = "monsters/sludge/bio.wav";
		Precache(SOUND_DEATH);
		const string POISON_CLOUD = "monsters/summon/npc_poison_cloud2";
	}

	void OnSpawn() override
	{
		SetName("Plague Spreader");
		SetRace("demon");
		SetHealth(100);
		SetWidth(40);
		SetHeight(44);
		SetModel("monsters/slime_large.mdl");
		SetModelBody(0, 0);
		SetDamageResistance("pierce", 1.5);
		SetDamageResistance("blunt", ".75");
		SetDamageResistance("poison", ".25");
		SetDamageResistance("acid", ".25");
		SetDamageResistance("fire", 1.5);
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
	}

	void bite1()
	{
		explode();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		explode();
	}

	void explode()
	{
		if ((EXPLODED)) return;
		EXPLODED = 1;
		SLIME_TARGETS = FindEntitiesInSphere(GetOwner(), 96);
		if (SLIME_TARGETS != "none")
		{
			for (int i = 0; i < GetTokenCount(SLIME_TARGETS, ";"); i++)
			{
				slime_affect_targs();
			}
		}
		string CLOUD_POS = GetEntityOrigin(GetOwner());
		string GRND_CLOUD = /* TODO: $get_ground_height */ $get_ground_height(CLOUD_POS);
		GRND_CLOUD += 24;
		CLOUD_POS = "z";
		SpawnNPC("monsters/summon/npc_poison_cloud2", CLOUD_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), RandomInt(100, 200), 60.0, 1
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		ScheduleDelayedEvent(60.0, "npc_suicide");
	}

	void slime_affect_targs()
	{
		string CUR_TARG = GetToken(SLIME_TARGETS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 10.0, GetEntityIndex(GetOwner()), 25);
	}

}

}
