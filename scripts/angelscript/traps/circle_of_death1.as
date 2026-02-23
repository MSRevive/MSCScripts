#pragma context server

#include "monsters/debug.as"

namespace MS
{

class CircleOfDeath1 : CGameScript
{
	string CIRCLE_END;
	string CL_DUR;
	string DMG_PULSE;
	int IS_ACTIVE;
	int NPC_DIE_ON_SPAWN_REMOVAL;
	int PLAYING_DEAD;
	int SKEL_RESPAWN_TIMES;

	CircleOfDeath1()
	{
		const int CIRCLE_RAD = 90;
		const int CL_BODY = 3;
		const int CL_RAD = 98;
		const string CIRCLE_DMG_TYPE = "dark_effect";
		const string SOUND_LOOP = "ambience/pulsemachine.wav";
	}

	void OnSpawn() override
	{
		SetName("Circle of Death");
		SetInvincible(true);
		SetNoPush(true);
		SetSolid("none");
		SetRace("undead");
		PLAYING_DEAD = 1;
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.5, "circle_loop");
	}

	void game_postspawn()
	{
		if ((param4).length() < 2)
		{
			int L_AUTO_SET = 1;
		}
		if (param4 == "PARAM4")
		{
			int L_AUTO_SET = 1;
		}
		if ((L_AUTO_SET))
		{
			DMG_PULSE = "auto";
			CIRCLE_END = 10.0;
		}
		else
		{
			DMG_PULSE = GetToken(param4, 0, ";");
			CIRCLE_END = GetToken(param4, 1, ";");
		}
		LogDebug("game_postspawn L_AUTO_SET DMG_PULSE CIRCLE_END");
		if (CIRCLE_END <= 0)
		{
			CIRCLE_END = 9999;
		}
		CL_DUR = CIRCLE_END;
		CIRCLE_END += GetGameTime();
		NPC_DIE_ON_SPAWN_REMOVAL = 1;
	}

	void game_dynamically_created()
	{
		DMG_PULSE = "auto";
		CIRCLE_END = 10.0;
		CL_DUR = CIRCLE_END;
		CIRCLE_END += GetGameTime();
	}

	void circle_loop()
	{
		if ((IS_ACTIVE))
		{
			ScheduleDelayedEvent(1.0, "circle_loop");
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		string L_DMG_PULSE = DMG_PULSE;
		if (DMG_PULSE == "auto")
		{
			string L_DMG_PULSE = "game.players.totalhp";
			L_DMG_PULSE /= GetPlayerCount();
			L_DMG_PULSE *= 0.1;
			LogDebug("circle_loop auto L_DMG_PULSE CIRCLE_POS");
		}
		string L_DMG_POINT = CIRCLE_POS;
		L_DMG_POINT += "z";
		XDoDamage(L_DMG_POINT, CIRCLE_RAD, L_DMG_PULSE, 0, GetOwner(), GetOwner(), "none", CIRCLE_DMG_TYPE);
		if (GetGameTime() > CIRCLE_END)
		{
			npc_suicide();
		}
		else
		{
			if (GetGameTime() > NEXT_CL_UPDATE)
			{
				// svplaysound: svplaysound 1 10 SOUND_LOOP
				EmitSound(1, 10, SOUND_LOOP);
				CIRCLE_POS = GetEntityOrigin(GetOwner());
				CIRCLE_POS = "z";
				ClientEvent("persist", "all", "effects/sfx_cod", CIRCLE_POS, CL_DUR, CL_BODY, CL_RAD);
				CL_IDX = "game.script.last_sent_id";
				NEXT_CL_UPDATE = GetGameTime();
				NEXT_CL_UPDATE += CL_DUR;
			}
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		IS_ACTIVE = 0;
		ClientEvent("update", "all", CL_IDX, "end_fx");
		// svplaysound: svplaysound 1 0 SOUND_LOOP
		EmitSound(1, 0, SOUND_LOOP);
	}

	void npc_suicide()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((I_R_COMPANION)) return;
		string SINCE_SPAWN = GetGameTime();
		SINCE_SPAWN -= NPC_SPAWN_TIME;
		if (SINCE_SPAWN < 2.0)
		{
			if (param1 == "dienow")
			{
				SetAnimFrameRate(0);
				SetAnimMoveSpeed(0);
				NPC_OVERRIDE_DEATH = 1;
				DeleteEntity(GetOwner(), true); // fade out
				int EXIT_SUB = 1;
			}
			else
			{
				NPC_QUED_FOR_DEATH = 1;
				ScheduleDelayedEvent(2.1, "npc_suicide");
				LogDebug("npc_suicide - not_ready_to_die - qued for death");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (param1 == "no_pets")
		{
			if ((I_R_PET))
			{
			}
			int EXIT_SUB = 1;
		}
		if (param1 == "only_bad")
		{
			if (GetEntityRace(GetOwner()) == "human")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "hguard")
			{
				int EXIT_SUB = 1;
			}
			if (GetEntityRace(GetOwner()) == "beloved")
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		SetInvincible(false);
		SetRace("hated");
		SKEL_RESPAWN_TIMES = 99;
		DoDamage(GetOwner(), "direct", 99999, 100, GAME_MASTER);
	}

}

}
