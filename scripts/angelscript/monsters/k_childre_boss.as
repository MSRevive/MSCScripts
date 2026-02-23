#pragma context server

#include "monsters/k_childre.as"

namespace MS
{

class KChildreBoss : CGameScript
{
	int AM_CRAWLING;
	int AM_INVISIBLE;
	string ANIM_FLINCH;
	int CAN_FLINCH;
	string DID_WARCRY;
	int DOING_FADE;
	string FADE_TARGET;
	int FIREBALL_TOSS;
	int FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	string NEXT_NOVA;
	string NOVA_LIST;
	string NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int SPORE_POISON_DMG;
	int STARTED_CYCLES;
	string STEP_SIZE_NORM;
	int WAS_STRUCK;

	KChildreBoss()
	{
		const string PROJECTILE_SCRIPT = "proj_spore";
		SPORE_POISON_DMG = 100;
		const string DMG_SWIPE = RandomInt(160, 300);
		const float FREQ_NOVA = 30.0;
		const float DUR_NOVA = 5.0;
		const int DOT_NOVA = 50;
		NPC_IS_BOSS = 1;
		const string FREQ_RANDOM_JUMP = Random(10.0, 30.0);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		string MY_POS = GetEntityOrigin(GetOwner());
		string MY_Z = (MY_POS).z;
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		if (MY_GROUND != "none")
		{
		}
		string Z_DIFF = MY_GROUND;
		Z_DIFF -= MY_Z;
		if (Z_DIFF < 0)
		{
			Z_DIFF *= -1;
		}
		if (Z_DIFF > 256)
		{
		}
		LogDebug("Bombs away Z_DIFF - MY_Z vs MY_GROUND");
		string GROUND_POS = GetEntityOrigin(GetOwner());
		GROUND_POS = "z";
		TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 24, -102), GROUND_POS, 400, 200, 30, "none");
	}

	void game_precache()
	{
		Precache("monsters/summon/poison_burst");
	}

	void childre_spawn()
	{
		if (StringToLower(GetMapName()) == "kfortress")
		{
			SetName("Kruxus the Corrupting Shadow");
			NPC_GIVE_EXP = 10000;
		}
		else
		{
			SetName("Black Kharaztorant Hierophant");
			NPC_GIVE_EXP = 800;
		}
		SetModel("monsters/k_childre_black.mdl");
		SetHealth(9001);
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
		SetInvincible(false);
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

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 8);
		if (GetGameTime() > NEXT_NOVA)
		{
			NEXT_NOVA = GetGameTime();
			NEXT_NOVA += FREQ_NOVA;
			do_nova();
		}
		if (!(AM_CRAWLING)) return;
		if (!(DOING_FADE)) return;
		SetMoveAnim(ANIM_RUN);
		AM_CRAWLING = 0;
		WAS_STRUCK = 1;
		chicken_run(1.5);
	}

	void do_nova()
	{
		EmitSound(GetOwner(), 0, "magic/spookie1.wav", 10);
		NOVA_LIST = FindEntitiesInSphere("enemy", 256);
		do_nova_FX();
		if (!(NOVA_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(NOVA_LIST, ";"); i++)
		{
			nova_targets();
		}
	}

	void nova_targets()
	{
		string CUR_TARG = GetToken(NOVA_LIST, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", DUR_NOVA, GetEntityIndex(GetOwner()), DOT_NOVA);
		string TARGET_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARGET_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			do_warcry();
		}
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_FADE("fade_check");
		ScheduleDelayedEvent(1.0, "fireball_check");
		ScheduleDelayedEvent(1.0, "jump_check");
		FREQ_RANDOM_JUMP("do_random_jump");
	}

	void do_random_jump()
	{
		FREQ_RANDOM_JUMP("do_random_jump");
		chicken_run(1.0);
		ScheduleDelayedEvent(0.1, "do_jump");
	}

	void etherial_immunes()
	{
		ClearFX();
		Effect("glow", GetOwner(), Vector3(0, 0, 0), 10, -1, 0);
		SetInvincible(true);
		AM_INVISIBLE = 1;
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 0.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(StringToLower(GetMapName()) == "kfortress")) return;
		string START_POS = GetEntityOrigin(GetOwner());
		string START_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(START_POS);
		START_POS = "z";
		START_POS += "z";
		ClientEvent("new", "all", "kfortress/nh_appear_cl", START_POS);
		CallExternal(GAME_MASTER, "gm_createitem", 15.0, "smallarms_nh", START_POS);
	}

}

}
