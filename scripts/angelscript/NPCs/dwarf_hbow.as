#pragma context server

#include "monsters/dwarf_zombie_hbow.as"
#include "monsters/base_battle_ally.as"

namespace MS
{

class DwarfHbow : CGameScript
{
	int ALLY_FOLLOW_ON;
	int NPC_NO_PLAYER_DMG;

	DwarfHbow()
	{
		const int NPC_BASE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		ALLY_FOLLOW_ON = 0;
		const string ANIM_ALLY_JUMP = "anim_roll_back";
		const int NPC_USE_IDLE = 0;
		const string SOUND_ALLY_JUMP = "voices/dwarf/vs_nx0drogm_hit2.wav";
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
		const Vector3 LANTERN_COLOR = Vector3(128, 64, 0);
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
