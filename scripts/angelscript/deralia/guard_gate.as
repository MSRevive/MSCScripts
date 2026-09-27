#pragma context server

#include "deralia/guard.as"

namespace MS
{

class GuardGate : CGameScript
{
	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		if (!(IS_HUNTING))
		{
			if ((CanSee("ally", 80)))
			{
				string L_ENT = GetEntityIndex(m_hLastSeen);
				string L_EASTER_EGG = "Tamed Boar";
				if (GetEntityName(L_ENT) == L_EASTER_EGG)
				{
					if (!(IsValidPlayer(L_ENT)))
					{
						int L_RAND = RandomInt(0, 3);
						if (L_RAND == 0)
						{
							string L_SPEAK = "G'day, sir";
						}
						else
						{
							if (L_RAND == 1)
							{
								string L_SPEAK = "*Squeal?*";
							}
							else
							{
								if (L_RAND == 2)
								{
									string L_SPEAK = "henlo";
								}
								else
								{
									if (L_RAND == 3)
									{
										string L_SPEAK = "*cough cough*";
									}
								}
							}
						}
						CallExternal(L_ENT, "ext_speak", L_SPEAK);
					}
				}
				npcatk_setmovedest(L_ENT, 128);
				EmitSound(GetOwner(), 0, "npc/hello1.wav", 5);
				Say("[.83] [.33] [.91] [.91] [.38] [.36]");
			}
		}
	}

}

}
