#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class Appatruth : CGameScript
{
	int CHAT_NEVER_INTERRUPT;
	int PLAYING_DEAD;
	string TORCH_TRIGGER;

	Appatruth()
	{
		CHAT_NEVER_INTERRUPT = 1;
	}

	void OnSpawn() override
	{
		SetName("Apparition of Atruth");
		SetModel("npc/dwarf_lantern.mdl");
		SetHealth(9001);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		SetNoPush(true);
		SetRoam(false);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 100);
		SetProp(GetOwner(), "renderfx", 16);
		SetIdleAnim("idle");
		SetWidth(32);
		SetHeight(54);
		SetModelBody(0, 2);
		SetSayTextRange(2048);
		SetBloodType("none");
		SetSolid("none");
		UseTrigger("candle");
		ScheduleDelayedEvent(2.0, "intro");
	}

	void intro()
	{
		chat_face_speaker();
		chat_add_text("intro_chat", "Aye! Could ya be helpin' out a poor old ghost of a once good dwarf?", 3.5, "nod", "speak_help");
		chat_add_text("intro_chat", "My fellows and I were working these here mines, but something... Unholy... Happened to them.", 6.0);
		chat_add_text("intro_chat", "If ya could put their souls to rest, I would be forever grateful, as then I could be movin' on me self.", 7.0);
		chat_add_text("intro_chat", "There's also some explosives in the caves we were hoping to use to connect the other mines.", 6.5, "nod", "access");
		chat_add_text("intro_chat", "They be dwarven explosives, so they'll still be good, despite the time and the damp.", 6.0);
		chat_add_text("intro_chat", "So take these torches, and keep your eye out for a fuse. They'll be useful for that as well as fer seein'.", 6.0);
		chat_start_sequence("intro_chat", "add_to_que");
	}

	void speak_help()
	{
		EmitSound(GetOwner(), 0, "voices/dwarf/vs_nx0drogm_heal.wav", 10);
	}

	void game_postspawn()
	{
		TORCH_TRIGGER = param4;
	}

	void access()
	{
		UseTrigger(TORCH_TRIGGER);
		UseTrigger("wave1");
		chat_add_text("end_chat", "I think I'll be fading away fer a bit. After all, I can't really be helpin' ye like this, now can I?", 6.5, "none", "remove_me");
		chat_start_sequence("end_chat", "add_to_que");
	}

	void remove_me()
	{
		UseTrigger("candle");
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
