#pragma context server

namespace MS
{

class BaseChat : CGameScript
{
	string ANIM_STEP1;
	string ANIM_STEP10;
	string ANIM_STEP2;
	string ANIM_STEP3;
	string ANIM_STEP4;
	string ANIM_STEP5;
	string ANIM_STEP6;
	string ANIM_STEP7;
	string ANIM_STEP8;
	string ANIM_STEP9;
	string BC_END_AUTO_MOUTH_MOVE;
	int BC_TOTAL_MOUTH_TIME;
	string BUSY_CHATTING;
	string CHAT_DELAY_STEP1;
	string CHAT_DELAY_STEP10;
	string CHAT_DELAY_STEP2;
	string CHAT_DELAY_STEP3;
	string CHAT_DELAY_STEP4;
	string CHAT_DELAY_STEP5;
	string CHAT_DELAY_STEP6;
	string CHAT_DELAY_STEP7;
	string CHAT_DELAY_STEP8;
	string CHAT_DELAY_STEP9;
	string CHAT_EVENT_STEP1;
	string CHAT_EVENT_STEP10;
	string CHAT_EVENT_STEP2;
	string CHAT_EVENT_STEP3;
	string CHAT_EVENT_STEP4;
	string CHAT_EVENT_STEP5;
	string CHAT_EVENT_STEP6;
	string CHAT_EVENT_STEP7;
	string CHAT_EVENT_STEP8;
	string CHAT_EVENT_STEP9;
	string CHAT_SOUND1;
	string CHAT_SOUND10;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_SOUND4;
	string CHAT_SOUND5;
	string CHAT_SOUND6;
	string CHAT_SOUND7;
	string CHAT_SOUND8;
	string CHAT_SOUND9;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP10;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEP9;
	string CHAT_STEPS;
	int HAS_BASE_CHAT_INCLUDE;
	string TRADE_RING;

	BaseChat()
	{
		HAS_BASE_CHAT_INCLUDE = 1;
		const string CONV_ANIMS = "converse2;converse1;talkleft;talkright;lean;pondering;pondering2;pondering3;";
		const float CHAT_DELAY = 3.0;
		const string RQUEST_NAMES = "0;Galan;Narad;Darrelin;Rudolf;Vadrel;Edrin;Thordac;Slinker;Slinker;Gerald;Mosor;Cathain;";
	}

	void OnSpawn() override
	{
		SetMenuAutoOpen(1);
	}

	void game_menu_getoptions()
	{
		LogDebug("base_chat game_menu_getoptions");
		if (!(CAN_CHAT != 0)) return;
		if ((NO_CHAT)) return;
		bchat_before_menus();
		if (!(NO_HAIL))
		{
			LogDebug("base_chat reghail");
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
		}
		if (!(NO_JOB))
		{
			LogDebug("base_chat regjob");
			string reg.mitem.title = "Ask about Jobs";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
		}
		if (!(NO_RUMOR))
		{
			LogDebug("base_chat regrumor");
			string reg.mitem.title = "Ask about Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rumor";
		}
		LogDebug("game_menu_getoptions Ring Check");
		if ((IsValidPlayer(param1)))
		{
			if ((ItemExists(param1, "item_ring")))
			{
			}
			string RQUEST_STAGE = GetPlayerQuestData(param1, "r");
			if (RQUEST_STAGE >= 1)
			{
			}
			string RQUEST_NAME = GetToken(RQUEST_NAMES, RQUEST_STAGE, ";");
			if ((GetMonsterProperty("name")).findFirst(RQUEST_NAME) >= 0)
			{
				if (REQ_QUEST_NOTDONE == 1)
				{
					string reg.mitem.title = "Ask about the ring";
					string reg.mitem.type = "callback";
					string reg.mitem.data = RQUEST_STAGE;
					string reg.mitem.callback = "rquest_rub_my_back_first";
				}
				if (!(REQ_QUEST_NOTDONE))
				{
				}
				string reg.mitem.title = "Ask about the ring";
				string reg.mitem.type = "callback";
				string reg.mitem.data = RQUEST_STAGE;
				string reg.mitem.callback = "give_runaround";
			}
		}
		bchat_after_menus();
		LogDebug("game_menu_getoptions Post Ring Check");
	}

