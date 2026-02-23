#pragma context server

#include "monsters/base_npc_attack.as"
#include "monsters/base_civilian.as"

namespace MS
{

class DwarfLantern : CGameScript
{
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int I_R_GLOWING;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	DwarfLantern()
	{
		MOVE_RANGE = 64;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_DEATH = "diesimple";
		const int CAN_HUNT = 0;
		const int HUNT_AGRO = 0;
		const int CAN_ATTACK = 0;
		ATTACK_RANGE = 90;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 25;
		const float FLEE_CHANCE = 1.0;
		const int CAN_HEAR = 1;
		const int CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		const int CAN_FLINCH = 1;
		const string FLINCH_ANIM = "flinch1";
		const float FLINCH_CHANCE = 0.5;
		const int FLINCH_DELAY = 1;
		const int NO_JOB = 1;
		const int NO_HAIL = 1;
		const int NO_RUMOR = 1;
		const string MONSTER_MODEL = "npc/dwarf_lantern.mdl";
		const Vector3 GLOW_COLOR = Vector3(255, 255, 128);
		const int GLOW_RAD = 200;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		EmitSound(GetOwner(), 0, "npc/dwarfchitchat.wav", 2);
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Dwarven Miner");
		if (!(NO_WANDER))
		{
			SetRoam(true);
		}
		if ((NO_WANDER))
		{
			SetRoam(false);
		}
		SetModel(MONSTER_MODEL);
		SetModelBody(0, RandomInt(0, 1));
		SetModelBody(1, 4);
		SetMoveAnim("walk");
		if ((true))
		{
			ScheduleDelayedEvent(3.0, "light_on");
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		npcatk_flee(GetEntityIndex(m_hLastStruck), 4096, 20.0);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void client_activate()
	{
		SKEL_ID = param1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
		light_loop();
	}

	void light_loop()
	{
		if ((GetMonsterProperty("isalive")))
		{
			ScheduleDelayedEvent(0.2, "light_loop");
		}
		if (!(GetMonsterProperty("isalive")))
		{
			ClientEffect("light", SKEL_LIGHT_ID, "remove");
		}
		if (!(GetMonsterProperty("isalive"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
	}

	void light_on()
	{
		if ((I_R_GLOWING)) return;
		I_R_GLOWING = 1;
		ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()));
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

}

}
