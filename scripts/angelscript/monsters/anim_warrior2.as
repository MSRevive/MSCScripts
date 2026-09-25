#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class AnimWarrior2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int HUNT_AGRO;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int I_AM_TURNABLE;
	string LAST_ENEMY;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_HIT;
	string SOUND_HIT2;
	string SOUND_HIT3;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SPAWNER;

	AnimWarrior2()
	{
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		SOUND_STRUCK1 = "body/armour1.wav";
		SOUND_STRUCK2 = "body/armour2.wav";
		SOUND_STRUCK3 = "body/armour3.wav";
		SOUND_HIT = "body/armour3.wav";
		SOUND_HIT2 = "body/armour2.wav";
		SOUND_HIT3 = "body/armour1.wav";
		SOUND_PAIN = "body/armour1.wav";
		SOUND_ATTACK1 = "none";
		SOUND_ATTACK2 = "none";
		SOUND_ATTACK3 = "none";
		SOUND_DEATH = "none";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		CAN_FLEE = 0;
		CAN_FLINCH = 0;
		LAST_ENEMY = "NONE";
		MOVE_RANGE = 54;
		ATTACK_RANGE = 82;
		ATTACK_HITRANGE = 128;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 40);
		NPC_GIVE_EXP = 65;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ATTACK_ACCURACY = 0.85;
		ATTACK_DMG_LOW = 25;
		ATTACK_DMG_HIGH = 35;
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetName("Infernal Animated Armor");
		SetRoam(true);
		SetRace("demon");
		SetWidth(40);
		SetHealth(400);
		SetFOV(359);
		SetHeight(90);
		SetModel("monsters/animarmor.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetStepSize(16);
		SetDamageResistance("all", 0.9);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 2.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 3.0);
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 5);
		SetModelBody(3, 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
		SetModelBody(4, 0);
		CallExternal(SPAWNER, "undead_died");
		DEAD_GUARDS += 1;
		if (DEAD_GUARDS > 1000)
		{
			SetGlobalVar("DEAD_GUARDS", 0);
		}
	}

	void npc_targetsighted()
	{
		string LASTSEEN_ENEMY = GetEntityIndex(m_hLastSeen);
		if (!(LASTSEEN_ENEMY != LAST_ENEMY)) return;
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK2, 5);
		LAST_ENEMY = LASTSEEN_ENEMY;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {"game.sound.maxvol", SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(ATTACK_PUSH != "ATTACK_PUSH")) return;
		if (!(ATTACK_PUSH != "none")) return;
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 10, GetOwner(), RandomInt(5, 12));
		AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
	}

	void OnFlinch()
	{
		PlayAnim("critical", "flinch");
	}

	void retaliate()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		SetMoveDest(m_hLastStruck);
		LookAt(GetOwner());
		hunt_look();
	}

	void swing_axe()
	{
		float L_DMG = Random(ATTACK_DMG_LOW, ATTACK_DMG_HIGH);
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 10, GetOwner(), RandomInt(5, 12));
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, L_DMG, ATTACK_ACCURACY, "slash");
	}

	void swing_sword()
	{
		swing_axe();
	}

	void game_dynamically_created()
	{
		SPAWNER = param1;
	}

}

}
