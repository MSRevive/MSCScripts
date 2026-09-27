#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandLightningStorm : CGameScript
{
	int DRAIN_COUNT;
	string EFFECT_DMG;
	int MELEE_ATK_DURATION;
	int MELEE_HITCHANCE;
	int MELEE_NOAUTOAIM;
	int MELEE_RANGE;
	string MELEE_TYPE;
	string SCRIPT_SFX_CAST;
	string SCRIPT_SFX_PREP;
	string SOUND_LOOP;
	string SOUND_SHOOT;
	string SOUND_SHOOT1;
	string SOUND_SHOOT2;
	string SOUND_SHOOT3;
	string SPELL_DAMAGE_TYPE;
	int SPELL_MPDRAIN;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;
	string STORM_ID;
	string STORM_UP;

	MagicHandLightningStorm()
	{
		MELEE_TYPE = "strike-land";
		MELEE_RANGE = 1000;
		MELEE_HITCHANCE = 100;
		MELEE_ATK_DURATION = 1;
		MELEE_NOAUTOAIM = 1;
		SPELL_SKILL_REQUIRED = 10;
		SCRIPT_SFX_PREP = "items/magic_hand_lightning_weak_cl";
		SPELL_DAMAGE_TYPE = "lightning";
		SPELL_MPDRAIN = 30;
		SPELL_STAT = "spellcasting.lightning";
		SOUND_LOOP = "magic/shock_noloop.wav";
		SOUND_SHOOT = "debris/beamstart14.wav";
		SOUND_SHOOT1 = "debris/zap1.wav";
		SOUND_SHOOT2 = "debris/zap2.wav";
		SOUND_SHOOT3 = "debris/zap3.wav";
		SCRIPT_SFX_CAST = "effects/sfx_lightning";
		DRAIN_COUNT = 0;
		EmitSound(GetOwner(), 0, SOUND_LOOP, 5);
	}

	void game_precache()
	{
		Precache(SCRIPT_SFX_CAST);
	}

	void spell_spawn()
	{
		SetName("Lightning Storm");
		SetDescription("An electrical storm");
	}

	void spell_casted()
	{
		string L_ATK_POS = param2;
		DRAIN_COUNT = 0;
		if ((STORM_UP))
		{
			Effect("beam", "point", "lgtning.spr", 200, GetEntityOrigin(GetOwner()), L_ATK_POS, Vector3(255, 255, 0), 64, 10, 0.5);
			CallExternal(STORM_ID, "sustain_storm", L_ATK_POS);
		}
		else
		{
			string MY_OWNER = GetEntityIndex(GetOwner());
			EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
			EFFECT_DMG *= 1.5;
			SpawnNPC("monsters/summon/summon_lightning_storm", L_ATK_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(MY_OWNER, "angles.y"), EFFECT_DMG, 15, "spellcasting.lightning"
			STORM_ID = GetEntityIndex(m_hLastCreated);
			STORM_UP = 1;
		}
		// PlayRandomSound from: SOUND_SHOOT1, SOUND_SHOOT2, SOUND_SHOOT3
		array<string> sounds = {SOUND_SHOOT1, SOUND_SHOOT2, SOUND_SHOOT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		string L_POS = param2;
		CallExternal(STORM_ID, "sustain_storm", L_POS);
	}

	void storm_ended()
	{
		STORM_UP = 0;
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

}

}
