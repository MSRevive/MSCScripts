#pragma context server

namespace MS
{

class SfxBlacksmith : CGameScript
{
	string SOUND_ANVIL;

	SfxBlacksmith()
	{
		SOUND_ANVIL = "amb/fx_anvil.wav";
	}

	void OnSpawn() override
	{
		SetName("sfx_blacksmith");
		SetModel("weapons/p_weapons2.mdl");
		SetIdleAnim("dagger_floor_idle");
		SetModelBody(0, 79);
		SetInvincible(true);
		SetNoPush(true);
		SetAngles("face");
	}

	void do_spark()
	{
		string SPARK_LOC = GetEntityOrigin(GetOwner());
		EmitSound(GetOwner(), 0, SOUND_ANVIL, 5);
		ClientEvent("update", "all", "const.localplayer.scriptID", "fx_spark", SPARK_LOC);
	}

	void do_forge_fx()
	{
		string SMITH_TYPE = param1;
		string WEAPON_SCRIPT = param2;
		string FX_LOC = GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(6.0, "do_forge_fx_end");
		Precache("skull.spr");
		Precache("ice_icon.spr");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		if (WEAPON_SCRIPT == "swords_ub")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 65);
		}
		if (WEAPON_SCRIPT == "swords_sf")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 86);
		}
		if (WEAPON_SCRIPT == "axes_df")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 79);
		}
		if (WEAPON_SCRIPT == "blunt_db")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 73);
		}
		if (WEAPON_SCRIPT == "axes_ss")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 76);
		}
		if (WEAPON_SCRIPT == "smallarms_vt")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 68);
		}
		if (WEAPON_SCRIPT == "blunt_gauntlets_ic")
		{
			SetModel("weapons/p_weapons3.mdl");
			SetIdleAnim("standard_floor_idle");
			SetModelBody(0, 70);
		}
		ClientEvent("update", "all", "const.localplayer.scriptID", "fx_smith_effect", SMITH_TYPE, "skull.spr", "ice_icon.spr");
	}

	void do_forge_fx_end()
	{
		ClientEvent("update", "all", "const.localplayer.scriptID", "fx_smith_effect", "none");
		SetModel("weapons/p_weapons2.mdl");
		SetIdleAnim("dagger_floor_idle");
		SetModelBody(0, 79);
		SetAngles("face");
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

}

}
