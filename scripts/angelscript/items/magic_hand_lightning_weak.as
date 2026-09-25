#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandLightningWeak : CGameScript
{
	string LAST_CAST;
	string LIGHT_COLOR;
	int MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	float MELEE_HITCHANCE;
	int MELEE_NOAUTOAIM;
	int MELEE_RANGE;
	string MELEE_TYPE;
	string SCRIPT_SFX_CAST;
	float SCRIPT_SFX_DURATION;
	string SCRIPT_SFX_PREP;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;
	string script.npc;
	int script.ramp;

	MagicHandLightningWeak()
	{
		SOUND_SHOOT = "magic/cast.wav";
		MELEE_RANGE = 500;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 1;
		MELEE_TYPE = "strike-land";
		MELEE_DMG = 25;
		MELEE_DMG_RANGE = 15;
		MELEE_NOAUTOAIM = 1;
		MELEE_DMG_DELAY = 0.4;
		SPELL_SKILL_REQUIRED = 0;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "lightning_effect";
		SPELL_ENERGYDRAIN = 10;
		SPELL_MPDRAIN = 1;
		SPELL_STAT = "spellcasting.lightning";
		SCRIPT_SFX_CAST = "effects/sfx_lightning";
		SCRIPT_SFX_PREP = "items/magic_hand_lightning_weak_cl";
		SCRIPT_SFX_DURATION = 0.5;
		LIGHT_COLOR = Vector3(30, 30, 253);
	}

	void OnRepeatTimer()
	{
		if (IS_NEW_ITEM == 1)
		{
		}
		SetRepeatDelay(Random(4.0, 8.0));
		if ((LAST_CAST).findFirst("LAST") == 0)
		{
			LAST_CAST = GetGameTime();
		}
		string L_LAST_CAST = LAST_CAST;
		L_LAST_CAST += 5.0;
		if (GetGameTime() > L_LAST_CAST)
		{
		}
		// TODO: splayviewanim ent_me ANIM_IDLE1
	}

	void game_precache()
	{
		Precache(SCRIPT_SFX_CAST);
	}

	void spell_spawn()
	{
		SetName("Erratic Lightning");
		SetDescription("A highly erratic lightning bolt");
		script.ramp = 1;
	}

	void spell_casted()
	{
		LAST_CAST = GetGameTime();
		string l.end = param2;
		l.end += Vector3(0, 0, 4096);
		string l.widthratio = GetSkillLevel(GetOwner(), "spellcasting.lightning.ratio");
		l.widthratio *= 3;
		l.widthratio = max(0, min(1, l.widthratio));
		ClientEvent("new", "all_in_sight", SCRIPT_SFX_CAST, param2, l.end, SCRIPT_SFX_DURATION, l.widthratio);
		if (param1 == "npc")
		{
			Effect("glow", param3, LIGHT_COLOR, 128, 1, 1);
			script.npc = param3;
		}
		else
		{
			script.ramp = 1;
		}
	}

	void cast_damaged_other()
	{
		if (!(GetEntityProperty(script.npc, "alive"))) return;
		if (script.npc != param1)
		{
			script.ramp = 1;
		}
		string l.dmg = param2;
		l.dmg *= script.ramp;
		SetDamage("dmg");
		string RAMP_LIMIT = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		RAMP_LIMIT /= 2;
		if (RAMP_LIMIT < 3)
		{
			int RAMP_LIMIT = 3;
		}
		if (!(script.ramp < RAMP_LIMIT)) return;
		script.ramp += 0.6;
	}

}

}
