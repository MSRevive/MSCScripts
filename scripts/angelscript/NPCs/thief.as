#pragma context server

namespace MS
{

class Thief : CGameScript
{
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	string CURRENT_ENEMY;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int IS_FLEEING;
	int SEE_ENEMY;
	int STEAL;
	int STEALING;
	int THIEF;

	Thief()
	{
		if (STEAL == 1)
		{
		}
		SetVolume(8);
		Say("hello1[50] *[20] *[55] *[55] *[23] *[22]");
		SetRoam(false);
		ScheduleDelayedEvent(4, "resumeroam");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(4);
		CanSee("enemy");
		SetMoveDest(m_hLastSeen);
		if (STEAL == 0)
		{
		}
		STEALING = RandomInt(-40, -20);
		// TODO: offer ent_lastseen gold STEALING
		gold += STEALING;
		PlayAnim("once", "return_needle");
		SetRoam(false);
		ScheduleDelayedEvent(4, "resumeroam");
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.2);
		CanSee(CURRENT_ENEMY);
		SetMoveAnim("run");
		SetMoveDest(m_hLastSeen);
		SEE_ENEMY = 1;
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(0.3);
		CanSee(CURRENT_ENEMY);
		SetMoveDest(m_hLastSeen);
		PlayAnim("once", "beatdoor");
	}

	void OnSpawn() override
	{
		SetHealth(45);
		SetMaxHealth(45);
		SetGold(10);
		SetWidth(32);
		SetHeight(72);
		SetRace("orc");
		SetName("Shifty Person");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetDamageResistance("all", ".9");
		SetModelBody(0, 1);
		SetModelBody(1, 5);
		SetMoveAnim("walk");
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.6;
		THIEF = 0;
		STEAL = 0;
		FLEE_HEALTH = 40;
		FLEE_CHANCE = 1.0;
		IS_FLEEING = 0;
		CatchSpeech("say_gold", "gold");
		CatchSpeech("say_gold", "money");
		CatchSpeech("say_gold", "thief");
		CatchSpeech("say_gold", "bandit");
		CatchSpeech("say_gold", "back");
		CatchSpeech("say_gold2", "gold");
		CatchSpeech("say_gold2", "money");
		CatchSpeech("say_gold2", "thief");
		CatchSpeech("say_gold2", "bandit");
		CatchSpeech("say_gold2", "back");
		CatchSpeech("say_thief", "lock");
		CatchSpeech("say_thief", "kill");
		CatchSpeech("say_thief", "execute");
		CatchSpeech("say_thief", "execution");
		CatchSpeech("say_thief", "prison");
	}

	void resumeroam()
	{
		SetRoam(true);
	}

	void robbed()
	{
		CURRENT_ENEMY = "ent_laststole";
		SayText("Aha! Thief!");
		SetMoveDest("ent_laststole");
	}

	void wander()
	{
		SetMoveAnim("walk");
		SEE_ENEMY = 0;
		ScheduleDelayedEvent(12, "losethief");
	}

	void losethief()
	{
		SEE_ENEMY = "equals";
		CURRENT_ENEMY = "noenemy";
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void struck()
	{
		if (!(CURRENT_HEALTH <= FLEE_HEALTH)) return;
		if (!(RandomInt(0, 100) <= FLEE_CHANCE)) return;
		SetMoveAnim("run");
		SetMoveDest("flee");
		IS_FLEEING = 1;
		ScheduleDelayedEvent(0.5, "stopflee");
	}

	void say_gold()
	{
		if (!(THIEF == 0)) return;
		THIEF = 1;
		SayText(I + " don t know what you re talking about.");
		if (!(THIEF == 3)) return;
		SayText("Go away.");
	}

	void say_gold2()
	{
		if (!(THIEF == 1)) return;
		THIEF = 2;
		SayText("Look , " + I + " don t know what you re talking about. With guards around , nobody would dare to steal.");
	}

	void say_thief()
	{
		if (!(THIEF == 2)) return;
		THIEF = 3;
		STEAL = 1;
		SayText("Oh... he told you that , did he? Look , if you don t report me, I ll give you this.");
		ScheduleDelayedEvent(4, "say_thief2");
	}

	void say_thief2()
	{
		SayText("It s a map of where the band is. I m just a nobody among those. If you want to catch real thieves , go for them , not me.");
		// TODO: offer ent_lastspoke item_thiefmap
	}

}

}
