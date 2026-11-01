#pragma context server

namespace MS
{

class FirstSkillgain : CGameScript
{
	void game_learnskill()
	{
		if (!(param2 == "Proficiency")) return;
		if (!(param3 >= 2)) return;
		string TEXT = "You have gained skill in proficiency. ";
		TEXT += "|This trait unlocks new abilities with certain weapons.";
		TEXT += "|To use them, double click attack to start charging.";
		TEXT += "||Level 1 charge is usually extra damage.  With higher";
		TEXT += "|proficiency comes more advanced attacks.";
		ShowHelpTip(GetOwner(), "help_skill_gain", "Proficiency", TEXT);
	}

}

}
