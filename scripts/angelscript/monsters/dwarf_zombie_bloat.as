#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class DwarfZombieBloat : CGameScript
{
	int AM_EXPLODING;
	int AM_PUKING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_EXPLODE;
	string ANIM_IDLE;
	string ANIM_PUKE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int DID_FAKE_DEATH;
	int DID_INTRO;
	int DMG_EXPLODE;
	int DMG_PROJECTILE;
	int DMG_SWIPE;
	int DOT_PUKE;
	string DO_PROJECTILE;
	string DRIFT_ANG;
	float FREQ_PUKE;
	float FREQ_SPIT;
	int IS_BLOODLESS;
	int I_AM_TURNABLE;
	int LIGHT_SIZE;
	float MSC_PUSH_RESIST;
	string MY_HEAD_POS;
	string MY_LIGHT_IDX;
	string MY_PUKE_POS;
	string NEARBY_ALLIES;
	string NEW_ALLY_TARGET;
	string NEXT_ALLY_ALERT;
	string NEXT_CONFUSED;
	string NEXT_IDLE_SOUND;
	string NEXT_LIGHT;
	string NEXT_PUKE;
	string NEXT_SPIT;
	int NPC_GIVE_EXP;
	int PUKE_RANGE;
	string PUKE_SCRIPT_IDX;
	string PUKE_TARGS;
	int RAD_EXPLODE;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACKHIT1;
	string SOUND_ATTACKHIT2;
	string SOUND_ATTACKHIT3;
	string SOUND_DEATH;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_DEATH3;
	string SOUND_HOLYPAIN1;
	string SOUND_HOLYPAIN2;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_PUKE;
	string SOUND_SPIT1;
	string SOUND_SPIT2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_TURNED1;
	string SOUND_TURNED2;
	string SOUND_TURNED3;
	string SOUND_TURNED4;

	DwarfZombieBloat()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle";
		ANIM_DEATH = "none";
		SOUND_DEATH = "none";
		MSC_PUSH_RESIST = 0.25;
		NPC_GIVE_EXP = 400;
		ANIM_ATTACK = "attack";
		ANIM_PUKE = "anim_puke";
		ANIM_EXPLODE = "anim_death";
		FREQ_PUKE = Random(10.0, 20.0);
		FREQ_SPIT = Random(1.0, 5.0);
		PUKE_RANGE = 256;
		RAD_EXPLODE = 300;
		SOUND_PUKE = "monsters/mummy/c_mummycom_bat1.wav";
		SOUND_DEATH1 = "agrunt/ag_die5.wav";
		SOUND_DEATH2 = "agrunt/ag_die4.wav";
		SOUND_DEATH3 = "agrunt/ag_die3.wav";
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 120;
		SOUND_TURNED1 = "ambience/the_horror1.wav";
		SOUND_TURNED2 = "ambience/the_horror2.wav";
		SOUND_TURNED3 = "ambience/the_horror3.wav";
		SOUND_TURNED4 = "ambience/the_horror4.wav";
		SOUND_HOLYPAIN1 = "agrunt/ag_pain4.wav";
		SOUND_HOLYPAIN2 = "agrunt/ag_die3.wav";
		DMG_PROJECTILE = 300;
		DOT_PUKE = 100;
		DMG_SWIPE = 100;
		DMG_EXPLODE = 2000;
		SOUND_SPIT1 = "bullchicken/bc_attack2.wav";
		SOUND_SPIT2 = "bullchicken/bc_attack3.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_ATTACKHIT1 = "zombie/claw_strike1.wav";
		SOUND_ATTACKHIT2 = "zombie/claw_strike2.wav";
		SOUND_ATTACKHIT3 = "zombie/claw_strike3.wav";
		SOUND_IDLE1 = "agrunt/ag_idle2.wav";
		SOUND_IDLE2 = "agrunt/ag_alert3.wav";
		SOUND_IDLE3 = "agrunt/ag_idle5.wav";
		SOUND_STRUCK1 = "debris/flesh2.wav";
		SOUND_STRUCK2 = "debris/flesh5.wav";
		SOUND_STRUCK3 = "debris/flesh7.wav";
		SOUND_PAIN1 = "agrunt/ag_pain2.wav";
		SOUND_PAIN2 = "agrunt/ag_pain3.wav";
		SOUND_PAIN3 = "agrunt/ag_pain5.wav";
		SOUND_ALERT = "agrunt/ag_alert2.wav";
		I_AM_TURNABLE = 1;
	}

	void game_precache()
	{
		Precache("bloodspray.spr");
	}

	void OnSpawn() override
	{
		SetName("Bloated Dwarven Zombie");
		SetModel("monsters/dwarf_bloat.mdl");
		SetWidth(48);
		SetHeight(96);
		SetRace("undead");
		SetBloodType("green");
		SetHealth(2000);
		SetRoam(true);
		SetHearingSensitivity(5);
		SetDamageResistance("poison", 0.0);
		IS_BLOODLESS = 1;
		SetDamageResistance("pierce", 1.5);
		SetDamageResistance("blunt", 0.75);
		SetDamageResistance("holy", 2.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("lightning", 1.0);
		SetDamageResistance("acid", 0.75);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		LIGHT_SIZE = 64;
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += FREQ_SPIT;
		NEXT_PUKE = GetGameTime();
		NEXT_PUKE += FREQ_PUKE;
	}

	void OnPostSpawn() override
	{
		LIGHT_SIZE = 64;
		ClientEvent("new", "all", "monsters/dwarf_zombie_bloat_light_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), LIGHT_SIZE, 30.0);
		MY_LIGHT_IDX = "game.script.last_sent_id";
		NEXT_LIGHT = GetGameTime();
		NEXT_LIGHT += 15.0;
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		PlayAnim("critical", ANIM_IDLE);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += FREQ_SPIT;
		NEXT_PUKE = GetGameTime();
		NEXT_PUKE += FREQ_PUKE;
		LIGHT_SIZE = 64;
		ClientEvent("update", "all", MY_LIGHT_IDX, "remove_light");
		ClientEvent("new", "all", "monsters/dwarf_zombie_bloat_light_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), LIGHT_SIZE, 30.0);
		MY_LIGHT_IDX = "game.script.last_sent_id";
		NEXT_LIGHT = GetGameTime();
		NEXT_LIGHT += 15.0;
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_CONFUSED)) return;
		NEXT_CONFUSED = GetGameTime();
		NEXT_CONFUSED += 20.0;
		PlayAnim("critical", ANIM_IDLE);
		EmitSound(GetOwner(), 0, SOUND_IDLE2, 10);
		DID_INTRO = 0;
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_CONFUSED)) return;
		NEXT_CONFUSED = GetGameTime();
		NEXT_CONFUSED += 20.0;
		PlayAnim("critical", ANIM_IDLE);
		EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((AM_EXPLODING)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		float L_GAME_TIME = GetGameTime();
		if (L_GAME_TIME > NEXT_LIGHT)
		{
			ClientEvent("new", "all", "monsters/dwarf_zombie_bloat_light_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), LIGHT_SIZE, 15.0);
			MY_LIGHT_IDX = "game.script.last_sent_id";
			NEXT_LIGHT = L_GAME_TIME;
			NEXT_LIGHT += 15.0;
		}
		if ((SUSPEND_AI)) return;
		if ((AM_PUKING)) return;
		if (L_GAME_TIME > NEXT_IDLE_SOUND)
		{
			NEXT_IDLE_SOUND = L_GAME_TIME;
			NEXT_IDLE_SOUND += Random(5.0, 15.0);
			int RND_SOUND = RandomInt(1, 3);
			if (RND_SOUND == 1)
			{
				EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
			}
			if (RND_SOUND == 2)
			{
				EmitSound(GetOwner(), 0, SOUND_IDLE2, 10);
			}
			if (RND_SOUND == 3)
			{
				EmitSound(GetOwner(), 0, SOUND_IDLE3, 10);
			}
		}
		if (!(m_hAttackTarget != "none")) return;
		if (L_GAME_TIME > NEXT_SPIT)
		{
			if (GetEntityRange(m_hAttackTarget) > 256)
			{
			}
			if ((NPC_CANSEE_TARGET))
			{
			}
			DO_PROJECTILE = 1;
			NEXT_SPIT = L_GAME_TIME;
			NEXT_SPIT += FREQ_SPIT;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			PlayAnim("once", ANIM_ATTACK);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityRange(m_hAttackTarget) < 256)) return;
		if (!(L_GAME_TIME > NEXT_PUKE)) return;
		NEXT_PUKE = L_GAME_TIME;
		NEXT_PUKE += FREQ_PUKE;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 15.0;
		do_puke();
	}

	void frame_attack()
	{
		if ((DO_PROJECTILE))
		{
			// PlayRandomSound from: SOUND_SPIT1, SOUND_SPIT2
			array<string> sounds = {SOUND_SPIT1, SOUND_SPIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			DO_PROJECTILE = 0;
			TossProjectile("proj_poison_spit2", GetEntityProperty(GetOwner(), "attachpos"), m_hAttackTarget, 250, DMG_PROJECTILE, 2, "none");
			Effect("glow", "ent_lastprojectile", Vector3(0, 255, 0), 64, -1, 0);
		}
		else
		{
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, 0.8, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:swipe");
		}
	}

	void swipe_dodamage()
	{
		if ((param1))
		{
			// PlayRandomSound from: SOUND_ATTACKHIT1, SOUND_ATTACKHIT2, SOUND_ATTACKHIT3
			array<string> sounds = {SOUND_ATTACKHIT1, SOUND_ATTACKHIT2, SOUND_ATTACKHIT3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			AddVelocity(m_hAttackTarget, Vector3(-25, 150, 110));
		}
		else
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void do_puke()
	{
		AM_PUKING = 1;
		npcatk_suspend_ai();
		CAN_FLINCH = 0;
		npcatk_suspend_movement(ANIM_PUKE);
		PlayAnim("critical", ANIM_PUKE);
		EmitSound(GetOwner(), 2, SOUND_PUKE, 10);
		LIGHT_SIZE = PUKE_RANGE;
		ClientEvent("update", "all", MY_LIGHT_IDX, "light_grow", PUKE_RANGE, 0.5);
	}

	void frame_puke_start()
	{
		ClientEvent("new", "all", "monsters/dwarf_zombie_bloat_cl", GetEntityIndex(GetOwner()));
		PUKE_SCRIPT_IDX = "game.script.last_sent_id";
		DRIFT_ANG = GetEntityAngles(GetOwner());
		puke_scan_loop();
	}

	void puke_scan_loop()
	{
		if (!(AM_PUKING)) return;
		ScheduleDelayedEvent(0.25, "puke_scan_loop");
		DRIFT_ANG = GetEntityAngles(GetOwner());
		MY_HEAD_POS = GetEntityProperty(GetOwner(), "attachpos");
		MY_PUKE_POS = GetEntityProperty(GetOwner(), "attachpos");
		// TODO: UNCONVERTED: vectorset.yaw DRIFT_ANG	$angles(MY_HEAD_POS,MY_PUKE_POS)
		PUKE_TARGS = FindEntitiesInSphere("enemy", PUKE_RANGE);
		if (!(PUKE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(PUKE_TARGS, ";"); i++)
		{
			puke_affect_targets();
		}
	}

	void puke_affect_targets()
	{
		string CUR_TARG = GetToken(PUKE_TARGS, i, ";");
		string CUR_TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(CUR_TARG_ORG, MY_HEAD_POS, DRIFT_ANG))) return;
		string TRACE_START = MY_HEAD_POS;
		string TRACE_END = CUR_TARG_ORG;
		string TRACE_LINE = TraceLine(MY_HEAD_POS, CUR_TARG_ORG);
		if (!(TRACE_LINE == TRACE_END)) return;
		ApplyEffect(CUR_TARG, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_PUKE);
		if (!(GetGameTime() > NEXT_ALLY_ALERT)) return;
		set_ally_targets(CUR_TARG);
	}

	void frame_puke_finish()
	{
		ClientEvent("update", "all", PUKE_SCRIPT_IDX, "end_puke");
		AM_PUKING = 0;
		npcatk_resume_movement();
		npcatk_resume_ai();
		LIGHT_SIZE = 64;
		ClientEvent("update", "all", MY_LIGHT_IDX, "light_shrink", 64, 1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((DID_FAKE_DEATH)) return;
		DID_FAKE_DEATH = 1;
		ClientEvent("update", "all", MY_LIGHT_IDX, "remove_light");
		ClientEvent("new", "all", "monsters/dwarf_zombie_bloat_light_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), LIGHT_SIZE, 30.0);
		MY_LIGHT_IDX = "game.script.last_sent_id";
		if ((AM_PUKING))
		{
			ClientEvent("update", "all", PUKE_SCRIPT_IDX, "end_puke");
			EmitSound(GetOwner(), 2, SOUND_PUKE, 0);
		}
		ClearFX();
		SetAlive(1);
		SetInvincible(true);
		npcatk_suspend_movement(ANIM_EXPLODE);
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_EXPLODE);
		EmitSound(GetOwner(), 0, SOUND_DEATH1, 10);
		DID_FAKE_DEATH = 1;
		AM_EXPLODING = 1;
		ScheduleDelayedEvent(0.1, "light_flicker");
	}

	void light_flicker()
	{
		ClientEvent("update", "all", MY_LIGHT_IDX, "light_flicker");
	}

	void frame_death_buckle1()
	{
		EmitSound(GetOwner(), 0, SOUND_DEATH2, 10);
		ClientEvent("update", "all", MY_LIGHT_IDX, "light_grow", 512, 2);
	}

	void frame_death_buckle2()
	{
		EmitSound(GetOwner(), 0, SOUND_DEATH3, 10);
		LIGHT_SIZE = 512;
	}

	void frame_death_explode()
	{
		ClientEvent("new", "all", "effects/sfx_acid_splash", GetEntityOrigin(GetOwner()), 512);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), RAD_EXPLODE, DMG_EXPLODE, 0.1, GetOwner(), GetOwner(), "none", "poison_effect", "dmgevent:explode");
	}

	void explode_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison_blind", 8.0, GetEntityIndex(GetOwner()), DOT_PUKE);
		if (!(GetGameTime() > NEXT_ALLY_ALERT)) return;
		set_ally_targets(GetEntityIndex(param2));
	}

	void frame_death_done()
	{
		SetInvincible(false);
		SetEntityOrigin(GetOwner(), Vector3(20000, -20000, 20000));
		npc_suicide();
	}

	void set_ally_targets()
	{
		NEXT_ALLY_ALERT = GetGameTime();
		NEXT_ALLY_ALERT += 15.0;
		NEW_ALLY_TARGET = param1;
		NEARBY_ALLIES = FindEntitiesInSphere("ally", 1024);
		if (!(NEARBY_ALLIES != "none")) return;
		for (int i = 0; i < GetTokenCount(NEARBY_ALLIES, ";"); i++)
		{
			set_allies_target_loop();
		}
	}

	void set_allies_target_loop()
	{
		string CUR_ALLY = GetToken(NEARBY_ALLIES, i, ";");
		CallExternal(CUR_ALLY, "npcatk_settarget", NEW_ALLY_TARGET);
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("effect") >= 0)
		{
			int L_DO_PAIN = RandomInt(1, 3);
		}
		if (L_DO_PAIN == 1)
		{
			float L_RND_SND = Random(1, 3);
			if (L_RND_SND == 1)
			{
				EmitSound(GetOwner(), 0, SOUND_PAIN1, 10);
			}
			if (L_RND_SND == 2)
			{
				EmitSound(GetOwner(), 0, SOUND_PAIN2, 10);
			}
			if (L_RND_SND == 3)
			{
				EmitSound(GetOwner(), 0, SOUND_PAIN3, 10);
			}
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

}

}
