#pragma context server

namespace MS
{

class Pillar : CGameScript
{
	int CANCHAT;
	int GOT_RING;
	int SHAD_SPAWN;

	Pillar()
	{
		Precache("monsters/skeleton.mdl");
		Precache("mscave/Shadahar");
		Precache("weapons/magic/seals.mdl");
		Precache("magic/temple.wav");
		Precache("magic/pulsemachine_noloop.wav");
		Precache("magic/frost_reverse.wav");
		Precache("skull.spr");
		Precache("monsters/skeleton/cal_laugh.wav");
		Precache("monsters/skeleton/calrain3.wav");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("The Enchanted Pillar");
		SetWidth(32);
		SetHeight(32);
		SetRoam(false);
		SetRace("neutral");
		SetModel("props/skullprop.mdl");
		CANCHAT = 1;
		SetInvincible(true);
		CatchSpeech("say_release", "erste");
		CatchSpeech("say_hail", "hail");
		SetMenuAutoOpen(1);
	}

	void say_release()
	{
		SayText("The name is not what " + I + "require , but the light of the ring , this is what " + I + " desire!");
	}

	void say_hail()
	{
		if ((ItemExists("ent_lastspoke", "item_runicsymbol2")))
		{
			SayText("Come hither , closer to me! You have that which will set me free!");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((ItemExists("ent_lastspoke", "item_runicsymbol")))
		{
			SayText("Too soon , you have come , your journey , it is not done.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SayText("Mortal , speak warily unto me , you have not that which sets me free.");
	}

	void game_menu_getoptions()
	{
		if ((GOT_RING)) return;
		SetSayTextRange(1024);
		if ((G_DEVELOPER_MODE))
		{
			ScheduleDelayedEvent(5.0, "gave_ring");
		}
		if ((G_DEVELOPER_MODE)) return;
		if ((ItemExists(param1, "item_runicsymbol2")))
		{
			string reg.mitem.title = "Insert the Urdualian Ring";
			string reg.mitem.type = "payment_silent";
			string reg.mitem.data = "item_runicsymbol2";
			string reg.mitem.callback = "gave_ring";
		}
		if ((ItemExists(param1, "item_runicsymbol")))
		{
			string reg.mitem.title = "Insert the Expended Ring";
			string reg.mitem.type = "payment_silent";
			string reg.mitem.data = "item_runicsymbol";
			string reg.mitem.callback = "wrong_ring";
		}
	}

	void wrong_ring()
	{
		SayText("This ring , it shines not , therefore no evil , shall it wrought.");
		// TODO: offer PARAM1 item_runicsymbol
	}

	void gave_ring()
	{
		SetModelBody(0, 1);
		GOT_RING = 1;
		UseTrigger("mm_shad");
		ScheduleDelayedEvent(4, "spawnage");
		SayText("At last! " + I + "shall be freed! ...and upon you , first shall " + I + " feed!");
	}

	void spawnage()
	{
		if ((SHAD_SPAWN)) return;
		UseTrigger("spawn_shad");
		ScheduleDelayedEvent(2, "gobyebye");
		SHAD_SPAWN = 1;
	}

	void gobyebye()
	{
		UseTrigger("pillar_removed");
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
