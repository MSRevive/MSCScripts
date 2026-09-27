#pragma context server

#include "items/base_item_extras.as"
#include "items/dev_staff/physgun.as"
#include "items/dev_staff/copypaste.as"
#include "items/dev_staff/remover.as"
#include "items/dev_staff/afflicter.as"
#include "items/dev_staff/damager.as"

namespace MS
{

class DevStaff : CGameScript
{
	int ANIM_USE;
	string BEAM_TARGET;
	int BEAM_TYPE;
	int LAST_ANIM;
	string MENU_ID;
	int NO_BANK;

	DevStaff()
	{
		ANIM_USE = 6;
		LAST_ANIM = 0;
		NO_BANK = 1;
		BEAM_TYPE = 0;
		BEAM_TARGET = "none";
		MENU_ID = "none";
	}

	void game_removefromowner()
	{
		validation_check();
	}

	void validation_check()
	{
		if (("game.central"))
		{
			string L_ME = GetPlayerAuthId(GetOwner());
			if ((G_DEVSTAFF_OWNERS).findFirst(L_ME) >= 0)
			{
				DeleteEntity(GetOwner());
			}
		}
	}

	void OnSpawn() override
	{
		SetName("Jester's Staff");
		SetDescription("For the real clowns who spend days troubleshooting simple problems.");
		SetWeight(0);
		SetSize(5);
		SetValue(0);
		SetHUDSprite("hand", "item");
		SetHUDSprite("trade", 21);
		SetModel("weapons/p_weapons1.mdl");
		SetModelBody(0, 20);
		SetViewModel("viewmodels/v_1hblunts.mdl");
		SetHand("both");
		SetExpireTime(0);
	}

	void bweapon_effect_activate()
	{
		SendColoredMessage(GetOwner(), "Hold 'e' then push mouse1 to access the menu.");
		SendColoredMessage(GetOwner(), "Mouse2 instead to copy your target. Left click will be replaced with paste.");
		SendColoredMessage(GetOwner(), "Clear the clipboard (copy nothing) to restore other left click function.");
		ScheduleDelayedEvent(0.1, "submodel_me_baby");
		if (!(MENU_ID == "none")) return;
		SpawnNPC("items/dev_staff/menus/main", "(0,0,0)", ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner())
		MENU_ID = GetEntityIndex(m_hLastCreated);
	}

	void bweapon_effect_remove()
	{
		DeleteEntity(MENU_ID);
		MENU_ID = "none";
	}

	void OnPickup(CBaseEntity@ player) override
	{
		PlayViewAnim(0);
	}

	void game_attack1()
	{
		if ((IsKeyDown(GetOwner(), "use")))
		{
			CallExternal(MENU_ID, "ext_menu_main");
		}
		else
		{
			if (NPC_CLIPBOARD != "none")
			{
				paste_target();
			}
		}
	}

	void game_attack1_down()
	{
		if (!(IsKeyDown(GetOwner(), "use")))
		{
			if (NPC_CLIPBOARD == "none")
			{
				if (BEAM_TYPE == 0)
				{
					try_physgun();
				}
				if (BEAM_TYPE == 1)
				{
					try_remove();
				}
				if (BEAM_TYPE == 2)
				{
					try_applyeffect();
				}
				if (BEAM_TYPE == 3)
				{
					try_damage();
				}
			}
		}
		try_anim();
	}

	void game_attack2()
	{
		if ((IsKeyDown(GetOwner(), "use")))
		{
			copy_target();
		}
		else
		{
			if ((AM_NOCLIPPING))
			{
				AM_NOCLIPPING = 0;
				SetProp(GetOwner(), "movetype", 3);
				SetProp(GetOwner(), "solid", 2);
			}
			else
			{
				AM_NOCLIPPING = 1;
				SetProp(GetOwner(), "movetype", 8);
				SetProp(GetOwner(), "solid", 0);
			}
		}
	}

	void find_beam_target()
	{
		string L_START = GetEntityProperty(GetOwner(), "eyepos");
		string L_END = /* TODO: $relpos */ $relpos(GetEntityProperty(GetOwner(), "viewangles"), Vector3(0, 10000, 0));
		L_END += L_START;
		BEAM_TARGET = "none";
		string L_TARGET = TraceLine(L_START, L_END);
		if (((L_TARGET !is null)))
		{
			if ((IsEntityAlive(L_TARGET)))
			{
				BEAM_TARGET = L_TARGET;
			}
		}
	}

	void try_anim()
	{
		if ((GetGameTime() - LAST_ANIM) > 0.8)
		{
			PlayViewAnim(ANIM_USE);
			LAST_ANIM = GetGameTime();
		}
	}

	void set_beam_type()
	{
		BEAM_TYPE = param1;
	}

	void submodel_me_baby()
	{
		// TODO: setviewmodelprop ent_me submodel 0 6
	}

	void wmodel_me_baby()
	{
	}

}

}
