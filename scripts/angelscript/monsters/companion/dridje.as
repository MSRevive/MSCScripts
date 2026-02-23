#pragma context server

namespace MS
{

class Dridje : CGameScript
{
	int CUR_ROT;
	string MY_LIGHT_SCRIPT;
	string MY_OWNER;
	int PLAYING_DEAD;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	int SPAWN_ZAP;

	Dridje()
	{
		const float FREQ_ROTATE = 0.1;
		const string FREQ_ZAP = Random(10, 60);
		const int ROAM_DISTANCE = 28;
		const int ROAM_HEIGHT = 0;
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart15.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const Vector3 GLOW_COLOR = Vector3(255, 255, 0);
		const int GLOW_RAD = 64;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_ZAP);
		zap_dridje(MY_OWNER);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_ROTATE);
		string DEST_POS = GetEntityOrigin(MY_OWNER);
		CUR_ROT += 5;
		if (CUR_ROT > 359)
		{
			CUR_ROT -= 359;
		}
		DEST_POS += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ROT, 0), Vector3(0, ROAM_DISTANCE, ROAM_HEIGHT));
		SetEntityOrigin(GetOwner(), DEST_POS);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
	}

	void OnSpawn() override
	{
		SetName("The Mighty Sphere of Dridje");
		SetName("dridje_sphere");
		SetBlind(true);
		SetFly(true);
		SetInvincible(true);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 13);
		SetSolid("none");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 64);
		CatchSpeech("zap_dridje", "zap");
		CatchSpeech("go_away", "vanish");
		PLAYING_DEAD = 1;
		SetIdleAnim("spin_horizontal_norm");
		CUR_ROT = 0;
		ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()));
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
		SPAWN_ZAP = 1;
		ScheduleDelayedEvent(0.1, "zap_dridje");
	}

	void go_away()
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		SayText("Yes , my master...");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void zap_dridje()
	{
		if (param1 == MY_OWNER)
		{
			int ZAP_GO = 1;
		}
		if (GetEntityIndex("ent_lastspoke") == MY_OWNER)
		{
			if (param1 != MY_OWNER)
			{
			}
			SayText("Yes master...");
			int ZAP_GO = 1;
		}
		if ((SPAWN_ZAP))
		{
			SPAWN_ZAP = 0;
			int ZAP_GO = 1;
		}
		if (!(ZAP_GO)) return;
		Effect("beam", "ents", "lgtning.spr", 20, GetOwner(), 0, MY_OWNER, 1, Vector3(255, 255, 0), 200, 200, 3.0);
		Effect("beam", "ents", "lgtning.spr", 20, GetOwner(), 0, MY_OWNER, 2, Vector3(255, 255, 0), 200, 200, 3.0);
		SetModelBody(0, 16);
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		Effect("glow", MY_OWNER, Vector3(255, 255, 0), 128, 8.0, 10.0);
		ScheduleDelayedEvent(2.0, "zap_down");
	}

	void zap_down()
	{
		SetModelBody(0, 13);
	}

	void client_activate()
	{
		SKEL_ID = param1;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
	}

}

}
