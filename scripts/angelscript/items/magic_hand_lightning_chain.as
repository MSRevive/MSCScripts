#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandLightningChain : CGameScript
{
	string CLIENT_SCRIPT_IDX;
	string GAME_PVP;
	string IDX_LIST;
	int SPELL_SKILL_REQUIRED;
	string TARGET_LIST;

	MagicHandLightningChain()
	{
		const string SOUND_SHOOT = "weather/Storm_exclamation.wav";
		const int MELEE_RANGE = 2000;
		const float MELEE_HITCHANCE = 1.0;
		const float MELEE_ATK_DURATION = 1.0;
		const string MELEE_TYPE = "strike-land";
		const int MELEE_DMG = 0;
		const int MELEE_DMG_RANGE = 0;
		const int MELEE_NOAUTOAIM = 1;
		const float MELEE_DMG_DELAY = 0.4;
		SPELL_SKILL_REQUIRED = 1;
		const string SPELL_DAMAGE_TYPE = "lightning";
		const int SPELL_ENERGYDRAIN = 10;
		const int SPELL_MPDRAIN = 5;
		const string SPELL_STAT = "spellcasting.lightning";
		const string SOUND_ZAP1 = "debris/beamstart14.wav";
		const string SOUND_ZAP2 = "debris/beamstart15.wav";
		const string SOUND_ZAP3 = "debris/zap1.wav";
		const string SCRIPT_SFX_PREP = "items/magic_hand_lightning_weak_cl";
		const float SCRIPT_SFX_DURATION = 0.5;
		const Vector3 LIGHT_COLOR = Vector3(30, 30, 253);
		const int SCAN_RANGE = 400;
	}

	void spell_spawn()
	{
		SetName("Chain Lightning");
		SetDescription("Fires lightning bolts at multiple targets");
	}

	void spell_deploy()
	{
		if (!(true)) return;
		ClientEvent("new", "all", "items/magic_hand_lightning_chain_cl", GetEntityIndex(GetOwner()));
		CLIENT_SCRIPT_IDX = "game.script.last_sent_id";
		GAME_PVP = "game.pvp";
	}

	void spell_casted()
	{
		string SCAN_ORIGIN = GetEntityOrigin(GetOwner());
		if ((IsEntityAlive(param3)))
		{
			if (GetRelationship(param3) == "enemy")
			{
				if ((IsValidPlayer(param3)))
				{
					if (!(GAME_PVP))
					{
					}
					int EXIT_IF = 1;
				}
			}
			if (!(EXIT_IF))
			{
			}
			string FIRST_TARGET = param3;
			string SCAN_ORIGIN = GetEntityOrigin(param3);
		}
		CallExternal(GetOwner(), "ext_sphere_token", "enemy", SCAN_RANGE, SCAN_ORIGIN);
		TARGET_LIST = GetEntityProperty(GetOwner(), "scriptvar");
		if ((IsEntityAlive(FIRST_TARGET)))
		{
			string TEMP_LIST = TARGET_LIST;
			TARGET_LIST = FIRST_TARGET;
			TARGET_LIST += ";";
			TARGET_LIST += TEMP_LIST;
		}
		if (!(TARGET_LIST != "none")) return;
		string DMG_LIGHTNING = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		DMG_LIGHTNING *= 0.75;
		XDoDamage(SCAN_ORIGIN, SCAN_RANGE, DMG_LIGHTNING, 0, GetOwner(), GetOwner(), "spellcasting.lightning", "lightning");
		IDX_LIST = "";
		for (int i = 0; i < GetTokenCount(TARGET_LIST, ";"); i++)
		{
			convert_targets_to_idxs();
		}
		ClientEvent("update", "all", CLIENT_SCRIPT_IDX, "draw_beams", IDX_LIST);
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void convert_targets_to_idxs()
	{
		string CUR_TARGET = GetToken(TARGET_LIST, i, ";");
		if (IDX_LIST.length() > 0) IDX_LIST += ";";
		IDX_LIST += GetEntityIndex(CUR_TARGET);
	}

	void spell_end()
	{
		ClientEvent("remove", "all", CLIENT_SCRIPT_IDX);
	}

}

}
