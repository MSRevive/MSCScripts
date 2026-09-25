#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Nalchemist : CGameScript
{
	int NO_HAIL;
	int NO_JOB;
	string STORE_NAME;
	int STORE_SELLMENU;
	string STORE_TRIGGERTEXT;

	Nalchemist()
	{
		STORE_NAME = "Alchemy";
		STORE_TRIGGERTEXT = "store buy purchase";
		STORE_SELLMENU = 0;
		NO_JOB = 1;
		NO_HAIL = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(0);
		SetName("Potion Seller");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		CatchSpeech("say_easteregg", "strongest");
	}

	void say_easteregg()
	{
		PlayAnim("once", "converse1");
		bchat_mouth_move();
		EmitSound(GetOwner(), 5, "voices/deralia/potiondeny.wav", 10);
		SayText("My potions are too strong for you , traveller.");
	}

}

}
