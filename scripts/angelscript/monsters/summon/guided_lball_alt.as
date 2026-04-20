#pragma context server

namespace MS
{

class GuidedLballAlt : CGameScript
{
	string DMG_TYPE;
	string DOT_DMG;
	string EXPIRE_TIME;
	string GAME_PVP;
	int IS_ACTIVE;
	string MAX_DURATION;
	string MY_DMG;
	string MY_OWNER;
	string MY_RADIUS;
	string MY_TARGET;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string SCAN_TOKENS;
	string SKILL_TYPE;
	string SOUND_LOOP;
	int SPHERE_SPEED;

	GuidedLballAlt()
	{
		SPHERE_SPEED = 30;
		DMG_TYPE = "lightning";
		SOUND_LOOP = "magic/bolt_loop.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.25);
		if ((IS_ACTIVE))
		{
		}
		if (!(IsEntityAlive(MY_TARGET)))
		{
			pick_target();
		}
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ORG = GetEntityOrigin(MY_TARGET);
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
		ANG_TO_TARG = "x";
		string DEST_ORG = MY_ORG;
		DEST_ORG += /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, SPHERE_SPEED, 0));
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, SPHERE_SPEED, 0)));
		string WALL_CHECK = TraceLine(MY_ORG, DEST_ORG);
		if (WALL_CHECK != DEST_ORG)
		{
			sphere_explode();
		}
		if (GetGameTime() > EXPIRE_TIME)
		{
			if ((IS_ACTIVE))
			{
			}
			sphere_explode();
		}
		if ((IS_ACTIVE))
		{
			SCAN_TOKENS = FindEntitiesInSphere("enemy", 64);
			if (SCAN_TOKENS != "none")
			{
			}
			sphere_explode();
		}
		if ((IS_ACTIVE))
		{
			SetEntityOrigin(GetOwner(), DEST_ORG);
		}
	}

	void OnSpawn() override
	{
		SetName("Lightning Sphere");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 18);
		SetWidth(16);
		SetHeight(16);
		SetSolid("none");
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		SetRoam(false);
		SetGravity(0);
		SetIdleAnim("spin_horizontal_slow");
		SetMoveAnim("spin_horizontal_slow");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		// svplaysound: svplaysound 1 5 SOUND_LOOP
		EmitSound(1, 5, SOUND_LOOP);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DMG = param2;
		MY_RADIUS = param3;
		MAX_DURATION = param4;
		DOT_DMG = MY_DMG;
		DOT_DMG *= 0.1;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		GAME_PVP = "game.pvp";
		EXPIRE_TIME = GetGameTime();
		EXPIRE_TIME += MAX_DURATION;
		SKILL_TYPE = "none";
		if ((OWNER_ISPLAYER))
		{
			SKILL_TYPE = param5;
		}
		SetRace(GetEntityRace(MY_OWNER));
		ScheduleDelayedEvent(0.1, "pick_target");
	}

	void pick_target()
	{
		string NME_TOKENS = FindEntitiesInSphere("enemy", 1024);
		if (NME_TOKEN != "none")
		{
			ScrambleTokens(NME_TOKEN, ";");
			MY_TARGET = GetToken(NME_TOKEN, 0, ";");
		}
		if (!(IsEntityAlive(MY_TARGET)))
		{
			MY_TARGET = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		IS_ACTIVE = 1;
	}

	void sphere_explode()
	{
		if (!(IS_ACTIVE)) return;
		IS_ACTIVE = 0;
		// svplaysound: svplaysound 1 0 SOUND_LOOP
		EmitSound(1, 0, SOUND_LOOP);
		ClientEvent("new", "all", "monsters/summon/guided_lball_alt_cl", GetEntityOrigin(GetOwner()), MY_RADIUS);
		XDoDamage(GetEntityOrigin(GetOwner()), MY_RADIUS, MY_DMG, 0, MY_OWNER, MY_OWNER, SKILL_TYPE, DMG_TYPE);
		ScheduleDelayedEvent(0.01, "remove_me");
		SCAN_TOKENS = FindEntitiesInSphere("enemy", 256);
		if (!(SCAN_TOKENS != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_TOKENS, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CUR_TARG = GetToken(SCAN_TOKENS, i, ";");
		if ((OWNER_ISPLAYER))
		{
			if (!(GAME_PVP))
			{
			}
			if ((IsValidPlayer(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, MY_OWNER, DOT_DMG, SKILL_TYPE);
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
