#pragma context server

namespace MS
{

class DqAdjustDamage : CGameScript
{
	float DAMAGE_MULTIPLIER;
	string DQ_WHERE_IS_THE_CREATOR;
	string MAX_DMG;

	DqAdjustDamage()
	{
		DAMAGE_MULTIPLIER = 0.5;
		DQ_WHERE_IS_THE_CREATOR = GetEntityIndex("ent_creationowner");
		MAX_DMG = (GetEntityProperty(DQ_WHERE_IS_THE_CREATOR, "scriptvar") * DAMAGE_MULTIPLIER);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (MAX_DMG != "MAX_DMG")
		{
			string L_TARGET = param1;
			string L_DMG = param2;
			string L_DMG_TYPE = param3;
			if ((IsValidPlayer(L_TARGET)))
			{
				if (L_DMG > MAX_DMG)
				{
					SetDamage("dmg");
					ReturnData((MAX_DMG / L_DMG));
				}
			}
		}
	}

}

}
