#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class BossSpider : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;
	int SPIDER_LATCHED;
	int SPIDER_LATCHING;
	string SPIDER_LATCH_TARGET;

	BossSpider()
	{
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SND_STRUCK4 = SOUND_PAIN;
		const string SND_STRUCK5 = SOUND_PAIN;
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const string ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		MOVE_RANGE = 32;
		ATTACK_RANGE = 60;
		const float ATTACK_DAMAGE_LOW = 7.0;
		const float ATTACK_DAMAGE_HIGH = 9.0;
		const float ATTACK_ACCURACY = 0.6;
		NPC_GIVE_EXP = 12;
		const int SPIDER_IDLE_VOL = 2;
		const float SPIDER_IDLE_DELAY = 3.6;
		const int SPIDER_VOLUME = 10;
		const int SPIDER_LATCHATTACK = 1;
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		const int SPIDER_LATCH_ATKDMG = 5;
		const int SPIDER_LATCH_ATKDUR = 4;
		const int SPIDER_LATCH_ATKCHANCE = 20;
		const int SPIDER_LATCH_MAXRANGE = 200;
		const string ANIM_LATCH_ATTACK = "jumpmiss";
		const string ANIM_LATCH_HIT = "jumphit";
		const string ANIM_LATCH_ON = "hitbite";
		const string ANIM_LATCH_OFF = "falloff";
		const string SOUND_LATCH_HISS = "monsters/spider/spiderhiss2.wav";
		const string SOUND_LATCH_JUMP = "monsters/spider/spiderjump.wav";
		const string SOUND_LATCH = "monsters/spider/spiderlatch.wav";
		Precache("effects/effect_spiderlatch");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5);
		if ((IS_HUNTING))
		{
		}
		if ((GetEntityProperty(GetOwner(), "alive")))
		{
		}
		if (RandomInt(0, 99) < SPIDER_LATCH_ATKCHANCE)
		{
		}
		if (!(SPIDER_LATCHING))
		{
		}
		if (GetMonsterProperty("last_seen.distance") < SPIDER_LATCH_MAXRANGE)
		{
		}
		if ((IsOnGround(GetOwner())))
		{
		}
		if ((IsOnGround(HUNT_LASTTARGET)))
		{
		}
		PlayAnim("critical", ANIM_LATCH_ATTACK);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_LATCH_HISS, "game.sound.maxvol");
		SetMoveDest("none");
		SetAnimFrameRate(".8");
		SPIDER_LATCHING = 1;
		SPIDER_LATCH_TARGET = HUNT_LASTTARGET;
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		CAN_HEAR = 0;
		CAN_RETALIATE = 0;
		SetRoam(false);
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetWidth(40);
		SetHeight(64);
		SetHearingSensitivity(3);
		SetName("Araneus");
		NPC_GIVE_EXP = 16;
		SetModel("monsters/spider.mdl");
		SetStat("awareness", 20);
		SetStat("parry", 50);
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		if ((SPIDER_LATCHING)) return;
		PlayAnim("critical", ANIM_DODGE);
	}

	void frame_jump()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 320, 120));
		SetGravity(".9");
		SetAnimFrameRate(".5");
		SetMoveSpeed(0);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_LATCH_JUMP, 5);
		ScheduleDelayedEvent(0.001, "spider_latch_checkhitground");
	}

	void spider_latch_checkhitground()
	{
		if (!(SPIDER_LATCHING)) return;
		if ((SPIDER_LATCHED)) return;
		if (GetEntityDist(SPIDER_LATCH_TARGET) < 70)
		{
			spider_latch_hit();
		}
		else
		{
			if ((IsOnGround(GetOwner())))
			{
				SetVelocity(GetOwner(), Vector3(0, 0, 0));
				SetAnimFrameRate(1);
				ScheduleDelayedEvent(0.2, "spider_latch_resetmovement");
			}
			else
			{
				ScheduleDelayedEvent(0.001, "spider_latch_checkhitground");
			}
		}
	}

	void spider_latch_hit()
	{
		SPIDER_LATCHED = 1;
		PlayAnim("once", "break");
		SetIdleAnim(ANIM_LATCH_ON);
		SetEntityOrigin(GetOwner(), GetEntityOrigin(SPIDER_LATCH_TARGET));
		SetFollow(SPIDER_LATCH_TARGET);
		SetAngles("face.x");
		ApplyEffect(SPIDER_LATCH_TARGET, "effects/effect_spiderlatch", SPIDER_LATCH_ATKDUR, GetOwner(), SPIDER_LATCH_ATKDMG);
		EmitSound(GetOwner(), "game.sound.body", SOUND_LATCH, "game.sound.maxvol");
		SetBBox(Vector3(-40, -40, 0), Vector3(40, 40, 128));
		spider_latch_think();
		SPIDER_LATCH_ATKDUR("spider_latch_drop");
	}

	void spider_latch_think()
	{
		if (!(SPIDER_LATCHED)) return;
		if (!(GetEntityProperty(SPIDER_LATCH_TARGET, "alive")))
		{
			spider_latch_drop();
		}
		else
		{
			ScheduleDelayedEvent(0.01, "spider_latch_think");
		}
	}

	void spider_latch_drop()
	{
		if (!(SPIDER_LATCHING)) return;
		SPIDER_LATCHED = 0;
		SetFollow("none");
		SetGravity(1);
		SetMoveSpeed(-1);
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		PlayAnim("critical", ANIM_LATCH_OFF);
		EmitSound(GetOwner(), 0);
	}

	void spider_latch_resetmovement()
	{
		SetRoam(true);
		SetMoveSpeed(1);
		SetGravity(1);
		SetIdleAnim(ANIM_IDLE);
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		CAN_HEAR = 1;
		CAN_RETALIATE = 1;
		SPIDER_LATCHING = 0;
		SPIDER_LATCHED = 0;
	}

	void frame_falloffend()
	{
		SetIdleAnim(ANIM_IDLE);
		ScheduleDelayedEvent(0.2, "spider_latch_resetmovement");
		PlayAnim("critical", ANIM_IDLE);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (!(SPIDER_LATCHED)) return;
		spider_latch_drop();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(SPIDER_LATCHED)) return;
		SetFollow("none");
		spider_latch_resetmovement();
	}

}

}
