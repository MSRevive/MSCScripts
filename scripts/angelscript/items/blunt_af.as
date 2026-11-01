#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntAf : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_IDLE1;
	int ANIM_IDLE2;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int AOE_STUN_REQ;
	int BASE_LEVEL_REQ;
	float DEMON_ATK_DURATION;
	float DEMON_DMG_DELAY;
	float FREQ_SKULL;
	int MANA_SKULL;
	int MANA_STUN;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	string MODEL_WORLD;
	string NEXT_SKULL;
	int SKULL_REQ;

	BluntAf()
	{
		MANA_SKULL = 50;
		MANA_STUN = 20;
		FREQ_SKULL = 5.0;
		ANIM_LIFT1 = 5;
		ANIM_IDLE1 = 0;
		ANIM_IDLE2 = 6;
		ANIM_IDLE_TOTAL = 2;
		ANIM_ATTACK1 = 1;
		ANIM_ATTACK2 = 1;
		BASE_LEVEL_REQ = 20;
		AOE_STUN_REQ = 25;
		SKULL_REQ = 20;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 10;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.1;
		DEMON_DMG_DELAY = 0.25;
		DEMON_ATK_DURATION = 0.7;
		MELEE_ENERGY = 2;
		MELEE_DMG = 400;
		MELEE_DMG_RANGE = 40;
		MELEE_ACCURACY = 0.75;
		MELEE_PARRY_AUGMENT = 0.2;
		MELEE_DMG_TYPE = "blunt";
	}

	void weapon_spawn()
	{
		SetName("Mace of Affliction");
		SetDescription("A skull encrusted club forged by goblin shamans");
		SetWeight(80);
		SetSize(10);
		SetValue(3000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", "maul");
	}

	void bash()
	{
		if (!("game.item.attacking")) return;
		PlayViewAnim(MELEE_VIEWANIM_ATK);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_strike()
	{
		if (GetEntityMP(GetOwner()) >= MANA_STUN)
		{
			SendColoredMessage(GetOwner(), "Stun Burst: Insufficient Mana");
		}
		if (!(GetEntityMP(GetOwner()) >= MANA_STUN)) return;
		GiveMP(GetOwner());
		string SPAWN_POINT = GetEntityOrigin(GetOwner());
		string MY_ANGLES = GetEntityAngles(GetOwner());
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 64, 0));
		string DMG_STUN = GetSkillLevel(GetOwner(), "bluntarms");
		DMG_STUN *= 2;
		SpawnNPC(SPAWN_POINT, "monsters/summon/stun_burst", ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 1, DMG_STUN, "bluntarms"
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_SKULL)) return;
		NEXT_SKULL = GetGameTime();
		NEXT_SKULL += FREQ_SKULL;
		if (GetEntityMP(GetOwner()) < MANA_SKULL)
		{
			SendColoredMessage(GetOwner(), "Venom Skull: Insufficient Mana");
		}
		if (!(GetEntityMP(GetOwner()) >= MANA_SKULL)) return;
		GiveMP(GetOwner());
		string SPAWN_POINT = GetEntityOrigin(GetOwner());
		string MY_ANGLES = GetEntityAngles(GetOwner());
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 64, 0));
		string DMG_STUN = GetSkillLevel(GetOwner(), "bluntarms");
		DMG_STUN *= 2;
	}

}

}
