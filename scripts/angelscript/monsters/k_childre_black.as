#pragma context server

#include "monsters/k_childre.as"

namespace MS
{

class KChildreBlack : CGameScript
{
	int AM_INVISIBLE;
	string ANIM_FLINCH;
	int CAN_FLINCH;
	int DOING_FADE;
	string FADE_TARGET;
	int FIREBALL_TOSS;
	int FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	int SPORE_POISON_DMG;
	string STEP_SIZE_NORM;
	int WAS_STRUCK;

	KChildreBlack()
	{
		const string PROJECTILE_SCRIPT = "proj_spore";
		SPORE_POISON_DMG = 60;
		const string DMG_SWIPE = RandomInt(80, 200);
		const int NPC_BASE_EXP = 800;
	}

	void game_precache()
	{
		Precache("monsters/summon/poison_burst");
	}

	void childre_spawn()
	{
		SetName("Black Kharaztorant Childre");
		SetModel("monsters/k_childre_black.mdl");
		SetHealth(3000);
		SetRace("demon");
		SetWidth(32);
		SetHeight(68);
		SetRoam(true);
		SetHearingSensitivity(4);
		string L_MAP_NAME = StringToLower(GetMapName());
		if ((L_MAP_NAME).findFirst("helena") >= 0)
		{
			STEP_SIZE_NORM = 18;
			int EXIT_SUB = 1;
		}
		if ((L_MAP_NAME).findFirst("demontemple") >= 0)
		{
			STEP_SIZE_NORM = 24;
			int EXIT_SUB = 1;
		}
		if ((L_MAP_NAME).findFirst("islesofdread") >= 0)
		{
			STEP_SIZE_NORM = 24;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SetStepSize(STEP_SIZE_NORM);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("stun", 0.5);
		ANIM_FLINCH = "new_flinch";
		CAN_FLINCH = 1;
		FLINCH_HEALTH = 500;
		FLINCH_DELAY = 5.0;
		FLINCH_CHANCE = 50;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetStat("parry", 100);
	}

	void normal_immunes()
	{
		AM_INVISIBLE = 0;
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 2.0);
	}

	void do_fireball()
	{
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
		FIREBALL_TOSS = 1;
		PlayAnim("critical", ANIM_ATTACK);
		TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 62), m_hAttackTarget, 400, 200, 0, "none");
		FIREBALL_AMMO -= 1;
		if (FIREBALL_AMMO == 0)
		{
			SetProp(GetOwner(), "skin", 0);
		}
		npcatk_resume_ai();
		SetRoam(true);
	}

	void do_fade()
	{
		SpawnNPC("monsters/summon/poison_burst", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 1, 100, 30
		npcatk_flee(m_hAttackTarget, 2048, 3.0);
		FADE_TARGET = m_hAttackTarget;
		DOING_FADE = 1;
		npcatk_suspend_ai(2.0);
		SetMoveAnim(ANIM_RUN);
		WAS_STRUCK = 0;
		ScheduleDelayedEvent(0.1, "do_fade2");
		ScheduleDelayedEvent(1.0, "resume_attack");
	}

}

}
