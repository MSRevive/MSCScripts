#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class MaldoraGminionRandom : CGameScript
{
	int AM_RISING;
	string ANIM_RUN;
	int ATTRIBS_SET;
	string FIRST_TARGET;
	int FOUND_GROUND;
	string GLOW_COLOR;
	int GLOW_RAD;
	string GROUND_LEVEL;
	int I_R_GLOWING;
	string LIGHT_COLOR;
	string MASTER_ORG;
	string MINION_DESC;
	string MINION_EFFECT;
	int MINION_SUMMONED;
	string MINION_TYPE;
	string MY_LIGHT_SCRIPT;
	string MY_MASTER;
	int NO_SPAWN_STUCK_CHECK;
	int NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;
	int PLAYING_DEAD;
	string SET_GREEK;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	MaldoraGminionRandom()
	{
		const float NPC_FADE_IN_SPEED = 0.02;
		ANIM_RUN = "run";
		const int SKEL_HP = 1000;
		const float ATTACK_HITCHANCE = 0.85;
		const int ATTACK_DAMAGE_LOW = 30;
		const int ATTACK_DAMAGE_HIGH = 40;
		if (StringToLower(GetMapName()) == "lodagond-2")
		{
			NPC_GIVE_EXP = 100;
		}
		else
		{
			NPC_GIVE_EXP = 600;
		}
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetModel("monsters/skeleton_boss1.mdl");
		if (MINION_TYPE == "MINION_TYPE")
		{
			MINION_TYPE = RandomInt(1, 4);
		}
		if (MINION_TYPE == 1)
		{
			MINION_DESC = "fire";
			string NAME_SUFFIX = "of Fire";
			MINION_EFFECT = "effects/dot_fire";
			SetModelBody(0, 1);
			SetModelBody(1, 6);
			LIGHT_COLOR = Vector3(255, 0, 0);
		}
		if (MINION_TYPE == 2)
		{
			MINION_DESC = "cold";
			string NAME_SUFFIX = "of Ice";
			MINION_EFFECT = "effects/dot_cold";
			SetModelBody(0, 1);
			SetModelBody(1, 5);
			LIGHT_COLOR = Vector3(0, 0, 255);
		}
		if (MINION_TYPE == 3)
		{
			MINION_DESC = "lightning";
			string NAME_SUFFIX = "of Lightning";
			MINION_EFFECT = "effects/dot_lightning";
			SetModelBody(0, 1);
			SetModelBody(1, 3);
			LIGHT_COLOR = Vector3(255, 255, 0);
		}
		if (MINION_TYPE == 4)
		{
			MINION_DESC = "poison";
			string NAME_SUFFIX = "of Venom";
			LIGHT_COLOR = Vector3(0, 255, 0);
			MINION_EFFECT = "effects/dot_poison";
			SetModelBody(0, 1);
			SetModelBody(1, 2);
		}
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		SetName("Greater Maldora Minion NAME_SUFFIX");
		SetWidth(32);
		SetHeight(80);
		SetRace("undead");
		SetBloodType("none");
		if ((true))
		{
			ScheduleDelayedEvent(1.0, "light_on");
		}
	}

	void npc_fadein_done()
	{
		minion_wakeup();
	}

	void skele_swing_dodamage()
	{
		if (!(param1)) return;
		Effect("glow", GetOwner(), LIGHT_COLOR, 64, 1, 1);
		ApplyEffect(HUNT_LASTTARGET, MINION_EFFECT, 5.0, GetEntityIndex(GetOwner()), RandomInt(10, 20));
	}

	void skeleton_attribs()
	{
		if ((ATTRIBS_SET)) return;
		ATTRIBS_SET = 1;
		SetDamageResistance("all", 0.6);
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("dark", 0.5);
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("magic", 0.0);
		if (MINION_DESC == "fire")
		{
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("cold", 0.0);
			SetDamageResistance("fire", 1.0);
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("acid", 0.0);
		}
		if (MINION_DESC == "cold")
		{
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("cold", 1.0);
			SetDamageResistance("fire", 0.0);
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("acid", 0.0);
		}
		if (MINION_DESC == "lightning")
		{
			SetDamageResistance("poison", 0.0);
			SetDamageResistance("cold", 0.0);
			SetDamageResistance("fire", 0.0);
			SetDamageResistance("lightning", 1.0);
			SetDamageResistance("acid", 0.0);
			SetDamageResistance("poison", 0.0);
		}
		if (MINION_DESC == "poison")
		{
			SetDamageResistance("cold", 0.0);
			SetDamageResistance("fire", 0.0);
			SetDamageResistance("lightning", 0.0);
			SetDamageResistance("acid", 1.0);
			SetDamageResistance("poison", 1.0);
		}
	}

	void pop_off_masters_head()
	{
		string RND_ANG = Random(0, 359.99);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, 500, 0)));
	}

	void game_dynamically_created()
	{
		string MY_ORG = GetEntityOrigin(GetOwner());
		MY_ORG += "z";
		SetEntityOrigin(GetOwner(), MY_ORG);
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		ScheduleDelayedEvent(0.1, "pop_off_masters_head");
		scan_for_ground();
		AM_RISING = 1;
		MINION_SUMMONED = 1;
		MY_MASTER = param1;
		FIRST_TARGET = param2;
		SetAnimFrameRate(0.0);
		SetRoam(false);
		PLAYING_DEAD = 1;
		SetMoveAnim(ANIM_RESPAWN_DEADIDLE);
		SetIdleAnim(ANIM_RESPAWN_DEADIDLE);
		SetInvincible(true);
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NO_STUCK_CHECKS = 1;
		MASTER_ORG = GetEntityOrigin(MY_MASTER);
		GROUND_LEVEL = (MASTER_ORG).z;
		NO_SPAWN_STUCK_CHECK = 1;
		// svplaysound: emitsound ent_me $get(ent_me,origin) 64 5.0 danger 128
		EmitSound(GetOwner(), GetEntityOrigin(GetOwner()), 64, 5.0, "danger", 128);
	}

	void scan_for_ground()
	{
		if ((FOUND_GROUND)) return;
		ScheduleDelayedEvent(0.1, "scan_for_ground");
		if (!(GetEntityProperty(GetOwner(), "origin.z") == /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin")))) return;
		FOUND_GROUND = 1;
		set_fade_in();
	}

	void minion_wakeup()
	{
		skeleton_attribs();
		AM_RISING = 0;
		float AWAKE_DELAY = 1.5;
		if (BASE_FRAMERATE == "BASE_FRAMERATE")
		{
			SetAnimFrameRate(1.0);
		}
		if (BASE_FRAMERATE != "BASE_FRAMERATE")
		{
			SetAnimFrameRate(BASE_FRAMERATE);
		}
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", "getup");
		ScheduleDelayedEvent(1.7, "aid_master");
		AWAKE_DELAY("skeleton_awake");
	}

	void aid_master()
	{
		if ((IsEntityAlive(HUNT_LASTTARGET))) return;
		if (!(GetEntityRange(FIRST_TARGET) < 1024)) return;
		if (!(IsEntityAlive(FIRST_TARGET))) return;
		npcatk_target(FIRST_TARGET);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(MY_MASTER, "skele_died");
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		if ((MINION_SUMMONED)) return;
		if ((NPC_NO_DROPS)) return;
		bm_gold_spew(25, 1, 32, 2, 4);
	}

	void client_activate()
	{
		GLOW_RAD = 200;
		const int NO_LOOP_DETECT = 1;
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void light_on()
	{
		if ((I_R_GLOWING)) return;
		I_R_GLOWING = 1;
		ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()), LIGHT_COLOR);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

	void maldora_died()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void maldora_final_died()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
