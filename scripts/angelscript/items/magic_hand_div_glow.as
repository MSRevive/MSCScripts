#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandDivGlow : CGameScript
{
	string CAST_DELAY;
	string CAST_STARTED;
	string LIGHT_POWER;
	string MAX_LIGHT_POWER;
	string NEXT_LIGHT_UPDATE;
	int SPELL_SKILL_REQUIRED;

	MagicHandDivGlow()
	{
		const string SOUND_SHOOT = "magic/cast.wav";
		const int MELEE_RANGE = 1024;
		const float MELEE_HITCHANCE = 1.0;
		const float MELEE_ATK_DURATION = 0.5;
		SPELL_SKILL_REQUIRED = 1;
		const float SPELL_PREPARE_TIME = 0.5;
		const string SPELL_DAMAGE_TYPE = "generic";
		const int SPELL_ENERGYDRAIN = 5;
		const int SPELL_MPDRAIN = 1;
		const string SPELL_STAT = "none";
		const int EFFECT_MAXDURATION = 240;
		const int EFFECT_MINDURATION = 60;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration");
		EFFECT_DURATION_STAT /= 100;
		const string EFFECT_DURATION_FORMULA = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		const int LIGHTRNG_MAX = 384;
		const int LIGHTRNG_MIN = 96;
		const string LIGHTRNG_SKILL = "l.skillratio";
		const string LIGHTRNG_FORMULA = /* TODO: $get_skill_ratio */ $get_skill_ratio(LIGHTRNG_SKILL, LIGHTRNG_MIN, LIGHTRNG_MAX);
		const int EFFECT_STACK = 1;
		const float FREQ_INC_LIGHT = 0.2;
	}

	void spell_spawn()
	{
		SetName("Glow");
		SetDescription("Create artificial light");
	}

	void OnDeploy() override
	{
		CAST_DELAY = GetGameTime();
		CAST_DELAY += 0.2;
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			if (!(CAST_STARTED))
			{
			}
			SendPlayerMessage("Glow:", "Extinguishing spell...");
			CallExternal(GAME_MASTER, "gm_light_update", "remove", GetEntityIndex(GetOwner()));
			CallExternal(GetOwner(), "ext_set_glow", 0);
			EmitSound(GetOwner(), 0, "magic/elecidlepop.wav", 5);
			glow_done("remove_glow");
		}
	}

	void game_attack1_down()
	{
		if (!(GetGameTime() > CAST_DELAY)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			SendPlayerMessage(GetOwner(), "You cannot use divine magic while under the influence of Demon Blood!");
			glow_done("demon_blood");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(GetOwner(), "scriptvar")))
		{
			SendPlayerMessage(GetOwner(), "A dark force is blocking the glow spell!");
			if ((CAST_STARTED))
			{
				CallExternal(GAME_MASTER, "gm_light_update", "remove", GetEntityIndex(GetOwner()));
				CallExternal(GetOwner(), "ext_set_glow", 0);
				EmitSound(GetOwner(), 0, "magic/elecidlepop.wav", 5);
				glow_done("dark_force");
			}
			spell_end();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(CAST_STARTED))
		{
			CAST_STARTED = 1;
			LIGHT_POWER = 0.05;
			MAX_LIGHT_POWER = GetSkillLevel(GetOwner(), "spellcasting");
			MAX_LIGHT_POWER *= 0.1;
			if (MAX_LIGHT_POWER > 1)
			{
				MAX_LIGHT_POWER = 1;
			}
			EmitSound(GetOwner(), 0, "magic/elecidlepop.wav", 5);
			// svplaysound: svplaysound 2 5 ambience/labdrone2.wav 0.8 50
			EmitSound(2, 5, "ambience/labdrone2.wav", 0.8, 50);
			int COLOR_RATIO_R = 255;
			string COLOR_RATIO_G = /* TODO: $ratio */ $ratio(LIGHT_POWER, 0, 255);
			string COLOR_RATIO_B = /* TODO: $ratio */ $ratio(LIGHT_POWER, 128, 255);
			string RAD_RATIO = /* TODO: $ratio */ $ratio(LIGHT_POWER, 50, 255);
			SendPlayerMessage("Glow:", "Charging...");
			CallExternal(GAME_MASTER, "gm_light_update", "new", GetEntityIndex(GetOwner()), Vector3(COLOR_RATIO_R, COLOR_RATIO_G, COLOR_RATIO_B), RAD_RATIO, "magic_hand_div_glow");
			NEXT_LIGHT_UPDATE = GetGameTime();
			NEXT_LIGHT_UPDATE += FREQ_INC_LIGHT;
			CallExternal(GetOwner(), "ext_set_glow", 1);
		}
		if (GetGameTime() > NEXT_LIGHT_UPDATE)
		{
			NEXT_LIGHT_UPDATE = GetGameTime();
			NEXT_LIGHT_UPDATE += FREQ_INC_LIGHT;
			LIGHT_POWER += 0.05;
			if (LIGHT_POWER >= MAX_LIGHT_POWER)
			{
				glow_done("max_power");
			}
			if (LIGHT_POWER < MAX_LIGHT_POWER)
			{
			}
			string PITCH_RATIO = /* TODO: $ratio */ $ratio(LIGHT_POWER, 50, 200);
			// svplaysound: svplaysound 2 5 ambience/labdrone2.wav 0.8 PITCH_RATIO
			EmitSound(2, 5, "ambience/labdrone2.wav", 0.8, PITCH_RATIO);
			LogDebug("cur_power LIGHT_POWER");
			int COLOR_RATIO_R = 100;
			string COLOR_RATIO_G = /* TODO: $ratio */ $ratio(LIGHT_POWER, 64, 100);
			string COLOR_RATIO_B = /* TODO: $ratio */ $ratio(LIGHT_POWER, 32, 100);
			string RAD_RATIO = /* TODO: $ratio */ $ratio(LIGHT_POWER, 50, 400);
			CallExternal(GAME_MASTER, "gm_light_update", "update", GetEntityIndex(GetOwner()), Vector3(COLOR_RATIO_R, COLOR_RATIO_G, COLOR_RATIO_B), RAD_RATIO, "magic_hand_div_glow");
		}
	}

	void game__attack1()
	{
		if (!(CAST_STARTED)) return;
		glow_done("mouse_release");
	}

	void glow_done()
	{
		LogDebug("glow_done PARAM1");
		if ((CAST_STARTED))
		{
			// svplaysound: if ( CAST_STARTED ) svplaysound 2 0 ambience/labdrone2.wav
			EmitSound(2, 0, "ambience/labdrone2.wav");
		}
		if (param1 == "max_power")
		{
			SendPlayerMessage("Glow:", "Maximum charge reached.");
		}
		else
		{
			if ((CAST_STARTED))
			{
			}
			string DISP_POWER = "(";
			string L_LIGHT_POWER = LIGHT_POWER;
			L_LIGHT_POWER *= 100;
			string L_LIGHT_POWER = int(L_LIGHT_POWER);
			DISP_POWER += L_LIGHT_POWER;
			DISP_POWER += "%";
			DISP_POWER += ")";
			SendPlayerMessage("Glow:", "Charge set DISP_POWER");
		}
		DeleteEntity(GetOwner());
	}

}

}
