#pragma context server

namespace MS
{

class SlimeGlobe : CGameScript
{
	string GLOB_TARG;
	int IS_ACTIVE;
	string MY_CL_IDX;
	string MY_DMG;
	string MY_OWNER;
	string NEXT_ORBIT_SOUND;
	string ORBIT_SOUND1;
	string ORBIT_SOUND2;
	int PLAYING_DEAD;
	string SOUND_SHOOT;

	SlimeGlobe()
	{
		Precache("xfireball3.spr");
		ORBIT_SOUND1 = "tentacle/te_move1.wav";
		ORBIT_SOUND2 = "tentacle/te_move2.wav";
		SOUND_SHOOT = "magic/blackhole.wav";
	}

	void OnSpawn() override
	{
		SetName("Globe of Slime");
		SetInvincible(true);
		SetNoPush(true);
		SetGravity(0);
		SetFly(true);
		SetModel("null.mdl");
		SetWidth(2);
		SetHeight(2);
		PLAYING_DEAD = 1;
		SetSolid("none");
	}

	void game_dynamically_created()
	{
		LogDebug("game_dynamically_created PARAM1 PARAM2 PARAM3");
		MY_OWNER = param1;
		MY_DMG = param2;
		SetRace(GetEntityRace(MY_OWNER));
		ScheduleDelayedEvent(0.1, "setup_cl");
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(3.0, "shoot_slime");
		ScheduleDelayedEvent(13.0, "end_slime");
		// PlayRandomSound from: ORBIT_SOUND1, ORBIT_SOUND2
		array<string> sounds = {ORBIT_SOUND1, ORBIT_SOUND2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		NEXT_ORBIT_SOUND = GetGameTime();
		NEXT_ORBIT_SOUND += 3.0;
	}

	void setup_cl()
	{
		ClientEvent("new", "all", "monsters/summon/slime_globe_cl", GetEntityOrigin(GetOwner()), 13.0);
		MY_CL_IDX = "game.script.last_sent_id";
	}

	void shoot_slime()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "shoot_slime");
		GLOB_TARG = "none";
		string TARG_LIST = FindEntitiesInSphere("enemy", 1200);
		if (!(TARG_LIST != "none")) return;
		ScrambleTokens(TARG_LIST, ";");
		string CUR_TARG = GetToken(TARG_LIST, 0, ";");
		GLOB_TARG = CUR_TARG;
		SetMoveDest(CUR_TARG);
		TossProjectile("proj_glob_guided", "view", CUR_TARG, 400, 0, 1, "none");
		if (!(GetGameTime() > NEXT_ORBIT_SOUND)) return;
		// PlayRandomSound from: ORBIT_SOUND1, ORBIT_SOUND2
		array<string> sounds = {ORBIT_SOUND1, ORBIT_SOUND2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		EmitSound(GetOwner(), 2, SOUND_SHOOT, 10);
		NEXT_ORBIT_SOUND = GetGameTime();
		NEXT_ORBIT_SOUND += 3.0;
	}

	void end_slime()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(5.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void ext_glob_landed()
	{
		XDoDamage(param1, 96, MY_DMG, 0.2, MY_OWNER, MY_OWNER, "none", "acid_effect", "dmgevent:glob");
	}

	void early_remove()
	{
		ClientEvent("update", "all", MY_CL_IDX, "early_remove");
		end_slime();
	}

	void ext_mommy_died()
	{
		early_remove();
	}

}

}
