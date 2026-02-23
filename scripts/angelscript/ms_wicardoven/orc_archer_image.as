#pragma context server

namespace MS
{

class OrcArcherImage : CGameScript
{
	void OnSpawn() override
	{
		SetName("Orc Lieutenant Shagul");
		SetRace("orc");
		SetInvincible(true);
		SetName("orc_a");
		SetModel("monsters/orc.mdl");
		SetSolid("none");
		SetSayTextRange(2048);
		SetModelBody(0, 3);
		SetModelBody(1, 3);
		SetModelBody(2, 3);
	}

	void say_excuse1()
	{
		PlayAnim("critical", "warcry");
		if (GetPlayerCount() == 1)
		{
			string PRO_NOUN = "He was";
		}
		if (GetPlayerCount() > 1)
		{
			string PRO_NOUN = "They were";
		}
		SayText("PRO_NOUN too powerful for us!");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/orca_2fmaldora1.wav", 10);
	}

	void say_whadup()
	{
		PlayAnim("hold", "deflectcounter");
		SayText("Yeah , what s up with that!?");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/orca_2fmaldora2.wav", 10);
	}

	void die()
	{
		SetIdleAnim("die_fallback");
		SetMoveAnim("die_fallback");
		EmitSound(GetOwner(), 0, "voices/orc/die.wav", 10);
		PlayAnim("hold", "die_fallback");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 200, 3, 3);
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void face_me()
	{
		SetAngles("face_origin");
		ScheduleDelayedEvent(0.1, "straighten_up");
	}

	void straighten_up()
	{
		SetAngles("face");
	}

}

}
