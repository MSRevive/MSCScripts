#pragma context server

namespace MS
{

class BaseXmass : CGameScript
{
	string ANIM_XMASS_WAVE;

	BaseXmass()
	{
		ANIM_XMASS_WAVE = "wave";
	}

	void OnSpawn() override
	{
		if ((G_CHRISTMAS_MODE))
		{
			CatchSpeech("say_xmass", "christmas");
			if (GetEntityRace(GetOwner()) == "human")
			{
			}
			SetModelBody(GetOwner(), 2);
		}
	}

	void say_xmass()
	{
		if (!(G_CHRISTMAS_MODE)) return;
		PlayAnim("critical", ANIM_XMASS_WAVE);
		SayText(A + " happy Hogswatch to you too!");
		if ((RandomInt(0, 1)))
		{
			// TODO: playmp3 all system xmass_annoy.mp3
		}
		else
		{
			// TODO: playmp3 all system xmass.mp3
		}
		if ((XMASS_OLD_GUY))
		{
			EmitSound(GetOwner(), 0, "npc/happy_hogswatch.wav", 10);
			Say("[.20] [.20] [.30] [.10] [.20] [.10] [.10] [.10] [.10]");
		}
		else
		{
			EmitSound(GetOwner(), 0, "npc/xmass_male.wav", 10);
			Say("[.20] [.20] [.30] [.10] [.20] [.10] [.10] [.10] [.10]");
		}
		if (!(IS_SNOWING))
		{
			CallExternal("players", "ext_weather_change", "snow");
		}
	}

}

}
