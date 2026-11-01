#pragma context server

#include "effects/dot_bleed.as"

namespace MS
{

class GutBuster : CGameScript
{
	int DID_PROC;
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string MY_BLOOD;
	string NUM_GIBS;
	string SWORD_ID;

	GutBuster()
	{
		EFFECT_ID = "gb";
		EFFECT_SCRIPT = currentscript;
		EFFECT_FLAGS = "nostack";
		DOT_TYPE = "pierce_effect";
		DOT_IM_AFFECTED = "Your flesh is defiled by the evil sword.";
		DOT_IM_RESIST = "Your armor prevents the attack from piercing through your skin.";
		DOT_HE_IMMUNE = "cannot bleed.";
		DID_PROC = 0;
		NUM_GIBS = "get_num_gibs"();
	}

	void game_activate()
	{
		SWORD_ID = param5;
		MY_BLOOD = GetEntityProperty(GetOwner(), "blood");
	}

	void dot_start()
	{
		Bleed(GetOwner(), MY_BLOOD, 10000);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		proc_death();
	}

	void proc_death()
	{
		if (!(DID_PROC))
		{
			DID_PROC = 1;
			for (int i = 0; i < NUM_GIBS; i++)
			{
				create_gib();
			}
			EmitSound(GetOwner(), 0, "common/bodysplat.wav", 10);
			if (!(GetEntityProperty(GetOwner(), "alive")))
			{
				if ((GetEntityHeight(GetOwner()) + GetEntityWidth(GetOwner())) < 150)
				{
					SetProp(GetOwner(), "rendermode", 5);
					SetProp(GetOwner(), "renderamt", 0);
				}
			}
		}
	}

	void create_gib()
	{
		Vector3 L_ANG = Vector3(Random(70, 95), RandomInt(0, 359), 0);
		string L_FORCE = (400 * i);
		L_FORCE += 400;
		string L_VEC = /* TODO: $relvel */ $relvel(L_ANG, Vector3(0, L_FORCE, 0));
		SpawnNPC("effects/swords_gb/gb_gib_explode", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: DOT_ATTACKER, L_VEC, 0, "swordsmanship", MY_BLOOD, SWORD_ID
	}

	void get_num_gibs()
	{
		string L_NUM_GIBS = (GetEntityHeight(GetOwner()) + GetEntityWidth(GetOwner()));
		L_NUM_GIBS /= 150;
		L_NUM_GIBS = max(0, min(2, L_NUM_GIBS));
		L_HP_GIBS += (GetEntityMaxHealth(GetOwner()) / 1750);
		L_HP_GIBS = max(0, min(3, L_HP_GIBS));
		L_NUM_GIBS += L_HP_GIBS;
		L_NUM_GIBS += 1;
		return;
		return;
	}

}

}
