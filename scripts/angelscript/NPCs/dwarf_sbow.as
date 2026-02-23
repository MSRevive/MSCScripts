#pragma context server

#include "monsters/dwarf_zombie_sbow.as"
#include "monsters/base_battle_ally.as"

namespace MS
{

class DwarfSbow : CGameScript
{
	int ALLY_FOLLOW_ON;
	int NPC_NO_PLAYER_DMG;

	DwarfSbow()
	{
		const int NPC_BASE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		ALLY_FOLLOW_ON = 0;
		const string ANIM_ALLY_JUMP = "anim_roll_back";
		const int NPC_USE_IDLE = 0;
		const string SOUND_ALLY_JUMP = "voices/dwarf/vs_nx0drogm_hit2.wav";
		const int ALLY_MOVE_AWAY_DIST = 128;
		const int ALLY_MIN_DISTANCE = 64;
		const string ACT_ANIM_RUN = "run";
		const string SOUND_PAIN1 = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		const string SOUND_PAIN2 = "voices/dwarf/vs_ndwarfm1_bat1.wav";
		const string SOUND_PAIN3 = "voices/dwarf/vs_ndwarfm1_hit3.wav";
		const string SOUND_FLINCH1 = "voices/dwarf/vs_nx0drogm_heal.wav";
		const string SOUND_FLINCH2 = "voices/dwarf/vs_nx0drogm_help.wav";
		const string SOUND_FLINCH3 = "voices/dwarf/vs_nx0drogm_hit1.wav";
		const string SOUND_DEATH = "voices/dwarf/vs_nx0drogm_hit3.wav";
		const string SOUND_ALERT1 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat3.wav";
		const string SOUND_ALERT2 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat1.wav";
		const string SOUND_ALERT3 = "voices/dwarf/voices/dwarf/vs_ndwarfm1_bat3.wav";
		const int LANTERN_HAND_SUBMODEL = 2;
		const int LANTERN_HAND_INDEX = 0;
		const Vector3 LANTERN_COLOR = Vector3(100, 75, 0);
	}

	void darcher_spawn()
	{
		SetName("Dwarven Elite Bowman");
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, RandomInt(0, 1));
		SetProp(GetOwner(), "skin", RandomInt(0, 6));
		SetModelBody(1, 6);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(300);
		SetRace("human");
		SetHearingSensitivity(8);
	}

	void frame_roll_back_push()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
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
