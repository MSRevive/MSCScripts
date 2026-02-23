#pragma context server

namespace MS
{

class IceMageImage : CGameScript
{
	int IS_UNHOLY;
	string MAGE_NAME;
	string MY_OWNER;

	IceMageImage()
	{
		IS_UNHOLY = 1;
		const float FREQ_BEAM = 3.0;
		const float BEAM_DURATION = 50.0;
		const string ANIM_TALK = "ref_shoot_staff";
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
	}

	void OnSpawn() override
	{
		SetModel("monsters/ice_mage.mdl");
		SetName("Ice Mage");
		SetInvincible(true);
		SetRace("demon");
		SetWidth(32);
		SetHeight(96);
		SetProp(GetOwner(), "skin", 1);
		SetNoPush(true);
		SetSayTextRange(2048);
		// svplaysound: svplaysound 1 1 magic/freezeray_loop_quiet.wav
		EmitSound(1, 1, "magic/freezeray_loop_quiet.wav");
		SetIdleAnim("ref_shoot_rayspell");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MAGE_NAME = param2;
		if (MAGE_NAME == "mage1")
		{
			SetName("Ice Mage Zarcon");
			SetName("mage1");
		}
		if (MAGE_NAME == "mage2")
		{
			SetName("Ice Mage Phrezax");
			SetName("mage2");
		}
		if (MAGE_NAME == "mage3")
		{
			SetName("Ice Mage Frozon");
			SetName("mage3");
		}
		if (MAGE_NAME == "mage4")
		{
			SetName("Ice Mage Depthaw");
			SetName("mage4");
		}
		SetAngles("face");
		ScheduleDelayedEvent(0.1, "straighten_up");
	}

	void straighten_up()
	{
		string MY_YAW = GetMonsterProperty("angles.yaw");
		SetAngles("face");
		ScheduleDelayedEvent(1.0, "draw_beam");
	}

	void ext_convo2()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("I m sorry, we were told to freeze you here forever.");
		EmitSound(GetOwner(), 2, "voices/sc_convo2.wav", 10);
	}

	void ext_convo3()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("Yes , releasing you would rather countermand orders...");
		EmitSound(GetOwner(), 2, "voices/sc_convo3.wav", 10);
	}

	void ext_convo4()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("If only you had pledged your loyalty to Lor Malgoriand , we wouldn t have to waste our time.");
		EmitSound(GetOwner(), 2, "voices/sc_convo4.wav", 10);
	}

	void ext_convo6()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("Maldora IS Lor Malgoriand you insolent fool!");
		EmitSound(GetOwner(), 2, "voices/sc_convo6.wav", 10);
	}

	void ext_convo7()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("And we will be there when he is restored to his throne in the Palace of Shae-hae-deed.");
		EmitSound(GetOwner(), 2, "voices/sc_convo7.wav", 10);
	}

	void ext_convo9()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("Oh we see them , and when we re done with you...");
		EmitSound(GetOwner(), 2, "voices/sc_convo9.wav", 10);
	}

	void ext_convo10()
	{
		PlayAnim("critical", ANIM_TALK);
		SayText("We ll mount their corpses in this beautiful ice casket, along with yours.");
		EmitSound(GetOwner(), 2, "voices/sc_convo10.wav", 10);
	}

	void ext_mage_go()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		// svplaysound: svplaysound 1 0 magic/freezeray_loop_quiet.wav
		EmitSound(1, 0, "magic/freezeray_loop_quiet.wav");
		SpawnNPC("monsters/ice_mage", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityName(GetOwner()), MY_OWNER
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void draw_beam()
	{
		string TRACE_START = GetEntityOrigin(GetOwner());
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		TRACE_START += FINGER_ADJ;
		string TRACE_END = GetEntityOrigin(MY_OWNER);
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 64));
		Effect("beam", "point", "lgtning.spr", 10, TRACE_START, TRACE_END, Vector3(200, 200, 255), 255, 0, BEAM_DURATION);
	}

}

}
