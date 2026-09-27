#pragma context server

namespace MS
{

class Blast : CGameScript
{
	void game_dynamically_created()
	{
		string MY_OWNER = param1;
		StoreEntity("ent_expowner");
		string BLAST_RAD = param2;
		string BLAST_DMG = param3;
		string BLAST_CTH = param4;
		string BLAST_FALLOFF = param5;
		string DMG_TYPE = param6;
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), BLAST_RAD, BLAST_DMG, BLAST_CTH, BLAST_FALLOFF);
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
