#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class SummonLightningStorm : CGameScript
{
	string ACTIVE_SKILL;
	string AOE_OWNER;
	string BASE_DURATION;
	string CAST_BY_PLAYER;
	string GROUND_Z;
	int LOOP_SOUND;
	string MY_BASE_DAMAGE;
	string MY_ITEM;
	string MY_OWNER;
	string NEG_WIDTH;
	int PLAYING_DEAD;
	string SMOKE_ANGLE;
	string SMOKE_POSITION;
	string STORM_CLID;
	string STORM_DURATION;

	SummonLightningStorm()
	{
		const int STORM_HEIGHT = 260;
		const string SMOKE_SPRITE = "bigsmoke.spr";
		const string LIGHTNING_SPRITE = "lgtning.spr";
		const string LIGHTNING_SPRITE_SPARKS = "3dmflaora.spr";
		const int STORM_WIDTH = 75;
		const float AOE_FREQ = 1.0;
		const int AOE_RADIUS = 150;
	}

	void game_precache()
	{
		Precache(LIGHTNING_SPRITE_SPARKS);
		Precache(SMOKE_SPRITE);
		Precache(LIGHTNING_SPRITE);
	}

	void OnSpawn() override
	{
		SetName("Lightning Storm");
		SetInvincible(true);
		SetNoPush(true);
		SetGravity(0);
		PLAYING_DEAD = 1;
		LOOP_SOUND = 0;
	}

	void game_dynamically_created()
	{
		AOE_OWNER = param1;
		MY_OWNER = param1;
		if ((GetEntityProperty(AOE_OWNER, "is_item")))
		{
			MY_ITEM = AOE_OWNER;
			AOE_OWNER = GetEntityProperty(MY_ITEM, "owner");
			MY_OWNER = AOE_OWNER;
		}
		NEG_WIDTH = /* TODO: $neg */ $neg(STORM_WIDTH);
		string L_ANGLE = param2;
		SetAngles("face.y");
		MY_BASE_DAMAGE = param3;
		BASE_DURATION = param4;
		STORM_DURATION = /* TODO: $math(add) */ GetGameTime();
		ACTIVE_SKILL = param5;
		CAST_BY_PLAYER = GetEntityProperty(MY_ITEM, "is_item");
		string F_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		LogDebug("GroundLevelSentToClient: F_GROUND_Z");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), L_ANGLE, F_GROUND_Z);
		STORM_CLID = "game.script.last_sent_id";
		do_storm();
		check_death();
	}

	void do_storm()
	{
		ScheduleDelayedEvent(0.3, "do_storm");
		LOOP_SOUND += 1;
		if (LOOP_SOUND >= 3)
		{
			EmitSound(GetOwner(), 0, "weather/lightning.wav", 6);
			LOOP_SOUND = 0;
		}
	}

	void apply_aoe_effect()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		float EFFECT_DUR = 5.0;
		string L_ENT = AOE_OWNER;
		if ((GetEntityProperty(L_ENT, "is_item")))
		{
			EFFECT_DUR *= 2;
			string L_ENT = GetEntityProperty(L_ENT, "owner");
		}
		ApplyEffect(param1, "effects/dot_lightning", EFFECT_DUR, L_ENT, MY_BASE_DAMAGE, ACTIVE_SKILL);
	}

	void sustain_storm()
	{
		string L_POS = param1;
		SetEntityOrigin(GetOwner(), L_POS);
		ClientEvent("update", "all", STORM_CLID, "cl_pos_update", L_POS);
		STORM_DURATION = /* TODO: $math(add) */ GetGameTime();
	}

	void check_death()
	{
		SetRepeatDelay(0.5);
		int L_REMOVE = 0;
		if (GetGameTime() > STORM_DURATION)
		{
			int L_REMOVE = 1;
		}
		if ((L_REMOVE))
		{
			ClientEvent("remove", "all", STORM_CLID);
			CallExternal(MY_ITEM, "storm_ended");
			DeleteEntity(GetOwner());
		}
	}

	void client_activate()
	{
		SMOKE_POSITION = param1;
		SMOKE_ANGLE = Vector3(0, param2, 0);
		GROUND_Z = param3;
	}

	void smokes_shoot()
	{
		SetRepeatDelay(0.25);
		string x = RandomInt(-64, 64);
		string y = RandomInt(-64, 64);
		string L_POS = /* TODO: $relpos */ $relpos(SMOKE_ANGLE, Vector3(x, y, 250));
		L_POS += SMOKE_POSITION;
		cl_beam(L_POS);
		ClientEffect("tempent", "sprite", SMOKE_SPRITE, L_POS, "setup_smokes");
	}

	void cl_pos_update()
	{
		SMOKE_POSITION = param1;
		GROUND_Z = (param1).z;
		GROUND_Z -= 100;
	}

	void cl_beam()
	{
		string CL_BEAM_START = param1;
		string CL_BEAM_END = CL_BEAM_START;
		CL_BEAM_END = "z";
		ClientEffect("beam_points", CL_BEAM_START, CL_BEAM_END, LIGHTNING_SPRITE, 1.0, 60, 0.4, 0.5, 1, 2, Vector3(255, 255, 0));
	}

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
