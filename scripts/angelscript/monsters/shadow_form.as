#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_flyer_grav.as"

namespace MS
{

class ShadowForm : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string CL_SCRIPT_IDX;
	int CYCLE_IDLE_SOUND;
	int DID_ALERT;
	int IMMUNE_ALL_BUT_HOLY;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MISS_COUNT;
	string NEXT_ATTACK;
	string NEXT_IDLE_SOUND;
	string NEXT_IDLE_ZAP;
	string NEXT_MINOR_STRIKE;
	string NEXT_PAIN_SOUND;
	string NEXT_SHOCK_SCAN;
	string NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_MUST_SEE_TARGET;
	string SCAN_TARGS;
	int SHADOW_CL_ON;

	ShadowForm()
	{
		IMMUNE_ALL_BUT_HOLY = 1;
		IS_UNHOLY = 1;
		NPC_HACKED_MOVE_SPEED = 10;
		const int AS_CUSTOM_UNSTUCK = 1;
		IMMUNE_VAMPIRE = 1;
		NPC_MUST_SEE_TARGET = 0;
		ANIM_ATTACK = "walk";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_IDLE = "walk";
		ANIM_DEATH = "walk";
		ATTACK_MOVERANGE = 64;
		ATTACK_RANGE = 512;
		const float FREQ_CL_UPDATE = 15.0;
		const string FREQ_IDLE_SOUND = Random(3.0, 6.0);
		const string FREQ_IDLE_ZAP = Random(2.0, 3.0);
		const float FREQ_PAIN = 1.0;
		const float FREQ_ATTACK = 5.0;
		const float FREQ_MINOR_STRIKE = 3.0;
		const int DMG_MAIN_ZAP = 1100;
		const int DOT_MAIN_ZAP = 50;
		const int DMG_MINOR_STRIKE = 300;
		const int DOT_MINOR_STRIKE = 30;
		const int RANGE_MINOR_STRIKE = 768;
		const string SOUND_ALERT = "monsters/shadow/shadow_alert.wav";
		const string SOUND_IDLE1 = "monsters/shadow/shadow_idle1.wav";
		const string SOUND_IDLE2 = "monsters/shadow/shadow_idle2.wav";
		const string SOUND_IDLE3 = "monsters/shadow/shadow_idle3.wav";
		const string SOUND_PAIN1 = "monsters/shadow/shadow_pain1.wav";
		const string SOUND_PAIN2 = "monsters/shadow/shadow_pain2.wav";
		const string SOUND_PAIN3 = "monsters/shadow/shadow_pain3.wav";
		const string SOUND_DEATH = "monsters/shadow/shadow_death.wav";
		const string SOUND_ZAP_READY = "magic/lightprep.wav";
		const string SOUND_ZAP_IDLE = "magic/elecidle.wav";
		const string SOUND_ZAP1 = "debris/zap1.wav";
		const string SOUND_ZAP2 = "debris/zap3.wav";
		const string SOUND_ZAP3 = "debris/zap8.wav";
		const string FREQ_SHOCK_SCAN = Random(3.0, 5.0);
		const int AS_DIST_THRESH = 5;
		if ((StringToLower(GetMapName())).findFirst("lodagond") >= 0)
		{
			NPC_GIVE_EXP = 2000;
		}
		else
		{
			NPC_GIVE_EXP = 1000;
		}
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.2);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		string L_MOVE_DEST = GetMonsterProperty("movedest.origin");
		if (L_MOVE_DEST != Vector3(0, 0, 0))
		{
		}
		AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(GetMonsterProperty("angles"), Vector3(0, NPC_HACKED_MOVE_SPEED, 0)));
	}

	void game_precache()
	{
		Precache("shadowfog.spr");
		Precache("monsters/shadow_form_cl");
	}

	void OnSpawn() override
	{
		SetName("Shadow Form");
		SetHealth(5000);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("dark", 0.5);
		SetDamageResistance("stun", 0);
		SetBloodType("none");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("lightning", 0.0);
		SetRace("demon");
		SetModel("monsters/shadow_hitbox.mdl");
		SetWidth(90);
		SetHeight(90);
		SetHearingSensitivity(11);
		SetGravity(0);
		if (!(true)) return;
		MISS_COUNT = 0;
		CYCLE_IDLE_SOUND = 0;
		array<string> ARRAY_MINOR_STRIKE;
	}

	void OnDamage(int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(SHADOW_CL_ON))
		{
			do_manifest();
		}
		if (!(IMMUNE_ALL_BUT_HOLY)) return;
		int NO_DAMAGE = 1;
		if ((param3).findFirst("holy") >= 0)
		{
			int NO_DAMAGE = 0;
		}
		if ((param3).findFirst("dark") >= 0)
		{
			int NO_DAMAGE = 0;
		}
		if ((param3).findFirst("target") >= 0)
		{
			int NO_DAMAGE = 0;
		}
		if ((param3).findFirst("magic") >= 0)
		{
			int NO_DAMAGE = 0;
		}
		if ((NO_DAMAGE))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
		else
		{
			if (GetGameTime() > NEXT_STRIKE_BACK)
			{
				if (param1 != m_hAttackTarget)
				{
				}
				add_minor_strike(GetEntityIndex(param1));
			}
			if (GetGameTime() > NEXT_PAIN_SOUND)
			{
			}
			NEXT_PAIN_SOUND = GetGameTime();
			NEXT_PAIN_SOUND += FREQ_PAIN;
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			Effect("beam", "ents", "lgtning.spr", 6, GetOwner(), RandomInt(0, 3), GetOwner(), RandomInt(0, 3), Vector3(255, 0, 0), 255, 255, Random(1.0, 2.0));
		}
	}

	void npc_targetsighted()
	{
		do_manifest();
	}

	void my_target_died()
	{
		DID_ALERT = 0;
	}

	void do_manifest()
	{
		if (!(DID_ALERT))
		{
			DID_ALERT = 1;
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			string GAME_TIME = GetGameTime();
			NEXT_IDLE_ZAP = GAME_TIME;
			NEXT_IDLE_ZAP += FREQ_IDLE_ZAP;
			NEXT_IDLE_SOUND = GAME_TIME;
			NEXT_IDLE_SOUND += FREQ_IDLE_SOUND;
			NEXT_ATTACK = GAME_TIME;
			NEXT_ATTACK += FREQ_ATTACK;
			NEXT_SHOCK_SCAN = GAME_TIME;
			NEXT_SHOCK_SCAN += FREQ_SHOCK_SCAN;
			if (StringToLower(GetMapName()) == "nashalrath")
			{
				CallExternal(m_hAttackTarget, "ext_play_music", "Hashalgath.mp3");
			}
		}
		if ((SHADOW_CL_ON)) return;
		SHADOW_CL_ON = 1;
		shadow_cl_loop();
	}

	void shadow_cl_loop()
	{
		if (!(SHADOW_CL_ON)) return;
		FREQ_CL_UPDATE("shadow_cl_loop", FREQ_CL_UPDATE);
		ClientEvent("new", "all", "monsters/shadow_form_cl", GetEntityIndex(GetOwner()), FREQ_CL_UPDATE);
		CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void npc_suicide()
	{
		IMMUNE_ALL_BUT_HOLY = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(SHADOW_CL_ON)) return;
		if (!(m_hAttackTarget != "none")) return;
		string GAME_TIME = GetGameTime();
		if (GAME_TIME > NEXT_IDLE_ZAP)
		{
			EmitSound(GetOwner(), 2, SOUND_ZAP_IDLE, 5);
			Effect("beam", "ents", "lgtning.spr", 2, GetOwner(), RandomInt(0, 3), GetOwner(), RandomInt(0, 3), Vector3(128, 128, 255), 200, 255, Random(2.0, 4.0));
			NEXT_IDLE_ZAP = GAME_TIME;
			NEXT_IDLE_ZAP += FREQ_IDLE_ZAP;
		}
		if (GAME_TIME > NEXT_IDLE_SOUND)
		{
			CYCLE_IDLE_SOUND += 1;
			if (CYCLE_IDLE_SOUND > 3)
			{
				CYCLE_IDLE_SOUND = 0;
			}
			if (CYCLE_IDLE_SOUND == 1)
			{
				EmitSound(GetOwner(), 4, SOUND_IDLE1, 10);
			}
			if (CYCLE_IDLE_SOUND == 2)
			{
				EmitSound(GetOwner(), 3, SOUND_IDLE2, 10);
			}
			if (CYCLE_IDLE_SOUND == 3)
			{
				EmitSound(GetOwner(), 4, SOUND_IDLE3, 10);
			}
			NEXT_IDLE_SOUND = GAME_TIME;
			NEXT_IDLE_SOUND += FREQ_IDLE_SOUND;
		}
		if (GAME_TIME > NEXT_SHOCK_SCAN)
		{
			NEXT_SHOCK_SCAN = GAME_TIME;
			NEXT_SHOCK_SCAN += FREQ_SHOCK_SCAN;
			shock_scan();
		}
		if (/* TODO: $get_array_amt */ $get_array_amt(ARRAY_MINOR_STRIKE) > 0)
		{
			if (GAME_TIME > NEXT_MINOR_STRIKE)
			{
			}
			NEXT_MINOR_STRIKE = GAME_TIME;
			NEXT_MINOR_STRIKE += FREQ_MINOR_STRIKE;
			minor_strike();
		}
	}

	void shock_scan()
	{
		SCAN_TARGS = FindEntitiesInSphere("enemy", RANGE_MINOR_STRIKE);
		if (!(SCAN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_TARGS, ";"); i++)
		{
			shock_scan_loop();
		}
	}

	void shock_scan_loop()
	{
		string CUR_TARG = GetToken(SCAN_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		if (!(CUR_TARG != m_hAttackTarget)) return;
		add_minor_strike(CUR_TARG);
	}

	void npcatk_attack()
	{
		if (GetGameTime() > NEXT_ATTACK)
		{
			string MY_ORG = GetEntityOrigin(GetOwner());
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string TRACE_LINE = TraceLine(MY_ORG, TARG_ORG);
			if (TRACE_LINE == TARG_ORG)
			{
			}
			NEXT_ATTACK = GetGameTime();
			NEXT_ATTACK += FREQ_ATTACK;
			zap_target1();
		}
	}

	void zap_target1()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		EmitSound(GetOwner(), 0, SOUND_ZAP_READY, 10);
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 0, GetOwner(), 1, Vector3(128, 128, 128), 200, 255, 0.5);
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 1, GetOwner(), 2, Vector3(128, 128, 128), 200, 255, 0.5);
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 2, GetOwner(), 3, Vector3(128, 128, 128), 200, 255, 0.5);
		ScheduleDelayedEvent(0.5, "zap_target2");
	}

	void zap_target2()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 0, GetOwner(), 1, Vector3(180, 180, 180), 200, 255, 0.5);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 2, Vector3(180, 180, 180), 200, 255, 0.5);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 3, Vector3(180, 180, 180), 200, 255, 0.5);
		ScheduleDelayedEvent(0.5, "zap_target3");
	}

	void zap_target3()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		string TRACE_LINE = TraceLine(MY_ORG, TARG_ORG);
		Effect("beam", "end", "lgtning.spr", 60, TRACE_LINE, GetOwner(), 0, Vector3(255, 255, 255), 200, 255, 3.0);
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (TRACE_LINE == TARG_ORG)
		{
			MISS_COUNT = 0;
			DoDamage(m_hAttackTarget, "direct", DMG_MAIN_ZAP, 1.0, "lightning");
			ApplyEffect(m_hAttackTarget, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_MAIN_ZAP);
			AddVelocity(m_hAttackTarget, /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 800, 110)));
			NEXT_ATTACK = GetGameTime();
			NEXT_ATTACK += FREQ_ATTACK;
		}
		else
		{
			MISS_COUNT += 1;
			if (MISS_COUNT > 2)
			{
				npc_stuck();
				MISS_COUNT = 2;
			}
		}
	}

	void npc_stuck()
	{
		string RND_P = Random(-359.0, 359.0);
		string RND_Y = Random(-359.0, 359.0);
		string RND_R = Random(-359.0, 359.0);
		SetVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(RND_P, RND_Y, RND_Y), Vector3(0, 400, 0)));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (CL_SCRIPT_IDX != "CL_SCRIPT_IDX")
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "shadow_death");
		}
	}

	void add_minor_strike()
	{
		ARRAY_MINOR_STRIKE.insertLast(param1);
	}

	void minor_strike()
	{
		string MINOR_STRIKE_TARG = /* TODO: $get_array */ $get_array(ARRAY_MINOR_STRIKE, 0);
		ARRAY_MINOR_STRIKE.removeAt(0);
		if (!(GetEntityRange(MINOR_STRIKE_TARG) < RANGE_MINOR_STRIKE)) return;
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ORG = GetEntityOrigin(MINOR_STRIKE_TARG);
		string TRACE_LINE = TraceLine(MY_ORG, TARG_ORG);
		string RND_ATCH = RandomInt(1, 3);
		if (TRACE_LINE == TARG_ORG)
		{
			Effect("beam", "end", "lgtning.spr", 10, TRACE_LINE, GetOwner(), RND_ATCH, Vector3(128, 128, 255), 200, 255, 2.0);
			// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
			array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
			DoDamage(MINOR_STRIKE_TARG, "direct", DMG_MINOR_STRIKE, 1.0, "lightning");
			ApplyEffect(MINOR_STRIKE_TARG, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_MINOR_ZAP);
			string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			string NEW_YAW = TARG_ANG;
			AddVelocity(MINOR_STRIKE_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 300, 110)));
		}
	}

}

}
