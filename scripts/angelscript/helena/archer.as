#pragma context server

#include "NPCs/human_guard_archer.as"

namespace MS
{

class Archer : CGameScript
{
	int NO_CHAT;
	string NPC_NO_PLAYER_DMG;

	Archer()
	{
		NO_CHAT = 1;
	}

	void OnSpawn() override
	{
		SetName("Archer");
		if (!(true)) return;
		if (StringToLower(GetMapName()) == "foutpost")
		{
			SetRace("human");
			NPC_NO_PLAYER_DMG = 1;
		}
		if (!(GetMapName() == "helena")) return;
		SetAngles("face");
	}

	void LightAttack()
	{
		int RAND = RandomInt(1, 100);
		if (RAND > 60)
		{
			SetSayTextRange(500);
			if (RAND < 85)
			{
				SayText("Small attack party incoming!");
			}
			else
			{
				SayText("Raiding party!");
			}
		}
	}

	void MediumAttack()
	{
		int RAND = RandomInt(1, 100);
		if (RAND > 60)
		{
			SetSayTextRange(500);
			if (RAND < 85)
			{
				SayText("Large attack group heading for us!");
			}
			else
			{
				SayText("Stand ready for the attack!");
			}
		}
	}

	void HeavyAttack()
	{
		int RAND = RandomInt(1, 100);
		if (RAND > 60)
		{
			SetSayTextRange(500);
			if (RAND < 85)
			{
				SayText("It s a siege!");
			}
			else
			{
				SayText("We need everyone at the gates! " + NOW!);
			}
		}
	}

	void CatapaultsIncoming()
	{
		int RAND = RandomInt(1, 100);
		if (RAND > 60)
		{
			SetSayTextRange(500);
			if (RAND < 85)
			{
				SayText("Take cover!");
			}
			else
			{
				SayText("Projectiles inbound!");
			}
		}
	}

}

}
