#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsPh : CGameScript
{
	int BASE_LEVEL_REQ;
	string LIGHTNING_CL_IDX;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string MELEE_STARTPOS;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	float POLE_BACKHAND_ACCURACY;
	int POLE_BACKHAND_DMG;
	int POLE_BACKHAND_DMG_RANGE;
	string POLE_BACKHAND_DMG_TYPE;
	int POLE_BACKHAND_RANGE;
	int POLE_BACKHAND_REPEL;
	int POLE_BACKHAND_SPECIAL;
	float POLE_BACKHAND_STUN_CHANCE;
	int POLE_CAN_BACKHAND;
	int POLE_CAN_BLOCK;
	int POLE_CAN_POKE1;
	int POLE_CAN_POKE2;
	int POLE_CAN_POWER_THROW;
	int POLE_CAN_REPEL;
	int POLE_CAN_SPIN;
	int POLE_CAN_SWIPE;
	float POLE_MAX_DMG_MULTI;
	float POLE_MIN_DMG_MULTI;
	int POLE_MIN_RANGE;
	string POLE_THOW_PROJECTILE;
	int POLE_THROW_MP;
	int POLE_THROW_POWER;
	string SOUND_SHOCK1;
	string SOUND_SHOCK2;
	string SOUND_SHOCK3;
	string SOUND_THUNDER;
	int VMODEL_IDX;
	int ZAP_MP;

	PolearmsPh()
	{
		BASE_LEVEL_REQ = 25;
		ZAP_MP = 20;
		VMODEL_IDX = 2;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 17;
		PMODEL_IDX_HANDS = 16;
		MELEE_DMG = 300;
		MELEE_RANGE = 120;
		MELEE_DMG_TYPE = "lightning";
		MELEE_STARTPOS = Vector3(0, 0, 5);
		POLE_MIN_RANGE = 60;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 1.75;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 1;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 1;
		POLE_BACKHAND_DMG = 150;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "blunt";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
		POLE_BACKHAND_STUN_CHANCE = 1.0;
		POLE_BACKHAND_REPEL = 500;
		POLE_BACKHAND_SPECIAL = 1;
		POLE_CAN_POWER_THROW = 1;
		POLE_THROW_MP = 10;
		POLE_THROW_POWER = 800;
		POLE_THOW_PROJECTILE = "proj_pole_ph";
		SOUND_THUNDER = "magic/bolt_end.wav";
		SOUND_SHOCK1 = "debris/zap8.wav";
		SOUND_SHOCK2 = "debris/zap3.wav";
		SOUND_SHOCK3 = "debris/zap4.wav";
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
