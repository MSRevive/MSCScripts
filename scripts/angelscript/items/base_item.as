#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class BaseItem : CGameScript
{
	int ANIM_IDLE1;
	int ANIM_IDLE2;
	int ANIM_IDLE3;
	int ANIM_IDLE4;
	int ANIM_IDLE5;
	int ANIM_IDLE_DELAY_HIGH;
	int ANIM_IDLE_DELAY_LOW;
	int ANIM_LIFT1;
	string PLAYERANIM_AIM;
	int baseitem.canidle;

	BaseItem()
	{
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 0;
		ANIM_IDLE2 = 0;
		ANIM_IDLE3 = 0;
		ANIM_IDLE4 = 0;
		ANIM_IDLE5 = 0;
		ANIM_IDLE_DELAY_LOW = 2;
		ANIM_IDLE_DELAY_HIGH = 5;
		baseitem.canidle = 1;
		PLAYERANIM_AIM = "blunt";
	}

	void OnSpawn() override
	{
		if ((IS_MAGIC_HAND)) return;
		SetAnimExt(PLAYERANIM_AIM);
		SetWorldModel(MODEL_WORLD);
		item_spawn();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		if ((IS_MAGIC_HAND)) return;
		PlayViewAnim(ANIM_LIFT1);
		SetModel(MODEL_HANDS);
		SetModelBody(0, "game.item.hand_index");
		item_pickup();
	}

	void OnDeploy() override
	{
		if ((IS_WEAPON)) return;
		if ((IS_MAGIC_HAND)) return;
		SetViewModel(MODEL_VIEW);
		item_deploy();
		if (!(true)) return;
		if (!(ITEM_MODEL_VIEW_IDX > 0)) return;
		ScheduleDelayedEvent(0.1, "bi_setup_model");
	}

	void game_switchhands()
	{
		if ((IS_MAGIC_HAND)) return;
		PlayViewAnim(ANIM_IDLE1);
		item_switchhands();
	}

	void OnDrop() override
	{
		item_drop();
	}

	void game_attack_cancel()
	{
		game_viewanimdone();
	}

	void game_viewanimdone()
	{
		if (!(ANIM_IDLE_TOTAL > 0)) return;
		RandomInt(ANIM_IDLE_DELAY_LOW, ANIM_IDLE_DELAY_HIGH)("item_idle");
	}

	void item_idle()
	{
		if ((NO_IDLE)) return;
		if (!(ANIM_IDLE_TOTAL > 0)) return;
		if (("game.item.attacking")) return;
		if (!("game.item.inhand")) return;
		if (!(baseitem.canidle)) return;
		int l.anim = RandomInt(1, ANIM_IDLE_TOTAL);
		if (l.anim == 1)
		{
			PlayViewAnim(ANIM_IDLE1);
		}
		else
		{
			if (l.anim == 2)
			{
				PlayViewAnim(ANIM_IDLE2);
			}
			else
			{
				if (l.anim == 3)
				{
					PlayViewAnim(ANIM_IDLE3);
				}
				else
				{
					if (l.anim == 4)
					{
						PlayViewAnim(ANIM_IDLE4);
					}
					else
					{
						if (l.anim == 5)
						{
							PlayViewAnim(ANIM_IDLE5);
						}
					}
				}
			}
		}
	}

	void bi_setup_model()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") ITEM_MODEL_VIEW_IDX
		ScheduleDelayedEvent(1.0, "bitem_setup_model2");
	}

	void bi_setup_model2()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		LogDebug("bi_setup_model2");
		// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") ITEM_MODEL_VIEW_IDX
	}

	void bitem_set_can_idle()
	{
		baseitem.canidle = 1;
		item_idle();
	}

}

}
