#pragma context server

#include "monsters/scorpion6.as"

namespace MS
{

class Scorpion6Stone : CGameScript
{
	float BASE_MOVESPEED;
	float FREQ_JUMP;
	int IS_UNHOLY;
	int NPC_GIVE_EXP;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Scorpion6Stone()
	{
		IS_UNHOLY = 1;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		FREQ_JUMP = 30.0;
	}

	void scorpion_spawn()
	{
		SetHealth(5000);
		SetWidth(196);
		SetHeight(196);
		SetRace("demon");
		SetName("Obsidian Scorpion");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 1000;
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.5);
		FREQ_JUMP("do_jump");
		SetModel("monsters/scorp6.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetProp(GetOwner(), "skin", 2);
		SetAnimMoveSpeed(0.5);
		BASE_MOVESPEED = 0.5;
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
