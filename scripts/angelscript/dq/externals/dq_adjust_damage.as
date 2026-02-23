#pragma context server

namespace MS
{

class DqAdjustDamage : CGameScript
{
	DqAdjustDamage()
	{
		const float DAMAGE_MULTIPLIER = 0.5;
		const string DQ_WHERE_IS_THE_CREATOR = GetEntityIndex("ent_creationowner");
		const string MAX_DMG = /* TODO: $math(multiply) */ GetEntityProperty(DQ_WHERE_IS_THE_CREATOR, "scriptvar");
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
					ReturnData(/* TODO: $math(divide) */ MAX_DMG);
				}
			}
		}
	}

}

}
