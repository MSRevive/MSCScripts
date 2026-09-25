#pragma context server

namespace MS
{

class ShockBeam : CGameScript
{
	string BEAM_COLOR;
	string BEAM_DELAY;
	string BEAM_END;
	string BEAM_START;
	string CLBEAM_COLOR;
	string CLBEAM_DUR;
	string CLBEAM_ORIGIN;
	string CLBEAM_RADIUS;
	string GAME_PVP;
	int IS_ACTIVE;
	string MY_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_RADIUS;
	string MY_SCRIPT;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string SOUND_LIGHTNING;
	string SOUND_THUNDER;
	string SOUND_WARNING;

	ShockBeam()
	{
		SOUND_THUNDER = "weather/Storm_exclamation.wav";
		SOUND_LIGHTNING = "magic/lightning_strike_replica.wav";
		SOUND_WARNING = "magic/eraticlightfail.wav";
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_RADIUS = param2;
		MY_DURATION = param3;
		MY_DAMAGE = param4;
		BEAM_COLOR = param5;
		BEAM_DELAY = param6;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		GAME_PVP = "game.pvp";
		if (BEAM_COLOR == "PARAM5")
		{
			BEAM_COLOR = Vector3(255, 255, 0);
		}
		string F_DURATION = MY_DURATION;
		if (BEAM_DELAY != "PARAM6")
		{
			F_DURATION += BEAM_DELAY;
		}
		F_DURATION("end_effect");
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(0.1, "make_thunder");
	}

	void make_thunder()
	{
		MY_SCRIPT = "game.script.last_sent_id";
		BEAM_START = GetMonsterProperty("origin");
		BEAM_END = BEAM_START;
		BEAM_END = "z";
		string CL_DURATION = MY_DURATION;
		if (BEAM_DELAY != "PARAM6")
		{
			CL_DURATION += BEAM_DELAY;
		}
		if (BEAM_DELAY == "PARAM6")
		{
			make_lightning();
		}
		if (BEAM_DELAY != "PARAM6")
		{
			BEAM_DELAY("make_lightning");
			EmitSound(GetOwner(), 0, SOUND_WARNING, 10);
		}
		ClientEvent("new", "all", currentscript, BEAM_START, BEAM_COLOR, MY_RADIUS, CL_DURATION);
	}

	void make_lightning()
	{
		EmitSound(GetOwner(), 0, SOUND_LIGHTNING, 10);
		Effect("beam", "point", "lgtning.spr", 200, BEAM_START, BEAM_END, BEAM_COLOR, 255, 100, MY_DURATION);
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "more_noise");
		damage_loop();
	}

	void more_noise()
	{
		EmitSound(GetOwner(), 0, SOUND_THUNDER, 10);
	}

	void damage_loop()
	{
		if (!(IS_ACTIVE)) return;
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), MY_RADIUS, 0.0, 1.0, 0.0);
		ScheduleDelayedEvent(0.25, "damage_loop");
	}

	void game_dodamage()
	{
		if (GAME_PVP == 0)
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		if ((GetEntityProperty(param2, "haseffect"))) return;
		ApplyEffect(param2, "effects/dot_lightning", 5.0, MY_OWNER, MY_DAMAGE);
	}

	void end_effect()
	{
		IS_ACTIVE = 0;
		ClientEvent("remove", "all", MY_SCRIPT);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		CLBEAM_ORIGIN = param1;
		CLBEAM_COLOR = param2;
		CLBEAM_RADIUS = param3;
		CLBEAM_DUR = param4;
		ClientEffect("light", "new", CLBEAM_ORIGIN, CLBEAM_RADIUS, CLBEAM_COLOR, CLBEAM_DUR);
		ClientEffect("tempent", "sprite", "blueflare1.spr", CLBEAM_ORIGIN, "shock_beam_endsprite");
		CLBEAM_DUR("remove_cl");
	}

	void shock_beam_endsprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", CLBEAM_DUR);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", CLBEAM_COLOR);
	}

	void remove_cl()
	{
		RemoveScript();
	}

}

}
