#pragma context server

namespace MS
{

class BaseTemporary : CGameScript
{
	int PLAYING_DEAD;

	BaseTemporary()
	{
		const float DEATH_DELAY = 0.5;
	}

	void OnSpawn() override
	{
		SetModel("null.mdl");
		SetHealth(1);
		SetWidth(0);
		SetHeight(0);
		SetSolid("none");
		SetName("tempent");
		SetRoam(false);
		SetFly(true);
		SetInvincible(true);
		SetHearingSensitivity(0);
		SetSkillLevel(0);
		SetRace("beloved");
		SetBloodType("none");
		DEATH_DELAY("end_me");
		PLAYING_DEAD = 1;
	}

	void end_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
