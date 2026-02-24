#pragma context server

namespace MS
{

class WizardBase : CGameScript
{
	string CONV_ANIMS;
	int DID_WARN;
	int HAS_SYMBOL;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_DEATH3;
	string SOUND_DEATH4;

	WizardBase()
	{
		CONV_ANIMS = "converse2;converse1;talkleft;talkright;lean;pondering;pondering2;pondering3;";
		SOUND_DEATH1 = "scientist/scream1.wav";
		SOUND_DEATH2 = "scientist/scream2.wav";
		SOUND_DEATH3 = "scientist/scream3.wav";
		SOUND_DEATH4 = "scientist/scream4.wav";
	}

	void OnSpawn() override
	{
		SetRace("human");
		SetHealth(60);
		SetModel("npc/balancepriest2.mdl");
		SetWidth(32);
		SetHeight(72);
		SetSayTextRange(1024);
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
		SetBlind(true);
		SetMenuAutoOpen(1);
	}

	void anim_text()
	{
		if (!(AM_KNEELING))
		{
			string N_ANIMS = GetTokenCount(CONV_ANIMS, ";");
			N_ANIMS -= 1;
			int RND_ANIM = RandomInt(0, N_ANIMS);
			PlayAnim("critical", GetToken(CONV_ANIMS, RND_ANIM, ";"));
		}
		SayText(param1);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(IsValidPlayer(m_hLastStruck))) return;
		if ((DID_WARN)) return;
		DID_WARN = 1;
		SayText("What sort of maniac are you!? If any one of us dies Undamael will be freed!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3, SOUND_DEATH4
		array<string> sounds = {SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3, SOUND_DEATH4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CallExternal(FindEntityByName("wizard1"), "wizard_died");
	}

	void game_menu_getoptions()
	{
		if ((HAS_SYMBOL)) return;
		if ((ItemExists(param1, SYMB_ITEM)))
		{
			string reg.mitem.title = "Offer ";
			string reg.mitem.type = "payment";
			string reg.mitem.data = SYMB_ITEM;
			string reg.mitem.callback = "got_symbol";
		}
		else
		{
			string reg.mitem.title = "Offer ";
			string reg.mitem.type = "disabled";
		}
	}

	void got_symbol()
	{
		HAS_SYMBOL = 1;
		string WIZ_ID = FindEntityByName("wizard1");
		if (GetEntityProperty(WIZ_ID, "scriptvar") < 1)
		{
			SayText("Thank you. Remember we ll need all five at the same time.");
		}
		else
		{
			SayText(SAYTEXT_GOT_SYMBOL);
		}
		SetIdleAnim("kneel_idle");
		SetMoveAnim("kneel_idle");
		PlayAnim("critical", "kneel");
		CallExternal(WIZ_ID, "add_symbol");
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void do_oshi()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SetIdleAnim("crouch_idle");
		PlayAnim("once", "crouch_idle");
	}

}

}
