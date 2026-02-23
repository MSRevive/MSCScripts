#pragma context server

namespace MS
{

class OrcSummoner : CGameScript
{
	int NO_SPAWN_STUCK_CHECK;

	void OnSpawn() override
	{
		SetName("orc_summoner");
		SetName("Blackhand Summoner");
		SetInvincible(true);
		SetRace("orc");
		SetModel("monsters/Orc.mdl");
		SetProp(GetOwner(), "skin", 2);
		SetWidth(5);
		SetHeight(5);
		SetHealth(9999);
		SetBloodType("red");
		SetIdleAnim("kneel");
		SetMoveAnim("kneel");
		PlayAnim("once", "kneel");
		NO_SPAWN_STUCK_CHECK = 1;
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
		SetSayTextRange(4096);
	}

	void ext_players_r_here()
	{
		SayText("No! The binding is not yet complete!");
		ScheduleDelayedEvent(2.0, "summon_fail");
	}

	void summon_fail()
	{
		// TODO: playmp3 all combat media/Suspense07.mp3
		string BONE_ABOM = FindEntityByName("bone_abomination");
		string FIRE_DJINN = FindEntityByName("fire_djinn");
		if ((IsEntityAlive(FIRE_DJINN)))
		{
			CallExternal(FIRE_DJINN, "kill_zugdah");
		}
		if ((IsEntityAlive(BONE_ABOM)))
		{
			EmitSound(GetOwner(), 0, "voices/orc/die.wav", 10);
			CallExternal(BONE_ABOM, "eat_me");
		}
		UseTrigger("mm_circle_fade");
	}

	void ext_me_die()
	{
		SetInvincible(false);
		DoDamage(GetOwner(), "direct", 2000, 100, GAME_MASTER);
		EmitSound(GetOwner(), 0, "voices/orc/die.wav", 10);
		PlayAnim("once", "break");
		PlayAnim("hold", "die_fallback");
		SetSolid("none");
		ScheduleDelayedEvent(5.0, "fade_out");
	}

	void fade_out()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
