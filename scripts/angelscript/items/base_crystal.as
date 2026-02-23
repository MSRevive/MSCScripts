#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class BaseCrystal : CGameScript
{
	int ACTIVE_DELAY;
	string ATTACK_DELAY;

	void OnSpawn() override
	{
		ACTIVE_DELAY = 5;
		crystal_spawn();
		SetAnimExt(PLAYERANIM_AIM);
		SetWorldModel(MODEL_WORLD);
		SetViewModel(MODEL_VIEW);
		SetHUDSprite("trade", 71);
	}

	void OnDeploy() override
	{
		ATTACK_DELAY = GetGameTime();
		ATTACK_DELAY += 1.0;
	}

	void game_attack1()
	{
		if (!(GetGameTime() > ATTACK_DELAY)) return;
		ATTACK_DELAY = GetGameTime();
		ATTACK_DELAY += 1.0;
		string OWNER_SKILL = GetEntityProperty(GetOwner(), "skill_type");
		if (OWNER_SKILL < SKILL_LEVEL_REQ)
		{
			string S_REQ = "(";
			S_REQ += SKILL_LEVEL_REQ;
			S_REQ += ")";
			SendColoredMessage(GetOwner(), "You lack the arcane skills to activate this crystal's magic. S_REQ");
		}
		else
		{
			check_use();
			if ((CRYSTAL_ABORT_USE))
			{
				CRYSTAL_ABORT_USE = 0;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			ScheduleDelayedEvent(0.1, "break_crystal");
			ScheduleDelayedEvent(0.2, "activate_crystal");
			ScheduleDelayedEvent(0.3, "remove_crystal");
		}
	}

	void break_crystal()
	{
		EmitSound(GetOwner(), 0, "debris/bustglass2.wav", 5);
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 0.3, 30, 10, 5, 1.0);
		ScheduleDelayedEvent(0.1, "remove_crystal");
	}

	void remove_crystal()
	{
		DeleteEntity(GetOwner());
	}

}

}
