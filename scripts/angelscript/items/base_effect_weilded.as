#pragma context server

namespace MS
{

class BaseEffectWeilded : CGameScript
{
	void ext_activate_items()
	{
		if (!(true)) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (!(BEW_IS_WEILDED)) return;
		bweapon_effect_activate();
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		bweapon_effect_activate();
	}

	void game_wear()
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

	void game_putinpack()
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

	void game_remove()
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

	void game_fall()
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

	void game_sheath()
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

	void OnDrop() override
	{
		if (!(true)) return;
		bweapon_effect_remove();
	}

}

}
