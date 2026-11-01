#pragma context server

#include "monsters/scorpion5.as"

namespace MS
{

class Scorpion5Stone : CGameScript
{
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int IS_UNHOLY;
	int NPC_GIVE_EXP;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Scorpion5Stone()
	{
		IS_UNHOLY = 1;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
	}

	void scorpion_spawn()
	{
		SetHealth(1000);
		SetWidth(40);
		SetHeight(50);
		SetRace("demon");
		SetName("Gigantic Stone Scorpion");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 300;
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.5);
		SetModel("monsters/scorp5.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetActionAnim("attackb");
		SetProp(GetOwner(), "skin", 3);
		SetAnimFrameRate(0.5);
		SetAnimMoveSpeed(0.25);
		BASE_FRAMERATE = 0.5;
		BASE_MOVESPEED = 0.25;
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
