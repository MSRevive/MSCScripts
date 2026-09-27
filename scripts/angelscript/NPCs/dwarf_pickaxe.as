#pragma context server

#include "monsters/base_battle_ally.as"
#include "monsters/base_monster_new.as"
#include "monsters/base_struck.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class DwarfPickaxe : CGameScript
{
	int ALLY_FOLLOW_ON;
	int ALLY_MOVE_AWAY_DIST;
	string ANIM_ALLY_JUMP;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK2_ACCURACY;
	int ATTACK2_CHANCE;
	int ATTACK2_DAMAGE;
	int ATTACK_ACCURACY;
	int ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int NPC_BASE_EXP;
	string NPC_MATERIAL_TYPE;
	int NPC_NO_PLAYER_DMG;
	int NPC_USE_FLINCH;
	int NPC_USE_IDLE;
	int NPC_USE_PAIN;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ALERT3;
	string SOUND_ALLY_JUMP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3voices/dwarf/voices/dwarf/vs_nx0drogm_atk3.wav;
	string SOUND_DEATH;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_FLINCH3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;

	DwarfPickaxe()
	{
		ALLY_FOLLOW_ON = 0;
		ANIM_ALLY_JUMP = "anim_roll_back";
		SOUND_ALLY_JUMP = "voices/dwarf/vs_nx0drogm_hit2.wav";
		ALLY_MOVE_AWAY_DIST = 128;
		NPC_MATERIAL_TYPE = "flesh";
		NPC_USE_PAIN = 1;
		NPC_USE_IDLE = 0;
		NPC_USE_FLINCH = 1;
		SOUND_PAIN1 = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		SOUND_PAIN2 = "voices/dwarf/vs_ndwarfm1_bat1.wav";
		SOUND_PAIN3 = "voices/dwarf/vs_ndwarfm1_hit3.wav";
		SOUND_FLINCH1 = "voices/dwarf/vs_nx0drogm_heal.wav";
		SOUND_FLINCH2 = "voices/dwarf/vs_nx0drogm_help.wav";
		SOUND_FLINCH3 = "voices/dwarf/vs_nx0drogm_hit1.wav";
		SOUND_DEATH = "voices/dwarf/vs_nx0drogm_hit3.wav";
		SOUND_ALERT1 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat3.wav";
		SOUND_ALERT2 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat1.wav";
		SOUND_ALERT3 = "voices/dwarf/voices/dwarf/vs_ndwarfm1_bat3.wav";
		SOUND_ATTACK1 = "voices/dwarf/voices/dwarf/vs_nx0drogm_atk1.wav";
		SOUND_ATTACK2 = "voices/dwarf/voices/dwarf/vs_nx0drogm_atk2.wav";
		SOUND_ATTACK3voices/dwarf/voices/dwarf/vs_nx0drogm_atk3.wav = "";
		ANIM_FLINCH = "anim_xbow_flinch";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		NPC_BASE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_MOVERANGE = 48;
		ATTACK_DAMAGE = 50;
		ATTACK2_DAMAGE = 150;
		ATTACK2_CHANCE = 30;
		ATTACK_ACCURACY = 80;
		ATTACK2_ACCURACY = 90;
	}

	void OnSpawn() override
	{
		dwarf_spawn();
	}

	void dwarf_spawn()
	{
		SetName("Dwarven Miner");
		SetModel("dwarf/male1.mdl");
		SetProp(GetOwner(), "skin", RandomInt(0, 6));
		SetModelBody(1, 8);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(400);
		SetRace("human");
		SetHearingSensitivity(8);
	}

	void frame_roll_back_push()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
	}

	void attack_1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		if (RandomInt(1, 100) < ATTACK2_CHANCE)
		{
			ANIM_ATTACK = "attack2";
		}
	}

	void attack_2()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK2_DAMAGE, ATTACK2_ACCURACY, "slash");
		ANIM_ATTACK = "attack";
		if (!(GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/debuff_stun", RandomInt(2, 8), GetEntityIndex(GetOwner()));
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 2, /* TODO: $relvel */ $relvel(10, -200, 10), 0);
	}

	void set_leader()
	{
		if (param1 != 0)
		{
			SetMoveSpeed(2.5);
			SetAnimMoveSpeed(2.5);
		}
		else
		{
			SetMoveSpeed(1.0);
			SetAnimMoveSpeed(1.0);
		}
	}

}

}