	void say_rumor()
	{
	}

	void face_speaker()
	{
		SetMoveDest(param1);
	}

	void chat_loop()
	{
		if (!(true)) return;
		if (!(BUSY_CHATTING))
		{
			BUSY_CHATTING = 1;
			CHAT_STEP = 0;
		}
		CHAT_STEP += 1;
		if (CHAT_STEP == CHAT_STEPS)
		{
			BUSY_CHATTING = 0;
			npc_chat_done();
		}
		if (!(CHAT_STEP <= CHAT_STEPS)) return;
		string L_ANIM = "none";
		string L_CHAT_DELAY = CHAT_DELAY;
		string L_CHAT_TEXT = "none";
		if (CHAT_STEP == 1)
		{
			string L_CHAT_TEXT = CHAT_STEP1;
			string L_ANIM = ANIM_STEP1;
			string L_CHAT_DELAY = CHAT_DELAY_STEP1;
			string L_CHAT_SOUND = CHAT_SOUND1;
			CHAT_STEP1 = "CHAT_STEP1";
			CHAT_DELAY_STEP1 = "CHAT_DELAY_STEP1";
			ANIM_STEP1 = "ANIM_STEP1";
			string L_CHAT_EVENT = CHAT_EVENT_STEP1;
			CHAT_EVENT_STEP1 = "CHAT_EVENT_STEP1";
			CHAT_SOUND1 = "CHAT_SOUND1";
		}
		if (CHAT_STEP == 2)
		{
			string L_CHAT_TEXT = CHAT_STEP2;
			string L_ANIM = ANIM_STEP2;
			string L_CHAT_DELAY = CHAT_DELAY_STEP2;
			string L_CHAT_SOUND = CHAT_SOUND2;
			CHAT_STEP2 = "CHAT_STEP2";
			CHAT_DELAY_STEP2 = "CHAT_DELAY_STEP2";
			ANIM_STEP2 = "ANIM_STEP2";
			string L_CHAT_EVENT = CHAT_EVENT_STEP2;
			CHAT_EVENT_STEP2 = "CHAT_EVENT_STEP2";
			CHAT_SOUND2 = "CHAT_SOUND2";
		}
		if (CHAT_STEP == 3)
		{
			string L_CHAT_TEXT = CHAT_STEP3;
			string L_ANIM = ANIM_STEP3;
			string L_CHAT_DELAY = CHAT_DELAY_STEP3;
			string L_CHAT_SOUND = CHAT_SOUND3;
			CHAT_STEP3 = "CHAT_STEP3";
			CHAT_DELAY_STEP3 = "CHAT_DELAY_STEP3";
			ANIM_STEP3 = "ANIM_STEP3";
			string L_CHAT_EVENT = CHAT_EVENT_STEP3;
			CHAT_EVENT_STEP3 = "CHAT_EVENT_STEP3";
			CHAT_SOUND3 = "CHAT_SOUND3";
		}
		if (CHAT_STEP == 4)
		{
			string L_CHAT_TEXT = CHAT_STEP4;
			string L_ANIM = ANIM_STEP4;
			string L_CHAT_DELAY = CHAT_DELAY_STEP4;
			string L_CHAT_SOUND = CHAT_SOUND4;
			CHAT_STEP4 = "CHAT_STEP4";
			CHAT_DELAY_STEP4 = "CHAT_DELAY_STEP4";
			ANIM_STEP4 = "ANIM_STEP4";
			string L_CHAT_EVENT = CHAT_EVENT_STEP4;
			CHAT_EVENT_STEP4 = "CHAT_EVENT_STEP4";
			CHAT_SOUND4 = "CHAT_SOUND4";
		}
		if (CHAT_STEP == 5)
		{
			string L_CHAT_TEXT = CHAT_STEP5;
			string L_ANIM = ANIM_STEP5;
			string L_CHAT_DELAY = CHAT_DELAY_STEP5;
			string L_CHAT_SOUND = CHAT_SOUND5;
			CHAT_STEP5 = "CHAT_STEP5";
			CHAT_DELAY_STEP5 = "CHAT_DELAY_STEP5";
			ANIM_STEP5 = "ANIM_STEP5";
			string L_CHAT_EVENT = CHAT_EVENT_STEP5;
			CHAT_EVENT_STEP5 = "CHAT_EVENT_STEP5";
			CHAT_SOUND5 = "CHAT_SOUND5";
		}
		if (CHAT_STEP == 6)
		{
			string L_CHAT_TEXT = CHAT_STEP6;
			string L_ANIM = ANIM_STEP6;
			string L_CHAT_DELAY = CHAT_DELAY_STEP6;
			string L_CHAT_SOUND = CHAT_SOUND6;
			CHAT_STEP6 = "CHAT_STEP6";
			CHAT_DELAY_STEP6 = "CHAT_DELAY_STEP6";
			ANIM_STEP6 = "ANIM_STEP6";
			string L_CHAT_EVENT = CHAT_EVENT_STEP6;
			CHAT_EVENT_STEP6 = "CHAT_EVENT_STEP6";
			CHAT_SOUND6 = "CHAT_SOUND6";
		}
		if (CHAT_STEP == 7)
		{
			string L_CHAT_TEXT = CHAT_STEP7;
			string L_ANIM = ANIM_STEP7;
			string L_CHAT_DELAY = CHAT_DELAY_STEP7;
			string L_CHAT_SOUND = CHAT_SOUND7;
			CHAT_STEP7 = "CHAT_STEP7";
			CHAT_DELAY_STEP7 = "CHAT_DELAY_STEP7";
			ANIM_STEP7 = "ANIM_STEP7";
			string L_CHAT_EVENT = CHAT_EVENT_STEP7;
			CHAT_EVENT_STEP7 = "CHAT_EVENT_STEP7";
			CHAT_SOUND7 = "CHAT_SOUND7";
		}
		if (CHAT_STEP == 8)
		{
			string L_CHAT_TEXT = CHAT_STEP8;
			string L_ANIM = ANIM_STEP8;
			string L_CHAT_DELAY = CHAT_DELAY_STEP8;
			string L_CHAT_SOUND = CHAT_SOUND8;
			CHAT_STEP8 = "CHAT_STEP8";
			CHAT_DELAY_STEP8 = "CHAT_DELAY_STEP8";
			ANIM_STEP8 = "ANIM_STEP8";
			string L_CHAT_EVENT = CHAT_EVENT_STEP8;
			CHAT_EVENT_STEP8 = "CHAT_EVENT_STEP8";
			CHAT_SOUND8 = "CHAT_SOUND8";
		}
		if (CHAT_STEP == 9)
		{
			string L_CHAT_TEXT = CHAT_STEP9;
			string L_ANIM = ANIM_STEP9;
			string L_CHAT_DELAY = CHAT_DELAY_STEP9;
			string L_CHAT_SOUND = CHAT_SOUND9;
			CHAT_STEP9 = "CHAT_STEP9";
			CHAT_DELAY_STEP9 = "CHAT_DELAY_STEP9";
			ANIM_STEP9 = "ANIM_STEP9";
			string L_CHAT_EVENT = CHAT_EVENT_STEP9;
			CHAT_EVENT_STEP9 = "CHAT_EVENT_STEP9";
			CHAT_SOUND9 = "CHAT_SOUND9";
		}
		if (CHAT_STEP == 10)
		{
			string L_CHAT_TEXT = CHAT_STEP10;
			string L_ANIM = ANIM_STEP10;
			string L_CHAT_DELAY = CHAT_DELAY_STEP10;
			string L_CHAT_SOUND = CHAT_SOUND10;
			CHAT_STEP10 = "CHAT_STEP10";
			CHAT_DELAY_STEP10 = "CHAT_DELAY_STEP10";
			ANIM_STEP10 = "ANIM_STEP10";
			string L_CHAT_EVENT = CHAT_EVENT_STEP10;
			CHAT_EVENT_STEP10 = "CHAT_EVENT_STEP10";
			CHAT_SOUND10 = "CHAT_SOUND10";
		}
		if ((L_ANIM).findFirst("ANIM_STEP") == 0)
		{
			int NO_ANIM = 1;
		}
		if (!(NO_ANIM))
		{
			PlayAnim("critical", L_ANIM);
		}
		SayText("L_CHAT_TEXT");
		if ((L_CHAT_DELAY).findFirst("CHAT_DELAY_STEP") == 0)
		{
			string L_CHAT_DELAY = CHAT_DELAY;
		}
		if ((L_CHAT_EVENT).findFirst("CHAT_EVENT_STEP") == 0)
		{
			int NO_EVENT = 1;
		}
		if (!(NO_EVENT))
		{
			L_CHAT_DELAY(L_CHAT_EVENT);
		}
		if ((L_CHAT_SOUND).findFirst("CHAT_SOUND") == 0)
		{
			int NO_SOUND = 1;
		}
		if (!(NO_SOUND))
		{
			if (L_CHAT_SOUND != "none")
			{
			}
			EmitSound(GetOwner(), 0, L_CHAT_SOUND, 10);
		}
		if (!(NO_MOUTH_MOVE))
		{
			bchat_auto_mouth_move(L_CHAT_DELAY);
		}
		if (!(CHAT_STEP < CHAT_STEPS)) return;
		L_CHAT_DELAY("chat_loop");
	}

