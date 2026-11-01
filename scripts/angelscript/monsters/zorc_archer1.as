#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class ZorcArcher1 : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	string ARROW_TYPE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int BO_ZOMBIE_MODE;
	int DMG_BOW;
	int DMG_KICK;
	int DMG_SMASH;
	int DMG_SWIPE;
	int DOING_KICK;
	int KICK_TYPE;
	int NO_STUCK_CHECKS;
	int NPC_BASE_EXP;
	string SOUND_BOW;

	ZorcArcher1()
	{
		NPC_BASE_EXP = 200;
		DMG_BOW = 400;
		DMG_SMASH = 200;
		DMG_SWIPE = 100;
		DMG_KICK = 100;
		BO_ZOMBIE_MODE = 1;
		ARROW_TYPE = "proj_arrow_npc_dyn";
		SOUND_BOW = "monsters/archer/bow.wav";
	}

	void orc_spawn()
	{
		SetHealth(3000);
		SetName("Undead Orc Archer");
		SetHearingSensitivity(2);
		SetDamageResistance("all", ".8");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("fire", 1.25);
		SetAnimFrameRate(0.75);
		BASE_FRAMERATE = 0.75;
		SetRace("undead");
		DOING_KICK = 0;
		KICK_TYPE = 1;
		SetModelBody(0, 3);
		SetModelBody(1, 0);
		SetModelBody(2, 3);
		SetProp(GetOwner(), "skin", 1);
	}

	void ext_arrow_hit()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 200, 110));
	}

	void set_turret()
	{
		if (!(NO_STUCK_CHECKS))
		{
			ScheduleDelayedEvent(0.1, "set_turret");
		}
		SetMoveSpeed(0.0);
		BASE_MOVESPEED = 0.0;
		SetMoveAnim(ANIM_IDLE);
		SetRoam(false);
		NO_STUCK_CHECKS = 1;
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
	}

}

}
