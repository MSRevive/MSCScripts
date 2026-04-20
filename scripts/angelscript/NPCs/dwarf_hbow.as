#pragma context server

#include "monsters/dwarf_zombie_hbow.as"
#include "monsters/base_battle_ally.as"

namespace MS
{

class DwarfHbow : CGameScript
{
	string ACT_ANIM_RUN;
	int ALLY_FOLLOW_ON;
	string ANIM_ALLY_JUMP;
	string LANTERN_COLOR;
	int LANTERN_HAND_INDEX;
	int LANTERN_HAND_SUBMODEL;
	int NPC_BASE_EXP;
	int NPC_NO_PLAYER_DMG;
	int NPC_USE_IDLE;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ALERT3;
	string SOUND_ALLY_JUMP;
	string SOUND_DEATH;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_FLINCH3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;

	DwarfHbow()
	{
		NPC_BASE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		ALLY_FOLLOW_ON = 0;
		ANIM_ALLY_JUMP = "anim_roll_back";
		NPC_USE_IDLE = 0;
		SOUND_ALLY_JUMP = "voices/dwarf/vs_nx0drogm_hit2.wav";
		ACT_ANIM_RUN = "run";
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
		LANTERN_HAND_SUBMODEL = 2;
		LANTERN_HAND_INDEX = 0;
		LANTERN_COLOR = Vector3(128, 64, 0);
	}

	void darcher_spawn()
	{
		SetName("Dwarven Bowman");
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 0);
		SetProp(GetOwner(), "skin", RandomInt(0, 6));
		SetModelBody(1, 7);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(300);
		SetRace("human");
		SetHearingSensitivity(8);
	}

	void set_follower()
	{
		ALLY_FOLLOW_ON = 1;
	}

	void frame_roll_back_push()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
	}

}

}
