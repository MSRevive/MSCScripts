#pragma context server

namespace MS
{

class BaseElementalResist : CGameScript
{
	int ELM_EFFECT_ACTIVE;

	BaseElementalResist()
	{
		ELM_EFFECT_ACTIVE = 0;
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

	void game_deleted()
	{
		if (!(true)) return;
		if ((GetEntityProperty(GetOwner(), "inhand")))
		{
			int L_REM_EFFECTS = 1;
		}
		if ((GetEntityProperty(GetOwner(), "is_worn")))
		{
			int L_REM_EFFECTS = 1;
		}
		if (!(L_REM_EFFECTS)) return;
		elm_remove_effect();
	}

	void game_wear()
	{
		elm_activate_effect();
	}

	void elm_activate_effect()
	{
		if ((ELM_EFFECT_ACTIVE)) return;
		ELM_EFFECT_ACTIVE = 1;
		elm_get_resist();
		if (!(ELM_WEAPON))
		{
			CallExternal(GetOwner(), "ext_register_element", ELM_NAME, ELM_TYPE, ELM_AMT);
		}
		else
		{
			CallExternal(GetOwner(), "ext_register_weapon", GetEntityIndex(GetOwner()), ELM_NAME, ELM_TYPE, ELM_AMT);
		}
	}

	void elm_remove_effect()
	{
		if (!(ELM_EFFECT_ACTIVE)) return;
		ELM_EFFECT_ACTIVE = 0;
		if (!(ELM_WEAPON))
		{
			CallExternal(GetOwner(), "ext_register_element", ELM_NAME, "remove");
		}
		else
		{
			CallExternal(GetOwner(), "ext_register_weapon", GetEntityIndex(GetOwner()), ELM_NAME, "remove");
		}
	}

	void elm_get_resist()
	{
	}

	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(ELM_WEAPON))
		{
			if (!(GetEntityProperty(GetOwner(), "is_worn")))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((ELM_WEAPON))
		{
			if (GetEntityProperty(GetOwner(), "scriptvar") != GetOwner())
			{
			}
			if (GetEntityProperty(GetOwner(), "scriptvar") != GetOwner())
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.1, "elm_activate_effect");
	}

}

}
