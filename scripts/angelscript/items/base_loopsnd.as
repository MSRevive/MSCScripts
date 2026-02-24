#pragma context server

namespace MS
{

class BaseLoopsnd : CGameScript
{
	string LOOPSND_CHANNEL;
	int LOOPSND_LENGTH;
	string LOOPSND_NAME;
	int LOOPSND_ON;
	string LOOPSND_VOLUME;

	BaseLoopsnd()
	{
		LOOPSND_NAME = "none";
		LOOPSND_LENGTH = 5;
		LOOPSND_VOLUME = "const.snd.maxvol";
		LOOPSND_CHANNEL = "const.sound.item";
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