	void bchat_mouth_move()
	{
		BC_TOTAL_MOUTH_TIME = 0;
		string RND_SAY1 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY1 += M_TIME;
		RND_SAY1 += "]";
		string RND_SAY2 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY2 += M_TIME;
		RND_SAY2 += "]";
		string RND_SAY3 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY3 += M_TIME;
		RND_SAY3 += "]";
		string RND_SAY4 = "[";
		string M_TIME = Random(0.1, 0.3);
		BC_TOTAL_MOUTH_TIME += M_TIME;
		RND_SAY4 += M_TIME;
		RND_SAY4 += "]";
		Say("RND_SAY1 RND_SAY2 RND_SAY3 RND_SAY4");
		BC_TOTAL_MOUTH_TIME += 1.0;
		BC_TOTAL_MOUTH_TIME("bchat_close_mouth");
	}

	void bchat_auto_mouth_move()
	{
		if ((param1).findFirst("PARAM") == 0)
		{
		}
		else
		{
			BC_END_AUTO_MOUTH_MOVE = GetGameTime();
			BC_END_AUTO_MOUTH_MOVE += param1;
			BC_END_AUTO_MOUTH_MOVE -= 1.0;
		}
		if (GetGameTime() < BC_END_AUTO_MOUTH_MOVE)
		{
			string RND_SAY = "[";
			string M_TIME = Random(0.1, 0.3);
			RND_SAY += M_TIME;
			RND_SAY += "]";
			Say("RND_SAY");
			M_TIME += 0.1;
			M_TIME("bchat_close_mouth");
			M_TIME += 0.1;
			M_TIME("bchat_auto_mouth_move");
		}
	}

