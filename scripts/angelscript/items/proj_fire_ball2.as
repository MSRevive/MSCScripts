#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFireBall2 : CGameScript
{
	string FB_SCRIPT_INDEX;
	string LOCK_BURN_DAMAGE;
	string MY_OWNER;
	int SOUND_ON;

	ProjFireBall2()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const string SOUND_BURN = "items/torch1.wav";
		const string SPRITE_FIRE = "3dmflaora.spr";
		const string SPRITE_BURN = "fire1_fixed.spr";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const string PROJ_DAMAGESTAT = "spellcasting";
		const int ARROW_BODY_OFS = 4;
		const string PROJ_DAMAGE = RandomInt(400, 500);
		const int PROJ_AOE_RANGE = 250;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_COLLIDEHITBOX = 64;
		const string SOUND_START = "magic/volcano_start.wav";
		const string SOUND_LOOP = "magic/volcano_loop.wav";
		Precache(SPRITE_BURN);
		const string SCRIPT_1 = "items/proj_fire_dart_cl";
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
		string PULSE_VALUE = RandomInt(100, 255);
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
