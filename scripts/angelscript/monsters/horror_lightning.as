#pragma context server

#include "monsters/horror_lightning2.as"

namespace MS
{

class HorrorLightning : CGameScript
{
	float BASE_MOVESPEED;
	int BREATH_AMMO;
	string BURST_ELEMENT;
	int DMG_BITE;
	int DMG_BLAST;
	int DMG_DOT;
	int DMG_PROJECTILE;
	float DUR_DOT;
	string EFFECT_DOT;
	string ELEMENT_COLOR;
	string FX_BURST_SCRIPT;
	int NPC_BASE_EXP;
	float PROJ_FOV;
	string PROJ_SCRIPT;
	int PROJ_SPEED;
	int SPIT_AMMO;

	HorrorLightning()
	{
		NPC_BASE_EXP = 200;
		DMG_PROJECTILE = 50;
		PROJ_SCRIPT = "proj_lightning_ball";
		PROJ_SPEED = 200;
		PROJ_FOV = 0.5;
		FX_BURST_SCRIPT = "effects/sfx_shock_burst";
		EFFECT_DOT = "effects/dot_lightning";
		DUR_DOT = 5.0;
		DMG_DOT = 30;
		DMG_BITE = 100;
		DMG_BLAST = 100;
		ELEMENT_COLOR = Vector3(255, 255, 0);
		BURST_ELEMENT = "lightning_effect";
	}

	void horror_spawn()
	{
		SetName("Lightning Horror");
		SetHealth(500);
		SetWidth(32);
		SetHeight(32);
		SetRoam(true);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(11);
		SetModel("monsters/edwardgorey2.mdl");
		SetModelBody(0, 2);
		SetMoveSpeed(3.0);
		BASE_MOVESPEED = 3.0;
		PlayAnim("once", ANIM_WALK);
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("acid", 2.0);
		SPIT_AMMO = 3;
		BREATH_AMMO = 1;
	}

}

}
