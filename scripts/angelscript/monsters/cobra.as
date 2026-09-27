#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Cobra : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK1_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	float DMG_POISON;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string SND_STRUCK4;
	string SND_STRUCK5;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_PAIN;
	string SOUND_WALK;

	Cobra()
	{
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SND_STRUCK4 = SOUND_PAIN;
		SND_STRUCK5 = SOUND_PAIN;
		SOUND_ATTACK1 = "monsters/spider/spiderhiss.wav";
		SOUND_ATTACK2 = "monsters/spider/spiderhiss.wav";
		SOUND_DEATH = "monsters/troll/trolldeath.wav";
		SOUND_WALK = "monsters/troll/trollidle.wav";
		ATTACK_HITCHANCE = 0.95;
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "diesimple";
		ANIM_ATTACK = "attack1";
		ATTACK1_DAMAGE = 45;
		ATTACK_RANGE = 230;
		ATTACK_HITRANGE = 230;
		MOVE_RANGE = 64;
		DMG_POISON = Random(10, 15);
	}

	void OnSpawn() override
	{
		SetHealth(200);
		SetMaxHealth(200);
		SetWidth(64);
		SetHeight(64);
		SetRace("demon");
		SetName("Cobra");
		SetRoam(false);
		NPC_GIVE_EXP = 100;
		SetModel("monsters/kcobra.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		PlayAnim("once", "idle1");
		SetHearingSensitivity(5);
		npcatk_suspend_ai();
	}

	void attack1()
	{
		DoDamage(ENTITY_ENEMY, ATTACK_RANGE, ATTACK1_DAMAGE, 0.75, "slash");
		if (RandomInt(1, 3) == 1)
		{
			ApplyEffect(m_hLastSeen, "effects/dot_poison", 15, GetEntityIndex(GetOwner()), DMG_POISON);
		}
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(SUSPEND_AI)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		SetMoveDest(GetEntityIndex("ent_lastheard"));
		if (RandomInt(1, 10) == 1)
		{
			PlayAnim("once", "idle3");
		}
		else
		{
			PlayAnim("once", "idle1");
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
			SetMoveAnim(ANIM_RUN);
			SetRoam(true);
		}
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
