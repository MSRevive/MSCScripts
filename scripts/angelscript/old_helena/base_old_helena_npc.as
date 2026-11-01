#pragma context server

namespace MS
{

class BaseOldHelenaNpc : CGameScript
{
	string ANIM_DEATH;
	float FREQ_WARN;
	string LAST_STRUCK_TIME;
	int NPC_REPORT_ITEMS;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_DEATH3;
	string SOUND_DEATH4;
	string SOUND_HELP1;
	string SOUND_HELP2;
	string SOUND_HELP3;
	string SOUND_HELP4;
	string SOUND_HELP5;
	string SOUND_HELP6;
	string SOUND_HELP7;
	string SOUND_HELP8;
	string SOUND_HELP9;
	int WARN_DELAY;

	BaseOldHelenaNpc()
	{
		SOUND_HELP1 = "scientist/sci_fear1.wav";
		SOUND_HELP2 = "scientist/sci_fear2.wav";
		SOUND_HELP3 = "scientist/sci_fear3.wav";
		SOUND_HELP4 = "scientist/sci_fear4.wav";
		SOUND_HELP5 = "scientist/sci_pain1.wav";
		SOUND_HELP6 = "scientist/sci_pain2.wav";
		SOUND_HELP7 = "scientist/sci_pain3.wav";
		SOUND_HELP8 = "scientist/sci_pain4.wav";
		SOUND_HELP9 = "scientist/sci_pain5.wav";
		SOUND_DEATH1 = "scientist/scream1.wav";
		SOUND_DEATH2 = "scientist/scream2.wav";
		SOUND_DEATH3 = "scientist/scream3.wav";
		SOUND_DEATH4 = "scientist/scream4.wav";
		FREQ_WARN = 5.0;
		ANIM_DEATH = "death";
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetSayTextRange(1024);
		ScheduleDelayedEvent(0.1, "critical_npc");
	}

	void reset_warn_delay()
	{
		WARN_DELAY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetIdleAnim("crouch_idle");
		PlayAnim("critical", "crouch_idle");
		LAST_STRUCK_TIME = GetGameTime();
		LAST_STRUCK_TIME += 9.0;
		ScheduleDelayedEvent(10.0, "check_unfear");
		// PlayRandomSound from: SOUND_HELP1, SOUND_HELP2, SOUND_HELP3, SOUND_HELP4, SOUND_HELP5, SOUND_HELP6, SOUND_HELP7, SOUND_HELP8, SOUND_HELP9
		array<string> sounds = {SOUND_HELP1, SOUND_HELP2, SOUND_HELP3, SOUND_HELP4, SOUND_HELP5, SOUND_HELP6, SOUND_HELP7, SOUND_HELP8, SOUND_HELP9};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		int RAND_SCREAM = RandomInt(1, 4);
		if (RAND_SCREAM == 1)
		{
			SayText("Help! Help!");
		}
		if (RAND_SCREAM == 2)
		{
			SayText("Over here!");
		}
		if (RAND_SCREAM == 3)
		{
			SayText("Save me!");
		}
		if (RAND_SCREAM == 4)
		{
			SayText("The orcs! Save me from the orcs!");
		}
	}

	void check_unfear()
	{
		if (!(GetGameTime() > LAST_STRUCK_TIME)) return;
		SetIdleAnim("idle1");
		PlayAnim("critical", "idle1");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3
		array<string> sounds = {SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void old_helena_warboss_died()
	{
		NPC_REPORT_ITEMS = 1;
		SetInvincible(true);
		SetIdleAnim("idle1");
	}

	void OnDamage(int damage) override
	{
		if (!(IsValidPlayer(param1))) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

}

}
