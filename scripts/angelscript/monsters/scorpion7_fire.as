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
	int IS_UNHOLY;
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
		const string DOT_EFFECT = "effects/dot_fire";
		const string DOT_EFFECT_STING = "effects/dot_poison";
		const string BURST_SCRIPT = "effects/sfx_fire_burst";
		const string DOT_EFFECT_BURST_TYPE = "effect";
		const float DOT_DURATION = 5.0;
		const float DOT_DMG = 100.0;
		const int DMG_BURST = 300;
		const int ATTACK_STINGRANGE = 180;
		const float FREQ_JUMP = 30.0;
		const int NPC_BASE_EXP = 2000;
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
