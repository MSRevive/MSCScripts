#pragma context server

#include "monsters/base_chat_array.as"
#include "monsters/skeleton_base.as"

namespace MS
{

class SurvivorAlfgar : CGameScript
{
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int CHAT_AUTO_HAIL;
	int CHAT_MENU_ON;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_GIVE_EXP;
	int SKEL_HP;
	int SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	int ZOMBIFIED;

	SurvivorAlfgar()
	{
		CHAT_AUTO_HAIL = 1;
		SKEL_HP = 1000;
		ATTACK_HITCHANCE = 0.8;
		ATTACK_DAMAGE_LOW = 20;
		ATTACK_DAMAGE_HIGH = 50;
		NPC_GIVE_EXP = 400;
		SKEL_RESPAWN_CHANCE = 0;
		SKEL_RESPAWN_LIVES = 0;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 15;
	}

	void skel_setup_body()
	{
		SetName("The Survivor|Alfgar");
		SetName("alfgar");
		SetInvincible(true);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/guard1.mdl");
		PlayAnim("hold", 89);
		SetWidth(32);
		SetHeight(72);
		SetMenuAutoOpen(1);
		CatchSpeech("say_madness", "madness");
		CatchSpeech("say_lost", "lost");
	}

	void say_hi()
	{
		if ((ZOMBIFIED)) return;
		if ((CHAT_BUSY)) return;
		chat_now("URDUAL'S BEARD!!! Adventurers? It's so good to see a friendly face here.");
		chat_now("Well, may this humble soldier welcome you to Idemark's Tower.");
		chat_now("My platoon was sent here to gather reconnaissance on the area, to relay to King Deralia our standing here.");
		chat_now("This tower, it seems to be an anchor for the [Lost], a baited hook in a dark ocean that draws predators unknown to us mortals.");
		chat_now("Evil energy lurks here, as my dear friends and I found out the hard way. Please heed my warnings, take care to not join the Undead or Lost armies here.");
		chat_now("My soldiers were overtaken by a [madness], once we fought our way towards the inner courtyard.");
		chat_now("I began to feel it myself, a resonating hum, drawing me deeper, tickling my brain...");
		chat_now("No. I can't return. If you absolutely must venture forth, I would suggest using the highest caution.");
	}

	void say_lost()
	{
		if ((ZOMBIFIED)) return;
		if ((CHAT_BUSY)) return;
		chat_now("Makes me wish that I had more of an interest in our histories growing up.");
		chat_now("I can tell you that this name is misleading. They are purposeful creatures, of that I am sure.");
	}

	void say_madness()
	{
		if ((ZOMBIFIED)) return;
		if ((CHAT_BUSY)) return;
		chat_now("The sight of it is seared in my mind. Even when I blink, I am haunted by flashes of the scene.");
		chat_now("It was slow to onset at first, some of the men were confused, and had to be turned toward the fight.");
		chat_now("Before long they were digging at their wounds. Have you ever dug out a splinter, me lad?");
		chat_now("I imagine it was like that burning, hurting desire to be freed of something... foreign to yourself.");
		chat_now("There are a lot of fates worse than death to be found here.");
		chat_now("I'm not ashamed to say that I screamed and took off running. By that point, I was the only one hanging onto any sanity, though I fear I speak too soon.");
	}

	void ext_zombify()
	{
		if ((ZOMBIFIED)) return;
		ZOMBIFIED = 1;
		CHAT_MENU_ON = 0;
		SetModel("monsters/skeleton2.mdl");
		SetRoam(true);
		SetRace("undead");
		SetDamageResistance("holy", 1);
		SetInvincible(false);
	}

}

}
