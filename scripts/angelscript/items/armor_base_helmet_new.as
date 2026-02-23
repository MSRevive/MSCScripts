#pragma context server

#include "items/base_item.as"
#include "items/base_effect_armor.as"

namespace MS
{

class ArmorBaseHelmetNew : CGameScript
{
	string CUR_STUN_PROT;

	ArmorBaseHelmetNew()
	{
		const int IS_HELM = 1;
		const int HELM_HIDES_HEAD = 0;
	}

	void OnSpawn() override
	{
		SetWearable(1);
		SetModelBody(ARMOR_GROUP, ARMOR_BODY);
	}

	void game_wear()
	{
		SetModel(ARMOR_MODEL);
		SetModelBody(ARMOR_GROUP, ARMOR_BODY);
		if (!(true)) return;
		if (!(HELM_HIDES_HEAD)) return;
		CallExternal(GetOwner(), "ext_setheadtype", 1);
	}

	void display_stun_info()
	{
		string L_STR = /* TODO: $math(multiply) */ CUR_STUN_PROT;
		string L_STR = int(/* TODO: $math(subtract) */ 100);
		if (CUR_STUN_PROT > 0)
		{
			SendColoredMessage(GetOwner(), "Your stun resistance is now L_STR");
		}
		if (CUR_STUN_PROT == 0)
		{
			SendColoredMessage(GetOwner(), "You now have no stun resistance");
		}
	}

	void barmor_effect_activate()
	{
		if ((HELM_HIDES_HEAD))
		{
			CallExternal(GetOwner(), "ext_setheadtype", 1);
		}
		string OLD_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		CallExternal(GetOwner(), "set_stun_prot", STUN_PROTECTION);
		CUR_STUN_PROT = STUN_PROTECTION;
		if (OLD_PROT != STUN_PROTECTION)
		{
			ScheduleDelayedEvent(0.1, "display_stun_info");
		}
	}

	void barmor_effect_remove()
	{
		if ((HELM_HIDES_HEAD))
		{
			CallExternal(GetOwner(), "ext_setheadtype", 0);
		}
		string OLD_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		CallExternal(GetOwner(), "set_stun_prot", 1);
		string STUN_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		CUR_STUN_PROT = 1;
		if (OLD_PROT != STUN_PROT)
		{
			ScheduleDelayedEvent(0.1, "display_stun_info");
		}
	}

}

}
