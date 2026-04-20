#pragma context server

#include "items/base_miscitem.as"
#include "items/base_effect_armor.as"

namespace MS
{

class ArmorBaseHelmet : CGameScript
{
	string CUR_STUN_PROT;
	int HELM_EFFECT_ACTIVE;
	int HELM_HIDES_HEAD;
	int IS_HELM;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;

	ArmorBaseHelmet()
	{
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_VIEW = "none";
		IS_HELM = 1;
		HELM_HIDES_HEAD = 0;
	}

	void OnSpawn() override
	{
		SetWearable(1);
		SetModelBody(ARMOR_GROUP, ARMOR_BODY);
	}

	void game_wear()
	{
		string CL_RACE = param1;
		string CL_GENDER = param2;
		string CL_DEBUG = param3;
		game_show(CL_RACE, CL_GENDER, CL_DEBUG);
	}

	void game_show()
	{
		SetModel(ARMOR_MODEL);
		SetModelBody(ARMOR_GROUP, ARMOR_BODY);
		if ((false))
		{
			string OWNER_RACE = /* TODO: $get_local_prop */ $get_local_prop("race");
			string OWNER_GENDER = /* TODO: $get_local_prop */ $get_local_prop("gender");
		}
		else
		{
			if ((true))
			{
			}
			string OWNER_RACE = GetEntityRace(GetOwner());
			string OWNER_GENDER = GetGender(GetOwner());
		}
		string OWNER_RACE = StringToLower(OWNER_RACE);
		string OWNER_GENDER = StringToLower(OWNER_GENDER);
		if (OWNER_RACE == 0)
		{
			string OWNER_RACE = param1;
		}
		if (OWNER_GENDER == 0)
		{
			string OWNER_GENDER = param2;
		}
		LogDebug("game_show race OWNER_RACE gend OWNER_GENDER dbg PARAM3");
		if (OWNER_GENDER == "female")
		{
			if (OWNER_RACE == "human")
			{
				LogDebug("*** Adjusted for Fembot");
				if (ARMOR_BODY_HUMAN_FEMALE != "ARMOR_BODY_HUMAN_FEMALE")
				{
					SetModelBody(ARMOR_GROUP, ARMOR_BODY_HUMAN_FEMALE);
				}
				else
				{
					string FEM_BODY = ARMOR_BODY;
					FEM_BODY += 14;
					SetModelBody(ARMOR_GROUP, FEM_BODY);
				}
			}
		}
		if (!(HELM_HIDES_HEAD)) return;
		CallExternal(GetOwner(), "ext_setheadtype", 1);
	}

	void display_stun_info()
	{
		string L_STR = (CUR_STUN_PROT * 100);
		int L_STR = int((100 - L_STR));
		if (CUR_STUN_PROT < 1)
		{
			SendColoredMessage(GetOwner(), "Your stun resistance is now " + L_STR);
		}
		if (CUR_STUN_PROT == 1)
		{
			SendColoredMessage(GetOwner(), "You now have no stun resistance");
		}
	}

	void barmor_effect_activate()
	{
		if ((HELM_EFFECT_ACTIVE)) return;
		HELM_EFFECT_ACTIVE = 1;
		if ((HELM_HIDES_HEAD))
		{
			CallExternal(GetOwner(), "ext_setheadtype", 1);
		}
		CallExternal(GetOwner(), "ext_register_helm", GetEntityIndex(GetOwner()));
		string OLD_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		string POT_CHECK = GetEntityProperty(GetOwner(), "scriptvar");
		if ((POT_CHECK))
		{
			CUR_STUN_PROT = GetEntityProperty(GetOwner(), "scriptvar");
			int SAME_PROTECT = 1;
			SendColoredMessage(GetOwner(), "Your stun resistance remains " + STUN_PROTECTION + " due to Lesser Leadfoot Potion");
		}
		if (OLD_PROT != STUN_PROTECTION)
		{
			CallExternal(GetOwner(), "set_stun_prot", STUN_PROTECTION);
			ScheduleDelayedEvent(0.1, "display_stun_info");
		}
		if (!(SAME_PROTECT))
		{
			CUR_STUN_PROT = STUN_PROTECTION;
		}
	}

	void barmor_effect_remove()
	{
		if (!(HELM_EFFECT_ACTIVE)) return;
		HELM_EFFECT_ACTIVE = 0;
		if ((HELM_HIDES_HEAD))
		{
			CallExternal(GetOwner(), "ext_setheadtype", 0);
		}
		CallExternal(GetEntityIndex(GetOwner()), "ext_register_helm", "none");
		string POT_CHECK = GetEntityProperty(GetOwner(), "scriptvar");
		if ((POT_CHECK))
		{
			string L_STUN_RESIST = GetEntityProperty(GetOwner(), "scriptvar");
			SendColoredMessage(GetOwner(), "Your stun resistance remains " + L_STUN_RESIST + " due to Lesser Leadfoot Potion");
		}
		if ((POT_CHECK)) return;
		string OLD_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		CallExternal(GetOwner(), "set_stun_prot", 1);
		string STUN_PROT = /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun");
		CUR_STUN_PROT = 1;
		if (OLD_PROT != STUN_PROT)
		{
			ScheduleDelayedEvent(0.1, "display_stun_info");
		}
	}

	void ext_setrender()
	{
		LogDebug("got ext_setrender PARAM1");
		// TODO: setrender PARAM1
	}

}

}
