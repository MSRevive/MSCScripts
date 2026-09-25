#pragma context server

namespace MS
{

class ClockBase : CGameScript
{
	int local.lasthour;
	int local.lastminute;

	void OnSpawn() override
	{
		SetAngles("face.x");
		SetProp(GetOwner(), "speed", 0);
		local.lasthour = -1;
		local.lastminute = -1;
	}

	void worldevent_time()
	{
		if (("local.updatehourhand"))
		{
			set_hour_hand(param1, param3);
		}
		if (("local.updateminutehand"))
		{
			set_minute_hand(param2, param3);
		}
	}

	void set_hour_hand()
	{
		if (!(param1 != local.lasthour)) return;
		string L_HOUR_POSITION = param1;
		L_HOUR_POSITION *= 30;
		string L_MIN_OFFSET = param1;
		L_MIN_OFFSET /= 60;
		L_MIN_OFFSET *= 30;
		string L_HAND_POSITION = L_HOUR_POSITION;
		L_HAND_POSITION += L_MIN_OFFSET;
		L_HAND_POSITION *= -1;
		SetAngles("face.x");
		local.lasthour = param1;
		int L_HAND_SPEED = -3220;
		L_HAND_SPEED /= 43200;
		L_HAND_SPEED *= param2;
		SetProp(GetOwner(), "avelocity", Vector3(L_HAND_SPEED, 0, 0));
	}

	void set_minute_hand()
	{
		if (!(param1 != local.lastminute)) return;
		string L_HAND_POSITION = param1;
		L_HAND_POSITION /= 60;
		L_HAND_POSITION *= 360;
		L_HAND_POSITION *= -1;
		SetAngles("face.x");
		local.lastminute = param2;
		int L_HAND_SPEED = -3220;
		L_HAND_SPEED /= 3600;
		L_HAND_SPEED *= param2;
		SetProp(GetOwner(), "avelocity", Vector3(L_HAND_SPEED, 0, 0));
	}

}

}
