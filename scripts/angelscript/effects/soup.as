#pragma context server

namespace MS
{

class Soup : CGameScript
{
	string FX_DURATION;
	int FX_END_TIME;
	string FX_POOPY;
	int HP_AMT;
	int MP_AMT;
	int NERF_TICK;
	float SOUP_TICKRATE;
	string game.effect.id;
	int game.effect.removeondeath;

	Soup()
	{
		string reg.effect.name = "soup";
		game.effect.id = "soup";
		string reg.effect.flags = "nostack";
		string reg.effect.script = currentscript;
		game.effect.removeondeath = 1;
		// TODO: registereffect
		SOUP_TICKRATE = 0.5;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(SOUP_TICKRATE);
		HealEntity(GetOwner(), HP_AMT);
		GiveMP(MP_AMT);
	}

	void game_activate()
	{
		FX_DURATION = param1;
		FX_POOPY = param2;
		HP_AMT = 38;
		MP_AMT = 58;
		NERF_TICK = 9;
		FX_DURATION("soup_duration_end");
		NERF_TICK("nerf_soup");
	}

	void nerf_soup()
	{
		HP_AMT /= 2;
		MP_AMT /= 2;
		NERF_TICK *= 2;
		if ((FX_POOPY))
		{
			EmitSound(GetOwner(), 0, "fart.wav", 10);
			SendPlayerMessage(GetOwner(), "Oh no. You let one squeak out.");
			XDoDamage(GetEntityOrigin(GetOwner()), 65, 10, 0, GetOwner(), GetOwner(), "spellcasting.affliction", "poison_effect", "dmgevent:poopy");
			ClientEvent("new", "all", "effects/sfx_poison_cloud", GetEntityOrigin(GetOwner()), 20, 1, 0);
		}
		NERF_TICK("nerf_soup");
	}

	void poopy_dodamage()
	{
		if (!(param1)) return;
		if (!(/* TODO: $get_takedmg */ $get_takedmg(param2, "poison") > 0)) return;
		ApplyEffect(param2, "effects/dot_poison", 6, GetEntityIndex(GetOwner()), 10, 0, "spellcasting.affliction");
		if (!(RandomInt(0, 3) == 0)) return;
		if (!(GetEntityRace(param2) != "vermin")) return;
		if (!(GetEntityRace(param2) != "wildanimal")) return;
		if (!(GetEntityRace(param2) != "spider")) return;
		if (!((GetEntityRace(param2)).findFirst("ant_") >= 0)) return;
		string L_STR = "Ewww! What's that smell?;";
		CallExternal(param2, "ext_speak", GetRandomToken(L_STR, ";"));
	}

	void soup_duration_end()
	{
		SendColoredMessage(GetOwner(), "Ah, that soup was good while it lasted...");
		RemoveScript();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		FX_END_TIME = 0;
		soup_duration_end();
	}

	void ext_resetsoup()
	{
		HP_AMT = 38;
		MP_AMT = 58;
		NERF_TICK = 9;
		FX_END_TIME = (GetGameTime() + FX_DURATION);
	}

}

}
