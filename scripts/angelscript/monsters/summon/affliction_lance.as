#pragma context server

#include "monsters/summon/base_aoe2.as"

namespace MS
{

class AfflictionLance : CGameScript
{
	string AOE_ACTIVE;
	string AOE_DURATION;
	string AOE_OWNER;
	string CUR_PITCH;
	string DOT_POISON;
	string MY_END_TIME;
	string MY_FX;
	string MY_OWNER;
	int PLAYING_DEAD;

	AfflictionLance()
	{
		const int AOE_RADIUS = 255;
		const float AOE_SCAN_FREQ = 1.0;
		const int AOE_VADJ = 32;
		const int AOE_AFFECTS_WARY = 1;
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetWidth(2);
		SetHeight(96);
		SetSolid("none");
		PLAYING_DEAD = 1;
		SetBlind(true);
		SetFly(true);
		SetGravity(0);
	}

	void game_dynamically_created()
	{
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 70);
		MY_OWNER = param1;
		string SPAWN_ORG = param2;
		AOE_DURATION = param4;
		SPAWN_ORG += "z";
		SetEntityOrigin(GetOwner(), SPAWN_ORG);
		SetIdleAnim("axis_spin");
		PlayAnim("once", "axis_spin");
		SetScriptFlags(MY_OWNER, "add", "pole_a", "Affliction Lance", GetEntityIndex(GetOwner()), AOE_DURATION);
		CUR_PITCH = /* TODO: $vec.pitch */ $vec.pitch(param3);
		SetAngles("face");
		if (CUR_PITCH != -90)
		{
			fix_pitch_loop();
		}
		AOE_OWNER = param1;
		DOT_POISON = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		// svplaysound: svplaysound 1 10 ambience/steamjet1.wav
		EmitSound(1, 10, "ambience/steamjet1.wav");
		ClientEvent("new", "all", "monsters/summon/affliction_lance_cl", GetEntityIndex(GetOwner()), 19.0);
		MY_FX = "game.script.last_sent_id";
		MY_END_TIME = /* TODO: $math(add) */ GetGameTime();
	}

	void fix_pitch_loop()
	{
		if (CUR_PITCH > 270)
		{
			CUR_PITCH -= 4;
		}
		if (CUR_PITCH < 270)
		{
			CUR_PITCH += 4;
		}
		if (CUR_PITCH < 290)
		{
			if (CUR_PITCH > 250)
			{
			}
			CUR_PITCH = 270;
		}
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string MY_ROLL = GetEntityProperty(GetOwner(), "angles.roll");
		SetAngles("face");
		LogDebug("fix_pitch_loop CUR_PITCH");
		if (!(CUR_PITCH != 270)) return;
		ScheduleDelayedEvent(0.1, "fix_pitch_loop");
	}

	void aoe_affect_target()
	{
		ApplyEffect(param1, "effects/dot_poison", 5.0, MY_OWNER, DOT_POISON, "polearms");
	}

	void aoe_end()
	{
		if (GetGameTime() >= MY_END_TIME)
		{
			AOE_ACTIVE = 0;
			// svplaysound: svplaysound 1 0 ambience/steamjet1.wav
			EmitSound(1, 0, "ambience/steamjet1.wav");
			DeleteEntity(GetOwner(), true); // fade out
		}
		else
		{
			ScheduleDelayedEvent(1, "aoe_end");
		}
	}

	void transfer_location()
	{
		string L_NEW_POS = param1;
		MY_END_TIME = /* TODO: $math(add) */ GetGameTime();
		ClientEvent("update", "all", MY_FX, "keep_on");
		L_NEW_POS += "z";
		SetEntityOrigin(GetOwner(), L_NEW_POS);
		SetScriptFlags(MY_OWNER, "edit", "pole_a", "Affliction Lance", GetEntityIndex(GetOwner()), AOE_DURATION);
	}

}

}
