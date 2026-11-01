#pragma context server

namespace MS
{

class BaseAimProj : CGameScript
{
	void baseaim_adjust_angles()
	{
		if (ANGLE_ADJ_DIVIDER == "ANGLE_ADJ_DIVIDER")
		{
			if (ATTACK_SPEED >= 1000)
			{
				ANGLE_ADJ_DIVIDER = 60;
			}
			if (ATTACK_SPEED >= 900)
			{
				ANGLE_ADJ_DIVIDER = 45;
			}
			if (ATTACK_SPEED >= 800)
			{
				ANGLE_ADJ_DIVIDER = 40;
			}
			if (ATTACK_SPEED >= 700)
			{
				ANGLE_ADJ_DIVIDER = 30;
			}
			if (ATTACK_SPEED >= 600)
			{
				ANGLE_ADJ_DIVIDER = 20;
			}
			if (ATTACK_SPEED >= 500)
			{
				ANGLE_ADJ_DIVIDER = 12;
			}
			if (ATTACK_SPEED < 500)
			{
				ANGLE_ADJ_DIVIDER = 10;
			}
		}
		string TARGET_POS = GetEntityOrigin(HUNT_LASTTARGET);
		if (!(IsValidPlayer(HUNT_LASTTARGET)))
		{
			string HALF_HEIGHT = GetEntityHeight(HUNT_LASTTARGET);
			HALF_HEIGHT /= 2;
			TARGET_POS += "z";
		}
		float TARGET_DIST = Distance(TARGET_POS, GetMonsterProperty("origin"));
		TARGET_DIST /= ANGLE_ADJ_DIVIDER;
		SetAngles("add_view.pitch");
	}

}

}
