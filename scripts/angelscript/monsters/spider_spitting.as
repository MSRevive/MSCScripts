#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class SpiderSpitting : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	int NO_STEP_ADJ;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;

	SpiderSpitting()
	{
		const string PROJ_TYPE = "proj_poison";
		const Vector3 PROJ_OFS = Vector3(0, 48, 32);
		const int DELETE_ON_DEATH = 1;
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SND_STRUCK4 = SOUND_PAIN;
		const string SND_STRUCK5 = SOUND_PAIN;
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const string ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		const int ATTACK_SPEED = 650;
		const int ATTACK_DAMAGE_LOW = 4;
		const int ATTACK_DAMAGE_HIGH = 6;
		const float ATTACK_ACCURACY = 0.6;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 69;
		const int SPIDER_IDLE_VOL = 3;
		const float SPIDER_IDLE_DELAY = 3.6;
		const int SPIDER_VOLUME = 10;
		const float SPIT_FREQ = 1.0;
		const int AIM_RATIO = 50;
		MOVE_RANGE = 384;
		NO_STEP_ADJ = 1;
		RETALIATE_CHANCE = 0.75;
	}

	void OnSpawn() override
	{
		spider_spawn();
	}

	void spider_spawn()
	{
		SetHealth(80);
		if (!(AM_CLIPPED))
		{
			SetWidth(64);
			SetHeight(64);
		}
		if ((AM_CLIPPED))
		{
			SetWidth(32);
			SetHeight(20);
		}
		SetName("Spitting Cave Spider");
		SetHearingSensitivity(7);
		SetModel("monsters/gspider.mdl");
		SetDamageResistance("all", ".8");
		NPC_GIVE_EXP = 70;
	}

	void debug_props()
	{
		SetSayTextRange(1024);
		SayText("I cansee nme false hunt false cycl CYCLE_TIME is IS_HUNTING plr HUNTING_PLAYER");
	}

	void bite1()
	{
		AS_ATTACKING = GetGameTime();
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_ACCURACY, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite");
		if (!(false)) return;
		string L_POS = GetEntityOrigin(GetOwner());
		L_POS += /* TODO: $relpos */ $relpos(GetEntityAngles(GetOwner()), PROJ_OFS);
		TossProjectile(PROJ_TYPE, L_POS, HUNT_LASTTARGET, ATTACK_SPEED, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), 2, "none");
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		if (!(GetEntityRange(param1) > ATTACK_RANGE)) return;
		PlayAnim("once", ANIM_ATTACK);
	}

}

}
