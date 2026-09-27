#pragma context server

#include "monsters/base_propelled.as"

namespace MS
{

class Tornado : CGameScript
{
	int CUR_DMGVICT;
	string DMG_BASE;
	string GAME_PVP;
	int IS_ACTIVE;
	string MONSTER_MODEL;
	string MOVE_TARG;
	string MY_DURATION;
	string MY_OWNER;
	int NPC_HACKED_MOVE_SPEED;
	int N_VICTIMS;
	string OWNER_ISPLAYER;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_WIND1;
	string SOUND_WIND2;
	string SOUND_WIND3;

	Tornado()
	{
		NPC_HACKED_MOVE_SPEED = 200;
		MONSTER_MODEL = "weapons/magic/tornado.mdl";
		SOUND_WIND1 = "magic/vent1.wav";
		SOUND_WIND2 = "magic/vent2.wav";
		SOUND_WIND3 = "magic/vent3.wav";
		SOUND_ATTACK1 = "magic/gusts1.wav";
		SOUND_ATTACK2 = "magic/gusts2.wav";
		Precache(MONSTER_MODEL);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if ((IS_ACTIVE))
		{
		}
		int RND_MOVE = RandomInt(1, 2);
		if (RND_MOVE == 1)
		{
			if (MOVE_TARG != "unset")
			{
				SetMoveDest(MOVE_TARG);
			}
			if (MOVE_TARG == "unset")
			{
				int RND_MOVE = 2;
			}
		}
		if (RND_MOVE == 2)
		{
			int RND_ANG = RandomInt(0, 359);
			string MOVE_DEST = GetMonsterProperty("origin");
			MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 1000, 0));
			SetMoveDest(MOVE_DEST);
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(Random(4, 6));
		if ((IS_ACTIVE))
		{
		}
		// PlayRandomSound from: SOUND_WIND1, SOUND_WIND2, SOUND_WIND3
		array<string> sounds = {SOUND_WIND1, SOUND_WIND2, SOUND_WIND3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		DMG_BASE = param2;
		MY_DURATION = param3;
		GAME_PVP = "game.pvp";
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		SetRace(GetEntityRace(MY_OWNER));
		MOVE_TARG = GetEntityProperty(MY_OWNER, "scriptvar");
		IS_ACTIVE = 1;
		summon_cycle();
		MY_DURATION("end_summon");
	}

	void OnSpawn() override
	{
		SetName("Tornado");
		SetModel(MONSTER_MODEL);
		SetInvincible(true);
		SetHealth(1);
		SetRoam(true);
		SetWidth(64);
		SetHeight(128);
		SetSolid("none");
		SetMonsterClip(0);
		N_VICTIMS = 0;
		CUR_DMGVICT = 0;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 180);
	}

	void summon_cycle()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "summon_cycle");
		if (MOVE_TARG == "unset")
		{
			if ((false))
			{
			}
			check_vict(GetEntityIndex(m_hLastSeen));
			if (!(ALREADY_MINE))
			{
				MOVE_TARG = GetEntityIndex(m_hLastSeen);
			}
		}
		DoDamage(/* TODO: $relpos */ $relpos(0, 30, 0), 128, 0.0, 1.0, 0.0);
	}

	void game_dodamage()
	{
		if (!(IS_ACTIVE)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
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
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CallExternal(MY_OWNER, "ext_dodamage", param2, "direct", DMG_BASE, 1.0, MY_OWNER, "magic");
		int RND_DIR = RandomInt(1, 2);
		if (RND_DIR == 1)
		{
			int RND_DIR = 1000;
		}
		if (RND_DIR == 2)
		{
			int RND_DIR = -1000;
		}
		int RND_FBDIR = RandomInt(1, 2);
		if (RND_FBDIR == 1)
		{
			int RND_FBDIR = 1000;
		}
		if (RND_FBDIR == 2)
		{
			int RND_FBDIR = -1000;
		}
		int RND_LIFT = RandomInt(300, 1000);
		LogDebug("temp RND_DIR RND_LIFT");
		SetVelocity(param2, /* TODO: $relvel */ $relvel(RND_DIR, RND_FBDIR, RND_LIFT));
	}

	void end_summon()
	{
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
