#pragma context client

namespace MS
{

class ChainScannerCl : CGameScript
{
	string MAGIC_HAND_IDX;

	void client_activate()
	{
		string CL_BEAM_START = /* TODO: $getcl */ $getcl(param1, "bonepos", 38);
		string CL_BEAM_END = /* TODO: $getcl */ $getcl(param2, "bonepos", 1);
		MAGIC_HAND_IDX = "game.localplayer.viewmodel.active.id";
		if (!("game.localplayer.thirdperson"))
		{
			if ("game.localplayer.index" == param1)
			{
			}
			string RND_FINGER = RandomInt(1, 10);
			if (RND_FINGER == 1)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 16);
			}
			if (RND_FINGER == 2)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 19);
			}
			if (RND_FINGER == 3)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 22);
			}
			if (RND_FINGER == 4)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 25);
			}
			if (RND_FINGER == 5)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 28);
			}
			if (RND_FINGER == 6)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 35);
			}
			if (RND_FINGER == 7)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 38);
			}
			if (RND_FINGER == 8)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 41);
			}
			if (RND_FINGER == 9)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 44);
			}
			if (RND_FINGER == 10)
			{
				string CL_FINGER = /* TODO: $getcl */ $getcl("game.localplayer.viewmodel.active.id", "bonepos", 47);
			}
			string CL_BEAM_START = CL_FINGER;
			int USE_FINGERS = 1;
		}
		ClientEffect("beam_points", CL_BEAM_START, CL_BEAM_END, "lgtning.spr", 0.5, 5.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
		ScheduleDelayedEvent(0.5, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
