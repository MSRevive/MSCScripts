#pragma context server

namespace MS
{

class OrcChampionImage : CGameScript
{
	void OnSpawn() override
	{
		SetName("Orc Lieutenant Veral");
		SetRace("orc");
		SetInvincible(true);
		SetName("orc_b");
		SetModel("monsters/orc.mdl");
		SetSolid("none");
		SetSayTextRange(2048);
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
	}

	void say_minions()
	{
		PlayAnim("critical", "shielddeflect1");
		SayText("...And we couldn t control your minions! They kept attacking us!");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/orcb_2fmaldora.wav", 10);
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
