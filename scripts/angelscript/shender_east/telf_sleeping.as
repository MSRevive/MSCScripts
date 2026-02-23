#pragma context server

namespace MS
{

class TelfSleeping : CGameScript
{
	int DOING_LEV;
	string PLAYER_LIST;
	int QUEST_FAILED;
	int TELE_COUNT;

	TelfSleeping()
	{
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		if (!(QUEST_FAILED))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 64, 4.9);
	}

	void OnSpawn() override
	{
		SetName("sleep_elf");
		SetName("Sleeping Elf");
		SetModel("npc/elf_m_wizard.mdl");
		SetWidth(32);
		SetHeight(32);
		SetHealth(1);
		SetInvincible(true);
		SetIdleAnim("sleep_idle");
		SetMoveAnim("sleep_idle");
		PlayAnim("once", "sleep_idle");
		SetMenuAutoOpen(1);
		TELE_COUNT = 0;
		SetProp(GetOwner(), "skin", 8);
	}

	void game_precache()
	{
		Precache("bunny.spr");
		Precache("debris/beamstart7.wav");
	}

	void game_menu_getoptions()
	{
		if ((QUEST_FAILED)) return;
		if ((DOING_LEV)) return;
		string reg.mitem.title = "Wake Sleeping Elf";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "wake_elf";
	}

	void wake_elf()
	{
		DOING_LEV = 1;
		PlayAnim("hold", "lev");
		EmitSound(GetOwner(), 1, "scientist/sci_fear4.wav", 10);
		EmitSound(GetOwner(), 2, "ambience/particle_suck2.wav", 10);
		ScheduleDelayedEvent(2.0, "fade_players");
		ScheduleDelayedEvent(3.0, "tele_players");
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		SetProp(GetOwner(), "skin", 9);
	}

	void fade_players()
	{
		EmitSound(GetOwner(), 0, "scientist/scream1.wav", 10);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			fade_players_go();
		}
	}

	void fade_players_go()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_TARG) < 128)) return;
		Effect("screenfade", CUR_TARG, 3.0, 1.0, Vector3(255, 255, 255), 255, "fadein");
	}

	void tele_players()
	{
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			tele_players_go();
		}
		ScheduleDelayedEvent(1.0, "resume_idle");
	}

	void resume_idle()
	{
		PlayAnim("critical", "sleep_idle");
		SetProp(GetOwner(), "skin", 8);
		DOING_LEV = 0;
	}

	void tele_players_go()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_TARG) < 384)) return;
		if (TELE_COUNT >= 8)
		{
			TELE_COUNT = 0;
		}
		if (GetPlayerCount() < 5)
		{
			if (TELE_COUNT >= 4)
			{
				TELE_COUNT = 0;
			}
		}
		TELE_COUNT += 1;
		if (TELE_COUNT == 1)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-272, -8, -3720));
		}
		if (TELE_COUNT == 2)
		{
			SetEntityOrigin(CUR_TARG, Vector3(240, -8, -3720));
		}
		if (TELE_COUNT == 3)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-16, -264, -3720));
		}
		if (TELE_COUNT == 4)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-8, -240, -3720));
		}
		if (TELE_COUNT == 5)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-232, -8, -3720));
		}
		if (TELE_COUNT == 6)
		{
			SetEntityOrigin(CUR_TARG, Vector3(220, -8, -3720));
		}
		if (TELE_COUNT == 7)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-16, -234, -3720));
		}
		if (TELE_COUNT == 8)
		{
			SetEntityOrigin(CUR_TARG, Vector3(-8, -210, -3720));
		}
		CallExternal(CUR_TARG, "ext_delay_playsound", 0.5, 4, 10, "debris/beamstart7.wav");
	}

	void quest_fail()
	{
		QUEST_FAILED = 1;
		PlayAnim("hold", "deadback");
		SetIdleAnim("deadback");
		SetMoveAnim("deadback");
		SetName("Dead Elf");
	}

	void ext_quest_win()
	{
		DeleteEntity(GetOwner());
	}

	void ext_shender_fail()
	{
		quest_fail();
	}

}

}
