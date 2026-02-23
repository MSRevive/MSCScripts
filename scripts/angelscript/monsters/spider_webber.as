#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SpiderWebber : CGameScript
{
	int AM_BURROWED;
	int AM_FLIPPED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BITE_ATTACK;
	int CAN_FLIP;
	int DEFAULT_CEILING;
	string NEXT_FLIP;
	string NEXT_QUICK_SPIT;
	int NPC_GIVE_EXP;
	int NPC_NO_AUTO_ACTIVATE;
	float NPC_PROXACT_DELAY;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	int NPC_PROXACT_IFSEEN;
	string NPC_PROXACT_RANGE;
	int NPC_PROX_ACTIVATE;
	int PROJECTILE_RANGE;
	int SILENT_BURROW;
	string START_BURROWED;
	int WEB_STRENGTH;

	SpiderWebber()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "spit";
		const string ANIM_JUMP = "latch_jump";
		const string ANIM_BURROW_IN = "BurrowIn";
		const string ANIM_BURROW_OUT = "BurrowOut";
		WEB_STRENGTH = 1;
		ATTACK_MOVERANGE = 250;
		PROJECTILE_RANGE = 400;
		ATTACK_HITRANGE = 90;
		ATTACK_RANGE = 70;
		const float HITCHANCE_BITE = 0.8;
		const int DMG_BITE = 10;
		const int DOT_POISON = 5;
		const string FREQ_FLIP = Random(15.0, 30.0);
		const string SOUND_SHOOT = "bullchicken/bc_attack3.wav";
		NPC_GIVE_EXP = 80;
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SND_STRUCK4 = "monsters/spider/spiderhiss.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
	}

	void game_precache()
	{
		Precache("effects/webbed");
	}

	void OnSpawn() override
	{
		SetName("Constrictor Spider");
		SetHealth(100);
		SetModel("monsters/spider_fuzzy.mdl");
		SetWidth(32);
		SetHeight(32);
		SetRace("spider");
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		if (!(true)) return;
		SetHearingSensitivity(4);
		ScheduleDelayedEvent(0.5, "start_ai");
		ScheduleDelayedEvent(1.5, "post_activated");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK4
		array<string> sounds = {SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK4};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void render_normal()
	{
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "rendermode", 0);
	}

	void burrow_in()
	{
		npcatk_suspend_ai();
		PlayAnim("once", "break");
		PlayAnim("hold", ANIM_BURROW_IN);
		AM_BURROWED = 1;
		if (!(SILENT_BURROW))
		{
			EmitSound(GetOwner(), 0, SOUND_BURROW, 10);
		}
		SILENT_BURROW = 0;
	}

	void burrow_out()
	{
		if ((START_BURROWED))
		{
			SetMoveDest(NPC_PROXACT_PLAYERID);
			START_BURROWED = 0;
		}
		npcatk_resume_ai();
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_BURROW_OUT);
		AM_BURROWED = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (param1 > GetEntityHealth(GetOwner()))
		{
			SetGravity(1);
		}
		if (!(AM_BURROWED)) return;
		burrow_out();
	}

	void set_start_burrowed()
	{
		NPC_NO_AUTO_ACTIVATE = 1;
		START_BURROWED = 1;
		if (param2 > 32)
		{
			NPC_PROXACT_RANGE = param2;
		}
		else
		{
			NPC_PROXACT_RANGE = 256;
		}
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_EVENT = "burrow_out";
		NPC_PROXACT_IFSEEN = 1;
		NPC_PROXACT_FOV = 0;
		NPC_PROXACT_DELAY = 0.5;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SILENT_BURROW = 1;
		ScheduleDelayedEvent(0.01, "burrow_in");
		ScheduleDelayedEvent(1.5, "render_normal");
	}

	void set_start_ceiling()
	{
		DEFAULT_CEILING = 1;
		AM_FLIPPED = 1;
		ANIM_IDLE = "up_idle";
		ANIM_WALK = "up_walk";
		ANIM_RUN = "up_walk";
		ANIM_DEATH = "up_death";
		ANIM_ATTACK = "up_spit";
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetGravity(-1.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 10000));
		ScheduleDelayedEvent(2.0, "set_ceiling_spider");
	}

	void set_ceiling_spider()
	{
		AM_FLIPPED = 1;
		ANIM_IDLE = "up_idle";
		ANIM_WALK = "up_walk";
		ANIM_RUN = "up_walk";
		ANIM_DEATH = "up_death";
		ANIM_ATTACK = "up_spit";
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetGravity(-1.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 10000));
	}

	void set_ground_spider()
	{
		AM_FLIPPED = 0;
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "spit";
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetGravity(1);
	}

	void set_can_flip()
	{
		NEXT_FLIP = GetGameTime();
		NEXT_FLIP += FREQ_FLIP;
		CAN_FLIP = 1;
	}

	void frame_spit()
	{
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			if ((AM_FLIPPED))
			{
				string L_START_OFS = /* TODO: $relpos */ $relpos(0, 32, -48);
			}
			else
			{
				string L_START_OFS = /* TODO: $relpos */ $relpos(0, 32, 0);
			}
			string L_END_POS = GetEntityOrigin(m_hAttackTarget);
			L_END_POS += Vector3(0, 0, /* TODO: $math(multiply) */ GetEntityHeight(m_hAttackTarget));
			TossProjectile("proj_web", L_START_OFS, L_END_POS, 275, 10, 0.1, "none");
			EmitSound(GetOwner(), 0, SOUND_SHOOT, 5);
			NEXT_QUICK_SPIT = GetGameTime();
			NEXT_QUICK_SPIT += 1.0;
		}
		else
		{
			BITE_ATTACK = 1;
			if (!(CanAttack(m_hAttackTarget)))
			{
				DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, HITCHANCE_BITE, "pierce");
			}
			else
			{
				DoDamage(m_hAttackTarget, "direct", DMG_BITE, 1.0, GetOwner());
			}
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		int TARG_COCOONED = 0;
		if (!(CanAttack(m_hAttackTarget)))
		{
			int TARG_COCOONED = 1;
		}
		if ((false))
		{
			if ((TARG_COCOONED))
			{
				ATTACK_MOVERANGE = 32;
			}
			else
			{
				ATTACK_MOVERANGE = 250;
			}
		}
		else
		{
			ATTACK_MOVERANGE = 32;
		}
		if ((CAN_FLIP))
		{
			if (GetGameTime() > NEXT_FLIP)
			{
			}
			NEXT_FLIP = GetGameTime();
			NEXT_FLIP += FREQ_FLIP;
			if ((AM_FLIPPED))
			{
				set_ground_spider();
			}
			else
			{
				set_ceiling_spider();
			}
		}
		if ((TARG_COCOONED))
		{
			if (GetEntityProperty(m_hAttackTarget, "range2d") < 100)
			{
			}
			set_ground_spider();
		}
		if ((AM_FLIPPED))
		{
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 1000));
		}
	}

	void npc_targetsighted()
	{
		if (!(CanAttack(m_hAttackTarget))) return;
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			if (GetGameTime() > NEXT_QUICK_SPIT)
			{
			}
			NEXT_QUICK_SPIT = GetGameTime();
			NEXT_QUICK_SPIT += 2.0;
			if (GetEntityRange(m_hAttackTarget) < PROJECTILE_RANGE)
			{
			}
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 2.0;
			PlayAnim("once", ANIM_ATTACK);
		}
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((BITE_ATTACK))
			{
			}
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ApplyEffect(param2, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), DOT_POISON);
		}
		BITE_ATTACK = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGravity(1);
	}

	void post_activated()
	{
		if (NPC_ADJ_LEVEL > 0)
		{
			string ADD_TO_WS = NPC_ADJ_LEVEL;
			// TODO: capvar ADD_TO_WS 1 7
			WEB_STRENGTH += ADD_TO_WS;
		}
	}

	void my_target_died()
	{
		if (!(DEFAULT_CEILING)) return;
		set_ceiling_spider();
	}

}

}
