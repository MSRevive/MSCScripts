#pragma context server

#include "monsters/summon/giant_rat.as"

namespace MS
{

class Fangtooth : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int MOVE_RANGE;
	string TRICK_ANIM;

	Fangtooth()
	{
		const int SUMMON_CIRCLE_INDEX = 12;
		const string SUM_SAY_COME = "*squirk!*";
		const string SUM_SAY_ATTACK = "*squeek!* *squeek!*";
		const string SUM_SAY_HUNT = "*squirk...*";
		const string SUM_SAY_DEFEND = "*squeekie!*";
		const string SUM_SAY_DEATH = "*SQUEEK!*";
		const string SUM_SAY_GUARD = "*gasp!*";
		const string SUM_REPORT_SUFFIX = "..er, I mean, *squirk*!?";
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
	}

	void summon_spawn()
	{
		SetName("Fang Tooth");
		SetFOV(359);
		SetWidth(32);
		SetHeight(20);
		SetRoam(true);
		SetHearingSensitivity(6);
		SetSkillLevel(0);
		SetRace("human");
		SetModel("monsters/giant_rat.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("run");
		PlayAnim("once", "idle1");
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(2.0);
		BASE_FRAMERATE = 2.0;
		BASE_MOVESPEED = 2.0;
		basesummon_attackall();
		CatchSpeech("rat_standup", "stand");
		CatchSpeech("rat_rollover", "rollover");
		CatchSpeech("rat_playdead", "play dead");
	}

	void bite_dodamage()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		ApplyEffect(param2, "effects/dot_poison", 10, GetEntityIndex(GetOwner()), Random(1, 10));
	}

}

}
