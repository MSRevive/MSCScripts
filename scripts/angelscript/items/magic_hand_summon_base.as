#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandSummonBase : CGameScript
{
	int baseitem.canidle;

	MagicHandSummonBase()
	{
		const string SPELL_NAME = "Some Spell";
		const string SPELL_DESC = "Some Description";
		const string SOUND_SHOOT = "magic/cast.wav";
		const int MELEE_RANGE = 200;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 1;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "summon";
		const int SPELL_ENERGYDRAIN = 20;
		const int SPELL_MPDRAIN = 1;
		const string SPELL_STAT = "none";
		const int EFFECT_MAXDURATION = 180;
		const int EFFECT_MINDURATION = 10;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		const string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		const int EFFECT_MAX_DMG = 10;
		const float EFFECT_MIN_DMG = 0.1;
		const string EFFECT_DMG = GetSkillLevel(GetOwner(), "spellcasting.ratio");
		const string EFFECT_SCRIPT = "EFFECT_SCRIPT needs to be defined!";
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName(SPELL_NAME);
		SetDescription("SPELL_NAME");
	}

	void cast_start()
	{
		baseitem.canidle = 0;
		start_spell_anim();
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void start_spell_anim()
	{
		ScheduleDelayedEvent(1.1, "bitem_set_can_idle");
		PlayViewAnim(16);
	}

	void summon_check()
	{
		string SPAWN_ORG = param1;
		string reg.npcmove.endpos = SPAWN_ORG;
		reg.npcmove.endpos += "z";
		int reg.npcmove.testonly = 0;
		NpcMove(m_hLastCreated, "none");
		if ("game.ret.npcmove.dist" <= 0)
		{
			SendPlayerMessage(GetOwner(), "You cannot summon here");
			DeleteEntity(m_hLastCreated);
			GiveMP(GetOwner());
			if ((SUMMON_UNQIUE))
			{
				CallExternal(GetOwner(), "ext_unsummon_unique", SUMMON_UNIQUE_TAG);
			}
		}
		else
		{
			CURRENT_SUMMONS += 1;
			DropToFloor();
		}
	}

}

}
