#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_jumper.as"
#include "monsters/base_propelled.as"

namespace MS
{

class AntFireFlyer : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ANT_AM_FLYING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BREATH_ON;
	string BREATH_TARG;
	string BREATH_TARGETS;
	string CL_BREATH_IDX;
	int DID_INTRO;
	string DODGE_IDX;
	int MOVE_RANGE;
	string NEXT_BREATH;
	string NEXT_DODGE;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_JUMPER;
	int NPC_PROPELL_SUSPEND;
	string SCAN_POINT;

	AntFireFlyer()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_RUN = "walk";
		ANIM_DEATH = "anim_hover_death";
		NPC_JUMPER = 1;
		const string ANIM_HOVER = "anim_hover";
		const string ANIM_2HOVER = "anim_2hover";
		const string ANIM_LAND = "anim_land";
		const string ANIM_HOVER_BREATH = "anim_hover_breath";
		const string ANIM_HOVER_BITE = "anim_hover_shoot";
		const string ANIM_WALK1 = "walk";
		const string ANIM_WALK2 = "walk2";
		const string ANIM_ATTACK1 = "attack";
		const string ANIM_ATTACK2 = "attack2";
		NPC_GIVE_EXP = 150;
		NPC_ALLY_RESPONSE_RANGE = 1024;
		const string FREQ_BREATH = Random(5.0, 10.0);
		const float FREQ_BUZZ = 4.45;
		const float FREQ_DODGE = 1.0;
		const int DMG_BITE = 50;
		const int DOT_FIRE = 10;
		ATTACK_MOVERANGE = 192;
		MOVE_RANGE = 192;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		const string SOUND_FLY_LOOP = "monsters/beetle/fly1_noloop.wav";
		const string SOUND_PAIN1 = "monsters/beetle/pain1.wav";
		const string SOUND_PAIN2 = "monsters/beetle/pain2.wav";
		const string SOUND_STRUCK1 = "monsters/beetle/shell_impact1.wav";
		const string SOUND_STRUCK2 = "monsters/beetle/shell_impact2.wav";
		const string SOUND_STRUCK3 = "monsters/beetle/shell_impact3.wav";
		const string SOUND_STRUCK4 = "monsters/beetle/shell_impact4.wav";
		const string SOUND_ATTACK1 = "monsters/beetle/attack_single1.wav";
		const string SOUND_ATTACK2 = "monsters/beetle/attack_single2.wav";
		const string SOUND_ATTACK3 = "monsters/beetle/attack_single3.wav";
		const string SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		const string SOUND_DEATH = "monsters/beetle/pain2.wav";
		NPC_HACKED_MOVE_SPEED = 0;
	}

	void OnSpawn() override
	{
		SetName("Elite Fire Ant Warrior");
		SetModel("monsters/ant_size2.mdl");
		SetWidth(32);
		SetHeight(64);
		SetBloodType("green");
		SetRace("ant_red");
		SetHealth(500);
		SetDamageResistance("pierce", 1.25);
		SetRoam(false);
		SetHearingSensitivity(5);
		SetModelBody(1, 1);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("fire", 0.5);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		SetMoveAnim(ANIM_HOVER);
		SetIdleAnim(ANIM_HOVER);
		ANIM_WALK = ANIM_HOVER;
		ANIM_RUN = ANIM_HOVER;
		ANIM_IDLE = ANIM_HOVER;
		PlayAnim("critical", ANIM_2HOVER);
		DID_INTRO = 1;
		ANT_AM_FLYING = 1;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += 3.0;
		NPC_PROPELL_SUSPEND = 1;
		NPC_HACKED_MOVE_SPEED = 0;
	}

	void my_target_died()
	{
		ANT_AM_FLYING = 0;
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle";
		PlayAnim("critical", ANIM_LAND);
		DID_INTRO = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if ((ANT_AM_FLYING))
		{
			NPC_PROPELL_SUSPEND = 0;
			if (NPC_HACKED_MOVE_SPEED < 300)
			{
				if (GetEntityRange(m_hAttackTarget) > ATTACK_MOVERANGE)
				{
					NPC_HACKED_MOVE_SPEED += 10;
				}
				else
				{
					if (GetEntityRange(m_hAttackTarget) <= ATTACK_MOVERANGE)
					{
					}
					if (NPC_HACKED_MOVE_SPEED > 0)
					{
					}
					NPC_HACKED_MOVE_SPEED -= 1;
				}
			}
			if (GetGameTime() > NEXT_BUZZ_SOUND)
			{
				NEXT_BUZZ_SOUND = GetGameTime();
				NEXT_BUZZ_SOUND += FREQ_BUZZ;
				// svplaysound: svplaysound 2 10 SOUND_FLY_LOOP
				EmitSound(2, 10, SOUND_FLY_LOOP);
			}
			ANIM_ATTACK = ANIM_HOVER_BITE;
			if (GetGameTime() > NEXT_BREATH)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 256)
			{
			}
			NEXT_BREATH = GetGameTime();
			NEXT_BREATH += FREQ_BREATH;
			PlayAnim("critical", "anim_hover_breath");
		}
		else
		{
			NPC_PROPELL_SUSPEND = 1;
			NPC_HACKED_MOVE_SPEED = 0;
		}
	}

	void game_stopmoving()
	{
		NPC_HACKED_MOVE_SPEED = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
	}

	void frame_breath_start()
	{
		SetAnimMoveSpeed(0);
		NPC_PROPELL_SUSPEND = 1;
		NPC_HACKED_MOVE_SPEED = 0;
		NPC_JUMPER = 0;
		SetMoveDest(BREATH_TARG);
		BREATH_TARG = m_hAttackTarget;
		npcatk_suspend_ai(3.0);
		BREATH_ON = 1;
		EmitSound(GetOwner(), 0, SOUND_BREATH, 10);
		ClientEvent("new", "all", "monsters/ant_fire_cl", GetEntityIndex(GetOwner()), 5.0, 0.5);
		CL_BREATH_IDX = "game.script.last_sent_id";
		SCAN_POINT = /* TODO: $relpos */ $relpos(0, 64, 32);
		breath_loop();
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		SetMoveDest(SCAN_POINT);
		ScheduleDelayedEvent(0.5, "breath_loop");
		BREATH_TARGETS = FindEntitiesInSphere("enemy", 196);
		if (!(BREATH_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(BREATH_TARGETS, ";"); i++)
		{
			breath_affect_targets();
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARG = GetToken(BREATH_TARGETS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARG) < 384)) return;
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = TARG_ORG;
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE == TRACE_END)) return;
		if (!(GetEntityProperty(CUR_TARG, "haseffect")))
		{
			ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		string PUSH_RATIO = GetEntityRange(CUR_TARG);
		if (PUSH_RATIO < 256)
		{
			PUSH_RATIO /= 256;
			string PUSH_RATIO = /* TODO: $ratio */ $ratio(PUSH_RATIO, 2000, 200);
		}
		else
		{
			int PUSH_RATIO = 200;
		}
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, PUSH_RATIO, 110));
	}

	void frame_breath_end()
	{
		NPC_PROPELL_SUSPEND = 0;
		NPC_JUMPER = 1;
		BREATH_ON = 0;
		npcatk_resume_ai();
		ClientEvent("update", "all", CL_BREATH_IDX, "end_fx");
	}

	void frame_shoot()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.9, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((GetEntityProperty(param2, "haseffect"))) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((BREATH_ON))
		{
			frame_breath_end();
		}
		if ((ANT_ANT_AM_FLYING))
		{
			// svplaysound: svplaysound 2 0 SOUND_FLY_LOOP
			EmitSound(2, 0, SOUND_FLY_LOOP);
			ANIM_DEATH = "anim_hover_death";
		}
		else
		{
			ANIM_DEATH = "die";
		}
	}

	void OnDamage(int damage) override
	{
		if (!(ANT_AM_FLYING)) return;
		if (!(param2 < GetEntityHealth(GetOwner()))) return;
		if ((param3).findFirst("effect") >= 0)
		{
			int L_IS_DOT = 1;
		}
		if ((L_IS_DOT)) return;
		if (!(GetGameTime() > NEXT_DODGE)) return;
		NEXT_DODGE = GetGameTime();
		NEXT_DODGE += FREQ_DODGE;
		DODGE_IDX += 1;
		if (DODGE_IDX == 1)
		{
			int RND_LR = 400;
		}
		if (DODGE_IDX == 2)
		{
			int RND_LR = -400;
			DODGE_IDX = 0;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, -200, 0));
	}

}

}
