#pragma context server

#include "monsters/telf_warrior_laxe.as"

namespace MS
{

class TelfLeader2 : CGameScript
{
	int DID_INTRO;
	int NPC_IS_BOSS;

	TelfLeader2()
	{
		NPC_IS_BOSS = 1;
		const int OVR_DROP_GOLD_AMT = 5000;
		const int NPC_BASE_EXP = 5000;
		SetGlobalVar("G_DID_ESCORT_ALERT", 0);
		SetGlobalVar("G_ORC_ALERT", 1);
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "Humans! Those fiends sent humans in after us!");
	}

	void elf_spawn()
	{
		SetName("Ulectrath the Storm");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 3);
		GiveItem(GetOwner(), "item_telfh2");
		SetSayTextRange(1024);
		CatchSpeech("say_no", "elf");
		G_TELF_LEADER_COUNTER += 1;
	}

	void say_no()
	{
		if (G_TELF_ESCORTS > 1)
		{
			SayText("Lies! Kill them! KILL THEM NOW!");
		}
		else
		{
			SayText("Lies! You'll not take any of us alive!");
		}
	}

	void npc_targetsighted()
	{
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		SayText("How dare you betray your father Torkalath with the stench of Felewyn!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "G_ESCORT_ALERT_SAYTEXT");
	}

}

}
