#pragma context server

#include "items/base_item.as"

namespace MS
{

class ManaSoup : CGameScript
{
	string APPLY_LATER;
	int DO_OWNER_IDLES;
	int ITEM_USED;
	string NEXT_USE;

	ManaSoup()
	{
		const int ANIM_LIFT1 = 21;
		const int ANIM_IDLE1 = 21;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const int ITEM_MODEL_VIEW_IDX = 8;
		const string MODEL_HANDS = "misc/p_misc.mdl";
		const string MODEL_WORLD = "misc/p_misc.mdl";
		const int MODEL_BODY_OFS = 69;
		const int MODEL_BODY_FLOOR = 71;
		const string ANIM_WORLD_IDLE = "apple_floor_idle";
		const string ANIM_HAND_IDLE = "idle";
		const string OWNER_ANIM_IDLE = "aim_soup";
		const string OWNER_ANIM_USE = "aim_soup";
		const int ANIM_USE = 20;
		const float USE_DELAY = 2.0;
		const string SOUND_USE = "magic/slurp.wav";
		const int NO_IDLE = 1;
	}

	void OnSpawn() override
	{
		SetName("Sylphiel's Soup");
		SetDescription("Sylphiel's Applemead Soup provides temporary health and mana regen.");
		SetWeight(1);
		SetSize(1);
		SetValue(200);
		SetHand("both");
		SetHUDSprite("hand", 88);
		SetHUDSprite("trade", 88);
	}

	void game_fall()
	{
		SetModelBody(0, MODEL_BODY_FLOOR);
		PlayAnim("once", WANIM_FLOOR);
		PlayAnim("once", ANIM_WORLD_IDLE);
	}

	void OnDeploy() override
	{
		SetAnimExt("soup");
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		PlayAnim("once", ANIM_HAND_IDLE);
		SetModelBody(0, MODEL_BODY_OFS);
		if (!(true)) return;
		PlayOwnerAnim("once", OWNER_ANIM_IDLE);
		NEXT_USE = GetGameTime();
		NEXT_USE += 1.0;
		DO_OWNER_IDLES = 1;
		ScheduleDelayedEvent(2.0, "item_idle");
	}

	void game_attack1()
	{
		if (!(true)) return;
		if ((ITEM_USED)) return;
		if (!(GetGameTime() > NEXT_USE)) return;
		ITEM_USED = 1;
		// TODO: splayviewanim ent_me ANIM_USE
		USE_DELAY("use_item");
	}

	void use_item()
	{
		CallExternal(GetOwner(), "ext_svplaysound_kiss", 1, 10, SOUND_USE, 0.8, 100);
		PlayOwnerAnim("once", OWNER_ANIM_USE);
		use_effect();
	}

	void use_effect()
	{
		ScheduleDelayedEvent(2.0, "use_complete");
		int L_POOPY = 0;
		if (RandomInt(0, 99) == 0)
		{
			int L_POOPY = 1;
		}
		if (!(GetEntityProperty(GetOwner(), "haseffect")))
		{
			ApplyEffect(GetOwner(), "effects/soup", 180, L_POOPY);
		}
		else
		{
			RemoveEffect(GetOwner(), "soup");
			APPLY_LATER = 1;
		}
		HealEntity(GetOwner(), /* TODO: $math(subtract) */ GetEntityMaxHealth(GetOwner()));
		GiveMP(GetOwner());
	}

	void use_complete()
	{
		int L_POOPY = 0;
		if (RandomInt(0, 99) == 0)
		{
			int L_POOPY = 1;
		}
		SendColoredMessage(GetOwner(), "All your health and mana has been restored.");
		SendColoredMessage(GetOwner(), "Three minutes of health and mana regen.");
		if ((APPLY_LATER))
		{
			ApplyEffect(GetOwner(), "effects/soup", 180, L_POOPY);
		}
		RemoveScript();
		DeleteEntity(GetOwner());
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_USE
		EmitSound(0, 0, SOUND_USE);
	}

	void bweapon_effect_remove()
	{
		DO_OWNER_IDLES = 0;
	}

	void item_idle()
	{
		if (!(DO_OWNER_IDLES)) return;
		if (!(GetEntityProperty(GetOwner(), "inhand")))
		{
			DO_OWNER_IDLES = 0;
		}
		else
		{
			PlayOwnerAnim("once", OWNER_ANIM_IDLE);
			ScheduleDelayedEvent(1.0, "item_idle");
		}
	}

}

}
