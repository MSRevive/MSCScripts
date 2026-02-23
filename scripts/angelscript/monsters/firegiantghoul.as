#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Firegiantghoul : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	int FIREBALL_DELAY;
	int HIT_SOMEONE;
	int I_AM_TURNABLE;
	string I_R_GLOWING;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	string NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	int THROW_DELAY;

	Firegiantghoul()
	{
		const int FIN_EXP = 150;
		NPC_GIVE_EXP = FIN_EXP;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "zombie/zo_pain2.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_DEATH = "zombie/zo_pain1.wav";
		const string SOUND_FIREBALL = "magic/fireball_strike.wav";
		const string ANIM_FIREBALL = "turnright";
		ANIM_IDLE = "idle1";
		const int ATTACK_DAMAGE = 40;
		MOVE_RANGE = 32;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 187;
		const float ATTACK_ACCURACY = 0.45;
		CAN_FLINCH = 1;
		const int FIREBALL_DAMAGE = 50;
		const int FIREBALL_RANGE = 1024;
		const float FIREBALL_FREQ = 5.0;
		const float THROW_FREQ = 5.0;
		const int THROW_CHANCE = 12;
		const int AIM_RATIO = 50;
		const int MY_MAX_HP = 1400;
		const string MY_NAME = "Reanimated Bones of a Fire Giant";
		const int NO_ROAM = 0;
		const int AM_TURRET = 0;
		const int I_GLOW = 1;
		const Vector3 GLOW_COLOR = Vector3(255, 255, 128);
		const int GLOW_RAD = 200;
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		ANIM_ATTACK = "attack1";
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		SetHealth(MY_MAX_HP);
		SetWidth(64);
		SetHeight(120);
		SetRace("undead");
		SetName(MY_NAME);
		SetGold(RandomInt(25, 50));
		SetHearingSensitivity(10);
		if (!(NO_ROAM))
		{
			SetRoam(true);
		}
		if ((NO_ROAM))
		{
			SetRoam(false);
		}
		SetModel("monsters/skeleton3.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		if (!(AM_TURRET))
		{
			SetMoveAnim(ANIM_WALK);
		}
		if ((AM_TURRET))
		{
			SetMoveAnim(ANIM_IDLE);
			ANIM_WALK = ANIM_IDLE;
			ANIM_RUN = ANIM_IDLE;
			NO_STUCK_CHECKS = 1;
		}
		PlayAnim("once", ANIM_IDLE);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 2.0);
		SetDamageResistance("holy", 1.5);
	}

	void throw_delay_reset()
	{
		THROW_DELAY = 0;
	}

	void attack_1()
	{
		HIT_SOMEONE = 5;
		int DID_PUSH = 0;
		ANIM_ATTACK = "attack1";
		if (!(THROW_DELAY))
		{
			if (RandomInt(1, 100) <= THROW_CHANCE)
			{
			}
			THROW_DELAY = 1;
			THROW_FREQ("throw_delay_reset");
			PlayAnim("critical", "bigflinch");
			EmitSound(GetOwner(), 0, "garg/gar_attack3.wav", 10);
			if (GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)
			{
			}
			ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
			int DID_PUSH = 1;
		}
		if ((DID_PUSH)) return;
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void throw_fireball()
	{
		AS_ATTACKING = GetGameTime();
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		PlayAnim("critical", "turnright");
		SetVolume(10);
		// PlayRandomSound from: SOUND_FIREBALL
		array<string> sounds = {SOUND_FIREBALL};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (GetEntityRange(m_hLastSeen) <= 400)
		{
			TossProjectile("proj_fire_ball", "view", "none", 500, FIREBALL_DAMAGE, 1, "none");
		}
		if (GetEntityRange(m_hLastSeen) > 400)
		{
			TossProjectile("proj_fire_ball", "view", GetEntityIndex(m_hLastSeen), 500, FIREBALL_DAMAGE, 1, "none");
			CallExternal("ent_lastprojectile", "lighten", 5, 0.1);
		}
		ANIM_ATTACK = "attack1";
	}

	void npc_targetsighted()
	{
		if ((I_R_FROZEN)) return;
		if (!(GetEntityRange(param1) > ATTACK_RANGE)) return;
		if ((FIREBALL_DELAY)) return;
		FIREBALL_DELAY = 1;
		FIREBALL_FREQ("reset_fireball_delay");
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "throw_fireball");
	}

	void cycle_up()
	{
		if ((NO_ROAM))
		{
			if (!(AM_TURRET))
			{
			}
			SetRoam(true);
		}
		if ((I_GLOW))
		{
			if (!(I_R_GLOWING))
			{
			}
			I_R_GLOWING = 1;
			ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()));
			MY_LIGHT_SCRIPT = "game.script.last_sent_id";
		}
	}

	void reset_fireball_delay()
	{
		FIREBALL_DELAY = 0;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void client_activate()
	{
		SKEL_ID = param1;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
	}

	void chest_sfor_fireloot1()
	{
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 1.0;
		CONTAINER_SCRIPT = "chests/sfor_fire1";
	}

	void chest_sfor_fireloot2()
	{
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 1.0;
		CONTAINER_SCRIPT = "chests/sfor_fire2";
	}

}

}
