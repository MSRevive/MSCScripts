#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFireBall2 : CGameScript
{
	int ARROW_BODY_OFS;
	string FB_SCRIPT_INDEX;
	string ITEM_NAME;
	string LOCK_BURN_DAMAGE;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_OWNER;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	string SCRIPT_1;
	string SOUND_BURN;
	string SOUND_LOOP;
	int SOUND_ON;
	string SOUND_START;
	string SPRITE_BURN;
	string SPRITE_FIRE;

	ProjFireBall2()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		SOUND_BURN = "items/torch1.wav";
		SPRITE_FIRE = "3dmflaora.spr";
		SPRITE_BURN = "fire1_fixed.spr";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGESTAT = "spellcasting";
		ARROW_BODY_OFS = 4;
		PROJ_DAMAGE = RandomInt(400, 500);
		PROJ_AOE_RANGE = 250;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_COLLIDEHITBOX = 64;
		SOUND_START = "magic/volcano_start.wav";
		SOUND_LOOP = "magic/volcano_loop.wav";
		Precache(SPRITE_BURN);
		SCRIPT_1 = "items/proj_fire_dart_cl";
		Precache(SCRIPT_1);
		Precache("rjet1.spr");
		Precache(MODEL_WORLD);
	}

	void arrow_spawn()
	{
		SetName("Meteor");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0.0);
		SetMonsterClip(0);
		SetModelBody(0, 0);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
		Effect("glow", GetOwner(), Vector3(255, 75, 0), 128, 5, 5);
		ScheduleDelayedEvent(0.1, "pulsate_loop");
	}

	void pulsate_loop()
	{
		SetProp(GetOwner(), "rendermode", 5);
		int PULSE_VALUE = RandomInt(100, 255);
		SetProp(GetOwner(), "renderamt", PULSE_VALUE);
		ScheduleDelayedEvent(0.1, "pulsate_loop");
	}

	void game_tossprojectile()
	{
		EmitSound(GetOwner(), 0, SOUND_START, 10);
		SOUND_ON = 1;
		ScheduleDelayedEvent(1.0, "loop_sound");
		ClientEvent("new", "all_in_sight", SCRIPT_1, GetEntityIndex(GetOwner()));
		FB_SCRIPT_INDEX = "game.script.last_sent_id";
	}

	void loop_sound()
	{
		if (!(SOUND_ON)) return;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_LOOP, 7);
		ScheduleDelayedEvent(6.0, "loop_sound");
	}

	void projectile_landed()
	{
		SOUND_ON = 0;
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 50, 20, DURATION, 256);
		Effect("tempent", "trail", "rjet1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 10), 20, 2, 9, 10, 20);
		ClientEvent("remove", "all", FB_SCRIPT_INDEX);
	}

	void game_hitnpc()
	{
		MY_OWNER = GetEntityIndex("ent_expowner");
		if (LOCK_BURN_DAMAGE == "LOCK_BURN_DAMAGE")
		{
			string BURN_DAMAGE = GetSkillLevel("ent_expowner", "spellcasting.fire");
			BURN_DAMAGE *= 0.4;
		}
		if (LOCK_BURN_DAMAGE != "LOCK_BURN_DAMAGE")
		{
			string BURN_DAMAGE = LOCK_BURN_DAMAGE;
		}
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 20, MY_OWNER, BURN_DAMAGE, "spellcasting.fire");
	}

	void lighten()
	{
		LOCK_BURN_DAMAGE = param1;
	}

}

}
