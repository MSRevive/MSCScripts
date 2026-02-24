#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class OrcforBase : CGameScript
{
	float ARTI_CHANCE;
	string ORCFOR_CHEST_FOUND;

	OrcforBase()
	{
		ARTI_CHANCE = 0.55;
	}

	void OnSpawn() override
	{
		if (!(ORCFOR_CHEST_FOUND))
		{
			ORCFOR_CHEST_FOUND = 1;
			G_GAVE_ARTI1 += 1;
		}
		ARTI_CHANCE = (ARTI_CHANCE * G_GAVE_ARTI1);
		tc_add_artifact("bows_sxbow", ARTI_CHANCE);
	}

	void chest_additems()
	{
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "blunt_ms1", 1, 0);
		}
		else
		{
			if (RandomInt(1, 20) == 1)
			{
				AddStoreItem(STORENAME, "blunt_ms2", 1, 0);
			}
			else
			{
				if (RandomInt(1, 30) == 1)
				{
					AddStoreItem(STORENAME, "blunt_ms3", 1, 0);
				}
			}
		}
	}

}

}
