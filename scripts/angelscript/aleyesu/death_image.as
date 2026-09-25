#pragma context server

namespace MS
{

class DeathImage : CGameScript
{
	float DIST_VORTEX;
	int FOUNTAIN_ACTIVE;
	int FOUNTAIN_MODE;
	int IS_ACTIVE;
	string MY_CL_IDX;
	int PLAYING_DEAD;
	int REND_COUNT;
	string ROT;
	int SPEECH_DONE;
	string SPRITE_CENTER;
	string VEC_DEST;
	string VORTEX_CENTER;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((FOUNTAIN_ACTIVE))
		{
		}
		if (FOUNTAIN_MODE == 1)
		{
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "glow_sprite");
		}
		if (FOUNTAIN_MODE == 2)
		{
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "explode_sprite");
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "explode_sprite");
			ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "explode_sprite");
		}
	}

	void OnSpawn() override
	{
		SetName("Younger Keledros");
		SetModel("monsters/venevus.mdl");
		SetWidth(32);
		SetHeight(80);
		SetRoam(false);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetSayTextRange(2048);
		SetSolid("none");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
		ScheduleDelayedEvent(0.1, "say_stuff1");
		IS_ACTIVE = 1;
		setup_spinout();
		// svplaysound: svplaysound 2 10 ambience/alien_chatter.wav
		EmitSound(2, 10, "ambience/alien_chatter.wav");
	}

	void say_stuff1()
	{
		SayText("Ahck! No! " + I + " m too weak to maintain phase in this time!");
		UseTrigger("timeroom_death");
		ScheduleDelayedEvent(3.0, "say_stuff2");
	}

	void say_stuff2()
	{
		SayText("Mark my words , this isn t the first time you had seen of meeeee...!");
		SPEECH_DONE = 1;
	}

	void spinout_done()
	{
		// svplaysound: svplaysound 2 0 ambience/alien_chatter.wav
		EmitSound(2, 0, "ambience/alien_chatter.wav");
		EmitSound(GetOwner(), 0, "ambience/alien_humongo.wav", 10);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("update", "all", MY_CL_IDX, "do_explode");
		Effect("screenfade", "all", 3, 1, Vector3(255, 255, 255), 200, "fadein");
		ScheduleDelayedEvent(1.0, "remove_me1");
		if ((GetEntityProperty(GAME_MASTER, "scriptvar"))) return;
		SpawnNPC("aleyesu/final_chest", VORTEX_CENTER, ScriptMode::Legacy);
	}

	void remove_me1()
	{
		ClientEvent("remove", "all", MY_CL_IDX);
		ScheduleDelayedEvent(0.1, "remove_me2");
	}

	void remove_me2()
	{
		if (!(SPEECH_DONE))
		{
			ScheduleDelayedEvent(1.0, "remove_me2");
		}
		if (!(SPEECH_DONE)) return;
		DeleteEntity(GetOwner());
	}

	void setup_spinout()
	{
		DIST_VORTEX = Distance(GetMonsterProperty("origin"), VORTEX_CENTER);
		ROT = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), VORTEX_CENTER);
		REND_COUNT = 0;
		ScheduleDelayedEvent(0.1, "spinout_loop");
	}

	void spinout_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "spinout_loop");
		VEC_DEST = VORTEX_CENTER;
		VEC_DEST += /* TODO: $relpos */ $relpos(Vector3(0, ROT, 0), Vector3(0, DIST_VORTEX, 0));
		ROT += 10;
		if (ROT > 359)
		{
			ROT -= 359;
		}
		if (DIST_VORTEX > 0)
		{
			DIST_VORTEX -= 5;
		}
		if (DIST_VORTEX > 1024)
		{
			DIST_VORTEX = 1024;
		}
		if (DIST_VORTEX <= 0)
		{
			IS_ACTIVE = 0;
			spinout_done();
		}
		int RND_AMT = RandomInt(128, 255);
		SetProp(GetOwner(), "renderamt", RND_AMT);
		SetEntityOrigin(GetOwner(), VEC_DEST);
	}

	void game_dynamically_created()
	{
		VORTEX_CENTER = param1;
		ClientEvent("new", "all", currentscript, VORTEX_CENTER);
		MY_CL_IDX = "game.script.last_sent_id";
	}

	void client_activate()
	{
		SPRITE_CENTER = param1;
		FOUNTAIN_ACTIVE = 1;
		FOUNTAIN_MODE = 1;
	}

	void do_explode()
	{
		FOUNTAIN_MODE = 2;
	}

	void glow_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-1.1, -1.6));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
	}

	void explode_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
	}

}

}
