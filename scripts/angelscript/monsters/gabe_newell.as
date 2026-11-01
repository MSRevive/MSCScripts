#pragma context server

#include "monsters/base_flyer_grav.as"
#include "monsters/base_propelled.as"

namespace MS
{

class GabeNewell : CGameScript
{
	string AS_LAST_POS;
	int AS_LAST_POS_SET;
	string CHOSEN_PLAYER;
	int IS_ACTIVE;
	string NEXT_MUSAK;
	string NEXT_WARN;
	int NPC_HACKED_MOVE_SPEED;
	int PLAYING_DEAD;

	GabeNewell()
	{
		NPC_HACKED_MOVE_SPEED = 75;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		if ((IS_ACTIVE))
		{
		}
		PlayAnim("once", "spin_horizontal_slow");
		SetAnimFrameRate(0.25);
		if (GetGameTime() > NEXT_MUSAK)
		{
			EmitSound(GetOwner(), 1, "gabe_loop.wav", 10);
			NEXT_MUSAK = GetGameTime();
			NEXT_MUSAK += 15.0;
		}
		ClientEvent("new", "all", "monsters/gabe_newell_cl", GetEntityIndex(GetOwner()), 4.9);
	}

	void OnSpawn() override
	{
		SetName("Gabe Newell");
		SetRace("demon");
		PLAYING_DEAD = 1;
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 65);
		SetWidth(8);
		SetHeight(8);
		IS_ACTIVE = 1;
		SetInvincible(true);
		SetHealth(9999);
		SetIdleAnim("spin_horizontal_slow");
		SetMoveAnim("spin_horizontal_slow");
		PlayAnim("once", "spin_horizontal_slow");
		SetAnimFrameRate(0.25);
		SetMonsterClip(0);
		EmitSound(GetOwner(), 1, "gabe_loop.wav", 10);
		ClientEvent("new", "all", "monsters/gabe_newell_cl", GetEntityIndex(GetOwner()), 4.9);
		ScheduleDelayedEvent(0.1, "pick_player");
		ScheduleDelayedEvent(5.0, "npcatk_hunt");
	}

	void pick_player()
	{
		GetAllPlayers(PLAYER_LIST);
		string N_PLAYERS = GetTokenCount(PLAYER_LIST, ";");
		N_PLAYERS -= 1;
		int RND_PLAYER = RandomInt(0, N_PLAYERS);
		CHOSEN_PLAYER = GetToken(PLAYER_LIST, RND_PLAYER, ";");
		if (CHOSEN_PLAYER == G_LAST_GABE_TARGET)
		{
			CHOSEN_PLAYER = "unset";
		}
		if (!(CHOSEN_PLAYER != "unset")) return;
		string OUT_TITLE = "Gabe Newell is out to eat ";
		OUT_TITLE += GetEntityName(CHOSEN_PLAYER);
		string OUT_MSG = "If he catches you, he will deleted your character!";
		SendInfoMsg("all", OUT_MSG + OUT_TITLE);
		SetGlobalVar("G_LAST_GABE_TARGET", CHOSEN_PLAYER);
		CallExternal("players", "ext_gabe_musak");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "npcatk_hunt");
		if (!((CHOSEN_PLAYER !is null)))
		{
			pick_player();
		}
		if (!((CHOSEN_PLAYER !is null))) return;
		SetMoveDest(CHOSEN_PLAYER);
		if (GetEntityRange(CHOSEN_PLAYER) < 512)
		{
			if (GetGameTime() > NEXT_WARN)
			{
			}
			NEXT_WARN = GetGameTime();
			NEXT_WARN += 15.0;
			SendInfoMsg(CHOSEN_PLAYER, "GABE NEWELL IS TRYING TO EAT YOU! Run you fool! He'll delete your character!");
			CallExternal("players", "ext_gabe_musak");
		}
		if (GetEntityRange(CHOSEN_PLAYER) < 64)
		{
			do_omnomnom();
		}
		if (NPC_HACKED_MOVE_SPEED < 250)
		{
			if (GetEntityRange(CHOSEN_PLAYER) < 1024)
			{
			}
			NPC_HACKED_MOVE_SPEED += 0.02;
		}
		if (!(IS_ACTIVE)) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (Distance(AS_LAST_POS, MY_ORG) < 1)
		{
			LogDebug("anti-stuck");
			if ((AS_LAST_POS_SET))
			{
			}
			float RND_DIR = Random(0, 359.99);
			float RND_UD = Random(-200, 200);
			AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, RND_DIR, 0), Vector3(0, 500, RND_UD)));
		}
		AS_LAST_POS = MY_ORG;
		AS_LAST_POS_SET = 1;
	}

	void do_omnomnom()
	{
		IS_ACTIVE = 0;
		EmitSound(GetOwner(), 1, "gabe_loop.wav", 0);
		SetProp(GetOwner(), "renderamt", 0);
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, -20000));
		// TODO: hud.addimgicon CHOSEN_PLAYER gabe1 gabe1 15 20 75 60 9.0
		SendColoredMessage(CHOSEN_PLAYER, "OMG! Character gonna delete!");
		ScheduleDelayedEvent(10.1, "do_omnomnom2");
	}

	void do_omnomnom2()
	{
		SetGlobalVar("G_APRIL_FOOLS_MODE", 0);
		CallExternal("players", "ext_gabe_musak", "stop");
		// TODO: hud.addimgicon CHOSEN_PLAYER gabe2 gabe2 15 20 75 60 10.0
		SendColoredMessage(CHOSEN_PLAYER, "OMG! APRIL FOOLS! (- The RKS Crew)");
		ScheduleDelayedEvent(1.0, "do_omnomnom3");
	}

	void do_omnomnom3()
	{
		DeleteEntity(GetOwner());
	}

}

}
