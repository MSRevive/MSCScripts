#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjLavaRock : CGameScript
{
	int DID_SPLODIE;
	string FINAL_DOT;
	string FINAL_OWNER;

	ProjLavaRock()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 67;
		const int MODEL_BODY_OFS = 67;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 1;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const string SOUND_HITWALL1 = "fire.wav";
		const string SOUND_HITWALL2 = "fire.wav";
		const string PROJ_DAMAGE_TYPE = "siege";
		const string PROJ_DAMAGE = RandomInt(200, 300);
		const int PROJ_AOE_RANGE = 200;
		const int PROJ_AOE_FALLOFF = 1;
		Precache("rockgibs.mdl");
	}

	void arrow_spawn()
	{
		SetName("Molten Boulder");
		SetDescription("A giant ball of lava");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.4);
		SetGroupable(25);
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, -1, -1);
	}

	void game_tossprojectile()
	{
		FINAL_OWNER = GetEntityProperty("ent_expowner", "scriptvar");
		FINAL_DOT = GetEntityProperty("ent_expowner", "scriptvar");
		FINAL_DOT *= 0.25;
	}

	void projectile_landed()
	{
		if (!(true)) return;
		go_splodie();
	}

	void go_splodie()
	{
		if ((DID_SPLODIE)) return;
		DID_SPLODIE = 1;
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		ClientEvent("new", "all", "effects/sfx_fire_burst", GetEntityOrigin(GetOwner()), 200, 1, Vector3(255, 0, 0));
		ScheduleDelayedEvent(0.1, "vanish");
	}

	void game_projectile_hitnpc()
	{
		if (!(true)) return;
		go_splodie();
	}

	void vanish()
	{
		DeleteEntity(GetOwner());
	}

	void hitwall()
	{
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
	}

	void game_dodamage()
	{
		LogDebug("game_dodamage GetEntityName(param2) GetEntityName(FINAL_OWNER)");
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, FINAL_OWNER, FINAL_DOT);
	}

}

}
