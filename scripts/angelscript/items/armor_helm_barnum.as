#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmBarnum : CGameScript
{
	int ARMOR_BODY;
	string ARMOR_MODEL;
	string ARMOR_TEXT;
	float BARMOR_PROTECTION;
	string BARMOR_TYPE;
	float STUN_PROTECTION;

	ArmorHelmBarnum()
	{
		ARMOR_MODEL = "armor/p_helmets.mdl";
		ARMOR_BODY = 6;
		ARMOR_TEXT = "You equip the Helm of Darkness.";
		BARMOR_TYPE = "platemail";
		BARMOR_PROTECTION = 0.6;
		STUN_PROTECTION = 0.75;
	}

	void OnSpawn() override
	{
		SetName("Helm of Darkness");
		SetDescription("This helm is enchanted with vile magics.");
		SetWeight(5);
		SetSize(20);
		SetWearable(1);
		SetValue(1150);
		SetHUDSprite("trade", "helm3");
	}

	void game_wear()
	{
		ScheduleDelayedEvent(0.1, "armor_spec_effect");
	}

	void OnDeploy() override
	{
		ScheduleDelayedEvent(0.1, "armor_spec_effect");
	}

	void armor_spec_effect()
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn")))
		{
			remove_bonus();
		}
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.1, "grant_bonus");
	}

	void grant_bonus()
	{
		CallExternal(GetOwner(), "ext_set_dmg_multi", "poison", "helm1", 1.5);
		CallExternal(GetOwner(), "ext_set_dmg_multi", "acid", "helm2", 1.5);
		SendColoredMessage(GetOwner(), "Your affliction power has increased.");
	}

	void remove_bonus()
	{
		CallExternal(GetOwner(), "ext_set_dmg_multi", "poison", "helm1", 0);
		CallExternal(GetOwner(), "ext_set_dmg_multi", "acid", "helm2", 0);
		SendColoredMessage(GetOwner(), "Your affliction power has returned to normal.");
	}

}

}
