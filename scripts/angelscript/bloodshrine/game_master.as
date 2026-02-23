#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int GM_BLOOD_DRINKER_FOUND;
	int GM_DID_SFS_ALERT;
	int GM_SFS_DEAD;
	int PLAYER_LIST;

	void gm_bloodshrine_sorc_check()
	{
		PLAYER_LIST = 0;
		GetAllPlayers(PLAYER_LIST);
		GM_BLOOD_DRINKER_FOUND = 0;
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			search_for_blood_drinker();
		}
		if ((GM_BLOOD_DRINKER_FOUND))
		{
			UseTrigger("spawn_zorcs_friendly");
		}
		else
		{
			UseTrigger("spawn_zorcs_hostile");
		}
	}

	void gm_bloodshrine_sorc_door()
	{
		if ((GM_BLOOD_DRINKER_FOUND))
		{
			UseTrigger("sorc_door1");
			CallExternal("all", "ext_fsorc_init");
		}
		else
		{
			UseTrigger("sorc_door1");
			UseTrigger("sorc_door2");
		}
	}

	void search_for_blood_drinker()
	{
		string CUR_IDX = i;
		string CUR_PLAYER = GetToken(PLAYER_LIST, CUR_IDX, ";");
		if (!(ItemExists(CUR_PLAYER, "swords_blood_drinker"))) return;
		GM_BLOOD_DRINKER_FOUND = 1;
	}

	void gm_bloodshrine_boss_fx()
	{
		string BOSS_ID = FindEntityByName("shadowform_boss");
		if (!(IsEntityAlive(BOSS_ID))) return;
		CallExternal(BOSS_ID, "ext_cl_fx_update");
	}

	void gm_bloodshrine_sfs_dead()
	{
		CallExternal("all", "fsorc_unwait");
		GM_SFS_DEAD = 1;
	}

	void gm_bloodshrine_fsorc_tele()
	{
		if (!(GM_SFS_DEAD)) return;
		if ((GM_INIT_TO_TELE)) return;
		string L_SHAMAN_ID = FindEntityByName("fsorc_shaman");
		string L_LEADER_ID = FindEntityByName("fsorc_leader");
		string L_SECOND_ID = FindEntityByName("fsorc_second");
		Vector3 TELE_POINT = Vector3(512, 128, -16);
		string L_ORG = GetEntityOrigin(L_SHAMAN_ID);
		if (Distance(L_ORG, L_ORG) < 600)
		{
			int INIT_MOVE_TO_TELE = 1;
		}
		string L_ORG = GetEntityOrigin(L_LEADER_ID);
		if (Distance(L_ORG, L_ORG) < 600)
		{
			int INIT_MOVE_TO_TELE = 1;
		}
		string L_ORG = GetEntityOrigin(L_SECOND_ID);
		if (Distance(L_ORG, L_ORG) < 600)
		{
			int INIT_MOVE_TO_TELE = 1;
		}
		if (!(INIT_MOVE_TO_TELE)) return;
		CallExternal("all", "fsorc_move_tele");
	}

	void gm_bloodshrine_hold_sfs()
	{
		if ((GM_DID_SFS_ALERT)) return;
		string L_SHAMAN = FindEntityByName("fsorc_shaman");
		if (!(IsEntityAlive(L_SHAMAN))) return;
		GM_DID_SFS_ALERT = 1;
		CallExternal(L_SHAMAN, "ext_wait_sfs_loop");
	}

}

}
