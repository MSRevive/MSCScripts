#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SpiderBaseNew : CGameScript
{
	int ATTACK_HITRANGE;
	int CAN_HEAR;

	SpiderBaseNew()
	{
		CAN_HEAR = 1;
		ATTACK_HITRANGE = 128;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(SPIDER_IDLE_DELAY);
		if ((GetMonsterProperty("alive")))
		{
		}
		if (!(SPIDER_LATCHED))
		{
		}
		EmitSound(GetOwner(), "game.sound.body", SOUND_IDLE1, SPIDER_IDLE_VOL);
	}

	void OnSpawn() override
	{
		SetRace("spider");
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void frame_bite1()
	{
		string ATTACK_DAMAGE = Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH);
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
	}

	void bite1()
	{
		frame_bite1();
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SPIDER_VOLUME, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK4, SND_STRUCK5
		array<string> sounds = {SPIDER_VOLUME, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK4, SND_STRUCK5};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		if (!(ANIM_DODGE != "ANIM_DODGE")) return;
		PlayAnim("critical", ANIM_DODGE);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0);
	}

}

}
