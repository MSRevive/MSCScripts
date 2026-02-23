#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntAf : CGameScript
{
	string NEXT_SKULL;

	BluntAf()
	{
		const int MANA_SKULL = 50;
		const int MANA_STUN = 20;
		const float FREQ_SKULL = 5.0;
		const int ANIM_LIFT1 = 5;
		const int ANIM_IDLE1 = 0;
		const int ANIM_IDLE2 = 6;
		const int ANIM_IDLE_TOTAL = 2;
		const int ANIM_ATTACK1 = 1;
		const int ANIM_ATTACK2 = 1;
		const int BASE_LEVEL_REQ = 20;
		const int AOE_STUN_REQ = 25;
		const int SKULL_REQ = 20;
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 10;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.5;
		const float MELEE_ATK_DURATION = 1.1;
		const float DEMON_DMG_DELAY = 0.25;
		const float DEMON_ATK_DURATION = 0.7;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 400;
		const int MELEE_DMG_RANGE = 40;
		const float MELEE_ACCURACY = 0.75;
		const float MELEE_PARRY_AUGMENT = 0.2;
		const string MELEE_DMG_TYPE = "blunt";
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
