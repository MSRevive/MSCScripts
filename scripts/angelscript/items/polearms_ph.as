#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsPh : CGameScript
{
	string LIGHTNING_CL_IDX;

	PolearmsPh()
	{
		const int BASE_LEVEL_REQ = 25;
		const int ZAP_MP = 20;
		const int VMODEL_IDX = 2;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 17;
		const int PMODEL_IDX_HANDS = 16;
		const int MELEE_DMG = 300;
		const int MELEE_RANGE = 120;
		const string MELEE_DMG_TYPE = "lightning";
		const Vector3 MELEE_STARTPOS = Vector3(0, 0, 5);
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.75;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 1;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_BACKHAND_DMG = 150;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "blunt";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.9;
		const float POLE_BACKHAND_STUN_CHANCE = 1.0;
		const int POLE_BACKHAND_REPEL = 500;
		const int POLE_BACKHAND_SPECIAL = 1;
		const int POLE_CAN_POWER_THROW = 1;
		const int POLE_THROW_MP = 10;
		const int POLE_THROW_POWER = 800;
		const string POLE_THOW_PROJECTILE = "proj_pole_ph";
		const string SOUND_THUNDER = "magic/bolt_end.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
	}

	void polearm_spawn()
	{
		SetName("Stormpharaoh's Lance");
		SetDescription("A spear once hefted by a mighty lord of the dead");
		SetWeight(40);
		SetSize(2);
		SetValue(6000);
		SetHUDSprite("trade", 109);
	}

	void attack_poke2_start()
	{
		ClientEvent("new", "all", "items/polearms_ph_cl", GetEntityIndex(GetOwner()));
		LIGHTNING_CL_IDX = "game.script.last_sent_id";
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_poke2_strike()
	{
		if (!(GetSkillLevel(GetOwner(), "spellcasting.lightning") > 25)) return;
		if (GetEntityMP(GetOwner()) < ZAP_MP)
		{
			SendColoredMessage(GetOwner(), "Stormpharaoh's Lance: Insufficient mana for Lightning Strike");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TRACE_START = param2;
		string TRACE_END = TRACE_START;
		string OWNER_VIEW = GetEntityProperty(GetOwner(), "viewangles");
		TRACE_END += /* TODO: $relpos */ $relpos(OWNER_VIEW, Vector3(0, 1024, 0));
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(IsEntityAlive(TRACE_LINE)))
		{
			string BEAM_END = TraceLine(TRACE_START, TRACE_END);
		}
		else
		{
			string BEAM_TARG = TRACE_LINE;
			string BEAM_END = GetEntityOrigin(BEAM_TARG);
			if (!(IsValidPlayer(BEAM_TARG)))
			{
				BEAM_END += "z";
			}
		}
		if ((IsValidPlayer(BEAM_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		int EXIT_SUB = 1;
		GiveMP(GetOwner());
		ClientEvent("update", "all", LIGHTNING_CL_IDX, "do_lightning", BEAM_END);
		EmitSound(GetOwner(), 0, SOUND_THUNDER, 10);
		if (!(IsEntityAlive(BEAM_TARG))) return;
		string DBEAM_DMG = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		DBEAM_DMG *= 3.0;
		XDoDamage(BEAM_TARG, "direct", DBEAM_DMG, 1.0, GetOwner(), GetOwner(), "spellcasting.lightning", "lightning");
		string DOT_SHOCK = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		DOT_SHOCK *= 1.5;
		ApplyEffect(BEAM_TARG, "effects/dot_lightning", 10.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
		int PUSH_STR = 500;
		PUSH_STR *= /* TODO: $get_takedmg */ $get_takedmg(BEAM_TARG, "lightning");
		AddVelocity(BEAM_TARG, /* TODO: $relvel */ $relvel(0, PUSH_STR, 110));
	}

	void pole_spin_hold()
	{
		if (!(GetSkillLevel(GetOwner(), "spellcasting.lightning") > 25)) return;
		CallExternal(GetOwner(), "ext_pole_lshield");
	}

	void pole_spin_end()
	{
		CallExternal(GetOwner(), "ext_pole_lshield_end", "abort");
	}

	void pole_backhand_special()
	{
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		L_DOT *= 0.5;
		ApplyEffect(param1, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), L_DOT);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(RandomInt(1, 3) == 1)) return;
		string DOT_BURN = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		DOT_BURN *= 1.5;
		ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_BURN);
	}

}

}
