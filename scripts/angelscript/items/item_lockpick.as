#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLockpick : CGameScript
{
	int AM_LOCKPICKING;
	int ANIM_FAIL;
	int ANIM_IDLE;
	int ANIM_IDLE1;
	int ANIM_IDLE2;
	int ANIM_IDLE3;
	int ANIM_IDLE4;
	int ANIM_IDLE5;
	int ANIM_IDLE_DELAY_HIGH;
	int ANIM_IDLE_DELAY_LOW;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_USE;
	string ICO_LOCKPICK_STATUS;
	int ITEM_MODEL_VIEW_IDX;
	int LOCKPICK_FAIL;
	string LOCK_TARGET;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string NEXT_USE;

	ItemLockpick()
	{
		ANIM_LIFT1 = 18;
		ANIM_IDLE = 18;
		ANIM_IDLE1 = 18;
		ANIM_IDLE2 = 18;
		ANIM_IDLE3 = 18;
		ANIM_IDLE4 = 18;
		ANIM_IDLE5 = 18;
		ANIM_IDLE_DELAY_LOW = 2;
		ANIM_IDLE_DELAY_HIGH = 5;
		ANIM_USE = 19;
		ANIM_FAIL = 16;
		MODEL_WORLD = "misc/p_misc.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
		MODEL_BODY_OFS = 13;
		MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		ITEM_MODEL_VIEW_IDX = 9;
		ANIM_PREFIX = "rustedkey";
		ICO_LOCKPICK_STATUS = "hud/status/alpha_lockpick";
	}

	void miscitem_spawn()
	{
		SetName("Lockpick");
		SetDescription("This can be used to disarm traps and open certain chests");
		SetGroupable(100);
		SetWeight(0);
		SetSize(1);
		SetValue(300);
		SetHUDSprite("trade", 195);
	}

	void OnDeploy() override
	{
		PlayViewAnim(ANIM_LIFT1);
		if (!(true)) return;
		NEXT_USE = GetGameTime();
		NEXT_USE += 0.5;
		ScheduleDelayedEvent(0.1, "bi_setup_model");
	}

	void game_attack1()
	{
		if (!(true)) return;
		if (!(GetGameTime() > NEXT_USE)) return;
		if ((AM_LOCKPICKING)) return;
		NEXT_USE = GetGameTime();
		NEXT_USE += 0.5;
		if (!(CanAttack(GetOwner()))) return;
		string L_TARG = GetEntityProperty(GetOwner(), "target");
		LOCKPICK_FAIL = 0;
		validate_target(L_TARG);
		if ((LOCKPICK_FAIL)) return;
		// TODO: hud.addstatusicon ent_owner ICO_LOCKPICK_STATUS lockpick 10.0
		// TODO: splayviewanim ent_me ANIM_USE
		AM_LOCKPICKING = 1;
		LOCK_TARGET = L_TARG;
		ScheduleDelayedEvent(10.0, "lockpick_complete");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		if ((IsValidPlayer(param1))) return;
		// TODO: splayviewanim ent_me ANIM_LIFT1
		SendColoredMessage(GetOwner(), "Your lock picking is interrupted!");
		// TODO: hud.killstatusicon ent_owner lockpick
		NEXT_USE = GetGameTime();
		NEXT_USE += 0.5;
		AM_LOCKPICKING = 0;
	}

	void lockpick_complete()
	{
		if (!(AM_LOCKPICKING)) return;
		AM_LOCKPICKING = 0;
		NEXT_USE = GetGameTime();
		NEXT_USE += 1.0;
		string L_TARG = LOCK_TARGET;
		LOCKPICK_FAIL = 0;
		validate_target(L_TARG);
		if ((LOCKPICK_FAIL)) return;
		CallExternal(LOCK_TARGET, "ext_picked", GetEntityIndex(GetOwner()));
		string L_COUNT = GetEntityProperty(GetOwner(), "quantity");
		LogDebug("lockpick_complete L_COUNT");
		L_COUNT -= 1;
		if (L_COUNT <= 0)
		{
			DeleteEntity(GetOwner());
		}
		else
		{
			// TODO: setquantity ent_me L_COUNT
		}
	}

	void resume_idle()
	{
		// TODO: splayviewanim ent_me ANIM_IDLE1
	}

	void bi_setup_model()
	{
		LogDebug("setting up model");
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") ITEM_MODEL_VIEW_IDX
	}

	void validate_target()
	{
		string L_TARG = param1;
		if (!(IsEntityAlive(L_TARG)))
		{
			SendColoredMessage(GetOwner(), "Lockpick: No target.");
			LOCKPICK_FAIL = 1;
			return;
		}
		if (!(GetEntityProperty(L_TARG, "scriptvar")))
		{
			if (!(GetEntityProperty(L_TARG, "scriptvar")))
			{
			}
			int L_FAIL = 1;
		}
		if (!(L_FAIL))
		{
			string L_TARG_ORG = GetEntityOrigin(L_TARG);
			string L_OWNER_ORG = GetEntityOrigin(GetOwner());
			if (Distance(L_TARG_ORG, L_OWNER_ORG) > 96)
			{
				int L_TOO_FAR = 1;
				int L_FAIL = 1;
			}
			if ((L_TOO_FAR))
			{
				string L_MSG = "Lockpick: You are too far away...";
			}
		}
		if ((L_FAIL))
		{
			LOCKPICK_FAIL = 1;
			// TODO: splayviewanim ent_me ANIM_FAIL
			ScheduleDelayedEvent(1.0, "resume_idle");
			NEXT_USE = GetGameTime();
			NEXT_USE += 1.0;
			if (!(L_TOO_FAR))
			{
				string L_MSG = "Lockpick: This is not a valid target.";
			}
			if ((GetEntityProperty(L_TARG, "scriptvar")))
			{
				if (!(L_TOO_FAR))
				{
				}
				if ((GetEntityProperty(L_TARG, "scriptvar")))
				{
					string L_MSG = "Lockpick: This chest cannot be picked.";
				}
				if (!(GetEntityProperty(L_TARG, "scriptvar")))
				{
					string L_MSG = "Lockpick: This chest is neither locked nor trapped.";
				}
			}
			SendColoredMessage(GetOwner(), L_MSG);
		}
	}

}

}
