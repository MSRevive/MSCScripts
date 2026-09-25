#pragma context server

namespace MS
{

class TreasurePicker : CGameScript
{
	string TREASURE_CHOICE;

	void OnSpawn() override
	{
		SetName("Treasure Picker");
		SetInvincible(true);
		SetSolid("none");
		SetRoam(false);
		SetModel("none");
		int TRES_CHOICE = RandomInt(1, 100);
		if (TRES_CHOICE > 50)
		{
			SendInfoMsg("all", "CRITICAL_ITEM_DROPPED The hellforge has summoned forth a Granite Maul");
			TREASURE_CHOICE = "blunt_granitemaul";
		}
		else
		{
			if (TRES_CHOICE <= 15)
			{
				SendInfoMsg("all", "CRITICAL_ITEM_DROPPED The hellforge has summoned forth a Raven Mace");
				TREASURE_CHOICE = "blunt_ravenmace";
			}
			else
			{
				if (TRES_CHOICE > 15)
				{
					SendInfoMsg("all", "CRITICAL_ITEM_DROPPED The hellforge has summoned forth a Dark Maul");
					TREASURE_CHOICE = "blunt_darkmaul";
				}
			}
		}
		ScheduleDelayedEvent(0.1, "create_treasure");
	}

	void create_treasure()
	{
		SpawnItem(TREASURE_CHOICE, GetEntityOrigin(GetOwner()));
		DeleteEntity(GetOwner());
	}

}

}
