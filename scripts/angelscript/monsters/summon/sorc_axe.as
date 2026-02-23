#pragma context server

#include "monsters/summon/bludgeon_axe.as"

namespace MS
{

class SorcAxe : CGameScript
{
	string BASE_DOT;
	string DMG_BASE;
	string GAME_PVP;
	int IS_ACTIVE;
	string ITEM_ID;
	string MY_DEST;
	string MY_OWNER;
	string NEXT_SCAN;
	string NPC_NOCLIP_DEST;
	string OWNER_HALFHEIGHT;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string TARG_LIST;

	SorcAxe()
	{
		const string DMG_TYPE = "lightning";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void OnSpawn() override
	{
		SetName("Thunder Axe");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 34);
		SetIdleAnim("spin_horizontal_norm");
		SetMoveAnim("spin_horizontal_norm");
		SetSolid("none");
		SetWidth(32);
		SetFly(true);
		SetHeight(32);
		SetBloodType("none");
		SetInvincible(true);
		SetMonsterClip(0);
		SetRace("demon");
		PLAYING_DEAD = 1;
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, -1, 0);
		LogDebug("spawned");
	}

	void do_shock()
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if (GAME_PVP < 1)
			{
			}
			if ((IsValidPlayer(param1)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string BEAM_START = GetMonsterProperty("origin");
		string AXE_SHOCK_DOT = param2;
		Effect("beam", "end", "lgtning.spr", 30, BEAM_START, param1, 0, Vector3(255, 255, 0), 255, 30, 0.5);
		ApplyEffect(param1, "effects/dot_lightning", 3, GetEntityIndex(GetOwner()), AXE_SHOCK_DOT);
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
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
		if (!(OWNER_ISPLAYER))
		{
			OWNER_HALFHEIGHT /= 2;
		}
		SetRace(GetEntityRace(MY_OWNER));
		NPC_NOCLIP_DEST = MY_DEST;
		IS_ACTIVE = 1;
		StoreEntity("ent_expowner");
		if ((OWNER_ISPLAYER))
		{
			BASE_DOT = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
			BASE_DOT *= 0.75;
		}
		ScheduleDelayedEvent(0.1, "damage_loop");
	}

	void damage_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "damage_loop");
		if (!(OWNER_ISPLAYER))
		{
			DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), SCAN_RAD, DMG_BASE, 1.0, 0.0);
		}
		else
		{
			XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), SCAN_RAD, DMG_BASE, 0, MY_OWNER, MY_OWNER, "axehandling", "slash");
			if (GetGameTime() > NEXT_SCAN)
			{
			}
			NEXT_SCAN = GetGameTime();
			NEXT_SCAN += 0.25;
			TARG_LIST = FindEntitiesInSphere("enemy", SCAN_RAD);
			if (TARG_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(TARG_LIST, ";"); i++)
			{
				plr_zap_targets();
			}
		}
	}

	void plr_zap_targets()
	{
		string CUR_TARG = GetToken(TARG_LIST, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (GAME_PVP < 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, MY_OWNER, BASE_DOT);
	}

}

}
