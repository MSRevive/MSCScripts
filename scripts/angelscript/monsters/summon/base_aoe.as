#pragma context server

namespace MS
{

class BaseAoe : CGameScript
{
	string AOE_ISPLAYER;
	string AOE_TOKENS;
	string GAME_PVP;
	int IS_ACTIVE;

	BaseAoe()
	{
		const int AOE_RADIUS = 256;
		const int AOE_DMG_FREQ = 0;
		const int AOE_DMG = 10;
		const string AOE_DMG_TYPE = "fire";
		const int AOE_FREQ = 0;
		const string AOE_FRIEND_FOE = "enemy";
	}

	void OnSpawn() override
	{
		GAME_PVP = "game.pvp";
		IS_ACTIVE = 1;
		if (AOE_FREQ > 0)
		{
			ScheduleDelayedEvent(0.1, "aoe_scan_loop");
		}
		if (AOE_DMG_FREQ > 0)
		{
			ScheduleDelayedEvent(0.1, "aoe_dmg_loop");
		}
		ScheduleDelayedEvent(0.1, "get_skill");
	}

	void get_skill()
	{
		AOE_ISPLAYER = IsValidPlayer(MY_OWNER);
		if (ACTIVE_SKILL == "ACTIVE_SKILL")
		{
		}
	}

	void aoe_scan_loop()
	{
		if (!(IS_ACTIVE)) return;
		AOE_FREQ("aoe_scan_loop");
		aoe_applyeffect_rad();
	}

	void aoe_dmg_loop()
	{
		if (!(IS_ACTIVE)) return;
		AOE_DMG_FREQ("aoe_dmg_loop");
		aoe_dodamage_rad();
	}

	void aoe_applyeffect_rad()
	{
		AOE_TOKENS = "";
		string AOE_SCAN_POS = GetEntityOrigin(GetOwner());
		AOE_SCAN_POS += "z";
		AOE_TOKENS = FindEntitiesInSphere("any", AOE_RADIUS);
		if (!(AOE_TOKENS != "none")) return;
		string N_TOKENS = GetTokenCount(AOE_TOKENS, ";");
		if (!(N_TOKENS > 0)) return;
		if (AOE_FRIEND_FOE == "enemy")
		{
			for (int i = 0; i < N_TOKENS; i++)
			{
				aoe_apply_loop();
			}
		}
		if (AOE_FRIEND_FOE == "ally")
		{
			for (int i = 0; i < N_TOKENS; i++)
			{
				aoe_applyeffect_rad_check_friendly();
			}
		}
	}

	void aoe_apply_loop()
	{
		string CUR_TARGET = GetToken(AOE_TOKENS, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		if (!(/* TODO: $can_damage */ $can_damage(CUR_TARGET, MY_OWNER))) return;
		apply_aoe_effect(CUR_TARGET);
	}

	void aoe_applyeffect_rad_check_friendly()
	{
		string CUR_TARGET = GetToken(AOE_TOKENS, i, ";");
		if (GetRelationship(MY_OWNER) == "ally")
		{
			int DO_EFFECT = 1;
		}
		if ((AOE_ISPLAYER))
		{
			if ((IsValidPlayer(CUR_TARGET)))
			{
				int DO_EFFECT = 1;
			}
		}
		if (!(DO_EFFECT)) return;
		apply_aoe_effect(CUR_TARGET);
	}

	void aoe_dodamage_rad()
	{
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), AOE_RADIUS, AOE_DMG, 0, MY_OWNER, MY_OWNER, ACTIVE_SKILL, AOE_DMG_TYPE);
	}

	void aoe_end()
	{
		IS_ACTIVE = 0;
		if (MY_SCRIPT_IDX > 0)
		{
			ClientEffect("remove", "all", MY_SCRIPT_IDX);
		}
		DeleteEntity(GetOwner());
	}

}

}
