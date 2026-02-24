#pragma context server

namespace MS
{

class PlayerClEffects : CGameScript
{
	int BREATHE_PLAYING;
	string GROUNDBOB_DIP;
	string GROUNDBOB_DURATION;
	string GROUNDBOB_STARTTIME;
	int MAX_BOB_DIP;
	int MAX_BOB_DURATION;
	string game.cleffect.view_ofs.z;
	string game.cleffect.viewmodel_ofs.z;

	PlayerClEffects()
	{
		MAX_BOB_DURATION = 3;
		MAX_BOB_DIP = 20;
	}

	void player_hitgroundhard()
	{
		string L_DIP = param1;
		L_DIP *= 0.05;
		if (!(L_DIP >= 12)) return;
		GROUNDBOB_DURATION = param1;
		GROUNDBOB_DURATION *= 0.001;
		GROUNDBOB_DIP = L_DIP;
		GROUNDBOB_STARTTIME = GetGameTime();
		if (!(GROUNDBOB_DIP >= 12)) return;
		GROUNDBOB_DURATION = max(0, min(MAX_BOB_DURATION, GROUNDBOB_DURATION));
		GROUNDBOB_DIP = max(0, min(MAX_BOB_DIP, GROUNDBOB_DIP));
		player_hitground_adjview();
		GROUNDBOB_DURATION("player_hitground_fixview");
	}

	void player_hitground_adjview()
	{
		if (!(GROUNDBOB_STARTTIME)) return;
		float LCL_BOBTIME = GetGameTime();
		LCL_BOBTIME -= GROUNDBOB_STARTTIME;
		LCL_BOBTIME = max(0, min(MAX_BOB_DURATION, LCL_BOBTIME));
		if (!(LCL_BOBAMT <= GROUNDBOB_DURATION)) return;
		string LCL_BOBAMT = LCL_BOBTIME;
		int LCL_TIMESCALE = 2;
		LCL_TIMESCALE /= GROUNDBOB_DURATION;
		LCL_BOBAMT *= LCL_TIMESCALE;
		LCL_BOBAMT -= 1;
		LCL_BOBAMT *= LCL_BOBAMT;
		LCL_BOBAMT *= GROUNDBOB_DIP;
		LCL_BOBAMT -= GROUNDBOB_DIP;
		game.cleffect.view_ofs.z = LCL_BOBAMT;
		LCL_BOBAMT *= 1.01;
		game.cleffect.viewmodel_ofs.z = LCL_BOBAMT;
		ScheduleDelayedEvent(0.01, "player_hitground_adjview");
	}

	void player_hitground_fixview()
	{
		GROUNDBOB_STARTTIME = 0;
		game.cleffect.view_ofs.z = 0;
		game.cleffect.viewmodel_ofs.z = LCL_BOBAMT;
	}

	void player_breathe()
	{
		if (!("game.player.stamina.ratio" < 0.05)) return;
		if ((BREATHE_PLAYING)) return;
		if (PLR_RACE == "human")
		{
			if (PLR_GENDER == "male")
			{
				string LCL_BREATHESOUND = "player/breathe_fast";
			}
			else
			{
				string LCL_BREATHESOUND = "player/Femalebreathe_fast";
			}
		}
		LCL_BREATHESOUND += RandomInt(1, 3);
		LCL_BREATHESOUND += ".wav";
		EmitSound(GetOwner(), CHAN_VOICE, LCL_BREATHESOUND, "game.sound.maxvol");
		BREATHE_PLAYING = 1;
		ScheduleDelayedEvent(6, "player_breathe_done");
	}

	void player_breathe_done()
	{
		BREATHE_PLAYING = 0;
	}

}

}
