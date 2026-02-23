#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class AnimWarriorHardRandom : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string ARMOR_TYPE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	string DAMAGE_TYPE;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	float FLINCH_DELAY;
	int IMMUNE_POISON;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	string LAST_ENEMY;
	string LIGHT_COLOR;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	int NPC_GIVE_EXP;

	AnimWarriorHardRandom()
	{
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "body/armour3.wav";
		const string SOUND_HIT2 = "body/armour2.wav";
		const string SOUND_HIT3 = "body/armour1.wav";
		const string SOUND_PAIN = "body/armour1.wav";
		const string SOUND_ATTACK1 = "none";
		const string SOUND_ATTACK2 = "none";
		const string SOUND_ATTACK3 = "none";
		const string SOUND_DEATH = "none";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die";
		LAST_ENEMY = "NONE";
		MOVE_RANGE = 44;
		ATTACK_RANGE = 82;
		ATTACK_HITRANGE = 128;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 40);
		NPC_GIVE_EXP = 450;
		FLINCH_CHANCE = 0.1;
		FLINCH_DELAY = 20.0;
		CAN_FLINCH = 1;
		const float ATTACK_ACCURACY = 0.85;
		const int ATTACK_DMG_LOW = 50;
		const int ATTACK_DMG_HIGH = 100;
		const int LIGHT_RAD = 64;
		IMMUNE_VAMPIRE = 1;
		IMMUNE_POISON = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(20.0);
		Effect("glow", GetOwner(), LIGHT_COLOR, 64, -1, 0);
	}

	void OnSpawn() override
	{
		SetModel("monsters/animarmor.mdl");
		SetWidth(40);
		SetHeight(90);
		SetBloodType("none");
		SetRoam(true);
		SetRace("demon");
		SetHealth(800);
		SetHearingSensitivity(4);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(0.1, "select_armor");
	}

	void select_armor()
	{
		if (ARMOR_TYPE == "ARMOR_TYPE")
		{
			ARMOR_TYPE = RandomInt(1, 4);
		}
		if (ARMOR_TYPE == 1)
		{
			SetName("Enchanted Armor of Fire");
			DAMAGE_TYPE = "fire";
			SetDamageResistance("all", 0.4);
			SetDamageResistance("lightning", 1.5);
			SetDamageResistance("fire", 0.0);
			SetDamageResistance("cold", 2.5);
			ANIM_ATTACK = "battleaxe_swing1_L";
			SetModelBody(0, 0);
			SetModelBody(1, 2);
			SetModelBody(2, 5);
			LIGHT_COLOR = Vector3(255, 0, 0);
		}
		if (ARMOR_TYPE == 2)
		{
			SetName("Enchanted Armor of Thunder");
			DAMAGE_TYPE = "lightning";
			SetDamageResistance("all", 0.4);
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("acid", 3.0);
			SetDamageResistance("fire", 1.0);
			SetDamageResistance("cold", 1.0);
			ANIM_ATTACK = "swordswing1_L";
			SetModelBody(0, 0);
			SetModelBody(1, 2);
			SetModelBody(2, 4);
			LIGHT_COLOR = Vector3(255, 255, 0);
		}
		if (ARMOR_TYPE == 3)
		{
			SetName("Enchanted Armor of Frost");
			DAMAGE_TYPE = "cold";
			SetDamageResistance("all", 0.4);
			SetDamageResistance("lightning", 1.5);
			SetDamageResistance("fire", 2.5);
			SetDamageResistance("cold", 0.0);
			ANIM_ATTACK = "battleaxe_swing1_L";
			SetModelBody(0, 0);
			SetModelBody(1, 2);
			SetModelBody(2, 1);
			LIGHT_COLOR = Vector3(200, 200, 255);
		}
		if (ARMOR_TYPE == 4)
		{
			SetName("Enchanted Armor of Venom");
			DAMAGE_TYPE = "poison";
			SetDamageResistance("all", 0.4);
			SetDamageResistance("lightning", 3.0);
			ANIM_ATTACK = "swordswing1_L";
			SetModelBody(0, 0);
			SetModelBody(1, 2);
			SetModelBody(2, 4);
			LIGHT_COLOR = Vector3(0, 255, 0);
		}
		Effect("glow", GetOwner(), LIGHT_COLOR, 64, -1, 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
		SetModelBody(4, 0);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void swing_dodamage()
	{
		if (DAMAGE_TYPE == "fire")
		{
			ApplyEffect(param2, "effects/dot_fire", 30, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "cold")
		{
			ApplyEffect(param2, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "lightning")
		{
			ApplyEffect(param2, "effects/dot_lightning", 10, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (DAMAGE_TYPE == "poison")
		{
			ApplyEffect(param2, "effects/dot_poison", 30, GetEntityIndex(GetOwner()), RandomInt(5, 12));
		}
		if (!(ATTACK_PUSH != "ATTACK_PUSH")) return;
		if (!(ATTACK_PUSH != "none")) return;
		AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
	}

	void swing_axe()
	{
		string L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG, ATTACK_ACCURACY, GetOwner(), GetOwner(), "none", DAMAGE_TYPE, "dmgevent:swing");
	}

	void swing_sword()
	{
		swing_axe();
	}

	void OnFlinch()
	{
		ANIM_FLINCH = "flinch";
		if (param1 > 100)
		{
			ANIM_FLINCH = "flinch2";
		}
		if (param1 > 200)
		{
			ANIM_FLINCH = "flinch3";
		}
	}

	void OnPostSpawn() override
	{
		ClientEvent("persist", "all", "monsters/lighted_cl", GetEntityIndex(GetOwner()), LIGHT_COLOR, LIGHT_RAD);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		ClientEvent("update", "all", MY_LIGHT_SCRIPT, "remove_me");
	}

}

}
