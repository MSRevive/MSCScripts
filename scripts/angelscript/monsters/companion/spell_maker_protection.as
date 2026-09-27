#pragma context server

#include "monsters/base_npc_attack.as"
#include "monsters/companion/spell_maker_base.as"

namespace MS
{

class SpellMakerProtection : CGameScript
{
	string ANIM_IDLE;
	int CAN_ATTACK;
	int CAN_HUNT;
	int MODEL_OFSET;
	string SOUND_SPAWN;
	string SPAWNER_MODEL;

	SpellMakerProtection()
	{
		ANIM_IDLE = "idle1";
		SPAWNER_MODEL = "weapons/p_weapons2.mdl";
		MODEL_OFSET = 5;
		SOUND_SPAWN = "magic/heal_powerup.wav";
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		Precache("monsters/companion/spell_maker_base");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Spell Spawner");
		SetWidth(32);
		SetHeight(32);
		SetRace("beloved");
		SetRoam(false);
		SetFly(true);
		1 = float(1);
		SetModel(SPAWNER_MODEL);
		SetModelBody(0, MODEL_OFSET);
		SetInvincible(true);
		SetSolid("none");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		PlayAnim("loop", ANIM_IDLE);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 255, 2, 2);
		SetVolume(4);
		EmitSound(GetOwner(), SOUND_SPAWN);
	}

}

}
