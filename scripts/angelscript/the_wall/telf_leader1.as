#pragma context server

#include "monsters/telf_warrior_idagger.as"

namespace MS
{

class TelfLeader1 : CGameScript
{
	int DID_INTRO;
	int NPC_BASE_EXP;
	int NPC_IS_BOSS;
	int OVR_DROP_GOLD_AMT;

	TelfLeader1()
	{
		NPC_IS_BOSS = 1;
		NPC_BASE_EXP = 5000;
		OVR_DROP_GOLD_AMT = 5000;
		SetGlobalVar("G_DID_ESCORT_ALERT", 0);
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "Azura! The Felewyn seekers have sent humans after us!");
	}

	void elf_spawn()
	{
		SetName("Frostmistress Azura");
		SetHealth(6000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 6);
		GiveItem(GetOwner(), "item_telfh1");
		SetSayTextRange(1024);
		CatchSpeech("say_no", "elf");
		G_TELF_LEADER_COUNTER += 1;
	}

	void say_no()
	{
		if (G_TELF_ESCORTS > 1)
		{
			SayText("Lies! Kill them! " + KILL + THEM + NOW!);
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
		SayText("No! I'll not be taken back! Not even by humans!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "G_ESCORT_ALERT_SAYTEXT");
	}

}

}
