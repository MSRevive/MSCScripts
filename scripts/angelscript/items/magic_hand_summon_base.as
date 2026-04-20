#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandSummonBase : CGameScript
{
	string EFFECT_DMG;
	string EFFECT_DURATION;
	string EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	int EFFECT_MINDURATION;
	float EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	float MELEE_HITCHANCE;
	int MELEE_RANGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	string SPELL_DESC;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	string SPELL_NAME;
	int SPELL_PREPARE_TIME;
	string SPELL_STAT;
	int baseitem.canidle;

	MagicHandSummonBase()
	{
		SPELL_NAME = "Some Spell";
		SPELL_DESC = "Some Description";
		SOUND_SHOOT = "magic/cast.wav";
		MELEE_RANGE = 200;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 1;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "summon";
		SPELL_ENERGYDRAIN = 20;
		SPELL_MPDRAIN = 1;
		SPELL_STAT = "none";
		EFFECT_MAXDURATION = 180;
		EFFECT_MINDURATION = 10;
		EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		EFFECT_MAX_DMG = 10;
		EFFECT_MIN_DMG = 0.1;
		EFFECT_DMG = GetSkillLevel(GetOwner(), "spellcasting.ratio");
		EFFECT_SCRIPT = "EFFECT_SCRIPT needs to be defined!";
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