	void bchat_mouth_twitch()
	{
		string RND_DIST = Random(-1.0, 0.0);
		LogDebug("bchat_mouth_twitch RND_DIST");
		SetProp(GetOwner(), "controller1", RND_DIST);
	}

	void bchat_close_mouth()
	{
		if ((NO_CLOSE_MOUTH)) return;
		SetProp(GetOwner(), "controller1", 0);
	}

	void bchat_open_mouth()
	{
		SetProp(GetOwner(), "controller1", -1);
	}

	void give_runaround()
	{
		if ((BUSY_CHATTING)) return;
		string RQUEST_STEP = param2;
		if (RQUEST_STEP == 1)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 4;
			CHAT_STEP1 = "My goodness, Olof sent you to me with this? It almost looks like one of those old bloodstone rings...";
			CHAT_STEP2 = "It's no good without the stone though. I remember Narad was saying he saw one once. They are very rare...";
			CHAT_STEP3 = "So it could be the same one. I don't remember WHERE he said he saw it though...";
			CHAT_STEP4 = "You can find him over in Daragoth, on the outskirts of Deralia. Provided the orcs and spiders haven't killed him.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 2)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Oh, yeah, I've seen that ring before... In a play I believe... A famous actor had it...";
			CHAT_STEP2 = "Darrelin, was his name, I believe. Last I heard he moved out by the orc caves to aid actors travelling to Gatecity.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 3)
		{
			EmitSound(GetOwner(), 0, "voices/mscave/actor-bloodstone.wav", 10);
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Ah... That ring looks familiar... It almost looks like Rudolf's old battle ring.";
			CHAT_STEP2 = "I think he's up by the old mines playing adventurer again. He's far too old for that...";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 4)
		{
			SayText("Nice ring by the way! You know, I think Vadrel used to have one just like it!");
			SayText("If memory serves me right, he was stationed at some old outpost.");
		}
		if (RQUEST_STEP == 5)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Ah yes, an old warrior friend of mine had one of those, very useful if you have the stone that goes in it.";
			CHAT_STEP2 = "Edrin, his name was. I believe he's now captain of the guard in Edana. He might be able to help you with it.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 6)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Oh, one of those old golden bloodstone rings, too bad the stone has come out of it.";
			CHAT_STEP2 = "It looks a lot like the one Thordac forged and used to wear. You can find him in Deralia.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 7)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Oh, wow! That old thing, I've not seen it since I sold it of to...";
			CHAT_STEP2 = "Slinker! Yeah, that was his name. Slimey guy - still slinks about here somewhere...";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 9)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 2;
			CHAT_STEP1 = "Oh that old ring... Was handy for extort... I mean handy for business back in the day.";
			CHAT_SOUND1 = "voices/deralia/slinker_ring.wav";
			CHAT_DELAY_STEP1 = 7.0;
			CHAT_STEP2 = "I lost it in a card game with Gerald a looong time ago. He runs the inn now.";
			CHAT_DELAY_STEP2 = 5.8;
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 10)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 3;
			CHAT_STEP1 = "Ah that, I won it in card game, if I recall correctly... Lost it in another the next day.";
			CHAT_STEP2 = "Long time ago that was, yet somehow you remember these things...";
			CHAT_STEP3 = "Eh, it was that whino, Mosor, over there in the corner who won it. He might know something about it.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 11)
		{
			CHAT_STEP = 0;
			CHAT_STEPS = 4;
			CHAT_STEP1 = "Oh that old thing, not seen it in... Must be twenty seasons now... Before I took to the drink so hard.";
			CHAT_STEP2 = "Yeaah, shouldn't have parted with it. I traded it for some ale to Cathain, who made a lot of money off it.";
			CHAT_STEP3 = "Boxing, as I recall. Suppose you have to be a warrior to make real use of it. Too bad the stone's gone.";
			CHAT_STEP4 = "He's the Quartermaster of the local militia... Might find him in the barracks.";
			chat_loop();
			SetPlayerQuestData(param1, "r");
		}
		if (RQUEST_STEP == 12)
		{
			if (!(ItemExists(param1, "item_ring_percept")))
			{
			}
			CHAT_STEP = 0;
			CHAT_STEPS = 5;
			SetMoveAnim("idle1");
			SetRoam(false);
			SetMoveDest(param1);
			CHAT_STEP1 = "Oh wow! I've not seen that thing since I was in the boxing circuit!";
			CHAT_STEP2 = "I used to use it to outlast my opponents, let me wear them down before I go in for the kill!";
			CHAT_STEP3 = "Oh, I'm far too old for that now though. Easier just to keep the recruits in line around here.";
			CHAT_STEP4 = "I still have the stone though... It broke off in a fight! Never saw where the ring went till now.";
			CHAT_STEP5 = "Tell ya what, you look like someone who could use it. Give me 500 gold, and I'll give you the stone!";
			chat_loop();
			TRADE_RING = 1;
			npcatk_suspend_ai();
		}
	}

	void rquest_rub_my_back_first()
	{
		ScheduleDelayedEvent(3.0, "say_job");
		SayText("Oh , I know a little something about that... If you could just help me with my little problem first.");
	}

	void convo_anim()
	{
		string N_ANIMS = GetTokenCount(CONV_ANIMS, ";");
		N_ANIMS -= 1;
		string RND_ANIM = RandomInt(0, N_ANIMS);
		PlayAnim("critical", GetToken(CONV_ANIMS, RND_ANIM, ";"));
	}

}

}
