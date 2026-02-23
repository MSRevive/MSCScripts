#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjFreezingSphere : CGameScript
{
	string FREEZE_DMG;
	string FREEZE_DUR;
	string GAME_PVP;
	int IS_ACTIVE;
	string TARGET_LIST;

	ProjFreezingSphere()
	{
		const string MODEL_HANDS = "weapons/projectiles.mdl";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 1;
		const string PROJ_ANIM_IDLE = "idle_iceball";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart14.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const string SOUND_LOOP = "ambience/pulsemachine.wav";
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const int HITWALL_VOL = 2;
		const int PROJ_MOTIONBLUR = 0;
		const int MODEL_BODY_OFS = 1;
		const int PROJ_DAMAGE = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_DAMAGE_AOE_RANGE = 0;
		const int PROJ_DAMAGE_AOE_FALLOFF = 1;
		const string PROJ_DAMAGE_TYPE = "cold";
		const int PROJ_COLLIDEHITBOX = 1;
		const int PROJ_IGNORENPC = 1;
		const string PROJ_ANIM_IDLE = "none";
		const int SCAN_RANGE = 96;
	}

	void arrow_spawn()
	{
		SetName("Freezing Sphere");
		SetDescription("A large ball of freezing magiks");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 1);
		ScheduleDelayedEvent(10.0, "remove_me");
		GAME_PVP = "game.pvp";
	}

	void game_fall()
	{
	}

	void game_projectile_hitnpc()
	{
	}

	void game_projectile_landed()
	{
		remove_me();
	}

	void game_projectile_hitwall()
	{
		remove_me();
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		remove_me();
	}

	void game_tossprojectile()
	{
		ScheduleDelayedEvent(10.0, "remove_me");
		if (!(true)) return;
		FREEZE_DMG = GetEntityProperty("ent_expowner", "scriptvar");
		FREEZE_DUR = GetEntityProperty("ent_expowner", "scriptvar");
		// svplaysound: svplaysound 2 10 SOUND_LOOP
		EmitSound(2, 10, SOUND_LOOP);
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.01, "scan_targets");
	}

	void scan_targets()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "scan_targets");
		TARGET_LIST = FindEntitiesInSphere("any", SCAN_RANGE);
		if (!(TARGET_LIST != "none")) return;
		string N_TARGETS = GetTokenCount(TARGET_LIST, ";");
		if (!(GetTokenCount(MY_ORG, ";") > 0)) return;
		if (!(N_TARGETS > 0)) return;
		for (int i = 0; i < N_TARGETS; i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CUR_TARGET = GetToken(TARGET_LIST, i, ";");
		if (!(GetRelationship(CUR_TARGET) == "enemy")) return;
		if ((GetEntityProperty(CUR_TARGET, "scriptvar"))) return;
		ApplyEffect(CUR_TARGET, "effects/dot_cold_freeze", FREEZE_DUR, GetEntityIndex("ent_expowner"), FREEZE_DMG);
	}

	void remove_me()
	{
		if ((true))
		{
			if (!(IsValidPlayer("ent_expowner")))
			{
				CallExternal("ent_expowner", "ext_ball_done");
			}
			// svplaysound: svplaysound 2 0 SOUND_LOOP
			EmitSound(2, 0, SOUND_LOOP);
			IS_ACTIVE = 0;
			DeleteEntity(GetOwner());
		}
		RemoveScript();
	}

}

}
