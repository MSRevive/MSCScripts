#pragma context server

#include "monsters/base_stripped_ai.as"

namespace MS
{

class VinePoison : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_GROW;
	string ANIM_IDLE;
	int ATTACK_HITRANGE;
	int DMG_ATK;
	int DOT_ATK;
	int IMMUNE_VAMPIRE;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int SWING_ATTACK;
	int VINE_SUSPEND;

	VinePoison()
	{
		NPC_GIVE_EXP = 200;
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "attack1";
		ANIM_GROW = "raise";
		ANIM_DEATH = "lower";
		ATTACK_HITRANGE = 200;
		DMG_ATK = 100;
		DOT_ATK = 50;
		SOUND_ATTACK1 = "tentacle/te_roar1.wav";
		SOUND_ATTACK2 = "tentacle/te_roar1.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_STRUCK3 = "debris/flesh3.wav";
		SOUND_PAIN1 = "tentacle/te_alert1.wav";
		SOUND_PAIN2 = "tentacle/te_alert2.wav";
		SOUND_DEATH = "tentacle/te_move2.wav";
	}

	void OnSpawn() override
	{
		SetName("Poison Vine");
		SetModel("monsters/deadlyvine.mdl");
		SetWidth(32);
		SetHeight(64);
		SetHealth(1000);
		SetRace("demon");
		SetBloodType("none");
		SetNoPush(true);
		IMMUNE_VAMPIRE = 1;
		SetHearingSensitivity(11);
		SetIdleAnim(ANIM_GROW);
		SetMoveAnim(ANIM_GROW);
		PlayAnim("once", ANIM_IDLE);
		VINE_SUSPEND = 1;
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("poison", 0);
		ScheduleDelayedEvent(2.0, "grow_in");
		SetModelBody(0, 1);
	}

	void set_wallmount()
	{
		SetGravity(0);
		SetFly(true);
	}

	void grow_in()
	{
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		VINE_SUSPEND = 0;
		PlayAnim("critical", ANIM_GROW);
		EmitSound(GetOwner(), 1, "tentacle/te_move1.wav", 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((QUIET_DEATH)) return;
		PlayAnim("critical", ANIM_DEATH);
		EmitSound(GetOwner(), 1, SOUND_DEATH, 10);
		ClearFX();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((VINE_SUSPEND)) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		NPCATK_TARGET = HEARD_ID;
		SetMoveDest(m_hAttackTarget);
		if (!(GetEntityRange(HEARD_ID) < ATTACK_HITRANGE)) return;
		PlayAnim("once", ANIM_ATTACK);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 5);
		if ((VINE_SUSPEND)) return;
		if (!(GetEntityRange(m_hLastStruck) < ATTACK_HITRANGE)) return;
		NPCATK_TARGET = GetEntityIndex(m_hLastStruck);
		SetMoveDest(m_hAttackTarget);
		PlayAnim("once", ANIM_ATTACK);
	}

	void frame_attack()
	{
		SWING_ATTACK = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_ATK, 1.0, "pierce");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((SWING_ATTACK))
		{
			ApplyEffect(param2, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_ATK);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-200, -300, 110));
		}
		SWING_ATTACK = 0;
	}

}

}
