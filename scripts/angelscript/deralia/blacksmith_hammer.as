#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class BlacksmithHammer : CGameScript
{
	int COUNT;
	float DELAY;
	int REST;

	BlacksmithHammer()
	{
		COUNT = 0;
		REST = 10;
		DELAY = 1.05;
		Precache("3dmflaora.spr");
		Precache("amb/fx_anvil.wav");
		const int NO_CHAT = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(DELAY);
		if (COUNT < 8)
		{
			COUNT += 1;
		}
		if (COUNT == 8)
		{
			if (REST > 0)
			{
				if (DELAY == 8.36)
				{
					PlayAnim("critical", "smith_hammer_look");
					COUNT = 0;
					DELAY = 1.05;
					REST--;
				}
				else
				{
					DELAY = 8.36;
				}
			}
		}
		if (REST == 0)
		{
			if (DELAY == 10.86)
			{
				PlayAnim("critical", "smith_hammer_idle");
				REST = 10;
				COUNT = 0;
				DELAY = 1.05;
			}
			else
			{
				DELAY = 10.86;
			}
		}
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("A blacksmith");
		SetWidth(1);
		SetHeight(72);
		SetRoam(false);
		SetModel("npc/blacksmith.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetIdleAnim("smith_hammer_time");
		SetInvincible(true);
		SetAngles("face");
	}

	void hammer_sound()
	{
		EmitSound(GetOwner(), 0, "amb/fx_anvil.wav", 10);
		Effect("tempent", "trail", "3dmflaora.spr", /* TODO: $relpos */ $relpos(-11, 15, -10), /* TODO: $relpos */ $relpos(-11, 15, 25), 5, 0.5, 1, 10, 10);
	}

}

}
