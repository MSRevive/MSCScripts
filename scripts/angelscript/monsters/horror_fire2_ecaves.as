#pragma context server

#include "monsters/horror_lightning2.as"

namespace MS
{

class HorrorFire2Ecaves : CGameScript
{
	float BASE_MOVESPEED;
	int BREATH_AMMO;
	string BURST_ELEMENT;
	int BURST_PUSH;
	int DMG_BITE;
	int DMG_BLAST;
	int DMG_DOT;
	int DMG_PROJECTILE;
	float DUR_DOT;
	string EFFECT_DOT;
	string ELEMENT_COLOR;
	string FX_BURST_SCRIPT;
	string NEXT_SWBEAMS_REFRESH;
	float PROJ_FOV;
	string PROJ_SCRIPT;
	int PROJ_SPEED;
	string SOUND_SHOCK1;
	string SOUND_SHOCK2;
	string SOUND_SHOCK3;
	string SOUND_SPRAY;
	int SPIT_AMMO;

	HorrorFire2Ecaves()
	{
		DMG_PROJECTILE = 100;
		PROJ_SCRIPT = "proj_fire_ball";
		PROJ_SPEED = 1000;
		PROJ_FOV = 0.5;
		FX_BURST_SCRIPT = "effects/sfx_fire_burst";
		EFFECT_DOT = "effects/dot_fire";
		DUR_DOT = 5.0;
		DMG_DOT = 30;
		DMG_BITE = 100;
		DMG_BLAST = 200;
		ELEMENT_COLOR = Vector3(255, 0, 0);
		BURST_ELEMENT = "fire_effect";
		BURST_PUSH = 1;
		SOUND_SPRAY = "magic/volcano_start.wav";
		SOUND_SHOCK1 = "magic/fireball_strike.wav";
		SOUND_SHOCK2 = "magic/fireball_strike.wav";
		SOUND_SHOCK3 = "magic/fireball_strike.wav";
	}

	void horror_spawn()
	{
		SetName("Burning Horror");
		SetHealth(1000);
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetModel("monsters/horror1_ecave.mdl");
		SetModelBody(0, 0);
		SetMoveSpeed(2.0);
		BASE_MOVESPEED = 2.0;
		PlayAnim("once", ANIM_WALK);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("cold", 2.0);
		SPIT_AMMO = 3;
		BREATH_AMMO = 1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(GetGameTime() > NEXT_SWBEAMS_REFRESH)) return;
		NEXT_SWBEAMS_REFRESH = GetGameTime();
		NEXT_SWBEAMS_REFRESH += 10.2;
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 1, 30, 10.0, 200, Vector3(255, 0, 0));
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 1, 10, 10.0, 200, Vector3(255, 128, 0));
	}

}

}
