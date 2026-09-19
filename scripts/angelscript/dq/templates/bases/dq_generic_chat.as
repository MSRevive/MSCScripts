#pragma context server

namespace MS
{

class DqGenericChat : CGameScript
{
	void quest_intro()
	{
		if (QUEST_INTRO_CHAT != "0")
		{
			chat_now(QUEST_INTRO_CHAT, 1.0);
			chat_convo_anim();
		}
		if (QUEST_INTRO_SOUND != "0")
		{
			EmitSound(GetOwner(), 2, QUEST_INTRO_SOUND, 10);
		}
	}

	void quest_activate()
	{
		if (QUEST_ACTIVATE_CHAT != "0")
		{
			chat_now(QUEST_ACTIVATE_CHAT, 1.0);
			chat_convo_anim();
		}
		if (QUEST_ACTIVATE_SOUND != "0")
		{
			EmitSound(GetOwner(), 2, QUEST_ACTIVATE_SOUND, 10);
		}
	}

	void quest_finished()
	{
		if (QUEST_FINISHED_CHAT != "0")
		{
			chat_now(QUEST_FINISHED_CHAT, 1.0);
			chat_convo_anim();
		}
		if (QUEST_FINISHED_SOUND != "0")
		{
			EmitSound(GetOwner(), 2, QUEST_FINISHED_SOUND, 10);
		}
	}

	void quest_complete()
	{
		if (QUEST_COMPLETE_CHAT != "0")
		{
			chat_now(QUEST_COMPLETE_CHAT, 1.0);
			chat_convo_anim();
		}
		if (QUEST_COMPLETE_SOUND != "0")
		{
			EmitSound(GetOwner(), 2, QUEST_COMPLETE_SOUND, 10);
		}
	}

}

}
