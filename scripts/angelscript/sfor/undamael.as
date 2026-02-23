#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Undamael : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int DID_WARCRY;
	int FLINCH_DELAY;
	int IGNORE_ENEMY;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;
	int SEE_ENEMY;
	string SOUND_PISSED;
	int SWIPES;

	Undamael()
	{
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "controller/con_pain2.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_TAUNT = "nihilanth/nil_die.wav";
		const string SOUND_IDLE = "garg/gar_idle2.wav";
		const string SOUND_DEATH = "nihilanth/nil_done.wav";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ATTACK_HITRANGE = 600;
		ATTACK_RANGE = 120;
		ANIM_ATTACK = "";
		ATTACK_HITCHANCE = 0.9;
		const string DAMAGE_ATTACK1 = RandomInt(40, 60);
		const string DAMAGE_ATTACK2 = RandomInt(60, 100);
		MOVE_RANGE = 100;
		SEE_ENEMY = 0;
		IGNORE_ENEMY = 0;
		CAN_FLINCH = 0;
		FLINCH_DELAY = 12;
		NPC_MOVE_TARGET = "enemy";
		GiveItem(GetOwner(), "ring_light2");
		Precache(SOUND_DEATH);
		SOUND_PISSED = "garg/gar_die1.wav";
		Precache(SOUND_PISSED);
		Precache(SOUND_IDLE);
		const string MONSTER_MODEL = "monsters/skeleton_boss2.mdl";
		Precache(MONSTER_MODEL);
		Precache("lgtning.spr");
	}

	void OnSpawn() override
	{
		SetName("boss_atholo");
		SetName("Atholo");
		SetInvincible(true);
		SetHealth(2200);
		SetGold(250);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.1);
		SetDamageResistance("lightning", 0.5);
		SetWidth(40);
		SetHeight(128);
		SetRace("undead");
		SetRoam(false);
		SetHearingSensitivity(6);
		NPC_GIVE_EXP = 400;
		SetModelBody(1, 4);
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ANIM_ATTACK = "attack1";
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_TAUNT);
		SWIPES = 0;
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, 600, DAMAGE_ATTACK1, 0.75, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), RandomInt(50, 100));
		SWIPES += 1;
		if (!(SWIPES > 10)) return;
		SWIPES = 0;
		ANIM_ATTACK = "attack2";
	}

	void attack_2()
	{
		DoDamage(m_hLastSeen, ATTACK2_RANGE, DAMAGE_ATTACK2, 1.0, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_cold_freeze", 5, GetEntityIndex(GetOwner()), RandomInt(25, 50));
		ANIM_ATTACK = "attack1";
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		SetRoam(true);
	}

	void death()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_DEATH);
	}

	void wander()
	{
		SetRepeatDelay(15);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_TAUNT);
		SetMoveAnim(ANIM_WALK);
		SEE_ENEMY = 0;
	}

	void vulnerable()
	{
		SetInvincible(false);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_PISSED);
		SetSayTextRange(1024);
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(1.5);
		CAN_FLINCH = 1;
		SayText("Fools! I shall destroy you all!");
	}

	void turn_undead()
	{
		string INC_HOLY_DMG = param1;
		string THE_EXCORCIST = param2;
		string ME_ME = GetEntityIndex(GetOwner());
		DoDamage(ME_ME, "direct", INC_HOLY_DMG, 100, THE_EXCORCIST);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 512, 1, 1);
	}

	void my_target_died()
	{
		EmitSound(GetOwner(), 0, SOUND_TAUNT, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// TODO: UNCONVERTED: usertrigger atholo_died
	}

}

}
