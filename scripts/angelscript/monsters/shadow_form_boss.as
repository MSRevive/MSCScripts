#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class ShadowFormBoss : CGameScript
{
	int AM_VISIBLE;
	string ANIM_DEATH;
	string BEAM_FX_ID;
	int BEAM_RANGE;
	string BEAM_TARGET;
	string CAGE_ACTIVE;
	string CAGE_BEAM_ID;
	int CAN_CAGE;
	string CL_FX_ID;
	int DMG_BEAM;
	int DOT_CAGE;
	int DOT_SHOCK;
	int FADEOUT_STEP;
	int FADE_STEP;
	float FREQ_BEAM;
	float FREQ_MANIFEST;
	int IMMUNE_VAMPIRE;
	string NEXT_BEAM;
	string NEXT_CAGE;
	string NEXT_MANIFEST;
	string NEXT_MANIFEST_CHECK;
	string NEXT_NME_SCAN;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_CAGE_LOOP;
	string SOUND_DEATH;
	string SOUND_IDLE_LOOP;
	string SOUND_MANIFEST1;
	string SOUND_MANIFEST2;
	string SOUND_PAIN;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;
	string TOTAL_INVIS;

	ShadowFormBoss()
	{
		NPC_GIVE_EXP = 10000;
		NPC_IS_BOSS = 1;
		FREQ_MANIFEST = 15.0;
		FREQ_BEAM = Random(3.0, 8.0);
		DOT_SHOCK = 200;
		DOT_CAGE = 100;
		DMG_BEAM = 200;
		BEAM_RANGE = 700;
		SOUND_ZAP1 = "debris/zap1.wav";
		SOUND_ZAP2 = "debris/zap3.wav";
		SOUND_ZAP3 = "debris/zap8.wav";
		SOUND_ATTACK1 = "monsters/undeadz/c_shadow_atk1.wav";
		SOUND_ATTACK2 = "monsters/undeadz/c_shadow_atk2.wav";
		SOUND_ATTACK3 = "monsters/undeadz/c_shadow_atk3.wav";
		SOUND_MANIFEST1 = "monsters/undeadz/c_shadow_bat1.wav";
		SOUND_MANIFEST2 = "monsters/undeadz/c_shadow_bat2.wav";
		SOUND_PAIN = "monsters/undeadz/c_shadow_hit1.wav";
		SOUND_PAIN = "monsters/undeadz/c_shadow_hit2.wav";
		SOUND_PAIN = "monsters/undeadz/c_shadow_slct.wav";
		SOUND_CAGE_LOOP = "weapons/egon_run3.wav";
		SOUND_DEATH = "monsters/undeadz/c_shadow_dead.wav";
		SOUND_IDLE_LOOP = "magic/chant_loop.wav";
		ANIM_DEATH = "idle";
	}

	void game_precache()
	{
		Precache("monsters/shadow_form_boss_fx");
		Precache("monsters/shadowform_beams.mdl");
		Precache("shadowfog.spr");
		Precache("magic/bolt_start.wav");
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Ancient Shadowform");
		SetName("shadowform_boss");
		SetModel("monsters/shadowform_eye.mdl");
		SetHealth(25000);
		SetWidth(64);
		SetHeight(64);
		SetFly(true);
		SetGravity(0);
		SetNoPush(true);
		SetMoveSpeed(0.0);
		SetHearingSensitivity(11);
		SetRace("undead");
		IMMUNE_VAMPIRE = 1;
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.2);
		SetDamageResistance("fire", 0.2);
		SetDamageResistance("acid", 0.2);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("slash", 0.5);
		SetDamageResistance("blunt", 0.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("dark", 0.0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SetInvincible(true);
		AM_VISIBLE = 0;
		ScheduleDelayedEvent(0.1, "cl_fx_loop");
		ScheduleDelayedEvent(0.5, "setup_beams");
		NPCATK_TARGET = "unset";
		ScheduleDelayedEvent(1.0, "npcatk_hunt");
	}

	void OnPostSpawn() override
	{
		if (StringToLower(GetMapName()) == "bloodshrine")
		{
			CallExternal("all", "ext_shadowform_boss");
		}
	}

	void setup_beams()
	{
		SpawnNPC("monsters/shadow_form_boss_fx", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		BEAM_FX_ID = GetEntityIndex(m_hLastCreated);
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((CAGE_ACTIVE)) return;
		string HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(HEARD_ID) == "enemy")) return;
		if (m_hAttackTarget == "unset")
		{
			int ACQUIRE_TARGET = 1;
		}
		if (GetEntityRange(m_hAttackTarget) > GetEntityRange(HEARD_ID))
		{
			int ACQUIRE_TARGET = 1;
		}
		if (!(ACQUIRE_TARGET)) return;
		NPCATK_TARGET = HEARD_ID;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.1, "npcatk_hunt");
		float GAME_TIME = GetGameTime();
		if (!(AM_VISIBLE))
		{
			if (GAME_TIME > NEXT_MANIFEST)
			{
			}
			if (GAME_TIME > NEXT_MANIFEST_CHECK)
			{
			}
			NEXT_MANIFEST_CHECK = GAME_TIME;
			NEXT_MANIFEST_CHECK += 3.0;
			string NME_DETECT = FindEntitiesInSphere("enemy", 384);
			if (NME_DETECT != "none")
			{
			}
			ScrambleTokens(NME_DETECT, ";");
			NPCATK_TARGET = GetToken(NME_DETECT, 0, ";");
			do_manifest();
		}
		if (GAME_TIME > NEXT_BEAM)
		{
			NEXT_BEAM = GAME_TIME;
			NEXT_BEAM += FREQ_BEAM;
			string BEAM_TARGS = FindEntitiesInSphere("enemy", BEAM_RANGE);
			if (BEAM_TARGS == "none")
			{
				NEXT_BEAM = GAME_TIME;
				NEXT_BEAM += 1.0;
			}
			if (BEAM_TARGS != "none")
			{
			}
			ScrambleTokens(BEAM_TARGS, ";");
			BEAM_TARGET = GetToken(BEAM_TARGS, 0, ";");
			ScheduleDelayedEvent(0.1, "do_beam");
		}
		if (m_hAttackTarget == "unset")
		{
			if (GAME_TIME > NEXT_NME_SCAN)
			{
			}
			NEXT_NME_SCAN = GAME_TIME;
			NEXT_NME_SCAN += 1.0;
			random_target();
		}
		if ((AM_VISIBLE))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
		}
		if ((CAGE_ACTIVE)) return;
		if ((TOTAL_INVIS)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			NPCATK_TARGET = "unset";
		}
		else
		{
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string NEW_ANGS = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
			SetAngles("face");
			if ((CAN_CAGE))
			{
				if (GAME_TIME > NEXT_CAGE)
				{
				}
				NEXT_CAGE = GAME_TIME;
				NEXT_CAGE += 1.0;
				do_cage();
			}
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		NPCATK_TARGET = GetEntityIndex(m_hLastStruck);
	}

	void cl_fx_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		// svplaysound: svplaysound 2 0 SOUND_IDLE_LOOP
		EmitSound(2, 0, SOUND_IDLE_LOOP);
		// svplaysound: svplaysound 2 10 SOUND_IDLE_LOOP
		EmitSound(2, 10, SOUND_IDLE_LOOP);
		if (CL_FX_ID != "CL_FX_ID")
		{
			ClientEvent("update", "all", CL_FX_ID, "remove_fx");
		}
		ClientEvent("new", "all", "monsters/shadow_form_boss_cl", GetEntityIndex(GetOwner()));
		CL_FX_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(30.0, "cl_fx_loop");
	}

	void ext_cl_fx_update()
	{
		if (CL_FX_ID != "CL_FX_ID")
		{
			ClientEvent("update", "all", CL_FX_ID, "remove_fx");
		}
		ClientEvent("new", "all", "monsters/shadow_form_boss_cl", GetEntityIndex(GetOwner()));
	}

	void OnDamage(int damage) override
	{
		if ((AM_VISIBLE))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
		}
		else
		{
			ClearFX();
		}
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void make_visible()
	{
		fade_in();
		AM_VISIBLE = 1;
		SetInvincible(false);
		ScheduleDelayedEvent(2.0, "enable_cage");
		ScheduleDelayedEvent(20.0, "make_invisible");
	}

	void enable_cage()
	{
		CAN_CAGE = 1;
	}

	void make_invisible()
	{
		CAN_CAGE = 0;
		AM_VISIBLE = 0;
		NEXT_MANIFEST = GetGameTime();
		NEXT_MANIFEST += FREQ_MANIFEST;
		fade_out();
	}

	void fade_in()
	{
		FADE_STEP = 0;
		fade_in_loop();
	}

	void fade_in_loop()
	{
		if (!(FADE_STEP < 255)) return;
		FADE_STEP += 5;
		if (FADE_STEP == 255)
		{
			FADE_STEP = 255;
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", FADE_STEP);
		ScheduleDelayedEvent(0.1, "fade_in_loop");
	}

	void fade_out()
	{
		FADEOUT_STEP = 255;
		fade_out_loop();
	}

	void fade_out_loop()
	{
		if (!(FADEOUT_STEP > 0)) return;
		FADEOUT_STEP -= 5;
		if (FADEOUT_STEP <= 0)
		{
			FADEOUT_STEP = 0;
			ClearFX();
			SetInvincible(true);
			TOTAL_INVIS = 1;
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", FADEOUT_STEP);
		ScheduleDelayedEvent(0.1, "fade_out_loop");
	}

	void do_manifest()
	{
		TOTAL_INVIS = 0;
		NEXT_MANIFEST = GetGameTime();
		NEXT_MANIFEST += 999;
		make_visible();
	}

	void do_beam()
	{
		string TRACE_START = GetEntityOrigin(GetOwner());
		float RND_ANG = Random(0, 359.99);
		float RND_DIST = Random(64, 150);
		TRACE_START += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, 0));
		string TRACE_END = GetEntityOrigin(BEAM_TARGET);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (TRACE_LINE == TRACE_END)
		{
			int BEAM_TYPE = RandomInt(1, 2);
			if (BEAM_TYPE == 1)
			{
				Vector3 BEAM_COLOR = Vector3(64, 128, 255);
				string REND_PROPS = "1;1.0;255;add;(64,128,255);1;1";
				string DMG_TYPE = "lightning";
			}
			else
			{
				Vector3 BEAM_COLOR = Vector3(255, 0, 0);
				string REND_PROPS = "1;1.0;255;add;(255,0,0);1;1";
				string DMG_TYPE = "dark";
			}
			Effect("beam", "point", "lgtning.spr", 60, TRACE_START, TRACE_END, BEAM_COLOR, 200, 10, 1.0);
			ClientEvent("new", "all", "effects/sfx_sprite", TRACE_START, "3dmflaora.spr", REND_PROPS, 2.0);
			// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
			array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
			EmitSound(GetOwner(), 3, sounds[RandomInt(0, sounds.length() - 1)], 10);
			DoDamage(BEAM_TARGET, "direct", DMG_BEAM, 1.0, GetOwner());
			if (BEAM_TYPE == 1)
			{
				ApplyEffect(BEAM_TARGET, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_SHOCK);
			}
		}
		else
		{
			NEXT_BEAM = GetGameTime();
			NEXT_BEAM += 1.0;
		}
	}

	void do_cage()
	{
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = GetEntityOrigin(m_hAttackTarget);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (TRACE_LINE == TRACE_END)
		{
			CAN_CAGE = 0;
			NEXT_CAGE = GetGameTime();
			NEXT_CAGE += 15.0;
			// PlayRandomSound from: SOUND_MANIFEST1, SOUND_MANIFEST2
			array<string> sounds = {SOUND_MANIFEST1, SOUND_MANIFEST2};
			EmitSound(GetOwner(), 3, sounds[RandomInt(0, sounds.length() - 1)], 10);
			// svplaysound: svplaysound 4 10 SOUND_CAGE_LOOP
			EmitSound(4, 10, SOUND_CAGE_LOOP);
			Effect("beam", "ents", "lgtning.spr", 90, GetOwner(), 1, m_hAttackTarget, 1, Vector3(200, 255, 0), 255, 20, 15.0);
			CAGE_BEAM_ID = GetEntityIndex(m_hLastCreated);
			ApplyEffect(m_hAttackTarget, "effects/dot_lightning_cage", 15.0, GetEntityIndex(GetOwner()));
			ApplyEffect(m_hAttackTarget, "effects/dot_lightning", 15.0, GetEntityIndex(GetOwner()), DOT_CAGE, "none");
			CAGE_ACTIVE = 1;
			ScheduleDelayedEvent(15.0, "ext_end_cage");
		}
		else
		{
			CAN_CAGE = 1;
			random_target();
		}
	}

	void random_target()
	{
		string NME_DETECT = FindEntitiesInSphere("enemy", 384);
		if (!(NME_DETECT != "none")) return;
		ScrambleTokens(NME_DETECT, ";");
		NPCATK_TARGET = GetToken(NME_DETECT, 0, ";");
	}

	void ext_end_cage()
	{
		if (!(CAGE_ACTIVE)) return;
		CAGE_ACTIVE = 0;
		// svplaysound: svplaysound 4 0 SOUND_CAGE_LOOP
		EmitSound(4, 0, SOUND_CAGE_LOOP);
		CAN_CAGE = 0;
		Effect("beam", "update", CAGE_BEAM_ID, "brightness", 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		LogDebug("game_death - enter");
		if (StringToLower(GetMapName()) == "bloodshrine")
		{
			CallExternal("all", "ext_boss_dead");
		}
		if ((CAGE_ACTIVE))
		{
			ext_end_cage();
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		ClientEvent("update", "all", CL_FX_ID, "boss_died");
		CallExternal(BEAM_FX_ID, "remove_beams");
		// svplaysound: svplaysound 2 0 SOUND_IDLE_LOOP
		EmitSound(2, 0, SOUND_IDLE_LOOP);
		LogDebug("game_death - exit");
	}

}

}
