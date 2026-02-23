#pragma context server

#include "monsters/fallen_armor.as"

namespace MS
{

class FallenArmorTriggered : CGameScript
{
	string FIRST_TARGET;
	string TOSHIELD_DELAY;
	int WAITING_FOR_PLAYER;

	void armor_spawn()
	{
		SetName("Armor of the Fallen");
		SetHealth(6000);
		SetWidth(32);
		SetHeight(96);
		SetRace("demon");
		SetModel("monsters/enemy.mdl");
		SetHearingSensitivity(11);
		SetIdleAnim(ANIM_SIT_IDLE);
		SetMoveAnim(ANIM_SIT_IDLE);
		PlayAnim("once", ANIM_SIT_IDLE);
		SetStat("parry", 30);
		SetInvincible(true);
		SetDamageResistance("all", 0.1);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("lightning", 1.5);
		SetDamageResistance("cold", 0.8);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.5);
		WAITING_FOR_PLAYER = 1;
		npcatk_suspend_ai();
	}

	void armor_heardsound()
	{
	}

	void enter_combat()
	{
		if (!(WAITING_FOR_PLAYER)) return;
		WAITING_FOR_PLAYER = 0;
		LookAt(GetOwner());
		FIRST_TARGET = GetEntityIndex(m_hLastSeen);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		TOSHIELD_DELAY = Random(10, 30);
		TOSHIELD_DELAY("setup_shield_check");
		PlayAnim("critical", ANIM_GETUP);
	}

}

}
