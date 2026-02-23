#pragma context server

namespace MS
{

class BaseLoopsnd : CGameScript
{
	int LOOPSND_ON;

	BaseLoopsnd()
	{
		const string LOOPSND_NAME = "none";
		const int LOOPSND_LENGTH = 5;
		const string LOOPSND_VOLUME = "const.snd.maxvol";
		const string LOOPSND_CHANNEL = "const.sound.item";
		Precache(LOOPSND_NAME);
	}

	void OnSpawn() override
	{
		LOOPSND_ON = 0;
	}

	void loopsnd_start()
	{
		LOOPSND_ON = 1;
		loopsnd();
	}

	void loopsnd_end()
	{
		LOOPSND_ON = 0;
		// svplaysound: svplaysound LOOPSND_CHANNEL 0
		EmitSound(LOOPSND_CHANNEL, 0);
	}

	void loopsnd()
	{
		if (!(LOOPSND_ON)) return;
		// svplaysound: svplaysound LOOPSND_CHANNEL LOOPSND_VOLUME LOOPSND_NAME
		EmitSound(LOOPSND_CHANNEL, LOOPSND_VOLUME, LOOPSND_NAME);
		LOOPSND_LENGTH("loopsnd");
	}

	void game_putinpack()
	{
		loopsnd_end();
	}

}

}
