#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class Voldararcher : CGameScript
{
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DOING_KICK;
	int DROPS_CONTAINER;
	int IS_ARROW;
	int KICK_TYPE;

	Voldararcher()
	{
		const string ARROW_TYPE = "proj_arrow_gpoison";
		const string NPC_DEATH_MSG = "You have slain one of Voldar's rangers";
	}

	void orc_spawn()
	{
		SetProp(GetOwner(), "skin", 3);
		SetHealth(220);
		SetName("Voldar's Ranger");
		SetHearingSensitivity(2);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		DOING_KICK = 0;
		KICK_TYPE = 1;
		SetModelBody(0, 3);
		SetModelBody(1, 3);
		SetModelBody(2, 3);
	}

	void OnPostSpawn() override
	{
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_gpoison";
	}

	void shoot_arrow()
	{
		if ((CanSee("enemy", KICK_RANGE)))
		{
			PlayAnim("once", "break");
			DOING_KICK = 0;
			KICK_TYPE = 1;
			do_kick();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TARGET_DIST = GetEntityRange(m_hLastSeen);
		string FINAL_TARGET = GetEntityOrigin(m_hLastSeen);
		FINAL_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, TARGET_DIST));
		TARGET_DIST /= 100;
		SetAngles("add_view.pitch");
		string LCL_ATKDMG = Random(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		IS_ARROW = 1;
		TossProjectile(ARROW_TYPE, /* TODO: $relpos */ $relpos(0, 0, 18), m_hLastSeen, ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SOUND_BOW);
	}

}

}
