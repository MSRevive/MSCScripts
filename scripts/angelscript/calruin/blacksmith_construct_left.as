#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class BlacksmithConstructLeft : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	int SKEL_HEIGHT;
	int SKEL_HP;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	int SKEL_WIDTH;
	string SOUND_PUSH;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int STONE_SKELETON;
	int STUN_ATK_CHANCE;
	int STUN_ATTACK;

	BlacksmithConstructLeft()
	{
		NPC_IS_BOSS = 1;
		NPC_ALLY_RESPONSE_RANGE = 6000;
		ANIM_RUN = "run";
		SKEL_HP = 2000;
		SKEL_WIDTH = 64;
		SKEL_HEIGHT = 180;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 180;
		ATTACK_HITCHANCE = 0.95;
		ATTACK_DAMAGE_LOW = 40;
		ATTACK_DAMAGE_HIGH = 60;
		NPC_GIVE_EXP = 1200;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 100;
		DROP_GOLD_MAX = 250;
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_PUSH = "monsters/skeleton/calrain3.wav";
		STUN_ATK_CHANCE = 10;
		STONE_SKELETON = 1;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 7);
		SetModelBody(1, 4);
		SetProp(GetOwner(), "scale", 2.0);
		SetName("Blacksmith s Construct");
		SetBloodType("none");
		SetDamageResistance("all", 0.6);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("stun", 0.6);
		SetDamageResistance("blunt", 1.25);
		ANIM_ATTACK = "attack3";
		SetHearingSensitivity(3);
	}

	void attack_1()
	{
		STUN_ATTACK = 1;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack3";
	}

	void attack_3()
	{
		STUN_ATTACK = 0;
		attack_snd();
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		if (!(RandomInt(1, 100) < STUN_ATK_CHANCE)) return;
		ANIM_ATTACK = "attack1";
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(STUN_ATTACK)) return;
		EmitSound(GetOwner(), 0, SOUND_PUSH, 10);
		ApplyEffect(param2, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
		STUN_ATTACK = 0;
	}

}

}
