#pragma context server

#include "items/proj_arrow_base.as"
#include "items/base_loopsnd.as"

namespace MS
{

class ProjArrowFire : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_EXPIRE_DELAY;
	int ARROW_SOLIDIFY_ON_WALL;
	int ARROW_STICK_DURATION;
	int LOOPSND_LENGTH;
	string LOOPSND_NAME;
	int LOOPSND_VOLUME;
	int PROJ_DAMAGE;
	string PROJ_DAMAGETYPE;
	int PROJ_STICK_DURATION;
	string SCRIPT_1_ID;
	string SFX_SCRIPT;
	string SPRITE_ARROW_TRADE;

	ProjArrowFire()
	{
		SPRITE_ARROW_TRADE = "firearrow";
		ARROW_BODY_OFS = 0;
		PROJ_DAMAGE = RandomInt(100, 150);
		PROJ_DAMAGETYPE = "fire";
		ARROW_STICK_DURATION = 25;
		PROJ_STICK_DURATION = 25;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 0.0;
		ARROW_EXPIRE_DELAY = 100;
		SFX_SCRIPT = "items/proj_arrow_fire_cl";
		Precache(SFX_SCRIPT);
		LOOPSND_NAME = "items/torch1.wav";
		LOOPSND_LENGTH = 6;
		LOOPSND_VOLUME = 5;
	}

	void arrow_spawn()
	{
		SetName("Fire Arrow");
		SetDescription("This kind of arrow is merely used for lighting up dark areas");
		SetWeight(0.125);
		SetSize(1);
		SetValue(10);
		SetGravity(0.8);
		SetGroupable(25);
	}

	void game_putinpack()
	{
		loopsnd_end();
	}

	void game_fall()
	{
		loopsnd_start();
	}

	void arrow_hitwall()
	{
		loopsnd_start();
	}

	void game_tossprojectile()
	{
		ClientEvent("new", "all", SFX_SCRIPT, GetEntityIndex(GetOwner()));
		SCRIPT_1_ID = "game.script.last_sent_id";
	}

	void hitwall()
	{
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = TRACE_START;
		TRACE_END += /* TODO: $relpos */ $relpos(0, 100, 0);
		Effect("decal", TRACE_END, 46);
	}

	void projectile_landed()
	{
		SetSolid("none");
		loopsnd_end();
		ClientEvent("update", "all", SCRIPT_1_ID, "loop_sound");
		ScheduleDelayedEvent(10.0, "projectile_expire");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		ApplyEffect(param2, "effects/dot_fire", 5, MY_OWNER, 1, "archery");
	}

	void game_projectile_hitnpc()
	{
		if (!(IsEntityAlive(param1))) return;
		ClientEvent("update", "all", SCRIPT_1_ID, "transfer_owner", GetEntityIndex(param1));
	}

	void projectile_broke()
	{
		loopsnd_end();
	}

	void projectile_expire()
	{
		DeleteEntity(GetOwner());
	}

}

}
