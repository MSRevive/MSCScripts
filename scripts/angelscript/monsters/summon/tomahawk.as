#pragma context server

#include "monsters/summon/bludgeon_axe.as"

namespace MS
{

class Tomahawk : CGameScript
{
	string DMG_BASE;
	string GAME_PVP;
	int IS_ACTIVE;
	string ITEM_ID;
	string MY_DEST;
	string MY_OWNER;
	string NPC_NOCLIP_DEST;
	string OWNER_HALFHEIGHT;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string TOM_TYPE;
	string T_BOX;

	void OnSpawn() override
	{
		SetName("Tomahawk");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 39);
		SetIdleAnim("spin_vertical_norm");
		SetMoveAnim("spin_vertical_norm");
		SetSolid("none");
		SetWidth(32);
		SetFly(true);
		SetHeight(32);
		SetBloodType("none");
		SetInvincible(true);
		SetMonsterClip(0);
		SetRace("demon");
		PLAYING_DEAD = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DEST = param2;
		DMG_BASE = param3;
		TOM_TYPE = param5;
		GAME_PVP = "game.pvp";
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		SetEntityOrigin(GetOwner(), GetEntityProperty(MY_OWNER, "attachpos"));
		ITEM_ID = MY_OWNER;
		if ((OWNER_ISPLAYER))
		{
			ITEM_ID = param4;
			string DOT_SKILL = "spellcasting.";
			if (TOM_TYPE != "cold")
			{
				DOT_SKILL += TOM_TYPE;
			}
			else
			{
				DOT_SKILL += "ice";
			}
			if (TOM_TYPE != "dark")
			{
				if (TOM_TYPE == "cold")
				{
					DOT_BASE = GetSkillLevel(MY_OWNER, "spellcasting.ice");
					DOT_BASE *= 0.5;
				}
				if (TOM_TYPE == "lightning")
				{
					DOT_BASE = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
					DOT_BASE *= 0.75;
				}
				if (TOM_TYPE == "fire")
				{
					DOT_BASE = GetSkillLevel(MY_OWNER, "spellcasting.fire");
				}
				if (TOM_TYPE == "poison")
				{
					DOT_BASE = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
				}
			}
		}
		OWNER_HALFHEIGHT = GetEntityHeight(MY_OWNER);
		if (!(OWNER_ISPLAYER))
		{
			OWNER_HALFHEIGHT /= 2;
		}
		SetRace(GetEntityRace(MY_OWNER));
		NPC_NOCLIP_DEST = MY_DEST;
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "damage_loop");
		set_skin();
	}

	void set_skin()
	{
		if (TOM_TYPE == "fire")
		{
			SetProp(GetOwner(), "skin", 0);
		}
		if (TOM_TYPE == "cold")
		{
			SetProp(GetOwner(), "skin", 1);
		}
		if (TOM_TYPE == "lightning")
		{
			SetProp(GetOwner(), "skin", 2);
		}
		if (TOM_TYPE == "poison")
		{
			SetProp(GetOwner(), "skin", 3);
		}
		if (TOM_TYPE == "dark")
		{
			SetProp(GetOwner(), "skin", 4);
		}
	}

	void damage_loop()
	{
		ScheduleDelayedEvent(0.2, "damage_loop");
		T_BOX = FindEntitiesInSphere("enemy", SCAN_RAD);
		if (!(T_BOX != "none")) return;
		for (int i = 0; i < GetTokenCount(T_BOX, ";"); i++)
		{
			damage_targets();
		}
	}

	void damage_targets()
	{
		string CUR_TARGET = GetToken(T_BOX, i, ";");
		if ((IsValidPlayer(CUR_TARGET)))
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if (GAME_PVP < 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		XDoDamage(CUR_TARGET, "direct", DMG_BASE, 1.0, MY_OWNER, MY_OWNER, "axehandling", TOM_TYPE);
		if (TOM_TYPE == "cold")
		{
			ApplyEffect(CUR_TARGET, "effects/dot_cold", 5, MY_OWNER, DOT_BASE);
		}
		if (TOM_TYPE == "fire")
		{
			ApplyEffect(CUR_TARGET, "effects/dot_fire", 5, MY_OWNER, DOT_BASE);
		}
		if (TOM_TYPE == "lightning")
		{
			ApplyEffect(CUR_TARGET, "effects/dot_lightning", 5, MY_OWNER, DOT_BASE);
		}
		if (TOM_TYPE == "poison")
		{
			ApplyEffect(CUR_TARGET, "effects/dot_poison", 10.0, MY_OWNER, DOT_BASE);
		}
	}

}

}
