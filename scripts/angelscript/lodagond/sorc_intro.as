#pragma context server

namespace MS
{

class SorcIntro : CGameScript
{
	string BARRIER_ID;
	float CONV_DELAY;
	int DEAD_MAGES;
	int DETECT_RADIUS;
	string ID_MAGE1;
	string ID_MAGE2;
	string ID_MAGE3;
	string ID_MAGE4;
	string ID_SORC;
	string IMG_ICE_MAGE;
	string IMG_SORC;
	int INTRO_COMPLETE;
	int MAGE_RADIUS;
	float SPAWN_DELAY;
	int STARTED_INTRO;

	SorcIntro()
	{
		IMG_SORC = "lodagond/sorc_image";
		IMG_ICE_MAGE = "lodagond/ice_mage_image";
		MAGE_RADIUS = 164;
		DETECT_RADIUS = 256;
		SPAWN_DELAY = 0.25;
		CONV_DELAY = 3.0;
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_BEAM);
		if (!(INTRO_COMPLETE))
		{
		}
		Effect("tempent", "trail", "3dmflaora.spr", /* TODO: $relpos */ $relpos(0, 0, 64), /* TODO: $relpos */ $relpos(0, 0, 128), 10, 1, 1, 5, 12);
	}

	void OnSpawn() override
	{
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetFly(true);
		SetGravity(0);
		SetInvincible(true);
		SetModel("null.mdl");
		SetNoPush(true);
		SetRace("demon");
		SetWidth(20);
		SetHeight(20);
		SetModel("none");
		SetDamageResistance("stun", 0);
		SetGravity(0.0);
		SetName("sorc_intro");
		if (!(true)) return;
		ScheduleDelayedEvent(0.1, "spawn_image_sorc");
		DEAD_MAGES = 0;
	}

	void game_precache()
	{
		Precache("monsters/sorc_chief1");
		Precache("monsters/ice_mage");
		Precache("lodagond/sorc_image");
		Precache("lodagond/ice_mage_image");
	}

	void spawn_image_sorc()
	{
		SpawnNPC(IMG_SORC, /* TODO: $relpos */ $relpos(0, 0, 64), ScriptMode::Legacy); // params: /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"))
		ID_SORC = GetEntityIndex(m_hLastCreated);
		SPAWN_DELAY("spawn_image1");
	}

