#pragma context server

namespace MS
{

class SfxJumpBeams : CGameScript
{
	string BEAM_TARG;
	int CUR_JUMPS;
	int FX_ACTIVE;
	string FX_OWNER;
	string FX_SCRIPT_ID;
	string FX_TARGET;
	int GOT_NEW_TARG;
	string OLD_TARG;
	int STATIC_ACTIVE;
	int SWIRL_ACTIVE;
	int SWIRL_ROT;

	SfxJumpBeams()
	{
		const int MAX_JUMPS = 6;
		CUR_JUMPS = 0;
		const int BONE_BEAM_WIDTH = 5;
		const int JUMP_BEAM_WIDTH = 10;
		const string SOUND_IDLEZAP1 = "debris/zap4.wav";
		const string SOUND_IDLEZAP2 = "debris/zap2.wav";
		const string SOUND_IDLEZAP3 = "debris/zap5.wav";
		const string SOUND_ZAP_TARG = "magic/lightning_strike2.wav";
	}

	void OnSpawn() override
	{
		SetName("Swirly Lightning Effect :)");
		SetModel("null.mdl");
		SetRace("beloved");
		SetInvincible(true);
		SetHeight(0);
		SetWidth(0);
		SetSolid("none");
		ScheduleDelayedEvent(120.0, "end_me_please");
	}

	void game_dynamically_created()
	{
		FX_TARGET = param1;
		FX_OWNER = param2;
		ClientEvent("new", "all", GetScriptName(GetOwner()), GetEntityOrigin(FX_OWNER));
		FX_SCRIPT_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "jump_beam");
	}

	void jump_beam()
	{
		if (CUR_JUMPS != 0)
		{
			if ((FX_TARGET).findFirst("(") == 0)
			{
				scan_target(GetEntityOrigin(FX_TARGET));
			}
			else
			{
				scan_target(FX_TARGET);
			}
		}
		if ((FX_TARGET).findFirst("(") == 0)
		{
			beam_damage();
			ClientEvent("update", "all", FX_SCRIPT_ID, "beam_jump", GetEntityIndex(FX_TARGET));
		}
		else
		{
			ClientEvent("update", "all", FX_SCRIPT_ID, "beam_jump", FX_TARGET);
		}
		CUR_JUMPS += 1;
		if (CUR_JUMPS >= MAX_JUMPS)
		{
			ScheduleDelayedEvent(2.0, "end_me_please");
		}
		else
		{
			ScheduleDelayedEvent(2.0, "jump_beam");
		}
	}

