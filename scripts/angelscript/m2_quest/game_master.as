#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void gm_map_m2_quest_setmusic()
	{
		string SYLPH_ID = FindEntityByName("sylphiel");
		if ((GetEntityProperty(SYLPH_ID, "scriptvar")))
		{
			if (!(GetEntityProperty(SYLPH_ID, "scriptvar")))
			{
				CallExternal(param1, "ext_play_music_me", "FortFraeyOrch.mp3");
			}
			else
			{
				CallExternal(param1, "ext_play_music_me", "idemarks_tower_elegie-in-bb-minor.mp3");
			}
		}
	}

}

}
