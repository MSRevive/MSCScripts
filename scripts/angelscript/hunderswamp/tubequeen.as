#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_monster_shared.as"

namespace MS
{

class Tubequeen : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SPELL_LOOP;
	string ANIM_SPELL_START;
	string ANIM_WALK;
	int ATTACH_LHAND;
	int ATTACH_RHAND;
	int CANT_FLEE;
	int CUR_HURT_STAGE;
	int DID_INTRO;
	int DMG_GLOB;
	int DMG_SLAM;
	string DOING_SPELL;
	int DOT_GLOB;
	int ESCORT_CYCLE;
	float ESCORT_SPAWN_FREQ_HIGH;
	float ESCORT_SPAWN_FREQ_LOW;
	float ESCORT_SPAWN_FREQ_MED;
	float ESCORT_SPAWN_FREQ_PANIC;
	int FIRST_ESCORT;
	float FREQ_ESCORT_SPAWN;
	float FREQ_SPELL;
	string HURT_STAGE1;
	string HURT_STAGE2;
	string HURT_STAGE3;
	string INIT_DELAY;
	int LEFT_YAW;
	string NEXT_ATTACK;
	string NEXT_ESCORT;
	string NEXT_FLINCH;
	string NEXT_IDLE;
	string NEXT_IDLE_ANIM;
	string NEXT_SPELL;
	string NEXT_TUBE;
	string NPCATK_TARGET;
	int NPC_BOSS_REGEN_FREQ;
	float NPC_BOSS_REGEN_RATE;
	int NPC_GIVE_EXP;
	string NPC_HBAR_ADJ;
	int NPC_HEARDSOUND_OVERRIDE;
	int NPC_IS_BOSS;
	int RIGHT_YAW;
	string SLAM_ORG;
	string SOUND_ATTACK_FORWARD;
	string SOUND_ATTACK_LEFT;
	string SOUND_ATTACK_RIGHT;
	string SOUND_BIGFLINCH1;
	string SOUND_BIGLLFLINCH2;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_RAWR;
	string SOUND_SMALLFLINCH1;
	string SOUND_SMALLFLINCH2;
	string SOUND_SPELLPREP1;
	string SOUND_SPELLPREP2;
	string SOUND_SPELLPREP3;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWOOP;
	string SOUND_VIOLENTFLINCH;
	string TIME_SPAWN_PLUS_20;
	int TUBEQUEEN_ACTIVE;

	Tubequeen()
	{
		ANIM_SPELL_START = "spell_start";
		ANIM_SPELL_LOOP = "spell_loop";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ESCORT_SPAWN_FREQ_LOW = Random(80.0, 120.0);
		ESCORT_SPAWN_FREQ_MED = Random(60.0, 100.0);
		ESCORT_SPAWN_FREQ_HIGH = Random(45.0, 80.0);
		ESCORT_SPAWN_FREQ_PANIC = Random(20.0, 60.0);
		FREQ_ESCORT_SPAWN = 30.0;
		NPC_HBAR_ADJ = Vector3(0, 128, 0);
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.05;
		NPC_BOSS_REGEN_FREQ = 120;
		NPC_GIVE_EXP = 20000;
		CANT_FLEE = 1;
		NPC_HEARDSOUND_OVERRIDE = 1;
		SOUND_RAWR = "monsters/tubequeen/tq_lavascream.wav";
		SOUND_SMALLFLINCH1 = "monsters/tubequeen/tq_smallflinch.wav";
		SOUND_SMALLFLINCH2 = "monsters/tubequeen/tq_smallflinch2.wav";
		SOUND_BIGFLINCH1 = "monsters/tubequeen/tq_bigflinch.wav";
		SOUND_BIGLLFLINCH2 = "monsters/tubequeen/tq_bigflinch2.wav";
		SOUND_VIOLENTFLINCH = "monsters/tubequeen/tq_flinchviolent.wav";
		SOUND_STRUCK1 = "monsters/tube/TubeCritter_Hit1.wav";
		SOUND_STRUCK2 = "monsters/tube/TuberCritter_Hit2.wav";
		SOUND_STRUCK3 = "monsters/tube/TubeCritter_Hit3.wav";
		SOUND_IDLE1 = "monsters/tubequeen/tq_idle1.wav";
		SOUND_IDLE2 = "monsters/tubequeen/tq_idle1a.wav";
		SOUND_IDLE3 = "monsters/tubequeen/tq_idle2.wav";
		SOUND_SWOOP = "weapons/swinghuge.wav";
		SOUND_ATTACK_FORWARD = "monsters/tubequeen/tq_clawattack.wav";
		SOUND_ATTACK_RIGHT = "monsters/tubequeen/tq_clawattack_right.wav";
		SOUND_ATTACK_LEFT = "monsters/tubequeen/tq_clawattack_left.wav";
		SOUND_SPELLPREP1 = "monsters/tubequeen/tq_mortarfire1.wav";
		SOUND_SPELLPREP2 = "monsters/tubequeen/tq_mortarfire2.wav";
		SOUND_SPELLPREP3 = "monsters/tubequeen/tq_mortarfire3.wav";
		ATTACH_RHAND = 1;
		ATTACH_LHAND = 2;
		DMG_SLAM = 800;
		FREQ_SPELL = Random(60.0, 100.0);
		DMG_GLOB = 300;
		DOT_GLOB = 100;
	}

