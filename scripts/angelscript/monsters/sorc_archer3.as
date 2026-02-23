#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class SorcArcher3 : CGameScript
{
	int ARROW_MISSED;
	string ARROW_TARGET_LIST;
	int DOING_KICK;
	string DROP_GOLD_AMT;
	int IS_ARROW;
	int KICK_TYPE;
	int MELEE_ATK;

	SorcArcher3()
	{
		const string ARROW_TYPE = "proj_arrow_npc_dyn";
		const int FIN_EXP = 400;
		DROP_GOLD_AMT = RandomInt(20, 60);
		const string DROP_ITEM_BASE1 = "bows_swiftbow";
		const string CONTAINER_BASE = "chests/quiver_of_lightning";
		const int DMG_AOE = 200;
		const int ARROW_DAMAGE_LOW = 100;
		const int ARROW_DAMAGE_HIGH = 200;
		const int AM_SORC = 1;
		Precache("magic/lightning_strike2.wav");
	}

	void orc_spawn()
	{
		SetHealth(800);
		SetName("Elite Shadahar Archer");
		SetHearingSensitivity(10);
		SetStat("parry", 60);
		SetDamageResistance("all", ".7");
		SetRace("orc");
		SetModel("monsters/sorc.mdl");
		DOING_KICK = 0;
		KICK_TYPE = 1;
		SetModelBody(0, 3);
		SetModelBody(1, 3);
		SetModelBody(2, 2);
	}

	void ext_arrow_hit()
	{
		string ARROW_POS = param3;
		string TARG_ALIVE = IsEntityAlive(param2);
		if (GetRelationship(param2) == "enemy")
		{
			if ((TARG_ALIVE))
			{
			}
			int HIT_ENEMY = 1;
		}
		if ((HIT_ENEMY))
		{
			string ARROW_POS = GetEntityOrigin(param2);
		}
		ARROW_POS = "z";
		ClientEvent("new", "all", "effects/sfx_shock_burst", ARROW_POS, 128, 1, Vector3(255, 255, 0));
		XDoDamage(ARROW_POS, 128, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "lightning_effect");
		ARROW_TARGET_LIST = FindEntitiesInSphere("enemy", 128);
		if (!(ARROW_TARGET_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(ARROW_TARGET_LIST, ";"); i++)
		{
			arrow_affect_targets();
		}
	}

	void arrow_affect_targets()
	{
		string CUR_TARG = GetToken(ARROW_TARGET_LIST, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), 40);
		ARROW_MISSED = 0;
	}

	void shoot_arrow()
	{
		string TARGET_DIST = GetEntityRange(m_hLastSeen);
		string FINAL_TARGET = GetEntityOrigin(m_hLastSeen);
		FINAL_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, TARGET_DIST));
		TARGET_DIST /= 100;
		SetAngles("add_view.pitch");
		IS_ARROW = 1;
		TossProjectile(ARROW_TYPE, /* TODO: $relpos */ $relpos(0, 0, 18), "none", 900, DMG_BOW, ATTACK_CONE_OF_FIRE, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4, 1, Vector3(255, 255, 0));
		SetModelBody(2, 2);
		EmitSound(GetOwner(), 2, SOUND_BOW, 10);
		MELEE_ATK = 0;
	}

}

}
