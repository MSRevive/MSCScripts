#pragma context server

#include "monsters/spider.as"

namespace MS
{

class Cavespid : CGameScript
{
	int FIN_EXP;
	string SPIDER_MODEL;

	Cavespid()
	{
		FIN_EXP = 20;
		SPIDER_MODEL = "monsters/fer_spider.mdl";
	}

	void OnSpawn() override
	{
		SetHealth(85);
		SetName("Cave Spider");
		if ((StringToLower(GetMapName())).findFirst("calruin") >= 0)
		{
			SetName("Maisculus Araneu");
		}
		if ((StringToLower(GetMapName())).findFirst("deralia") >= 0)
		{
			SetName("Maisculus Araneu");
		}
		SetModelBody(0, 0);
	}

}

}
