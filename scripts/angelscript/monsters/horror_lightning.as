#pragma context server

#include "monsters/horror_lightning2.as"

namespace MS
{

class HorrorLightning : CGameScript
{
	float BASE_MOVESPEED;
	int BREATH_AMMO;
	int SPIT_AMMO;

	HorrorLightning()
	{
		const int NPC_BASE_EXP = 200;
		const int DMG_PROJECTILE = 50;
		const string PROJ_SCRIPT = "proj_lightning_ball";
		const int PROJ_SPEED = 200;
		const float PROJ_FOV = 0.5;
		const string FX_BURST_SCRIPT = "effects/sfx_shock_burst";
		const string EFFECT_DOT = "effects/dot_lightning";
		const float DUR_DOT = 5.0;
		const int DMG_DOT = 30;
		const int DMG_BITE = 100;
		const int DMG_BLAST = 100;
		const Vector3 ELEMENT_COLOR = Vector3(255, 255, 0);
		const string BURST_ELEMENT = "lightning_effect";
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
