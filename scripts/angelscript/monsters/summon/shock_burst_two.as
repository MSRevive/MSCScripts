#pragma context server

namespace MS
{

class ShockBurstTwo : CGameScript
{
	int ANG_ADJ;
	string BEAM_COLOR;
	string BEAM_WIDTH;
	int BOLTS_DEFINED;
	int BOLT_ANG;
	int BOLT_HEIGHT;
	int BOLT_INC;
	int CUR_ANG;
	int CUR_RAD;
	int DELAY_SOUND;
	string GAME_PVP;
	string HIT_TARG;
	int IS_ACTIVE;
	string MY_DMG;
	string MY_OWNER;
	string MY_RADIUS;
	string NUM_BOLTS;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string SOUND_THUNDER;

	ShockBurstTwo()
	{
		SOUND_THUNDER = "weather/Storm_exclamation.wav";
		BOLT_HEIGHT = 512;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DMG = param2;
		MY_RADIUS = param3;
		NUM_BOLTS = param4;
		BEAM_COLOR = param5;
		BEAM_WIDTH = param6;
		GAME_PVP = "game.pvp";
		if (BEAM_COLOR == "PARAM5")
		{
			BEAM_COLOR = Vector3(255, 255, 0);
		}
		if (BEAM_WIDTH == "PARAM6")
		{
			BEAM_WIDTH = 200;
		}
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		StoreEntity("ent_expowner");
		SetRace(GetEntityRace(MY_OWNER));
		ANG_ADJ = 359;
		ANG_ADJ /= NUM_BOLTS;
		CUR_RAD = 5;
		CUR_ANG = 0;
		BOLTS_DEFINED = 0;
		BOLT_INC = 359;
		BOLT_INC /= NUM_BOLTS;
		BOLT_ANG = 0;
		for (int i = 0; i < NUM_BOLTS; i++)
		{
			define_bolts();
		}
		IS_ACTIVE = 1;
		rotate_bolts();
	}

	void OnSpawn() override
	{
		SetName("Lightning Blast");
		SetHealth(1);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		EmitSound(GetOwner(), 0, SOUND_THUNDER, 10);
	}

	void define_bolts()
	{
		if (BOLT_LIST.length() > 0) BOLT_LIST += ";";
		BOLT_LIST += BOLT_ANG;
		BOLT_ANG += BOLT_INC;
	}

	void rotate_bolts()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "rotate_bolts");
		CUR_RAD += 2;
		CUR_ANG += 5;
		for (int i = 0; i < NUM_BOLTS; i++)
		{
			draw_bolts();
		}
		if (CUR_RAD >= MY_RADIUS)
		{
			end_summon();
		}
	}

	void draw_bolts()
	{
		string CUR_BOLT = i;
		string L_BOLT_ANG = GetToken(BOLT_LIST, CUR_BOLT, ";");
		L_BOLT_ANG += CUR_ANG;
		string BOLT_START = GetMonsterProperty("origin");
		BOLT_START += /* TODO: $relpos */ $relpos(Vector3(0, L_BOLT_ANG, 0), Vector3(0, CUR_RAD, 0));
		string BOLT_END = BOLT_START;
		BOLT_END += "z";
		Effect("beam", "point", "lgtning.spr", BEAM_WIDTH, BOLT_START, BOLT_END, BEAM_COLOR, 255, 100, 0.1);
		HIT_TARG = /* TODO: $get_insphere */ $get_insphere("any", 64, BOLT_START);
		if (!(IsEntityAlive(HIT_TARGET) + "callevent" + "check_targ" + HIT_TARGET)) return;
	}

	void end_summon()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void check_targ()
	{
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if ((IsValidPlayer(HIT_TARG)))
			{
			}
			if (GAME_PVP < 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		shock_targ();
	}

	void shock_targ()
	{
		ApplyEffect(HIT_TARG, "effects/dot_lightning", 5, MY_OWNER, MY_DMG);
		if ((DELAY_SOUND)) return;
		DELAY_SOUND = 1;
		ScheduleDelayedEvent(2.0, "reset_delay_sound");
		CallExternal("ext_playsound", "SOUND_SHOCK");
	}

	void reset_delay_sound()
	{
		DELAY_SOUND = 0;
	}

}

}
