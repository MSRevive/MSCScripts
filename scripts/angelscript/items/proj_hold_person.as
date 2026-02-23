#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjHoldPerson : CGameScript
{
	string GAME_PVP;
	string HOLD_DMG;
	string HOLD_DURATION;
	string MY_BEAM_ID;

	ProjHoldPerson()
	{
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 2;
		const int MODEL_BODY_OFS = 2;
		const string PROJ_ANIM_IDLE = "idle_iceball";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const string SOUND_LOOP = "ambience/pulsemachine.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const int HITWALL_VOL = 2;
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 0;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "magic";
		const int PROJ_COLLIDEHITBOX = 1;
		const string PROJ_ANIM_IDLE = "none";
		const int SCAN_RANGE = 96;
	}

	void arrow_spawn()
	{
		SetName("Hold Person Spell");
		SetDescription("A paralyzing ball of magic");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 2);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 200);
		SetProp(GetOwner(), "rendercolor", Vector3(255, 128, 0));
		GAME_PVP = "game.pvp";
	}

	void game_fall()
	{
	}

	void game_projectile_hitnpc()
	{
		ApplyEffect(m_hLastStruckByMe, "effects/debuff_hold", HOLD_DURATION);
		remove_me();
	}

	void game_tossprojectile()
	{
		HOLD_DURATION = GetEntityProperty("ent_expowner", "scriptvar");
		HOLD_DMG = GetEntityProperty("ent_expowner", "scriptvar");
		if (HOLD_DURATION == "PROJ_HOLD_DURATION")
		{
			HOLD_DURATION = 30.0;
		}
		if (HOLD_DMG == "PROJ_HOLD_DMG")
		{
			HOLD_DMG = 0;
		}
		// svplaysound: svplaysound 1 10 SOUND_LOOP
		EmitSound(1, 10, SOUND_LOOP);
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 0, "ent_expowner", 1, Vector3(255, 255, 255), 200, 100, 10.0);
		MY_BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

	void game_projectile_hitwall()
	{
		remove_me();
	}

	void game_projectile_landed()
	{
		remove_me();
	}

	void remove_me()
	{
		Effect("beam", "update", MY_BEAM_ID, "remove", 0.1);
		// svplaysound: svplaysound 1 0 SOUND_LOOP
		EmitSound(1, 0, SOUND_LOOP);
	}

}

}
