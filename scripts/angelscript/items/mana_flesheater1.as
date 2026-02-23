#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ManaFlesheater1 : CGameScript
{
	int ABORT_USE;
	string ATTACK_DELAY;

	ManaFlesheater1()
	{
		const int ANIM_IDLE = 0;
		const int ANIM_DRINK = 1;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const string MODEL_VIEW = "viewmodels/v_misc.mdl";
		const int ITEM_MODEL_VIEW_IDX = 2;
		const string SOUND_DRINK = "items/drink.wav";
		const int MODEL_BODY_OFS = 39;
		const string ANIM_PREFIX = "mana";
		const int DRINK_TIME = 3;
		ABORT_USE = 0;
		const int SKILL_REQ = 15;
		const int AFFLIC_REQ = 10;
		const string ITEM_TO_GIVE = "blunt_gauntlets_fe1";
	}

	void item_spawn()
	{
		SetName("Venom Claw Potion");
		SetDescription("This potion infuses you with the power of a Flesheater.");
		SetWeight(1);
		SetSize(2);
		SetValue(1500);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", "gpot");
		SetHand("both");
	}

	void OnSpawn() override
	{
		SetHand("any");
		SetAnimExt("holditem");
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		item_spawn();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		PlayViewAnim(ANIM_LIFT);
	}

	void game_attack1()
	{
		if (!(GetGameTime() > ATTACK_DELAY)) return;
		ATTACK_DELAY = GetGameTime();
		ATTACK_DELAY += DRINK_TIME;
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "martialarts");
		if (OWNER_SKILL < SKILL_REQ)
		{
			string S_REQ = "(";
			S_REQ += SKILL_REQ;
			S_REQ += ")";
			SendColoredMessage(GetOwner(), "You lack the Martial Arts skill to use the Flesheater Gauntlets. S_REQ");
			int EXIT_SUB = 1;
		}
		if (OWNER_SKILL >= SKILL_REQ)
		{
			check_use();
			if ((ABORT_USE))
			{
				ABORT_USE = 0;
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.1, "drink_pot");
	}

	void drink_pot()
	{
		// TODO: splayviewanim ent_me ANIM_DRINK
		DRINK_TIME("activate_pot");
	}

	void activate_pot()
	{
		CallExternal(GAME_MASTER, "give_item_delayed", GetEntityIndex(GetOwner()), ITEM_TO_GIVE, 0.5);
		ScheduleDelayedEvent(0.1, "remove_pot");
	}

	void remove_pot()
	{
		DeleteEntity(GetOwner());
	}

	void check_use()
	{
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") < AFFLIC_REQ)
		{
			ABORT_USE = 1;
			string S_REQ = "(";
			S_REQ += AFFLIC_REQ;
			S_REQ += ")";
			SendColoredMessage(GetOwner(), "You lack the Affliction Magic skill to use the Flesheater Gauntlets. S_REQ");
		}
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		ATTACK_DELAY = GetGameTime();
		ATTACK_DELAY += 1.0;
	}

	void game_fall()
	{
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 2;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
	}

}

}
