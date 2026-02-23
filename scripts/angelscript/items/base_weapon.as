#pragma context server

#include "items/base_item.as"

namespace MS
{

class BaseWeapon : CGameScript
{
	int IS_WEAPON;

	BaseWeapon()
	{
		const string PLAYERANIM_AIM = "blunt";
		IS_WEAPON = 1;
	}

	void item_spawn()
	{
		SetAnimExt(PLAYERANIM_AIM);
		SetHand("right");
		weapon_spawn();
	}

	void game_sheath()
	{
		SetModelBody(0, 2);
		weapon_sheath();
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), "weapons/cbar_miss1.wav");
		weapon_parry();
	}

	void OnDeploy() override
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_HANDS);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 1;
		L_SUBMODEL -= "game.item.hand_index";
		SetModelBody(0, L_SUBMODEL);
		if (!(BASEWEAPON_NO_HAND_IDLE))
		{
			string L_ANIM = ANIM_PREFIX;
			L_ANIM += "_idle";
			if (ANIM_PREFIX == "ANIM_PREFIX")
			{
				string L_ANIM = "idle";
			}
			if (ANIM_PREFIX == "none")
			{
				string L_ANIM = "idle";
			}
			PlayAnim("once", L_ANIM);
		}
		weapon_deploy();
		if (!(true)) return;
		if (!(MODEL_VIEW_IDX > 0)) return;
		ScheduleDelayedEvent(0.01, "bw_setup_model");
	}

	void game_fall()
	{
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL++;
		if ((NO_WORLD_MODEL))
		{
			L_SUBMODEL -= 1;
		}
		string L_ANIM = ANIM_PREFIX;
		L_ANIM += "_floor_idle";
		SetModelBody(0, L_SUBMODEL);
		if (ANIM_PREFIX == "ANIM_PREFIX")
		{
			string L_ANIM = "idle";
		}
		if (ANIM_PREFIX == "none")
		{
			string L_ANIM = "idle";
		}
		PlayAnim("once", L_ANIM);
		weapon_fall();
	}

	void bw_setup_model()
	{
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
	}

}

}
