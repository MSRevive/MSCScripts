#pragma context server

namespace MS
{

class LightningRepulse : CGameScript
{
	string ACTIVE_SKILL;
	string GAME_PVP;
	int IS_ACTIVE;
	string MY_BASE_DMG;
	string MY_DURATION;
	string MY_OWNER;
	string MY_RANGE;
	string OWNER_DBLHP;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;

	LightningRepulse()
	{
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if ((IS_ACTIVE))
		{
		}
		SetEntityOrigin(GetOwner(), GetEntityOrigin(MY_OWNER));
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), MY_RANGE, 0, 1.0, 0);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_RANGE = param2;
		SetRace(GetEntityRace(MY_OWNER));
		MY_DURATION = param3;
		MY_BASE_DMG = param4;
		OWNER_DBLHP = GetEntityMaxHealth(MY_OWNER);
		OWNER_DBLHP *= 2.0;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		GAME_PVP = "game.pvp";
		IS_ACTIVE = 1;
		MY_DURATION("end_summon");
		ACTIVE_SKILL = param5;
		if (ACTIVE_SKILL == "PARAM5")
		{
			ACTIVE_SKILL = "spellcasting.lightning";
		}
	}

	void OnSpawn() override
	{
		SetName("Static Shock");
		SetInvincible(true);
		SetWidth(32);
		SetHeight(32);
		SetSolid("none");
		PLAYING_DEAD = 1;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((OWNER_ISPLAYER))
		{
			if (GAME_PVP == 0)
			{
			}
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string BEAM_START = GetMonsterProperty("origin");
		Effect("beam", "end", "lgtning.spr", 30, BEAM_START, param2, 0, Vector3(200, 255, 50), 200, 30, 0.1);
		string TARG_HP = GetEntityMaxHealth(param2);
		if (TARG_HP > 1500)
		{
			if (OWNER_DBLHP < TARG_HP)
			{
			}
			int EXIT_SUB = 1;
			if ((OWNER_ISPLAYER))
			{
				if (!(DID_MESSAGE))
				{
				}
				DID_MESSAGE = 1;
				SendPlayerMessage(MY_OWNER, "GetEntityName(param2) is too strong to be affected.");
			}
		}
		if ((EXIT_SUB)) return;
		string TARG_VEL = GetEntityAngles(MY_OWNER);
		SetAngles("face");
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 500, 10));
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(MY_BASE_DMG > 0)) return;
		XDoDamage(param2, "direct", MY_BASE_DMG, 1.0, MY_OWNER, MY_OWNER, ACTIVE_SKILL, "lightning");
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

}

}
