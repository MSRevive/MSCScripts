#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class Gesoth : CGameScript
{
	int CHAT_AUTO_FACE;
	string CHAT_CONV_ANIMS;
	int CHAT_FACE_ON_USE;
	int CHAT_NEVER_INTERRUPT;
	int CHAT_USE_CONV_ANIMS;
	string CONVO_IDX;
	string NEXT_NAY;
	int PLAYING_DEAD;
	int QUEST_REWARD_ALL;

	Gesoth()
	{
		CHAT_AUTO_FACE = 0;
		CHAT_FACE_ON_USE = 0;
		CHAT_NEVER_INTERRUPT = 1;
		CHAT_CONV_ANIMS = "anim_sit_convo;anim_sit_idle_lantern";
		CHAT_USE_CONV_ANIMS = 1;
		QUEST_REWARD_ALL = 1;
	}

	void OnSpawn() override
	{
		SetName("Gesoth");
		SetName("gesoth");
		SetModel("dwarf/male1.mdl");
		SetWidth(32);
		SetHeight(48);
		SetRoam(false);
		SetHealth(1000);
		SetHearingSensitivity(0);
		SetRace("beloved");
		SetSayTextRange(1024);
		SetNoPush(true);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetIdleAnim("anim_sit_idle_nolantern");
		SetProp(GetOwner(), "skin", 1);
		SetMenuAutoOpen(1);
		SetMonsterClip(0);
	}

	void game_menu_getoptions()
	{
		ReturnData("abortmenu");
		PlayAnim("critical", "anim_sit_idle_nolantern");
		if (CONVO_IDX == 0)
		{
			chat_now("Uggh... Talk to Halsof, he's the brains of this doomed outfit.");
		}
		if (CONVO_IDX == 1)
		{
			CONVO_IDX = 0;
			chat_now("Leave me alone... Talk to Halsof.");
		}
		CONVO_IDX += 1;
		if (!(GetGameTime() > NEXT_NAY)) return;
		NEXT_NAY = GetGameTime();
		NEXT_NAY += 3.0;
		EmitSound(GetOwner(), 2, "voices/dwarf/vs_ndwarfm1_no.wav", 10);
	}

	void ext_remove()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void ext_found_tnt()
	{
		chat_now("Eh, it may have been me who left that there.");
	}

}

}
