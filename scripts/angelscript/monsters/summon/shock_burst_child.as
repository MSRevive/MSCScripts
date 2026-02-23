#pragma context server

namespace MS
{

class ShockBurstChild : CGameScript
{
	string CMY_DMG;
	string CMY_OWNER;
	int DELAY_SOUND;
	int IS_ACTIVE;
	string N_CREATED;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string PVP_MODE;

	ShockBurstChild()
	{
		const string SOUND_SHOCK = "debris/zap1.wav";
	}

	void game_dynamically_created()
	{
		CMY_OWNER = param1;
		CMY_DMG = param2;
		N_CREATED = param3;
		PVP_MODE = "game.pvp";
		OWNER_ISPLAYER = IsValidPlayer(CMY_OWNER);
		float ACTIVE_DELAY = 1.0;
		ACTIVE_DELAY += N_CREATED;
		IS_ACTIVE = 1;
		ACTIVE_DELAY("scan_loop");
		StoreEntity("ent_expowner");
	}

	void OnSpawn() override
	{
		SetName("Lightning Blast Bolt");
		SetRace("hated");
		SetHealth(1);
		SetInvincible(true);
		PLAYING_DEAD = 1;
	}

	void set_active()
	{
		IS_ACTIVE = 1;
	}

	void scan_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.23, "scan_loop");
		string HIT_TARG = /* TODO: $get_insphere */ $get_insphere("any", 64);
		if (!(GetRelationship(HIT_TARG) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if (PVP_MODE == 0)
			{
			}
			if ((IsValidPlayer(HIT_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(HIT_TARG, "effects/dot_lightning", 5, CMY_OWNER, CMY_DMG);
		if ((DELAY_SOUND)) return;
		DELAY_SOUND = 1;
		ScheduleDelayedEvent(2.0, "reset_delay_sound");
		EmitSound(GetOwner(), 0, SOUND_SHOCK, 10);
	}

	void reset_delay_sound()
	{
		DELAY_SOUND = 0;
	}

	void debug_beam()
	{
		if (param3 == "PARAM3")
		{
			Vector3 BEAM_COLOR = Vector3(255, 0, 255);
		}
		if (param3 != "PARAM3")
		{
			string BEAM_COLOR = param3;
		}
		float BEAM_DURATION = 1.0;
		string BEAM_START = param1;
		if (param2 == "PARAM2")
		{
			string BEAM_END = BEAM_START;
		}
		if (param2 != "PARAM2")
		{
			string BEAM_END = param2;
		}
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "point", "laserbeam.spr", 20, BEAM_START, BEAM_END, BEAM_COLOR, 255, 0.7, BEAM_DURATION);
	}

}

}
