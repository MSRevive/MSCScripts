#pragma context server

#include "monsters/summon/base_summon.as"
#include "monsters/summon/rat.as"

namespace MS
{

class GiantRat : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int I_R_PET;
	int MOVE_RANGE;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string TRICK_ANIM;

	GiantRat()
	{
		I_R_PET = 1;
		const int SUMMON_CIRCLE_INDEX = 12;
		const string SUM_SAY_COME = "*squeek!*";
		const string SUM_SAY_ATTACK = "*squeek!* *squeek!*";
		const string SUM_SAY_HUNT = "*squeek...*";
		const string SUM_SAY_DEFEND = "*squeekie!*";
		const string SUM_SAY_DEATH = "*SQUEEK!*";
		const string SUM_SAY_GUARD = "*squeek!*";
		const string SUM_REPORT_SUFFIX = "..er, I mean, *squeek*!?";
		const string ANIM_WALK_BASE = "walk";
		const string ANIM_RUN_BASE = "run";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 60;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.9;
		TRICK_ANIM = "attack";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		SOUND_PAIN = "monsters/rat/squeak1.wav";
		SOUND_ATTACK1 = "monsters/rat/squeak2.wav";
		SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		CAN_HUNT = 1;
		CAN_HEAR = 0;
		CAN_FLINCH = 0;
	}

	void summon_spawn()
	{
		SetName("Giant Rat");
		SetFOV(359);
		SetWidth(32);
		SetHeight(20);
		SetRoam(true);
		SetHearingSensitivity(3);
		SetSkillLevel(0);
		SetRace("human");
		SetModel("monsters/giant_rat.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("run");
		basesummon_attackall();
		CatchSpeech("rat_standup", "stand");
		CatchSpeech("rat_rollover", "rollover");
		CatchSpeech("rat_playdead", "play dead");
	}

}

}
