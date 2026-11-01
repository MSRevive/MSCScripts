#pragma context server

#include "monsters/scorpion6.as"

namespace MS
{

class Scorpion7Fire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_STINGRANGE;
	string BURST_SCRIPT;
	int DMG_BURST;
	float DOT_DMG;
	float DOT_DURATION;
	string DOT_EFFECT;
	string DOT_EFFECT_BURST_TYPE;
	string DOT_EFFECT_STING;
	float FREQ_JUMP;
	int IS_UNHOLY;
	int NPC_BASE_EXP;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Scorpion7Fire()
	{
		IS_UNHOLY = 1;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "weapons/dagger/daggermetal2.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		DOT_EFFECT = "effects/dot_fire";
		DOT_EFFECT_STING = "effects/dot_poison";
		BURST_SCRIPT = "effects/sfx_fire_burst";
		DOT_EFFECT_BURST_TYPE = "effect";
		DOT_DURATION = 5.0;
		DOT_DMG = 100.0;
		DMG_BURST = 300;
		ATTACK_STINGRANGE = 180;
		FREQ_JUMP = 30.0;
		NPC_BASE_EXP = 2000;
		ANIM_IDLE = "idle_b";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attackb";
		ANIM_DEATH = "die";
	}

	void scorpion_spawn()
	{
		SetName("Blistering Scorpion");
		SetHealth(5000);
		SetModel("monsters/scorp7.mdl");
		SetProp(GetOwner(), "skin", 4);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetWidth(196);
		SetHeight(196);
		SetHearingSensitivity(10);
		SetRoam(true);
		SetRace("demon");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.5);
		FREQ_JUMP("do_jump");
		PlayAnim("once", "idle_a");
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