	void spawn_image1()
	{
		string SPAWN_LOC = GetMonsterProperty("origin");
		SPAWN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, 45, 0), Vector3(0, MAGE_RADIUS, 0));
		SpawnNPC(IMG_ICE_MAGE, SPAWN_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "mage1"
		SPAWN_DELAY("spawn_image2");
	}

	void spawn_image2()
	{
		string SPAWN_LOC = GetMonsterProperty("origin");
		SPAWN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, 135, 0), Vector3(0, MAGE_RADIUS, 0));
		SpawnNPC(IMG_ICE_MAGE, SPAWN_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "mage2"
		SPAWN_DELAY("spawn_image3");
	}

	void spawn_image3()
	{
		string SPAWN_LOC = GetMonsterProperty("origin");
		SPAWN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, 225, 0), Vector3(0, MAGE_RADIUS, 0));
		SpawnNPC(IMG_ICE_MAGE, SPAWN_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "mage3"
		SPAWN_DELAY("spawn_image4");
	}

	void spawn_image4()
	{
		string SPAWN_LOC = GetMonsterProperty("origin");
		SPAWN_LOC += /* TODO: $relpos */ $relpos(Vector3(0, 315, 0), Vector3(0, MAGE_RADIUS, 0));
		SpawnNPC(IMG_ICE_MAGE, SPAWN_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "mage4"
		SPAWN_DELAY("spawn_barrier");
	}

	void spawn_barrier()
	{
		string BARRIER_RADIUS = MAGE_RADIUS;
		BARRIER_RADIUS += 32;
		BARRIER_ID = GetEntityIndex(m_hLastCreated);
		scan_for_players();
		ID_MAGE1 = FindEntityByName("mage1");
		ID_MAGE2 = FindEntityByName("mage2");
		ID_MAGE3 = FindEntityByName("mage3");
		ID_MAGE4 = FindEntityByName("mage4");
	}

	void scan_for_players()
	{
		if ((STARTED_INTRO)) return;
		ScheduleDelayedEvent(0.25, "scan_for_players");
		GetAllPlayers(L_PLAYERS);
		for (int i = 0; i < GetTokenCount(L_PLAYERS, ";"); i++)
		{
			scan_loop();
		}
	}

	void scan_loop()
	{
		if ((STARTED_INTRO)) return;
		string CUR_PLAYER = GetToken(L_PLAYERS, i, ";");
		if (!(GetEntityRange(CU_PLAYER) < DETECT_RADIUS)) return;
		STARTED_INTRO = 1;
		do_intro1();
	}

	void do_intro1()
	{
		CallExternal(ID_SORC, "ext_convo1");
		ScheduleDelayedEvent(2.1, "do_intro2");
		UseTrigger("ice_crystal1");
	}

	void do_intro2()
	{
		CallExternal(ID_MAGE1, "ext_convo2");
		ScheduleDelayedEvent(4.3, "do_intro3");
		UseTrigger("ice_crystal2");
	}

	void do_intro3()
	{
		CallExternal(ID_MAGE2, "ext_convo3");
		ScheduleDelayedEvent(4.0, "do_intro4");
		UseTrigger("ice_crystal3");
	}

	void do_intro4()
	{
		CallExternal(ID_MAGE3, "ext_convo4");
		ScheduleDelayedEvent(6.3, "do_intro5");
		UseTrigger("ice_crystal4");
	}

	void do_intro5()
	{
		CallExternal(ID_SORC, "ext_convo5");
		ScheduleDelayedEvent(7.1, "do_intro6");
		UseTrigger("ice_crystal5");
	}

	void do_intro6()
	{
		CallExternal(ID_MAGE4, "ext_convo6");
		ScheduleDelayedEvent(3.5, "do_intro_oops");
		UseTrigger("ice_crystal6");
	}

	void do_intro_oops()
	{
		CallExternal(ID_MAGE3, "ext_convo7");
		ScheduleDelayedEvent(5.7, "do_intro7");
		UseTrigger("ice_crystal7");
	}

	void do_intro7()
	{
		CallExternal(ID_SORC, "ext_convo8");
		ScheduleDelayedEvent(7.1, "do_intro8");
		UseTrigger("ice_crystal8");
	}

	void do_intro8()
	{
		CallExternal(ID_MAGE2, "ext_convo9");
		ScheduleDelayedEvent(3.7, "do_intro9");
		UseTrigger("ice_crystal9");
	}

	void do_intro9()
	{
		CallExternal(ID_MAGE3, "ext_convo10");
		ScheduleDelayedEvent(5.6, "intro_complete");
	}

	void ext_ice_mage_died()
	{
		DEAD_MAGES += 1;
		if (!(DEAD_MAGES == 4)) return;
		spawn_sorc();
	}

	void spawn_sorc()
	{
		CallExternal(ID_SORC, "sorc_in");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void intro_complete()
	{
		INTRO_COMPLETE = 1;
		CallExternal(BARRIER_ID, "remove_barrier");
		CallExternal(ID_MAGE1, "ext_mage_go");
		ScheduleDelayedEvent(0.2, "intro_complete2");
	}

	void intro_complete2()
	{
		CallExternal(ID_MAGE2, "ext_mage_go");
		ScheduleDelayedEvent(0.2, "intro_complete3");
	}

	void intro_complete3()
	{
		CallExternal(ID_MAGE3, "ext_mage_go");
		ScheduleDelayedEvent(0.2, "intro_complete4");
	}

	void intro_complete4()
	{
		CallExternal(ID_MAGE4, "ext_mage_go");
	}

}

}
