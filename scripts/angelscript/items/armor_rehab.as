#pragma context server

#include "items/armor_base.as"

namespace MS
{

class ArmorRehab : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_PROTECTION_AREA;
	string BARMOR_REPLACE_BODYPARTS;
	string BARMOR_TYPE;
	string DID_INIT;
	int ELM_AMT;
	string ELM_NAME;
	float FREQ_CHANGE;
	int IS_ACTIVE;
	int NEW_ARMOR_OFS;
	int RND_ELE;

	ArmorRehab()
	{
		ARMOR_MODEL = "armor/p_armorvest.mdl";
		ARMOR_BODY = 5;
		ARMOR_TEXT = "You work your way into the visual nightmare.";
		BARMOR_TYPE = "leather";
		BARMOR_PROTECTION = 0.4;
		BARMOR_PROTECTION_AREA = "chest";
		BARMOR_REPLACE_BODYPARTS = "chest";
		FREQ_CHANGE = 90.0;
		NEW_ARMOR_OFS = 19;
		ELM_NAME = "rehab";
		ELM_AMT = 100;
	}

	void OnSpawn() override
	{
		SetName("Chromatic Vest");
		SetDescription("This magic vest makes your eyes swim");
		SetWeight(12);
		SetSize(30);
		SetWearable(1);
		SetValue(3000);
		SetHUDSprite("trade", 12);
	}

	void game_putinpack()
	{
		elm_remove_effect();
	}

	void OnDrop() override
	{
		elm_remove_effect();
	}

	void game_remove()
	{
		elm_remove_effect();
	}

	void game_fall()
	{
		elm_remove_effect();
	}

	void game_sheath()
	{
		elm_remove_effect();
	}

	void OnDeploy() override
	{
		if ((ELM_WEAPON)) return;
		elm_remove_effect();
	}

	void game_wear()
	{
		ScheduleDelayedEvent(0.1, "elm_activate_effect");
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "is_worn")))
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		RND_ELE = RandomInt(1, 4);
		ScheduleDelayedEvent(0.1, "elm_activate_effect");
	}

	void elm_get_resist()
	{
		if (!(DID_INIT))
		{
			DID_INIT = 1;
			RND_ELE = RandomInt(0, 3);
		}
		if (!(IS_ACTIVE))
		{
			RND_ELE += 1;
			if (RND_ELE > 4)
			{
				RND_ELE = 1;
			}
			if (RND_ELE == 1)
			{
				ELM_TYPE = "fire";
			}
			if (RND_ELE == 2)
			{
				ELM_TYPE = "lightning";
			}
			if (RND_ELE == 3)
			{
				ELM_TYPE = "cold";
			}
			if (RND_ELE == 4)
			{
				ELM_TYPE = "poison";
			}
			string ICON_NAME = "hud/status/alpha_";
			// TODO: hud.addstatusicon ent_owner ICON_NAME rehab FREQ_CHANGE
			ClientEvent("new", "all", "items/armor_rehab_cl", GetEntityIndex(GetOwner()), RND_ELE);
			SendColoredMessage(GetOwner(), "Chromatic vest has chosen to protect you from " + ELM_TYPE);
			// svplaysound: svplaysound 2 10 magic/energy1.wav
			EmitSound(2, 10, "magic/energy1.wav");
		}
	}

	void elm_activate_effect()
	{
		elm_get_resist();
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, ELM_TYPE, ELM_AMT, GetScriptName(GetOwner()));
		if ((IS_ACTIVE)) return;
		IS_ACTIVE = 1;
		FREQ_CHANGE("change_element");
	}

	void elm_remove_effect()
	{
		CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove", 0, GetScriptName(GetOwner()));
		if ((IS_ACTIVE))
		{
			// TODO: hud.killimgicon ent_owner rehab
		}
	}

	void change_element()
	{
		if (!(IS_ACTIVE)) return;
		IS_ACTIVE = 0;
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		elm_remove_effect();
		elm_activate_effect();
	}

}

}