	void game_precache()
	{
		Precache("monsters/swamp_tube");
		Precache("monsters/swamp_tube_cl");
		Precache("monsters/summon/slime_globe");
		Precache("monsters/summon/slime_globe_cl");
	}

	void OnSpawn() override
	{
		SetName("Oodle-beak Hivemother");
		SetModel("monsters/tubequeen.mdl");
		SetWidth(600);
		SetHeight(600);
		SetRace("wildanimal");
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		if (!(true)) return;
		SetHealth(30000);
		SetRoam(false);
		SetNoPush(true);
		SetHearingSensitivity(11);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("slash", 0.25);
		ScheduleDelayedEvent(0.1, "pre_setup");
		ScheduleDelayedEvent(2.1, "npcatk_hunt");
		ScheduleDelayedEvent(2.0, "finalize_monster");
		CUR_HURT_STAGE = 0;
		NPCATK_TARGET = "unset";
		FIRST_ESCORT = 0;
		ESCORT_CYCLE = 0;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(GetGameTime() > INIT_DELAY)) return;
		if (!(m_hAttackTarget == "unset")) return;
		string CHECK_TARG = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(CHECK_TARG) == "enemy")) return;
		npcatk_settarget(CHECK_TARG);
	}

	void pre_setup()
	{
		INIT_DELAY = GetGameTime();
		INIT_DELAY += 5.0;
		PlayAnim("once", "idle1");
		NEXT_ESCORT = GetGameTime();
		NEXT_ESCORT += FREQ_ESCORT_SPAWN;
		TIME_SPAWN_PLUS_20 = GetGameTime();
		TIME_SPAWN_PLUS_20 += 20.0;
		setup_delays();
	}

	void setup_delays()
	{
		NEXT_FLINCH = GetGameTime();
		NEXT_FLINCH += 60.0;
		NEXT_SPELL = GetGameTime();
		NEXT_SPELL += FREQ_SPELL;
		NEXT_IDLE_ANIM = GetGameTime();
		NEXT_IDLE_ANIM += 10.0;
	}

	void finalize_monster()
	{
		LEFT_YAW = -60;
		RIGHT_YAW = -110;
		string MY_HP = GetEntityMaxHealth(GetOwner());
		HURT_STAGE1 = MY_HP;
		HURT_STAGE1 *= 0.75;
		HURT_STAGE2 = MY_HP;
		HURT_STAGE2 *= 0.5;
		HURT_STAGE3 = MY_HP;
		HURT_STAGE3 *= 0.25;
	}

	void OnDamage(int damage) override
	{
		TUBEQUEEN_ACTIVE = 1;
		DID_INTRO = 1;
		delay_idle_anim();
		if (m_hAttackTarget == "unset")
		{
			if (GetRelationship(param1) == "enemy")
			{
			}
			npcatk_settarget(GetEntityIndex(param1));
		}
		string CUR_HP = GetEntityHealth(GetOwner());
		if (CUR_HP < HURT_STAGE1)
		{
			if (CUR_HURT_STAGE == 0)
			{
			}
			SetModelBody(1, 0);
			CUR_HURT_STAGE = 1;
			SetProp(GetOwner(), "skin", 1);
			EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_inspectbelly.wav", 10);
			PlayAnim("critical", "bellyinspect");
			delay_flinch();
			NEXT_ESCORT = GetGameTime();
			NEXT_ESCORT += 2.0;
			int EXIT_SUB = 1;
		}
		if (CUR_HP < HURT_STAGE2)
		{
			if (CUR_HURT_STAGE == 1)
			{
			}
			SetModelBody(1, 0);
			CUR_HURT_STAGE = 2;
			SetProp(GetOwner(), "skin", 2);
			EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_inspectbelly.wav", 10);
			PlayAnim("critical", "bellyinspect");
			delay_flinch();
			NEXT_ESCORT = GetGameTime();
			NEXT_ESCORT += 2.0;
			int EXIT_SUB = 1;
		}
		if (CUR_HP < HURT_STAGE3)
		{
			if (CUR_HURT_STAGE == 2)
			{
			}
			SetModelBody(1, 0);
			CUR_HURT_STAGE = 3;
			SetProp(GetOwner(), "skin", 2);
			EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_inspectbelly.wav", 10);
			PlayAnim("critical", "bellyinspect");
			delay_flinch();
			NEXT_ESCORT = GetGameTime();
			NEXT_ESCORT += 2.0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_FLINCH)
		{
			int EXIT_SUB = 1;
			delay_flinch();
			int RND_FLINCH = RandomInt(1, 8);
			if (RND_FLINCH >= 4)
			{
				PlayAnim("critical", "smallflinch");
				// PlayRandomSound from: SOUND_SMALLFLINCH1, SOUND_SMALLFLINCH2
				array<string> sounds = {SOUND_SMALLFLINCH1, SOUND_SMALLFLINCH2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if (RND_FLINCH >= 2)
			{
				if (RND_FLINCH > 1)
				{
				}
				PlayAnim("critical", "bigflinch");
				// PlayRandomSound from: SOUND_BIGFLINCH1, SOUND_BIGFLINCH2
				array<string> sounds = {SOUND_BIGFLINCH1, SOUND_BIGFLINCH2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if (RND_FLINCH == 1)
			{
				PlayAnim("critical", "flinchviolent");
				// PlayRandomSound from: SOUND_VIOLENTFLINCH
				array<string> sounds = {SOUND_VIOLENTFLINCH};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			SetModelBody(1, 0);
		}
		if ((EXIT_SUB)) return;
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void delay_flinch()
	{
		NEXT_FLINCH = GetGameTime();
		if (CUR_HURT_STAGE == 0)
		{
			NEXT_FLINCH += Random(20.0, 30.0);
		}
		if (CUR_HURT_STAGE == 1)
		{
			NEXT_FLINCH += Random(15.0, 25.0);
		}
		if (CUR_HURT_STAGE == 2)
		{
			NEXT_FLINCH += Random(10.0, 20.0);
		}
		if (CUR_HURT_STAGE == 3)
		{
			NEXT_FLINCH += Random(5.0, 15.0);
		}
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += Random(10.0, 20.0);
	}

	void delay_idle_anim()
	{
		NEXT_IDLE_ANIM = GetGameTime();
		NEXT_IDLE_ANIM += 10.0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(1.0, "npcatk_hunt");
		float GAME_TIME = GetGameTime();
		if (GAME_TIME > INIT_DELAY)
		{
			if (m_hAttackTarget == "unset")
			{
				npcatk_gettarget();
			}
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
				npcatk_gettarget();
			}
		}
		if (!(DID_INTRO))
		{
			if (GAME_TIME > TIME_SPAWN_PLUS_20)
			{
			}
			force_active();
		}
		if (!(DID_INTRO)) return;
		if (GAME_TIME > NEXT_ESCORT)
		{
			if (m_hAttackTarget != "unset")
			{
			}
			check_escort();
		}
		if ((I_R_FROZEN)) return;
		if ((SUSPEND_AI)) return;
		if ((DOING_SPELL)) return;
		if (GAME_TIME > NEXT_IDLE)
		{
			NEXT_IDLE = GAME_TIME;
			NEXT_IDLE += Random(10.0, 20.0);
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			if (GAME_TIME > NEXT_IDLE_ANIM)
			{
			}
			NEXT_IDLE_ANIM = GAME_TIME;
			NEXT_IDLE_ANIM += 10.0;
			PlayAnim("once", "idle2");
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GAME_TIME > NEXT_SPELL)
		{
			NEXT_SPELL = GAME_TIME;
			NEXT_SPELL += FREQ_SPELL;
			PlayAnim("critical", ANIM_SPELL_START);
			delay_idle_anim();
			delay_flinch();
			DOING_SPELL = 1;
			ScheduleDelayedEvent(15.0, "spell_break");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_TUBE)
		{
			if (TUBE_COUNT < 3)
			{
			}
			NEXT_TUBE = GAME_TIME;
			NEXT_TUBE += 20.0;
			NEXT_FLINCH = GAME_TIME;
			NEXT_FLINCH += 60.0;
			NEXT_IDLE_ANIM = GAME_TIME;
			NEXT_IDLE_ANIM += 60.0;
			PlayAnim("once", "grabtube");
			delay_spell(10.0);
			delay_attack(5.0);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GAME_TIME > NEXT_ATTACK)
		{
			NEXT_ATTACK = GAME_TIME;
			NEXT_ATTACK += Random(3.0, 5.0);
			string TARG_POS = GetEntityOrigin(m_hAttackTarget);
			string MY_POS = GetEntityOrigin(GetOwner());
			string TARG_ANGS = /* TODO: $angles */ $angles(MY_POS, TARG_POS);
			ANIM_ATTACK = "clawattack";
			if (TARG_ANGS > LEFT_YAW)
			{
				ANIM_ATTACK = "clawattackleft";
			}
			if (TARG_ANGS < RIGHT_YAW)
			{
				ANIM_ATTACK = "clawattackright";
			}
			PlayAnim("once", ANIM_ATTACK);
			delay_idle_anim();
		}
	}

	void delay_attack()
	{
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += param1;
	}

	void npcatk_gettarget()
	{
		if ((false))
		{
			NPCATK_TARGET = GetEntityIndex(m_hLastSeen);
		}
		if (m_hAttackTarget == "unset")
		{
			string IN_SPHERE = FindEntitiesInSphere("enemy", 768);
			if (IN_SPHERE != "none")
			{
				string IN_SPHERE = /* TODO: $sort_entlist */ $sort_entlist(IN_SPHERE, "range");
				NPCATK_TARGET = GetToken(IN_SPHERE, 0, ";");
			}
		}
		npcatk_targetvalidate(m_hAttackTarget);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (GetEntityProperty(m_hAttackTarget, "scriptvar") == 1)
		{
			NPCATK_TARGET = "unset";
		}
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			NPCATK_TARGET = "unset";
		}
		if (!(/* TODO: $can_damage */ $can_damage(m_hAttackTarget)))
		{
			NPCATK_TARGET = "unset";
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		PlayAnim("critical", "flinchviolent");
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 5, 1024);
		setup_delays();
	}

	void npcatk_settarget()
	{
		if (m_hAttackTarget != "unset")
		{
			if (GetEntityRange(m_hAttackTarget) < GetEntityRange(param1))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string OLD_TARGET = m_hAttackTarget;
		NPCATK_TARGET = param1;
		npcatk_targetvalidate(GetEntityIndex(param1));
		if (m_hAttackTarget == "unset")
		{
			if (OLD_TARGET != "unset")
			{
			}
			NPCATK_TARGET = OLD_TARGET;
		}
	}

	void frame_attack_forward_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SWOOP, 10);
		EmitSound(GetOwner(), 2, SOUND_ATTACK_FORWARD, 10);
	}

	void frame_attack_left_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SWOOP, 10);
		EmitSound(GetOwner(), 2, SOUND_ATTACK_LEFT, 10);
	}

	void frame_attack_right_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SWOOP, 10);
		EmitSound(GetOwner(), 2, SOUND_ATTACK_RIGHT, 10);
	}

	void frame_attack_forward_land()
	{
		string LAND_POS = GetEntityProperty(GetOwner(), "attachpos");
		LAND_POS += /* TODO: $relpos */ $relpos(GetMonsterProperty("angles"), Vector3(-128, 0, 0));
		LAND_POS = "z";
		Effect("screenshake", LAND_POS, 380, 20, 1, 512);
		ClientEvent("new", "all", "effects/sfx_stun_burst", LAND_POS, 512, 0, 0);
		SLAM_ORG = LAND_POS;
		LAND_POS += "z";
		XDoDamage(LAND_POS, 512, DMG_SLAM, 0.3, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:slam");
	}

	void frame_attack_right_land()
	{
		string LAND_POS = GetEntityProperty(GetOwner(), "attachpos");
		LAND_POS = "z";
		Effect("screenshake", LAND_POS, 380, 20, 1, 384);
		ClientEvent("new", "all", "effects/sfx_stun_burst", LAND_POS, 384, 0, 0);
		SLAM_ORG = LAND_POS;
		LAND_POS += "z";
		XDoDamage(LAND_POS, 384, DMG_SLAM, 0.3, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:slam");
	}

	void frame_attack_left_land()
	{
		string LAND_POS = GetEntityProperty(GetOwner(), "attachpos");
		LAND_POS = "z";
		Effect("screenshake", LAND_POS, 380, 20, 1, 256);
		ClientEvent("new", "all", "effects/sfx_stun_burst", LAND_POS, 384, 0, 0);
		SLAM_ORG = LAND_POS;
		LAND_POS += "z";
		XDoDamage(LAND_POS, 384, DMG_SLAM, 0.3, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:slam");
	}

	void slam_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(IsOnGround(param2))) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = SLAM_ORG;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
		delay_spell(20.0);
	}

	void delay_spell()
	{
		float CHECK_TIME = GetGameTime();
		CHECK_TIME += param1;
		if (CHECK_TIME > NEXT_SPELL)
		{
			LogDebug("delay_spell PARAM1");
			NEXT_SPELL = GetGameTime();
			NEXT_SPELL += param1;
		}
	}

	void frame_sack_start()
	{
		delay_spell(5.0);
		delay_attack(10.0);
		EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_grabtube1.wav", 10);
	}

	void frame_sack_grab()
	{
		delay_attack(10.0);
		SetModelBody(1, 1);
		EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_grabtube2.wav", 10);
	}

	void frame_sack_throw()
	{
		delay_attack(1.0);
		delay_spell(5.0);
		SetModelBody(1, 0);
		EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_grabtube3.wav", 10);
		delay_flinch();
		delay_idle_anim();
		TUBE_COUNT += 1;
		if (TUBE_COUNT < 3)
		{
			NEXT_TUBE = GetGameTime();
		}
		else
		{
			NEXT_TUBE = GetGameTime();
			NEXT_TUBE += 60.0;
		}
		string SPAWN_POS = GetEntityProperty(GetOwner(), "attachpos");
		SpawnNPC("monsters/swamp_tube", SPAWN_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		string RND_RL = GetEntityProperty(GetOwner(), "angles.yaw");
		RND_RL += Random(-65, 65);
		float RND_FD = Random(200, 800);
		float RND_UP = Random(200, 900);
		float RND_RL2 = Random(-1000, 1000);
		LogDebug("frame_sack_throw /* TODO: $relpos */ $relpos(Vector3(0, RND_RL, 0), Vector3(0, RND_FD, RND_UP))");
		AddVelocity(m_hLastCreated, /* TODO: $relpos */ $relpos(Vector3(0, RND_RL, 0), Vector3(RND_RL2, RND_FD, RND_UP)));
	}

	void ext_tube_died()
	{
		TUBE_COUNT -= 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0, "monsters/tubequeen/tq_lavascream.wav", 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 10, 1024);
		string DEATH_POS = GetEntityOrigin(GetOwner());
		DEATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(-256, 256, 0));
		CallExternal("all", "ext_mommy_died", DEATH_POS);
	}

	void frame_spell_start()
	{
		// PlayRandomSound from: SOUND_SPELLPREP1, SOUND_SPELLPREP2, SOUND_SPELLPREP3
		array<string> sounds = {SOUND_SPELLPREP1, SOUND_SPELLPREP2, SOUND_SPELLPREP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DOING_SPELL = 1;
		LogDebug("frame_spell_start");
		SpawnNPC("monsters/summon/slime_globe", /* TODO: $relpos */ $relpos(0, 512, -64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_GLOB
		NEXT_SPELL = GetGameTime();
		NEXT_SPELL += FREQ_SPELL;
	}

	void frame_spell_ready()
	{
		// PlayRandomSound from: SOUND_SPELLPREP1, SOUND_SPELLPREP2, SOUND_SPELLPREP3
		array<string> sounds = {SOUND_SPELLPREP1, SOUND_SPELLPREP2, SOUND_SPELLPREP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		npcatk_suspend_ai(12.0);
		npcatk_suspend_movement(ANIM_SPELL_LOOP, 12.0);
		PlayAnim("critical", ANIM_SPELL_LOOP);
	}

	void spell_break()
	{
		DOING_SPELL = 0;
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
		PlayAnim("once", "break");
		ANIM_IDLE = "idle1";
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		NEXT_SPELL = GetGameTime();
		NEXT_SPELL += FREQ_SPELL;
		delay_attack(1.0);
	}

	void glob_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_GLOB);
	}

	void check_escort()
	{
		LogDebug("check_escort game.time");
		if (!(FIRST_ESCORT))
		{
			LogDebug("first_escort");
			FIRST_ESCORT = 1;
			ESCORT_CYCLE = 2;
			UseTrigger("spawn_boss_escort1");
			UseTrigger("spawn_boss_escort2");
			int EXIT_SUB = 1;
		}
		NEXT_ESCORT = GetGameTime();
		if (CUR_HURT_STAGE == 0)
		{
			FREQ_ESCORT_SPAWN = ESCORT_SPAWN_FREQ_LOW;
		}
		if (CUR_HURT_STAGE == 1)
		{
			FREQ_ESCORT_SPAWN = ESCORT_SPAWN_FREQ_MED;
		}
		if (CUR_HURT_STAGE == 2)
		{
			FREQ_ESCORT_SPAWN = ESCORT_SPAWN_FREQ_HIGH;
		}
		if (CUR_HURT_STAGE == 3)
		{
			FREQ_ESCORT_SPAWN = ESCORT_SPAWN_FREQ_PANIC;
		}
		NEXT_ESCORT += FREQ_ESCORT_SPAWN;
		if ((EXIT_SUB)) return;
		ESCORT_CYCLE += 1;
		if (CUR_HURT_STAGE < 2)
		{
			if (ESCORT_CYCLE == 1)
			{
				UseTrigger("spawn_boss_escort1");
			}
			if (ESCORT_CYCLE == 2)
			{
				UseTrigger("spawn_boss_escort2");
			}
			if (ESCORT_CYCLE == 3)
			{
				ESCORT_CYCLE = 0;
				UseTrigger("spawn_boss_escort3");
			}
		}
		if (CUR_HURT_STAGE == 2)
		{
			if (ESCORT_CYCLE == 1)
			{
				UseTrigger("spawn_boss_escort1");
				UseTrigger("spawn_boss_escort2");
			}
			if (ESCORT_CYCLE == 2)
			{
				UseTrigger("spawn_boss_escort2");
				UseTrigger("spawn_boss_escort3");
			}
			if (ESCORT_CYCLE == 3)
			{
				ESCORT_CYCLE = 0;
				UseTrigger("spawn_boss_escort3");
				UseTrigger("spawn_boss_escort1");
			}
		}
		if (CUR_HURT_STAGE == 3)
		{
			ESCORT_CYCLE = 0;
			UseTrigger("spawn_boss_escort1");
			UseTrigger("spawn_boss_escort2");
			UseTrigger("spawn_boss_escort3");
		}
	}

	void force_active()
	{
		TUBEQUEEN_ACTIVE = 1;
		DID_INTRO = 1;
		PlayAnim("critical", "flinchviolent");
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 5, 1024);
		setup_delays();
	}

}

}
