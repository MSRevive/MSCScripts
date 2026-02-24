#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class AntFireWarrior : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ANIM_WALK1;
	string ANIM_WALK2;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BREATH_ON;
	string BREATH_TARG;
	string BREATH_TARGETS;
	string CL_BREATH_IDX;
	int DID_INTRO;
	int DMG_BITE;
	int DOT_FIRE;
	float FREQ_BREATH;
	float FREQ_SWITCH_ANIM;
	int MOVE_RANGE;
	string NEXT_BREATH;
	string NEXT_SWITCH_ANIM;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	string SCAN_POINT;
	string SND_STRUCK1;
	string SND_STRUCK2;
	string SND_STRUCK3;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_BREATH;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;

	AntFireWarrior()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_RUN = "walk";
		ANIM_DEATH = "die";
		ANIM_WALK1 = "walk";
		ANIM_WALK2 = "walk2";
		ANIM_ATTACK1 = "attack";
		ANIM_ATTACK2 = "attack2";
		NPC_GIVE_EXP = 150;
		NPC_ALLY_RESPONSE_RANGE = 1024;
		FREQ_SWITCH_ANIM = Random(5.0, 15.0);
		FREQ_BREATH = Random(20.0, 40.0);
		DMG_BITE = 50;
		DOT_FIRE = 10;
		ATTACK_RANGE = 32;
		MOVE_RANGE = 16;
		ATTACK_MOVERANGE = 16;
		ATTACK_HITRANGE = 64;
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SND_STRUCK1 = "body/flesh1.wav";
		SND_STRUCK2 = "body/flesh2.wav";
		SND_STRUCK3 = "body/flesh3.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		SOUND_ATTACK1 = "monsters/spider/spiderhiss2.wav";
		SOUND_ATTACK2 = "monsters/spider/spiderhiss.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.6);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// svplaysound: svplaysound 4 5 SOUND_IDLE1
		EmitSound(4, 5, SOUND_IDLE1);
	}

	void OnSpawn() override
	{
		SetName("Fire Ant Warrior");
		SetModel("monsters/ant_size2.mdl");
		SetWidth(32);
		SetHeight(16);
		SetBloodType("green");
		SetRace("ant_red");
		SetHealth(500);
		SetDamageResistance("pierce", 1.25);
		SetRoam(true);
		SetHearingSensitivity(5);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("fire", 0.5);
		SetAnimMoveSpeed(2.0);
		SetMoveSpeed(2.0);
	}

	void OnPostSpawn() override
	{
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
	}

	void frame_attack()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.9, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
	}

	void bite_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((GetEntityProperty(param2, "haseffect"))) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void my_target_died()
	{
		DID_INTRO = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetGameTime() > NEXT_BREATH)
			{
			}
			NEXT_BREATH = GetGameTime();
			NEXT_BREATH += FREQ_BREATH;
			do_breath();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_SWITCH_ANIM)) return;
		NEXT_SWITCH_ANIM = GetGameTime();
		NEXT_SWITCH_ANIM += FREQ_SWITCH_ANIM;
		if (RandomInt(1, 2) == 1)
		{
			ANIM_RUN = ANIM_WALK1;
			ANIM_WALK = ANIM_WALK1;
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			ANIM_RUN = ANIM_WALK2;
			ANIM_WALK = ANIM_WALK2;
			SetMoveAnim(ANIM_RUN);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SOUND_PAIN, SOUND_PAIN
		array<string> sounds = {SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SOUND_PAIN, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((BREATH_ON))
		{
			ClientEvent("update", "all", CL_BREATH_IDX, "end_fx");
		}
		// svplaysound: svplaysound 4 0 SOUND_IDLE1
		EmitSound(4, 0, SOUND_IDLE1);
	}

	void do_breath()
	{
		SetMoveDest(BREATH_TARG);
		BREATH_TARG = m_hAttackTarget;
		npcatk_suspend_movement("attack2", 5.0);
		npcatk_suspend_ai(5.0);
		BREATH_ON = 1;
		EmitSound(GetOwner(), 0, SOUND_BREATH, 10);
		ClientEvent("new", "all", "monsters/ant_fire_cl", GetEntityIndex(GetOwner()), 5.0, 0.25);
		CL_BREATH_IDX = "game.script.last_sent_id";
		SCAN_POINT = /* TODO: $relpos */ $relpos(0, 64, 32);
		breath_loop();
		ScheduleDelayedEvent(5.0, "breath_end");
	}

	void breath_loop()
	{
		if (!(BREATH_ON)) return;
		SetMoveDest(SCAN_POINT);
		ScheduleDelayedEvent(1.0, "breath_loop");
		BREATH_TARGETS = FindEntitiesInSphere("enemy", 128);
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
		if (!(GetEntityRange(CUR_TARG) < 256)) return;
		if ((GetEntityProperty(CUR_TARG, "haseffect"))) return;
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

	void breath_end()
	{
		BREATH_ON = 0;
		npcatk_resume_ai();
		npcatk_resume_movement();
	}

}

}
