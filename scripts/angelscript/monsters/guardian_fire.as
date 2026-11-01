#pragma context server

#include "monsters/guardian_iron.as"

namespace MS
{

class GuardianFire : CGameScript
{
	float ANIM_RATE;
	string CHARGER_ORG;
	string CHARGE_LEVEL;
	string CL_SCRIPT_IDX;
	string DMG_ELEF_TYPE;
	int DOT_DMG;
	int GUARDIAN_BEAM_SWORD;
	string GUARDIAN_CL_SCRIPT;
	int GUARDIAN_TYPE;
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	string NEEDS_CHARGER;
	string NEXT_SWBEAMS_REFRESH;
	int PITCH_SWORD_OFF;
	string SOUND_REACH;
	string SOUND_RECHARGE_START;
	string SOUND_SWING;
	string SOUND_SWORD_DRAW;
	string SOUND_SWORD_IDLE;
	string SOUND_SWORD_OFF;

	GuardianFire()
	{
		GUARDIAN_TYPE = 2;
		GUARDIAN_BEAM_SWORD = 0;
		DMG_ELEF_TYPE = "fire_effect";
		SOUND_SWORD_IDLE = "none";
		SOUND_SWORD_DRAW = "magic/dragon_fire.wav";
		SOUND_SWORD_OFF = "weapons/swords/sworddraw.wav";
		PITCH_SWORD_OFF = 50;
		SOUND_RECHARGE_START = "magic/sff_explsonic.wav";
		SOUND_REACH = "magic/dragon_fire.wav";
		SOUND_SWING = "magic/fireball_large.wav";
		GUARDIAN_CL_SCRIPT = "monsters/guardian_fire_cl";
		DOT_DMG = 100;
	}

	void game_precache()
	{
		Precache("fire1_fixed.spr");
	}

	void guardian_spawn()
	{
		SetName("Molten Guardian");
		SetHealth(10000);
		SetModel("monsters/guardian_fire.mdl");
		SetWidth(75);
		SetHeight(200);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.25);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("stun", 0);
		IMMUNE_VAMPIRE = 1;
		IS_BLOODLESS = 1;
		SetModelBody(0, 0);
		SetRace("demon");
		SetBloodType("none");
		SetHearingSensitivity(1);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
		if (!(true)) return;
		if (G_GUARDIAN_CHARGER != "G_GUARDIAN_CHARGER")
		{
			CHARGER_ORG = G_GUARDIAN_CHARGER;
			NEEDS_CHARGER = 1;
		}
		CHARGE_LEVEL = MAX_CHARGE_LEVEL;
		ANIM_RATE = 1.0;
		ClientEvent("new", "all", GUARDIAN_CL_SCRIPT, GetEntityIndex(GetOwner()));
		CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(MELEEING)) return;
		ApplyEffect(param1, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(GetGameTime() > NEXT_SWBEAMS_REFRESH)) return;
		if (!(SWORD_STATE)) return;
		NEXT_SWBEAMS_REFRESH = GetGameTime();
		NEXT_SWBEAMS_REFRESH += 10.2;
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 2, 30, 10.0, 200, Vector3(255, 0, 0));
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 2, 10, 10.0, 200, Vector3(255, 128, 0));
	}

	void frame_attack2_start()
	{
		LogDebug("frame_attack2_start");
	}

	void frame_attack1_start()
	{
		LogDebug("frame_attack2_start");
	}

}

}
