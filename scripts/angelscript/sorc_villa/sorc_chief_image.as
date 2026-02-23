#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class SorcChiefImage : CGameScript
{
	int CHAT_MENU_ON;
	int FADE_COUNT;
	string NEAREST_PLAYER;
	string POT_GUY_ID;

	SorcChiefImage()
	{
		const int CHAT_USE_CONV_ANIMS = 0;
		CHAT_MENU_ON = 0;
		const int CHAT_AUTO_FACE = 0;
		const int CHAT_NO_CLOSE_MOUTH = 1;
	}

	void OnSpawn() override
	{
		SetName("Runegahr the Warchief");
		SetRace("orc");
		SetNoPush(true);
		SetInvincible(true);
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 0);
		SetStat("parry", 150);
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetRoam(false);
		SetSayTextRange(1024);
	}

	void game_dynamically_created()
	{
		POT_GUY_ID = GetEntityIndex(param1);
		CallExternal(POT_GUY_ID, "ext_face_chief");
		ScheduleDelayedEvent(0.01, "tele_in");
	}

	void tele_in()
	{
		ClientEvent("new", "all", "effects/sfx_repulse_burst", GetEntityOrigin(GetOwner()), 64, 1.0);
		EmitSound(GetOwner(), 1, "weather/Storm_exclamation.wav", 10);
		SetMoveDest(POT_GUY_ID);
		FADE_COUNT = 0;
		fade_in();
		ScheduleDelayedEvent(0.5, "do_rant");
	}

	void fade_in()
	{
		if (FADE_COUNT <= 255)
		{
			FADE_COUNT += 25;
			SetProp(GetOwner(), "renderamt", FADE_COUNT);
			ScheduleDelayedEvent(0.1, "fade_in");
		}
		else
		{
			SetProp(GetOwner(), "renderamt", 255);
			SetProp(GetOwner(), "rendermode", 1);
		}
	}

	void do_rant()
	{
		SetMoveDest(POT_GUY_ID);
		ScheduleDelayedEvent(1.0, "do_rant2");
	}

	void do_rant2()
	{
		SetMoveDest(POT_GUY_ID);
		chat_now("Easkhar! You sniveling swine! These are MY guests, and you WILL treat them as such!", 3.0, "swordswing1_L");
		ScheduleDelayedEvent(3.0, "get_response");
	}

	void get_response()
	{
		CallExternal(POT_GUY_ID, "ext_chief_done_berating");
		ScheduleDelayedEvent(8.0, "says_sorries");
	}

	void says_sorries()
	{
		NEAREST_PLAYER = /* TODO: $get_insphere */ $get_insphere("player", 512);
		SetMoveDest(NEAREST_PLAYER);
		chat_now("My apologies, this unenlightened thakwaw will aid you now, should you wish it.", 3.0, "nod_yes");
		ScheduleDelayedEvent(3.0, "tele_out1");
	}

	void tele_out1()
	{
		ClientEvent("new", "all", "effects/sfx_repulse_burst", GetEntityOrigin(GetOwner()), 64, 1.0);
		SetProp(GetOwner(), "rendermode", 5);
		fade_out();
		ScheduleDelayedEvent(3.5, "tele_out_done");
	}

	void tele_out_done()
	{
		LogDebug("tele_out2 sending event to GetEntityName(POT_GUY_ID)");
		CallExternal(POT_GUY_ID, "ext_chief_gone");
	}

	void fade_out()
	{
		if (FADE_COUNT > 0)
		{
			FADE_COUNT -= 25;
			SetProp(GetOwner(), "renderamt", FADE_COUNT);
			ScheduleDelayedEvent(0.1, "fade_out");
		}
		else
		{
			SetProp(GetOwner(), "renderamt", 0);
			ScheduleDelayedEvent(5.0, "remove_script");
		}
	}

	void remove_script()
	{
		DeleteEntity(GetOwner());
	}

}

}
