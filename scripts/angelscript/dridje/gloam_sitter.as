#pragma context server

namespace MS
{

class GloamSitter : CGameScript
{
	string ENEMY_ID;
	string SLAYER_ID;

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(10, 60));
		PlayAnim("once", "cowering_in_corner");
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(2.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ENEMY_ID = /* TODO: $get_insphere */ $get_insphere(256, "enemy");
		if ((IsEntityAlive(ENEMY_ID)))
		{
		}
		int RND_ANIM = RandomInt(1, 2);
		if (RND_ANIM == 1)
		{
			PlayAnim("once", "sstruggleidle");
		}
		if (RND_ANIM == 2)
		{
			PlayAnim("once", "sstruggle");
		}
		string NME_TARGET = GetEntityProperty(ENEMY_ID, "scriptvar");
		if (GetEntityName(NME_TARGET) != "Frightened Mercenary")
		{
		}
		CallExternal(ENEMY_ID, "npcatk_settarget", GetEntityIndex(GetOwner()));
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Frightened Mercenary");
		SetWidth(32);
		SetHeight(64);
		SetRoam(false);
		SetRace("human");
		SetBloodType("red");
		SetModel("npc/guard1.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("sitidle");
		SetMoveAnim("sitidle");
		PlayAnim("once", "sitidle");
		SetBlind(true);
		SetNoPush(true);
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(10.0, "get_slayer_id");
	}

	void get_slayer_id()
	{
		SLAYER_ID = FindEntityByName("agrath");
	}

	void say_hi()
	{
		PlayAnim("once", "cowering_in_corner");
		SayText("Have you seen those things!? " + I + " m not going in there again!");
	}

	void game_menu_getoptions()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string reg.mitem.title = "Hail.";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
	}

	void OnDamage(int damage) override
	{
		if (!(IsValidPlayer(param1))) return;
		SetDamage("dmg");
		SetDamage("hit");
		return;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		PlayAnim("hold", "diebackward");
		// PlayRandomSound from: "voices/kcult_die1.wav", "voices/human/male_die.wav"
		array<string> sounds = {"voices/kcult_die1.wav", "voices/human/male_die.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