	void scan_target()
	{
		string SCAN_ORG = param1;
		SCAN_ORG = "z";
		SCAN_ORG += 32;
		CallExternal(FX_OWNER, "ext_sphere_token", "enemy", 270, SCAN_ORG);
		string BEAM_TARGS = GetEntityProperty(FX_OWNER, "scriptvar");
		int DO_RANDOM_JUMP = 0;
		if (BEAM_TARGS != "none")
		{
			string BEAM_TARGS = /* TODO: $sort_entlist */ $sort_entlist(BEAM_TARGS, "range", SCAN_ORG);
			string CUR_TARG = GetToken(BEAM_TARGS, 0, ";");
			string N_TARGS = GetTokenCount(BEAM_TARGS, ";");
			if (N_TARGS > 1)
			{
				string CUR_TARG = GetToken(BEAM_TARGS, 1, ";");
			}
			if (CUR_TARG == FX_TARGET)
			{
				int DO_RANDOM_JUMP = 1;
			}
			FX_TARGET = CUR_TARG;
		}
		else
		{
			int DO_RANDOM_JUMP = 1;
		}
		if ((DO_RANDOM_JUMP))
		{
			if ((FX_TARGET).findFirst("(") == 0)
			{
				FX_TARGET = GetEntityOrigin(FX_TARGET);
			}
			string L_OLD_TARG = FX_TARGET;
			FX_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, 270, 32));
			FX_TARGET = TraceLine(L_OLD_TARG, FX_TARGET);
		}
	}

	void beam_damage()
	{
		string L_DMG = GetSkillLevel(FX_OWNER, "spellcasting.lightning");
		string L_DMG_DIRECT = L_DMG;
		L_DMG_DIRECT *= 3;
		XDoDamage(FX_TARGET, "direct", L_DMG_DIRECT, 1.0, FX_OWNER, FX_OWNER, "spellcasting.lightning", "lightning_effect");
		string L_DOT = L_DMG;
		L_DOT *= 0.5;
		ApplyEffect(FX_TARGET, "effects/dot_lightning", 5.0, FX_OWNER, L_DOT);
	}

	void end_me_please()
	{
		ClientEvent("update", "all", FX_SCRIPT_ID, "end_fx");
		DeleteEntity(GetOwner());
	}

	void func_is_ent()
	{
		int L_RETURN = 0;
		if ((param1).findFirst("(") == 0)
		{
			int L_RETURN = 1;
		}
		return;
		return;
	}

	void client_activate()
	{
		string FX_ORIGIN = param1;
		SetCallback("render", "enable");
		GOT_NEW_TARG = 0;
		SWIRL_ROT = 0;
		BEAM_TARG = FX_ORIGIN;
		OLD_TARG = FX_ORIGIN;
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(0.2, "fx_loop");
		ScheduleDelayedEvent(120.0, "end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (!(STATIC_ACTIVE)) return;
		if (!((BEAM_TARG).findFirst("(") == 0)) return;
		string RND_BONE = RandomInt(1, 10);
		string BONE1_ORG = /* TODO: $getcl */ $getcl(BEAM_TARG, "bonepos", RND_BONE);
		string RND_BONE = RandomInt(1, 10);
		string BONE2_ORG = /* TODO: $getcl */ $getcl(BEAM_TARG, "bonepos", RND_BONE);
		if (BONE1_ORG == Vector3(0, 0, 0))
		{
			string BONE1_ORG = /* TODO: $getcl */ $getcl(BEAM_TARG, "origin");
		}
		if (BONE2_ORG == Vector3(0, 0, 0))
		{
			string BONE2_ORG = /* TODO: $getcl */ $getcl(BEAM_TARG, "origin");
		}
		if (BONE2_ORG == BONE1_ORG)
		{
			BONE2_ORG += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(Random(-48, 48), Random(-48, 48), 0));
		}
		ClientEffect("beam_points", BONE1_ORG, BONE2_ORG, "lgtning.spr", 0.001, BONE_BEAM_WIDTH, 1, 255, 255, 30, Vector3(255, 64, 0));
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		if (!(SWIRL_ACTIVE)) return;
		string L_BEAM_START = BEAM_TARG;
		string L_BEAM_END = L_BEAM_START;
		SWIRL_ROT += 40;
		if (SWIRL_ROT > 359)
		{
			SWIRL_ROT = 0;
		}
		L_BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, SWIRL_ROT, 0), Vector3(0, 15, 2));
		ClientEffect("beam_points", L_BEAM_START, L_BEAM_END, "lgtning.spr", 1.0, BONE_BEAM_WIDTH, 1, 255, 255, 30, Vector3(255, 64, 0));
		BEAM_TARG = L_BEAM_END;
	}

	void beam_jump()
	{
		if (!(FX_ACTIVE)) return;
		STATIC_ACTIVE = 0;
		SWIRL_ACTIVE = 0;
		string L_TARGET = param1;
		OLD_TARG = BEAM_TARG;
		if ((OLD_TARG).findFirst("(") == 0)
		{
			OLD_TARG = /* TODO: $getcl */ $getcl(BEAM_TARG, "origin");
		}
		else
		{
			OLD_TARG = BEAM_TARG;
		}
		BEAM_TARG = L_TARGET;
		if ((BEAM_TARG).findFirst("(") == 0)
		{
			string SOUND_ORG = /* TODO: $getcl */ $getcl(BEAM_TARG, "origin");
			ClientEffect("beam_points", OLD_TARG, SOUND_ORG, "lgtning.spr", 1.0, JUMP_BEAM_WIDTH, 1, 255, 255, 30, Vector3(255, 64, 0));
			SWIRL_ACTIVE = 0;
			STATIC_ACTIVE = 1;
		}
		else
		{
			ClientEffect("beam_points", OLD_TARG, BEAM_TARG, "lgtning.spr", 1.0, JUMP_BEAM_WIDTH, 1, 255, 255, 30, Vector3(255, 64, 0));
			SWIRL_ACTIVE = 1;
			STATIC_ACTIVE = 0;
			string SOUND_ORG = BEAM_TARG;
		}
		if ((SWIRL_ACTIVE))
		{
			string RND_ZAP = RandomInt(1, 3);
			if (RND_ZAP == 1)
			{
				EmitSound3D(SOUND_IDLEZAP1, 10, SOUND_ORG);
			}
			if (RND_ZAP == 2)
			{
				EmitSound3D(SOUND_IDLEZAP2, 10, SOUND_ORG);
			}
			if (RND_ZAP == 3)
			{
				EmitSound3D(SOUND_IDLEZAP3, 10, SOUND_ORG);
			}
		}
		else
		{
			string RND_ZAP = RandomInt(1, 3);
			if (RND_ZAP == 1)
			{
				EmitSound3D(SOUND_ZAP_TARG, 10, SOUND_ORG);
			}
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

}

}
