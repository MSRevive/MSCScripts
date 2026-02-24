#pragma context server

#include "items/base_tome.as"

namespace MS
{

class BaseScroll : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;
	string BASE_SUMMON_TEXT_FAILED;
	int JUST_GOT;
	int MODEL_BODY;
	string SCROLL_TIME;

	BaseScroll()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		BASE_SUMMON_TEXT = "You conjure the Fire Dart spell.";
		BASE_SUMMON_TEXT_FAILED = "You lack the arcane skills to control this scroll's magic.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 0;
		MODEL_BODY = 8;
	}

	void game_precache()
	{
		Precache(SPELL_MAKER_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Dire Fart Tome");
		SetDescription("*eats all your apples* oooh~ brrrt!");
		SetValue(1);
		SetWeight(1);
		SetHand("both");
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "letter");
		scroll_spawn();
		ext_scroll_time();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		JUST_GOT = 1;
	}

	void game_attack1()
	{
		if (SCROLL_TIME > GetGameTime())
		{
		}
		else
		{
			if (GetEntityProperty(GetOwner(), "scriptvar") > GetGameTime())
			{
				SendPlayerMessage(GetOwner(), "The magic needs a moment to recharge.");
			}
			else
			{
				if (GetEntityProperty(GetOwner(), "numitems") >= G_MAX_ITEMS)
				{
					SendColoredMessage(GetOwner(), "Cannot activate scrolls when inventory is full.");
				}
				else
				{
					ext_scroll_time();
					if (!(BASE_CAN_SUMMON))
					{
						SendPlayerMessage(GetOwner(), BASE_SUMMON_TEXT_FAILED);
					}
					else
					{
						grant_spell();
					}
				}
			}
		}
	}

	void grant_spell()
	{
		string SPELL_SPAWNER_LOC = /* TODO: $relpos */ $relpos(0, 0, SPELL_MAKER_HEIGHT);
		if (SPELL_MAKER_SCRIPT != "SPELL_MAKER_SCRIPT")
		{
			SpawnNPC(SPELL_MAKER_SCRIPT, SPELL_SPAWNER_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), BASE_SPELL_SCRIPT, GetEntityProperty(GetOwner(), "itemname"), SPELL_MAKER_HEIGHT, GetEntityIndex(GetOwner())
		}
	}

	void clear_hands()
	{
		game_wear();
		DeleteEntity(GetOwner());
	}

	void ext_scroll_time()
	{
		SCROLL_TIME = GetGameTime();
		SCROLL_TIME += 2;
	}

}

}
