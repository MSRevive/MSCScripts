#pragma context server

namespace MS
{

class BaseGlow : CGameScript
{
	string MY_LIGHT;
	string MY_LIGHT_SCRIPT;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	BaseGlow()
	{
		const Vector3 GLOW_COLOR = Vector3(255, 255, 128);
		const int GLOW_RAD = 200;
	}

	void OnSpawn() override
	{
		ClientEffect("persists", "player/player_conartist", "glow", GetEntityIndex(GetOwner()), GLOW_COLOR, GLOW_RAD);
		MY_LIGHT = "game.script.last_light_id";
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEffect("remove", "all", MY_LIGHT);
		ClientEffect("remove", "all", MY_LIGHT_SCRIPT);
	}

	void client_activate()
	{
		SKEL_ID = param1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		if (!(GetMonsterProperty("isalive") == 1)) return;
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, 256, Vector3(0, 255, 0), 5.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEffect("remove", SKEL_LIGHT_ID);
	}

}

}
