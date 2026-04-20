#pragma context server

#include "monsters/summon/fire_ball_guided.as"

namespace MS
{

class LightningBallGuided : CGameScript
{
	int AM_LIGHTNING;
	int IS_ACTIVE;
	string MY_LIGHT_SCRIPT;
	int MY_SPEED;
	int PLAYING_DEAD;
	string PUSH_LIST;
	string SOUND_EXPLODE;
	string SOUND_SPAWN;
	string SPRITE_EXPLODE;

	LightningBallGuided()
	{
		SOUND_SPAWN = "debris/beamstart4.wav";
		SOUND_EXPLODE = "ambience/alienlaser1.wav";
		SPRITE_EXPLODE = "xfire2.spr";
		MY_SPEED = 100;
		AM_LIGHTNING = 1;
	}

	void OnSpawn() override
	{
		SetName("ball lightning");
		SetHealth(30);
		SetFly(true);
		SetWidth(32);
		SetHeight(32);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 15);
		SetInvincible(2);
		PLAYING_DEAD = 1;
		SetMonsterClip(0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		EmitSound(GetOwner(), 0, SOUND_SPAWN, 10);
		SetIdleAnim("spin_horizontal_norm");
		SetSolid("none");
		ClientEvent("new", "all", "monsters/summon/guided_ball_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0));
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void go_splodie()
	{
		ScheduleDelayedEvent(0.1, "remove_me");
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		SetModel("none");
		XDoDamage(GetMonsterProperty("origin"), MY_AOE, MY_BASE_DMG, 0.1, MY_OWNER, MY_OWNER, "spellcasting.lightning", "lightning");
		PUSH_LIST = FindEntitiesInSphere("enemy", MY_AOE);
		if (PUSH_LIST != "none")
		{
			for (int i = 0; i < GetTokenCount(PUSH_LIST, ";"); i++)
			{
				push_loop();
			}
		}
		// PlayRandomSound from: SOUND_EXPLODE
		array<string> sounds = {SOUND_EXPLODE};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		IS_ACTIVE = 0;
	}

	void push_loop()
	{
		string CUR_TARGET = GetToken(PUSH_LIST, i, ";");
		LogDebug("push_loop GetEntityName(CUR_TARGET) of PUSH_LIST");
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 500, 0)));
		Effect("screenfade", CUR_TARGET, 3, 1, Vector3(255, 255, 255), 255, "fadein");
	}

}

}
