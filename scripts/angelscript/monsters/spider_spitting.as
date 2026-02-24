#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class SpiderSpitting : CGameScript
{
	int AIM_RATIO;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DODGE;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	float ATTACK_ACCURACY;
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int DELETE_ON_DEATH;
	int MOVE_RANGE;
	int NO_STEP_ADJ;
	int NPC_GIVE_EXP;
	string PROJ_OFS;
	string PROJ_TYPE;
	float RETALIATE_CHANCE;
	string SND_STRUCK1;
	string SND_STRUCK2;
	string SND_STRUCK3;
	string SND_STRUCK4;
	string SND_STRUCK5;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	float SPIDER_IDLE_DELAY;
	int SPIDER_IDLE_VOL;
	int SPIDER_VOLUME;
	float SPIT_FREQ;

	SpiderSpitting()
	{
		PROJ_TYPE = "proj_poison";
		PROJ_OFS = Vector3(0, 48, 32);
		DELETE_ON_DEATH = 1;
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		SND_STRUCK1 = "body/flesh1.wav";
		SND_STRUCK2 = "body/flesh2.wav";
		SND_STRUCK3 = "body/flesh3.wav";
		SND_STRUCK4 = SOUND_PAIN;
		SND_STRUCK5 = SOUND_PAIN;
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DODGE = "dodge";
		ANIM_DEATH = "die";
		ATTACK_SPEED = 650;
		ATTACK_DAMAGE_LOW = 4;
		ATTACK_DAMAGE_HIGH = 6;
		ATTACK_ACCURACY = 0.6;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 69;
		SPIDER_IDLE_VOL = 3;
		SPIDER_IDLE_DELAY = 3.6;
		SPIDER_VOLUME = 10;
		SPIT_FREQ = 1.0;
		AIM_RATIO = 50;
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
		SayText(I + " cansee nme false hunt false cycl CYCLE_TIME is IS_HUNTING plr HUNTING_PLAYER");
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
