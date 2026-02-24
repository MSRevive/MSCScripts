#pragma context server

#include "monsters/base_noclip.as"

namespace MS
{

class BludgeonAxe : CGameScript
{
	string AM_RETURNING;
	int ATTACK_MOVERANGE;
	string DMG_BASE;
	string DMG_TYPE;
	string END_FLIGHT_TIME;
	float FREQ_SOUND;
	int FWD_SPEED;
	string GAME_PVP;
	string IS_ACTIVE;
	string ITEM_ID;
	string MY_DEST;
	string MY_OWNER;
	string NPC_NOCLIP_DEST;
	string OWNER_HALFHEIGHT;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int SCAN_RAD;
	string SOUND_SPIN;

	BludgeonAxe()
	{
		FWD_SPEED = 50;
		ATTACK_MOVERANGE = 80;
		SOUND_SPIN = "zombie/claw_miss2.wav";
		FREQ_SOUND = 0.3;
		DMG_TYPE = "slash";
		SCAN_RAD = 72;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_SOUND);
		if ((IS_ACTIVE))
		{
		}
		EmitSound(GetOwner(), 0, "zombie/claw_miss2.wav", 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.1);
		if ((IS_ACTIVE))
		{
		}
		if (!(AM_RETURNING))
		{
			if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) <= ATTACK_MOVERANGE)
			{
			}
			AM_RETURNING = 1;
		}
		if ((AM_RETURNING))
		{
			NPC_NOCLIP_DEST = GetEntityOrigin(MY_OWNER);
			if ((IsValidPlayer(MY_OWNER)))
			{
				NPC_NOCLIP_DEST = GetEntityProperty(MY_OWNER, "attachpos");
			}
			else
			{
				NPC_NOCLIP_DEST += "z";
			}
			if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) <= ATTACK_MOVERANGE)
			{
			}
			IS_ACTIVE = 0;
			CallExternal(ITEM_ID, "catch_axe");
			ScheduleDelayedEvent(0.1, "remove_me");
		}
		if (!(OWNER_ISPLAYER))
		{
		}
		if (GetGameTime() > END_FLIGHT_TIME)
		{
			IS_ACTIVE = 0;
			CallExternal(ITEM_ID, "catch_axe");
			ScheduleDelayedEvent(0.1, "remove_me");
		}
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DEST = param2;
		DMG_BASE = param3;
		GAME_PVP = "game.pvp";
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		ITEM_ID = MY_OWNER;
		if ((OWNER_ISPLAYER))
		{
			ITEM_ID = param4;
		}
		OWNER_HALFHEIGHT = GetEntityHeight(MY_OWNER);
		SetRace(GetEntityRace(MY_OWNER));
		if (!(OWNER_ISPLAYER))
		{
			OWNER_HALFHEIGHT /= 2;
		}
		NPC_NOCLIP_DEST = MY_DEST;
		IS_ACTIVE = 1;
		StoreEntity("ent_expowner");
		ScheduleDelayedEvent(0.1, "damage_loop");
		END_FLIGHT_TIME = GetGameTime();
		END_FLIGHT_TIME += 10.0;
	}

	void OnSpawn() override
	{
		SetName("Bludgeon Axe");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 32);
		SetIdleAnim("spin_vertical_norm");
		SetMoveAnim("spin_vertical_norm");
		SetSolid("none");
		SetWidth(32);
		SetFly(true);
		SetHeight(32);
		SetBloodType("none");
		SetInvincible(true);
		SetMonsterClip(0);
		PLAYING_DEAD = 1;
	}

	void damage_loop()
	{
		ScheduleDelayedEvent(0.1, "damage_loop");
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), SCAN_RAD, DMG_BASE, 1.0, 0.0);
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
