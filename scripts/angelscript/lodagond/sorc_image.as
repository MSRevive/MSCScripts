#pragma context server

namespace MS
{

class SorcImage : CGameScript
{
	float ANIM_SPEED;
	string FACE_YAW;

	SorcImage()
	{
	}

	void OnSpawn() override
	{
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 8);
		SetNoPush(true);
		SetInvincible(true);
		SetSolid("none");
		SetRace("demon");
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetSayTextRange(2048);
		ANIM_SPEED = 1.0;
		SetAnimFrameRate(ANIM_SPEED);
		Effect("glow", GetOwner(), Vector3(200, 200, 255), 32, -1, 0);
	}

	void ext_convo1()
	{
		SetSayTextRange(2048);
		SayText("Release me!");
		EmitSound(GetOwner(), 0, "voices/sc_convo1.wav", 10);
		PlayAnim("critical", "warcry");
		ScheduleDelayedEvent(0.1, "slow_down");
	}

	void ext_convo5()
	{
		PlayAnim("critical", "warcry");
		EmitSound(GetOwner(), 0, "voices/sc_convo5.wav", 10);
		SayText("Ha! Maldora is NOT the Doom Bringer! He's an imposter with delusions of grandeur!");
	}

	void ext_convo8()
	{
		PlayAnim("critical", "warcry");
		EmitSound(GetOwner(), 0, "voices/sc_convo8.wav", 10);
		SayText("You'll... be dead before that happens! If you'd bother to look behind you...");
	}

	void slow_down()
	{
		if (!(ANIM_SPEED >= 0.01)) return;
		ScheduleDelayedEvent(0.25, "slow_down");
		ANIM_SPEED -= 0.05;
		if (ANIM_SPEED <= 0.01)
		{
			ANIM_SPEED = 0.0001;
		}
		LogDebug("slow_down ANIM_SPEED");
		SetAnimFrameRate(ANIM_SPEED);
	}

	void game_dynamically_created()
	{
		FACE_YAW = param1;
		ScheduleDelayedEvent(0.1, "set_yaw");
	}

	void set_yaw()
	{
		SetAngles("face");
	}

	void sorc_in()
	{
		ScheduleDelayedEvent(1.0, "sorc_go");
	}

	void sorc_go()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		UseTrigger("sorc_go");
		SpawnNPC("monsters/sorc_chief1", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		EmitSound(GetOwner(), 0, "debris/bustglass3.wav", 10);
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 32), 1, 40, 10, 100, 30);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
