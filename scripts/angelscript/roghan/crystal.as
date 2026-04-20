#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Crystal : CGameScript
{
	int CAN_FLINCH;
	string MONSTER_MODEL;
	string PLAYER_LIST;
	string SOUND_DEATH;

	Crystal()
	{
		CAN_FLINCH = 0;
		SOUND_DEATH = "monsters/abomination/die.wav";
		Precache(SOUND_DEATH);
		MONSTER_MODEL = "nimble/crystal.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("a Fire Crystal");
		SetRace("evil");
		SetHealth(100);
		SetModel(MONSTER_MODEL);
		SetWidth(32);
		SetHeight(72);
		SetDamageResistance("all", ".5");
		ScheduleDelayedEvent(5.0, "ice_shatter");
		SetBloodType("none");
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void ice_shatter()
	{
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			remove_ice();
		}
		ScheduleDelayedEvent(5.0, "ice_shatter");
	}

	void remove_ice()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		string TARG_POS = GetEntityOrigin(CUR_TARG);
		if ((GetEntityProperty(CUR_TARG, "haseffect")))
		{
			RemoveEffect(CUR_TARG, "iceshield");
			XDoDamage(TARG_POS, 100, 5, 0, GetOwner(), GetOwner(), "none", "cold_effect");
			SendColoredMessage(CUR_TARG, "It found the shield.");
		}
	}

}

}
