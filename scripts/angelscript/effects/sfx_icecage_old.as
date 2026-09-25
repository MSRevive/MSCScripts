#pragma context server

namespace MS
{

class SfxIcecageOld : CGameScript
{
	int rheight;
	string script.owner;
	int script.tilt;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		snap_to_owner();
	}

	void game_dynamically_created()
	{
		script.owner = param1;
		script.tilt = 1;
		string MY_DURATION = param2;
		string MY_OWNER = param1;
		LogDebug("ice cage spawn");
		CallExternal(MY_OWNER, "freeze_solid_start", MY_DURATION);
		SetModel("weapons/magic/icecage.mdl");
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetProp(GetOwner(), "solid", 0);
		SetAngles("angles.z");
		SetFly(true);
		SetInvincible(true);
		PlayAnim("once", "idle");
		SetAnimFrameRate(0);
		snap_to_owner();
		set_tilt();
		PARAM2("die");
	}

	void snap_to_owner()
	{
		string l.pos = GetEntityOrigin(script.owner);
		rheight = 0;
		if (IsValidPlayer(script.owner) == 1)
		{
			rheight = 0;
			l.pos += Vector3(0, 0, rheight);
		}
		SetEntityOrigin(GetOwner(), l.pos);
		if ((IsEntityAlive(script.owner))) return;
	}

	void die()
	{
		SetProp(GetOwner(), "avelocity", Vector3(0, 0, 0));
		DeleteEntity(GetOwner());
	}

}

}
