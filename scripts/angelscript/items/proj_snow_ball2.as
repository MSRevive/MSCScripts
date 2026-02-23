#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjSnowBall2 : CGameScript
{
	int DID_ICE_SPIKES;
	string DMG_ICE;
	int DMG_SET;
	string ICE_AMT;
	string ICE_RADIUS;

	ProjSnowBall2()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 9;
		const int MODEL_BODY_OFS = 9;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const string PROJ_DAMAGE = RandomInt(60, 90);
		const int PROJ_STICK_DURATION = 0;
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
		SetName("Ice Boulder");
		SetDescription("A giant rock");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.4);
		SetGroupable(25);
	}

	void projectile_landed()
	{
		if ((DID_ICE_SPIKES)) return;
		ice_spikes(GetEntityOrigin(GetOwner()));
	}

	void game_projectile_hitnpc()
	{
		if ((DID_ICE_SPIKES)) return;
		ice_spikes(GetEntityOrigin(param1));
	}

	void ice_spikes()
	{
		DID_ICE_SPIKES = 1;
		Effect("screenshake", param1, 100, 5, 3, 500);
		string SPRITE_START = param1;
		string SPRITE_DEST = SPRITE_START;
		SPRITE_DEST += "z";
		Effect("tempent", "trail", "blueflare1.spr", SPRITE_START, SPRITE_DEST, 2, 0.1, 9, 30, 0);
		string MY_OWNER = GetEntityIndex("ent_expowner");
		if (!(DMG_SET))
		{
			string DMG_ICE = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			string ICE_RADIUS = GetSkillLevel(MY_OWNER, "spellcasting.ice");
			ICE_RADIUS *= 10;
			int ICE_AMT = 10;
			ICE_AMT += DMG_ICE;
		}
		string SPAWN_POS = param1;
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(SPAWN_POS);
		SPAWN_POS = "z";
		SpawnNPC("monsters/summon/ice_spikes", SPAWN_POS, ScriptMode::Legacy); // params: MY_OWNER, DMG_ICE, ICE_RADIUS, ICE_AMT, "spellcasting.ice"
		ScheduleDelayedEvent(0.1, "vanish");
	}

	void set_dmg()
	{
		DMG_SET = 1;
		DMG_ICE = param1;
		ICE_RADIUS = param2;
		ICE_AMT = param3;
		SetGravity(param4);
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
		EmitSound(GetOwner(), "const.snd.body", "fire.wav", "const.snd.fullvol");
		if (!(param1)) return;
		CallExternal(param2, "hit_by_siege");
	}

}

}
