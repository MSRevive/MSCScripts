#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntBt : CGameScript
{
	string BURST_DMG;
	string BURST_POS;
	string BURST_STUN_DURATION;
	string BURST_TARGS;
	string CL_BEAM_IDX;
	string DOT_DMG;
	string GAME_PVP;

	BluntBt()
	{
		const int BASE_LEVEL_REQ = 35;
		const int STUN_BURST_MP = 40;
		const int MELEE_RANGE = 90;
		const float MELEE_DMG_DELAY = 0.5;
		const float MELEE_ATK_DURATION = 1.1;
		const float DEMON_DMG_DELAY = 0.25;
		const float DEMON_ATK_DURATION = 0.7;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 600;
		const int MELEE_DMG_RANGE = 40;
		const float MELEE_ACCURACY = 0.8;
		const float MELEE_PARRY_AUGMENT = 0.2;
		const string MELEE_DMG_TYPE = "lightning";
		const string MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		const int MODEL_VIEW_IDX = 13;
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 37;
		const string ANIM_PREFIX = "standard";
	}

	void weapon_spawn()
	{
		SetName("Thunder Breaker");
		SetDescription("An Earth Breaker imbued with elemental lightning");
		SetWeight(80);
		SetSize(10);
		SetValue(7000);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", 192);
	}

	void OnDeploy() override
	{
		GAME_PVP = "game.pvp";
	}

	void special_02_strike()
	{
		string ATTACK_END_POS = param2;
		if (GetEntityMP(GetOwner()) < STUN_BURST_MP)
		{
			SendColoredMessage(GetOwner(), "Thunder Breaker: Insufficient Mana for Shock Burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ATTACK_END_POS = "z";
		GiveMP(GetOwner());
		ClientEvent("new", "all", "effects/sfx_shock_burst", ATTACK_END_POS, 250, 1, Vector3(255, 255, 0));
		BURST_POS = ATTACK_END_POS;
		BURST_POS += 32;
		DOT_DMG = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		if (DOT_DMG > 20)
		{
			ScheduleDelayedEvent(0.1, "chain_beam_start");
		}
		BURST_STUN_DURATION = GetSkillLevel(GetOwner(), "bluntarms");
		BURST_DMG = BURST_STUN_DURATION;
		BURST_STUN_DURATION *= 0.5;
		BURST_DMG *= 4.0;
		BURST_TARGS = "none";
		XDoDamage(BURST_POS, 128, BURST_DMG, 0, GetOwner(), GetOwner(), "spellcasting.lightning", "lightning_effect", "dmgevent:*burst");
		if (GetTokenCount(BURST_TARGS, ";") > 1)
		{
			RemoveToken(BURST_TARGS, 0, ";");
		}
	}

	void burst_dodamage()
	{
		string CUR_TARG = param2;
		if (!(GetRelationship(CUR_TARG) == "enemy")) return;
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (BURST_TARGS.length() > 0) BURST_TARGS += ";";
		BURST_TARGS += CUR_TARG;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", BURST_STUN_DURATION, GetEntityIndex(GetOwner()));
		if (DOT_DMG >= 10)
		{
			ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = BURST_POS;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 110)));
	}

	void chain_beam_start()
	{
		if (BURST_TARGS != "none")
		{
			string FIRST_TARGET = GetToken(BURST_TARGS, 0, ";");
			string FIRST_TARGET = GetEntityIndex(FIRST_TARGET);
		}
		else
		{
			string START_YAW = GetEntityProperty(GetOwner(), "viewangles");
			string START_YAW = /* TODO: $vec.yaw */ $vec.yaw(START_YAW);
			string FIRST_TARGET = GetEntityOrigin(GetOwner());
			FIRST_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, START_YAW, 0), Vector3(0, 128, 0));
			FIRST_TARGET = "z";
			FIRST_TARGET += "z";
		}
		SpawnNPC("effects/sfx_jump_beams", "(0,0,0)", ScriptMode::Legacy); // params: FIRST_TARGET, GetEntityIndex(GetOwner())
		CL_BEAM_IDX = "game.script.last_sent_id";
	}

	void melee_damaged_other()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		L_DOT *= 0.25;
		ApplyEffect(param1, "effects/dot_lightning", 10.0, GetEntityIndex(GetOwner()), L_DOT);
	}

}

}
