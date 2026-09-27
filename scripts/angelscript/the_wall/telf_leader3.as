#pragma context server

#include "monsters/telf_warrior_fmace_dshield.as"

namespace MS
{

class TelfLeader3 : CGameScript
{
	string ANIM_ATTACK;
	int DID_INTRO;
	int NPC_BASE_EXP;
	int NPC_IS_BOSS;
	int OVR_DROP_GOLD_AMT;

	TelfLeader3()
	{
		NPC_IS_BOSS = 1;
		OVR_DROP_GOLD_AMT = 5000;
		NPC_BASE_EXP = 5000;
		SetGlobalVar("G_DID_ESCORT_ALERT", 0);
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "Treachery! Children of Torkalath slaved to the will of Felewyn!");
	}

	void elf_spawn()
	{
		SetName("Ivicta of the Hammer");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetRace("torkie");
		SetModelBody(1, 2);
		SetModelBody(2, 1);
		GiveItem(GetOwner(), "item_telfh3");
		SetSayTextRange(1024);
		CatchSpeech("say_no", "elf");
		G_TELF_LEADER_COUNTER += 1;
	}

	void OnPostSpawn() override
	{
		ANIM_ATTACK = "swordswing1_R";
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
		SayText("Kray Eldorad shall fall!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetGlobalVar("G_ESCORT_ALERT_SAYTEXT", "G_ESCORT_ALERT_SAYTEXT");
	}

}

}
