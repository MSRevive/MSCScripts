#pragma context server

namespace MS
{

class SfxIcewave : CGameScript
{
	int TILT_SPEED;
	int rheight;
	string script.owner;
	int script.tilt;

	SfxIcewave()
	{
		TILT_SPEED = 70;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		snap_to_owner();
	}

	void game_dynamically_created()
	{
		script.owner = param1;
		script.tilt = 1;
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 53);
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetProp(GetOwner(), "solid", 0);
		SetAngles("angles.z");
		SetFly(true);
		SetInvincible(true);
		PlayAnim("once", "idle");
		SetAnimFrameRate(2);
		snap_to_owner();
		set_tilt();
		PARAM2("die");
	}

	void set_tilt()
	{
		SetRepeatDelay(0.5);
		if ((script.tilt))
		{
			SetProp(GetOwner(), "avelocity", Vector3(0, 0, /* TODO: $neg */ $neg(TILT_SPEED)));
			script.tilt = 0;
		}
		else
		{
			SetProp(GetOwner(), "avelocity", Vector3(0, 0, TILT_SPEED));
			script.tilt = 1;
		}
	}

	void snap_to_owner()
	{
		string l.pos = GetEntityOrigin(script.owner);
		rheight = 37;
		if (IsValidPlayer(script.owner) == 0)
		{
			rheight = GetEntityHeight(script.owner);
			rheight += 15;
		}
		l.pos += Vector3(0, 0, rheight);
		SetEntityOrigin(GetOwner(), l.pos);
		if ((IsEntityAlive(script.owner))) return;
	}

	void die()
	{
		SetProp(GetOwner(), "avelocity", Vector3(0, 0, 0));
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
