#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandTurnUndead : CGameScript
{
	string HOLY_DMG;
	int SPELL_SKILL_REQUIRED;
	string TARGET_NPC;
	int TARGET_VALID;

	MagicHandTurnUndead()
	{
		const string SOUND_SHOOT = "fvox/hiss.wav";
		const int MELEE_RANGE = 500;
		const float MELEE_HITCHANCE = 1.0;
		const float MELEE_ATK_DURATION = 1.5;
		const string MELEE_TYPE = "holy";
		const int MELEE_DMG = 0;
		const int MELEE_DMG_RANGE = 0;
		const int MELEE_NOAUTOAIM = 1;
		const float MELEE_DMG_DELAY = 0.4;
		SPELL_SKILL_REQUIRED = 1;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "holy";
		const int SPELL_ENERGYDRAIN = 10;
		const int SPELL_MPDRAIN = 2;
		const string SPELL_STAT = "spellcasting.divination";
		const string SCRIPT_SFX_CAST = "effects/sfx_lightning";
		Precache(SCRIPT_SFX_CAST);
		const string SCRIPT_SFX_PREP = "items/magic_hand_lightning_weak_cl";
		const float SCRIPT_SFX_DURATION = 0.5;
		const Vector3 LIGHT_COLOR = Vector3(255, 255, 0);
	}

	void spell_spawn()
	{
		SetName("Rebuke Undead");
		SetDescription("Sets the wrath of the divine upon the Unholy");
	}

	void spell_casted()
	{
		string DEMON_ON = GetEntityProperty(GetOwner(), "scriptvar");
		if ((DEMON_ON))
		{
			SendPlayerMessage("You", "cannot use divine magic while under the influence of Demon Blood!");
			spell_end();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(TARGET_VALID)) return;
		// svplaysound: svplaysound 2 5 SOUND_SHOOT
		EmitSound(2, 5, SOUND_SHOOT);
		TARGET_VALID = 0;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		TARGET_VALID = 1;
		TARGET_NPC = param2;
		if (/* TODO: $get_takedmg */ $get_takedmg(TARGET_NPC, "holy") == 0)
		{
			TARGET_VALID = 0;
		}
		if (TARGET_VALID == 0)
		{
			if ((param2 !is null) == 1)
			{
				SendPlayerMessage("Holy", "Light only affects the Undead and Unholy.");
			}
		}
		if (!(TARGET_VALID)) return;
		HOLY_DMG = GetSkillLevel(GetOwner(), "spellcasting.divination");
		HOLY_DMG *= 0.5;
		string MY_OWNER = GetEntityIndex(GetOwner());
		CallExternal(TARGET_NPC, "turn_undead", HOLY_DMG, MY_OWNER);
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

}

}
