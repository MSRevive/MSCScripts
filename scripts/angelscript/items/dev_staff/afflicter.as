#pragma context server

namespace MS
{

class Afflicter : CGameScript
{
	float AFFLICT_DMG;
	int AFFLICT_DURATION;
	string AFFLICT_PARAMS;
	string AFFLICT_SCRIPT;
	string AFFLICT_SKILL;

	Afflicter()
	{
		AFFLICT_SCRIPT = "effects/dot_fire";
		AFFLICT_DURATION = 3;
		AFFLICT_DMG = 3.33;
		AFFLICT_SKILL = "swordsmanship";
		AFFLICT_PARAMS = "none";
	}

	void try_applyeffect()
	{
		find_beam_target();
		if (GetEntityOrigin(BEAM_TARGET) == "(0.00,0.00,0.00)")
		{
			return;
		}
		ApplyEffect(BEAM_TARGET, AFFLICT_SCRIPT, AFFLICT_DURATION, GetEntityIndex(GetOwner()), AFFLICT_DMG, AFFLICT_SKILL);
	}

	void set_affliction()
	{
		if (param1 == "fire")
		{
			AFFLICT_SCRIPT = "effects/dot_fire";
			AFFLICT_SKILL = "spellcasting.fire";
		}
		else
		{
			if (param1 == "cold")
			{
				AFFLICT_SCRIPT = "effects/dot_cold";
				AFFLICT_SKILL = "spellcasting.ice";
			}
			else
			{
				if (param1 == "lightning")
				{
					AFFLICT_SCRIPT = "effects/dot_lightning";
					AFFLICT_SKILL = "spellcasting.lightning";
				}
				else
				{
					if (param1 == "holy")
					{
						AFFLICT_SCRIPT = "effects/dot_holy";
						AFFLICT_SKILL = "spellcasting.divination";
					}
					else
					{
						if (param1 == "poison")
						{
							AFFLICT_SCRIPT = "effects/dot_poison";
							AFFLICT_SKILL = "spellcasting.affliction";
						}
						else
						{
							if (param1 == "acid")
							{
								AFFLICT_SCRIPT = "effects/dot_acid";
								AFFLICT_SKILL = "spellcasting.affliction";
							}
						}
					}
				}
			}
		}
		AFFLICT_DURATION = param2;
		AFFLICT_DMG = param3;
	}

}

}
