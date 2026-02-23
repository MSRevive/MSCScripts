#pragma context server

#include "monsters/base_civilian.as"
#include "helena/helena_npc.as"
#include "monsters/base_npc.as"
#include "monsters/base_xmass.as"

namespace MS
{

class DefaultHuman : CGameScript
{
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string MY_SEX;

	DefaultHuman()
	{
		const string MALE_MODEL = "npc/human1.mdl";
		const string FEMALE_MODEL = "npc/human2.mdl";
		Precache("npc/human1.mdl");
		Precache("npc/human2.mdl");
		const string MY_RAID_POS = "$relpos(0,0,0)";
		const int DEFAULT_HUMAN = 1;
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "diesimple";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(25, 35));
		if (!(RAID_ON))
		{
		}
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		SetVolume(2);
		if (MY_SEX == "male")
		{
			Say("chitchat[.5] [.2] [.55] [.55] [.23] [.22]");
		}
		if (MY_SEX == "female")
		{
			if (!(DID_FEM_VOICE))
			{
			}
			if ((IsValidPlayer(m_hLastSeen)))
			{
				EmitSound(GetOwner(), 0, "voices/human/female_vendor2.wav", 8);
				DID_FEM_VOICE = 1;
				Say("[.5] [.2] [.55] [.55] [.23] [.22] [.5] [.2] [.55] [.55] [.23] [.22]");
			}
		}
		if ((HELENA_SAVED))
		{
			if (RandomInt(1, 2) == 1)
			{
			}
			string RND_SAY = RandomInt(1, 2);
			if (RND_SAY == 1)
			{
				SayText("Thank you for saving our little village.");
			}
			if (RND_SAY == 2)
			{
				SayText("Thanks to heros like you , we may yet turn this into a safe place to live.");
			}
		}
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Commoner");
		SetRoam(true);
		SetBloodType("red");
		SetSkillLevel(-10);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		string GENDER_BENDER = RandomInt(1, 2);
		if (GENDER_BENDER == 1)
		{
			MY_SEX = "male";
			SetModel(MALE_MODEL);
		}
		if (GENDER_BENDER == 2)
		{
			SetModel(FEMALE_MODEL);
			MY_SEX = "female";
		}
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("walk");
	}

}

}
