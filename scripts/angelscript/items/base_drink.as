#pragma context server

#include "items/base_item.as"

namespace MS
{

class BaseDrink : CGameScript
{
	BaseDrink()
	{
		const int MODEL_BODY_OFS = 21;
		const string ANIM_PREFIX = "mhealth";
		const string DRINK_WORD = "swig";
		const string DONE_PHRASE = "You drink the last drop of the";
	}

	void OnSpawn() override
	{
		SetHand("any");
		SetAnimExt("holditem");
		drink_spawn();
		RegisterDrink();
	}

	void game_start_drink()
	{
		PlayViewAnim(ANIM_DRINK);
		drink_start();
	}

	void game_drink()
	{
		if (DRINK_TYPE == "givehealth")
		{
			string OUT_AMT = GetEntityMaxHealth(GetOwner());
			OUT_AMT *= RESTORE_PERCENT;
			if (OUT_AMT < DRINK_EFFECTAMT)
			{
				string OUT_AMT = DRINK_EFFECTAMT;
			}
			HealEntity(GetOwner(), OUT_AMT);
		}
		if (DRINK_TYPE == "givemana")
		{
			string OUT_AMT = GetEntityProperty(GetOwner(), "maxmp");
			OUT_AMT *= RESTORE_PERCENT;
			if (OUT_AMT < DRINK_EFFECTAMT)
			{
				string OUT_AMT = DRINK_EFFECTAMT;
			}
			GiveMP(GetOwner());
		}
		if (SOUND_DRINK != "SOUND_DRINK")
		{
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_DRINK, "game.sound.maxvol");
		}
		if (DRINK_TYPE == "effect")
		{
			drink_effect();
		}
		drink_now();
	}

	void game_drink_done()
	{
		PlayViewAnim(ANIM_IDLE);
	}

	void OnDeploy() override
	{
		if (GetEntityProperty(GetOwner(), "drink_amt") == 0)
		{
			drink_remove();
		}
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		drink_deploy();
	}

	void game_fall()
	{
		if (GetEntityProperty(GetOwner(), "drink_amt") == 0)
		{
			drink_remove();
		}
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 2;
		SetModelBody(0, L_SUBMODEL);
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		PlayAnim("once", L_ANIM);
	}

	void drink_now()
	{
		ScheduleDelayedEvent(0.25, "report_drink_amt");
	}

	void report_drink_amt()
	{
		string DRINK_REMAIN = GetEntityProperty(GetOwner(), "drink_amt");
		string MY_NAME = GetEntityName(GetOwner());
		string MY_NAME = StringToLower(MY_NAME);
		string MY_NAME_P = MY_NAME;
		MY_NAME_P += ".";
		if (DRINK_REMAIN > 1)
		{
			string L_DRINK_WORD = DRINK_WORD;
			L_DRINK_WORD += "s";
			SendPlayerMessage("This", "MY_NAME has int(DRINK_REMAIN) L_DRINK_WORD left.");
		}
		if (DRINK_REMAIN == 1)
		{
			SendPlayerMessage("This", "MY_NAME has one DRINK_WORD left.");
		}
		if (DRINK_REMAIN == 0)
		{
			SendColoredMessage(GetOwner(), "DONE_PHRASE MY_NAME_P");
			ScheduleDelayedEvent(0.1, "drink_remove");
		}
	}

	void drink_remove()
	{
		DeleteEntity(GetOwner());
	}

	void drink_deploy()
	{
		if (!(true)) return;
		if (!(ITEM_MODEL_VIEW_IDX > 0)) return;
		ScheduleDelayedEvent(0.01, "bi_setup_model");
	}

}

}
