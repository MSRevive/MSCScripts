#pragma context server

#include "monsters/base_flyer_grav.as"
#include "monsters/externals.as"

namespace MS
{

class MakeGlow : CGameScript
{
	float CYCLE_RATE;
	string NPCATK_TARGET;
	int SUSPEND_AI;

	void OnSpawn() override
	{
		SetName("Killer Map Brush");
		SetRace("hated");
		SetHealth(1000);
		SetHearingSensitivity(11);
		NPCATK_TARGET = "unset";
		SetMenuAutoOpen(1);
		SUSPEND_AI = 1;
		SetGravity(0);
		CYCLE_RATE = 1.0;
		ScheduleDelayedEvent(1.0, "npcatk_hunt");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		NPCATK_TARGET = HEARD_ID;
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, 30, 30);
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		NPCATK_TARGET = HEARD_ID;
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, 30, 30);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0, "voices/human/male_die.wav", 10);
		DeleteEntity(GetOwner(), true); // fade out
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		CYCLE_RATE("npcatk_hunt");
		if ((SUSPEND_AI)) return;
		LogDebug("Hunting GetEntityName(m_hAttackTarget) [ GetEntityRange(m_hAttackTarget) ]");
		EmitSound(GetOwner(), 2, "magic/energy1.wav", 10);
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			NPCATK_TARGET = "unset";
		}
		if (!(m_hAttackTarget != "unset")) return;
		SetMoveDest(m_hAttackTarget);
		if ((false))
		{
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 50, 0));
		}
		if (GetEntityRange(m_hAttackTarget) < 64)
		{
			DoDamage(m_hAttackTarget, 64, 5, 50, "slash");
		}
	}

	void npcatk_resume_ai()
	{
		CYCLE_RATE = 0.1;
		NPCATK_TARGET = param1;
		SUSPEND_AI = 0;
	}

	void OnSuspendAI()
	{
		CYCLE_RATE = 1.0;
		SUSPEND_AI = 1;
	}

	void menu_hunt()
	{
		npcatk_resume_ai(GetEntityIndex(param1));
	}

	void menu_stop()
	{
		npcatk_suspend_ai();
	}

	void menu_glow()
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 30.0);
	}

	void game_menu_getoptions()
	{
		if ((SUSPEND_AI))
		{
			string reg.mitem.title = "Hunt";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_hunt";
		}
		else
		{
			string reg.mitem.title = "Stop";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "menu_stop";
		}
		string reg.mitem.title = "Glow";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_glow";
		string reg.mitem.title = "Additive";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_additive";
		string reg.mitem.title = "Spin";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "menu_spin";
	}

	void menu_fly()
	{
		SetGravity(0);
		SetSayTextRange(1024);
		SayText("Weeee!");
	}

	void menu_additive()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void menu_spin()
	{
		SetProp(GetOwner(), "avelocity", Vector3(50, 50, 0));
		ScheduleDelayedEvent(0.1, "menu_spin");
	}

}

}
