#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseTome : CGameScript
{
	string BASE_CAN_SUMMON;
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;
	string BASE_SUMMON_TEXT_FAILED;
	int MODEL_BODY;
	string MODEL_WORLD;
	int READING;

	BaseTome()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		BASE_SUMMON_TEXT = "You learn to cast a weak fireball.";
		BASE_SUMMON_TEXT_FAILED = "Your spell casting skills are not yet sufficient to memorize this tome.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 0;
		BASE_CAN_SUMMON = "func_base_can_wield"();
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_BODY = 5;
		READING = 0;
	}

	void OnSpawn() override
	{
		SetName("Dire Fart Tome");
		SetDescription("im gonna learn you a oooh~ brrrt!");
		SetValue(1);
		SetWeight(1);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "book");
	}

	void OnDeploy() override
	{
		SetModel(MODEL_WORLD);
		string L_SUB_MODEL = (MODEL_BODY - 2);
		L_SUB_MODEL += "game.item.hand_index";
		SetModelBody(0, L_SUB_MODEL);
		if (MODEL_BODY == 5)
		{
			SendInfoMsg(GetOwner(), "TOMES Tomes can be used to memorize spells permanently.");
		}
	}

	void game_fall()
	{
		SetModel(MODEL_WORLD);
		SetModelBody(0, MODEL_BODY);
		PlayAnim("once", "oldbook_floor_idle");
	}

	void game_attack1()
	{
		if (!(READING == 0)) return;
		READING = 1;
		SendPlayerMessage(GetOwner(), "You study the tome carefully...");
		ScheduleDelayedEvent(3, "learn_spell");
	}

	void learn_spell()
	{
		if (READING == 1)
		{
			if ((BASE_CAN_SUMMON))
			{
				// TODO: UNCONVERTED: if ( BASE_CAN_SUMMON ) learnspell BASE_SPELL_SCRIPT
			}
			else
			{
				game_learnspell_failed();
			}
		}
		READING = 0;
	}

	void game_removefromowner()
	{
		if ((READING))
		{
			READING = -1;
		}
	}

	void game_learnspell_success()
	{
		SendPlayerMessage(GetOwner(), BASE_SUMMON_TEXT);
	}

	void game_learnspell_failed()
	{
		SendPlayerMessage(GetOwner(), BASE_SUMMON_TEXT_FAILED);
	}

	void func_base_can_wield()
	{
		string OWNER_SKILL = GetEntityProperty(GetOwner(), "base_required_skill");
		if (OWNER_SKILL >= BASE_REQUIRED_LEVEL)
		{
			return;
		}
		else
		{
			return;
		}
	}

}

}
