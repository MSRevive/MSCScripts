#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_struck.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class DwarfBomber : CGameScript
{
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DODGE;
	string ANIM_EXPLODE;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_RELOAD_L;
	string ANIM_RELOAD_R;
	string ANIM_RUN;
	string ANIM_THROW_L;
	string ANIM_THROW_R;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BASE_MOVESPEED;
	string CL_SCRIPT;
	int CL_SCRIPT_IDX;
	int DID_FAKE_DEATH;
	int DID_FSUICIDE;
	int DID_INTRO;
	int DMG_BOMB;
	int DMG_SUICIDE;
	string DROP_TNT;
	float FREQ_BOMB_DRAW;
	float FREQ_CL_UPDATE;
	float FREQ_DODGE;
	float FREQ_LBOMB_BEAM;
	float FREQ_LEAP_FORWARD;
	float FREQ_RBOMB_BEAM;
	int HL_ACTIVE;
	int HL_ATTACH_IDX;
	int HL_CHAN;
	int HR_ACTIVE;
	int HR_ATTACH_IDX;
	int HR_CHAN;
	string MODEL_TNT;
	string NEXT_ALERT;
	string NEXT_BOMB_DRAW;
	string NEXT_CL_UPDATE;
	string NEXT_DODGE;
	int NEXT_LBOMB_BEAM;
	int NEXT_RBOMB_BEAM;
	int NPC_GIVE_EXP;
	string NPC_MATERIAL_TYPE;
	string NPC_NEXT_FLINCH;
	int NPC_RANGED;
	int NPC_USE_FLINCH;
	int NPC_USE_IDLE;
	int NPC_USE_PAIN;
	string PROJ_SCRIPT;
	int ROLL_DIR;
	string SOUND_ALERT;
	string SOUND_DEATH;
	string SOUND_EXPLODE;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_FLINCH3;
	string SOUND_FUSE_LIGHT;
	string SOUND_FUSE_LOOP;
	string SOUND_GIGGLE1;
	string SOUND_GIGGLE2;
	string SOUND_GIGGLE3;
	string SOUND_GIGGLE4;
	string SOUND_GIGGLE5;
	string SOUND_GLOAT;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_SUICIDE;
	string SOUND_YELP;
	string VEC_ENGLISH;

	DwarfBomber()
	{
		ANIM_RELOAD_R = "anim_draw_r";
		ANIM_RELOAD_L = "anim_draw_l";
		ANIM_THROW_R = "anim_throw_r";
		ANIM_THROW_L = "anim_throw_l";
		ANIM_EXPLODE = "anim_explode";
		ANIM_JUMP = "anim_jump_back";
		ANIM_DODGE = "anim_roll_back";
		FREQ_LEAP_FORWARD = Random(15.0, 20.0);
		FREQ_DODGE = Random(10.0, 15.0);
		ANIM_ALERT = "nod";
		MODEL_TNT = "monsters/dwarf_bomber_tnt.mdl";
		PROJ_SCRIPT = "monsters/summon/tnt_bomb";
		CL_SCRIPT = "monsters/dwarf_bomber_cl";
		FREQ_CL_UPDATE = 15.0;
		CL_SCRIPT_IDX = -1;
		HR_ACTIVE = 0;
		HL_ACTIVE = 0;
		HR_ATTACH_IDX = 1;
		HL_ATTACH_IDX = 2;
		FREQ_BOMB_DRAW = 5.0;
		HR_CHAN = 1;
		HL_CHAN = 3;
		FREQ_RBOMB_BEAM = 5.0;
		FREQ_LBOMB_BEAM = 5.0;
		NEXT_RBOMB_BEAM = 0;
		NEXT_LBOMB_BEAM = 0;
		VEC_ENGLISH = Vector3(0, 0, 0);
		DMG_BOMB = 100;
		DMG_SUICIDE = 300;
		SOUND_FUSE_LOOP = "monsters/dwarf_bomber/fuse_loop.wav";
		SOUND_FUSE_LIGHT = "monsters/dwarf_bomber/fuse_lit.wav";
		SOUND_YELP = "monsters/dwarf_bomber/db_yelp.wav";
		SOUND_GIGGLE1 = "monsters/dwarf_bomber/db_giggle1.wav";
		SOUND_GIGGLE2 = "monsters/dwarf_bomber/db_giggle2.wav";
		SOUND_GIGGLE3 = "monsters/dwarf_bomber/db_giggle3.wav";
		SOUND_GIGGLE4 = "monsters/dwarf_bomber/db_giggle4.wav";
		SOUND_GIGGLE5 = "monsters/dwarf_bomber/db_giggle5.wav";
		SOUND_EXPLODE = "weapons/explode3.wav";
		SOUND_GLOAT = "monsters/dwarf_bomber/db_gloat.wav";
		SOUND_ALERT = "monsters/dwarf_bomber/db_alert1.wav";
		SOUND_SUICIDE = "monsters/dwarf_bomber/db_suicide.wav";
		NPC_GIVE_EXP = 300;
		NPC_RANGED = 1;
		ATTACK_RANGE = 640;
		ATTACK_HITRANGE = 640;
		ATTACK_MOVERANGE = 512;
		ANIM_ATTACK = "frame_release_r";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle";
		ANIM_DEATH = "none";
		SOUND_DEATH = "none";
		BASE_MOVESPEED = 2.0;
		SetMoveSpeed(BASE_MOVESPEED);
		SetAnimMoveSpeed(BASE_MOVESPEED);
		SOUND_IDLE1 = "monsters/dwarf_bomber/db_idle1.wav";
		SOUND_IDLE2 = "monsters/dwarf_bomber/db_idle2.wav";
		SOUND_IDLE3 = "monsters/dwarf_bomber/db_idle3.wav";
		SOUND_PAIN1 = "monsters/dwarf_bomber/db_pain1.wav";
		SOUND_PAIN2 = "monsters/dwarf_bomber/db_pain2.wav";
		SOUND_PAIN3 = "monsters/dwarf_bomber/db_pain3.wav";
		SOUND_FLINCH1 = "monsters/dwarf_bomber/db_flinch1.wav";
		SOUND_FLINCH2 = "monsters/dwarf_bomber/db_flinch2.wav";
		SOUND_FLINCH3 = "monsters/dwarf_bomber/db_flinch3.wav";
		ANIM_FLINCH = "anim_xbow_flinch";
		NPC_MATERIAL_TYPE = "flesh";
		NPC_USE_PAIN = 1;
		NPC_USE_IDLE = 1;
		NPC_USE_FLINCH = 1;
	}

	void game_precache()
	{
		Precache("monsters/dwarf_bomber_tnt.mdl");
		Precache("bigsmoke.spr");
		Precache(CL_SCRIPT);
		Precache(PROJ_SCRIPT);
		Precache("fleshgibs.mdl");
		Precache("misc/sylphiels_stuff.mdl");
		// svplaysound: svplaysound 0 0 monsters/dwarf_bomber/fuse_loop.wav
		EmitSound(0, 0, "monsters/dwarf_bomber/fuse_loop.wav");
	}

	void OnSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		dbomber_spawn();
	}

	void dbomber_spawn()
	{
		SetName("Mad Dwarven Bomber");
		SetModel("monsters/dwarf_bomber.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 6);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(300);
		SetRace("evil");
		SetHearingSensitivity(8);
	}

	void npc_targetsighted()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		NPC_NEXT_FLINCH = GetGameTime();
		NPC_NEXT_FLINCH += NPC_FREQ_FLINCH;
		if (GetGameTime() > NEXT_ALERT)
		{
			PlayAnim("critical", ANIM_ALERT);
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			NEXT_ALERT = GetGameTime();
			NEXT_ALERT += 20.0;
		}
		NEXT_BOMB_DRAW = GetGameTime();
		NEXT_BOMB_DRAW += 1.0;
		if (!(GetGameTime() > NEXT_CL_UPDATE)) return;
		if (CL_SCRIPT_IDX > -1)
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "end_fx");
		}
		CL_SCRIPT_IDX = -1;
		update_cl_script();
	}

	void cycle_down()
	{
		DID_INTRO = 0;
		PlayAnim("critical", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_GLOAT, 10);
		NEXT_ALERT = GetGameTime();
		NEXT_ALERT += 20.0;
	}

	void npc_selectattack()
	{
		if ((HR_ACTIVE))
		{
			ANIM_ATTACK = ANIM_THROW_R;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((HL_ACTIVE))
		{
			ANIM_ATTACK = ANIM_THROW_L;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_DRAW_R;
		}
		else
		{
			ANIM_ATTACK = ANIM_DRAW_L;
		}
	}

	void draw_random_bomb()
	{
		if ((SUSPEND_AI)) return;
		string L_N_ACTIVE = (HR_ACTIVE + HL_ACTIVE);
		if (!(L_N_ACTIVE < 2)) return;
		int L_RND_HAND = RandomInt(1, 2);
		if (L_RND_HAND == 1)
		{
			if (!(HR_ACTIVE))
			{
				int L_DRAWING_BOMB = 1;
				PlayAnim("critical", ANIM_DRAW_R);
			}
		}
		else
		{
			if (!(HL_ACTIVE))
			{
				int L_DRAWING_BOMB = 1;
				PlayAnim("critical", ANIM_DRAW_L);
			}
		}
		if ((L_DRAWING_BOMB)) return;
		if (!(HR_ACTIVE))
		{
			PlayAnim("critical", ANIM_DRAW_R);
		}
		if (!(HL_ACTIVE))
		{
			PlayAnim("critical", ANIM_DRAW_L);
		}
	}

	void frame_draw_r()
	{
		EmitSound(GetOwner(), 0, SOUND_FUSE_LIGHT, 10);
		update_submodels("activate", "right");
	}

	void frame_draw_l()
	{
		EmitSound(GetOwner(), 0, SOUND_FUSE_LIGHT, 10);
		update_submodels("activate", "left");
	}

	void update_submodels()
	{
		if (param1 == "activate")
		{
			if (param2 == "right")
			{
				if (!(HR_ACTIVE))
				{
					HR_ACTIVE = 1;
					// svplaysound: svplaysound HR_CHAN 5 SOUND_FUSE_LOOP
					EmitSound(HR_CHAN, 5, SOUND_FUSE_LOOP);
				}
			}
			else
			{
				if (param2 == "left")
				{
					if (!(HL_ACTIVE))
					{
						HL_ACTIVE = 1;
						// svplaysound: svplaysound HL_CHAN 5 SOUND_FUSE_LOOP
						EmitSound(HL_CHAN, 5, SOUND_FUSE_LOOP);
					}
				}
				else
				{
					if (param2 == "both")
					{
						if (!(HR_ACTIVE))
						{
							HR_ACTIVE = 1;
							// svplaysound: svplaysound HR_CHAN 5 SOUND_FUSE_LOOP
							EmitSound(HR_CHAN, 5, SOUND_FUSE_LOOP);
						}
						if (!(HL_ACTIVE))
						{
							HL_ACTIVE = 1;
							// svplaysound: svplaysound HL_CHAN 5 SOUND_FUSE_LOOP
							EmitSound(HL_CHAN, 5, SOUND_FUSE_LOOP);
						}
					}
				}
			}
		}
		else
		{
			if (param1 == "deactivate")
			{
				if (param2 == "right")
				{
					if ((HR_ACTIVE))
					{
						// svplaysound: if ( HR_ACTIVE ) svplaysound HR_CHAN 0 SOUND_FUSE_LOOP
						EmitSound(HR_CHAN, 0, SOUND_FUSE_LOOP);
					}
					HR_ACTIVE = 0;
				}
				else
				{
					if (param2 == "left")
					{
						if ((HL_ACTIVE))
						{
							// svplaysound: if ( HL_ACTIVE ) svplaysound HL_CHAN 0 SOUND_FUSE_LOOP
							EmitSound(HL_CHAN, 0, SOUND_FUSE_LOOP);
						}
						HL_ACTIVE = 0;
					}
					else
					{
						if (param2 == "both")
						{
							if ((HR_ACTIVE))
							{
								// svplaysound: if ( HR_ACTIVE ) svplaysound HR_CHAN 0 SOUND_FUSE_LOOP
								EmitSound(HR_CHAN, 0, SOUND_FUSE_LOOP);
							}
							if ((HL_ACTIVE))
							{
								// svplaysound: if ( HL_ACTIVE ) svplaysound HL_CHAN 0 SOUND_FUSE_LOOP
								EmitSound(HL_CHAN, 0, SOUND_FUSE_LOOP);
							}
							HR_ACTIVE = 0;
							HL_ACTIVE = 0;
						}
					}
				}
			}
		}
		string L_N_ACTIVE = (HR_ACTIVE + HL_ACTIVE);
		if (L_N_ACTIVE == 2)
		{
			SetModelBody(1, 3);
		}
		else
		{
			if ((HR_ACTIVE))
			{
				SetModelBody(1, 1);
			}
			if ((HL_ACTIVE))
			{
				SetModelBody(1, 2);
			}
			if (L_N_ACTIVE == 0)
			{
				SetModelBody(1, 0);
			}
		}
		if (CL_SCRIPT_IDX > -1)
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "set_hands", HR_ACTIVE, HL_ACTIVE);
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float L_GAME_TIME = GetGameTime();
		if (m_hAttackTarget != "unset")
		{
			if (!(SUSPEND_AI))
			{
			}
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
				if (!(NPC_IS_TURRET))
				{
				}
				if (L_GAME_TIME > NEXT_LEAP_FORWARD)
				{
				}
				NEXT_LEAP_FORWARD = L_GAME_TIME;
				LogDebug("npcatk_hunt leap forward");
				NEXT_LEAP_FORWARD += FREQ_LEAP_FORWARD;
				ROLL_DIR = 200;
				PlayAnim("critical", ANIM_JUMP);
				// PlayRandomSound from: SOUND_GIGGLE1, SOUND_GIGGLE2, SOUND_GIGGLE3, SOUND_GIGGLE4, SOUND_GIGGLE5
				array<string> sounds = {SOUND_GIGGLE1, SOUND_GIGGLE2, SOUND_GIGGLE3, SOUND_GIGGLE4, SOUND_GIGGLE5};
				EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 96)
			{
				if (!(NPC_IS_TURRET))
				{
				}
				if (L_GAME_TIME > NEXT_DODGE)
				{
				}
				NEXT_DODGE = L_GAME_TIME;
				NEXT_DODGE += FREQ_DODGE;
				LogDebug("npcatk_hunt dodge");
				ROLL_DIR = -100;
				// PlayRandomSound from: SOUND_GIGGLE1, SOUND_GIGGLE2, SOUND_GIGGLE3, SOUND_GIGGLE4, SOUND_GIGGLE5
				array<string> sounds = {SOUND_GIGGLE1, SOUND_GIGGLE2, SOUND_GIGGLE3, SOUND_GIGGLE4, SOUND_GIGGLE5};
				EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
				if (RandomInt(1, 2) == 1)
				{
					PlayAnim("critical", ANIM_DODGE);
				}
				else
				{
					PlayAnim("critical", ANIM_JUMP);
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (L_GAME_TIME > NEXT_BOMB_DRAW)
			{
				string L_N_ACTIVE = (HR_ACTIVE + HL_ACTIVE);
				if (L_N_ACTIVE < 2)
				{
				}
				NEXT_BOMB_DRAW = L_GAME_TIME;
				NEXT_BOMB_DRAW += FREQ_BOMB_DRAW;
				draw_random_bomb();
			}
		}
		if ((HR_ACTIVE))
		{
			if (L_GAME_TIME > NEXT_RBOMB_BEAM)
			{
			}
			NEXT_RBOMB_BEAM = L_GAME_TIME;
			NEXT_RBOMB_BEAM += FREQ_RBOMB_BEAM;
			Effect("beam", "follow", "lgtning.spr", GetOwner(), HR_ATTACH_IDX, 1, 4.0, 200, Vector3(255, 0, 0));
		}
		if ((HL_ACTIVE))
		{
			if (L_GAME_TIME > NEXT_LBOMB_BEAM)
			{
			}
			NEXT_LBOMB_BEAM = L_GAME_TIME;
			NEXT_LBOMB_BEAM += FREQ_LBOMB_BEAM;
			Effect("beam", "follow", "lgtning.spr", GetOwner(), HL_ATTACH_IDX, 1, 4.0, 200, Vector3(255, 0, 0));
		}
		if (CL_SCRIPT_IDX > -1)
		{
			if (L_GAME_TIME > NEXT_CL_UPDATE)
			{
			}
			ClientEvent("update", "all", CL_SCRIPT_IDX, "end_fx");
			CL_SCRIPT_IDX = -1;
			update_cl_script();
		}
	}

	void npc_bs_struck()
	{
		if (!(GetEntityRange(param1) < 128)) return;
		if (!(GetGameTime() > NEXT_DODGE)) return;
		NEXT_DODGE = GetGameTime();
		NEXT_DODGE += FREQ_DODGE;
		LogDebug("npc_bs_struck dodge");
		ROLL_DIR = -100;
		if (RandomInt(1, 2) == 1)
		{
			PlayAnim("critical", ANIM_DODGE);
		}
		else
		{
			PlayAnim("critical", ANIM_JUMP);
		}
	}

	void update_cl_script()
	{
		if (CL_SCRIPT_IDX > 0)
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "set_hands", HR_ACTIVE, HL_ACTIVE);
		}
		else
		{
			ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_CL_UPDATE, HR_ACTIVE, HL_ACTIVE);
			CL_SCRIPT_IDX = "game.script.last_sent_id";
			NEXT_CL_UPDATE = GetGameTime();
			NEXT_CL_UPDATE += FREQ_CL_UPDATE;
		}
	}

	void frame_release_r()
	{
		update_submodels("deactivate", "right");
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		string L_TARG_RANGE = GetEntityRange(m_hAttackTarget);
		string L_TARG_DIR = (L_TARG_ORG - L_MY_ORG).Normalize();
		L_TARG_DIR *= Vector3(L_TARG_RANGE, L_TARG_RANGE, L_TARG_RANGE);
		L_TARG_DIR += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 110));
		if ((L_MY_ORG).z < (L_TARG_ORG).z)
		{
			string L_VADJ = ((L_TARG_ORG).z - (L_MY_ORG).z);
			L_VADJ *= 4.0;
			L_VADJ += L_TARG_RANGE;
			L_TARG_DIR += /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, L_VADJ));
		}
		L_TARG_DIR += VEC_ENGLISH;
		SpawnNPC(PROJ_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_TARG_DIR
		VEC_ENGLISH += "z";
	}

	void frame_release_l()
	{
		update_submodels("deactivate", "left");
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		string L_TARG_RANGE = GetEntityRange(m_hAttackTarget);
		string L_TARG_DIR = (L_TARG_ORG - L_MY_ORG).Normalize();
		L_TARG_DIR *= Vector3(L_TARG_RANGE, L_TARG_RANGE, L_TARG_RANGE);
		if ((L_MY_ORG).z < (L_TARG_ORG).z)
		{
			string L_VADJ = ((L_TARG_ORG).z - (L_MY_ORG).z);
			L_VADJ *= 4.0;
			LogDebug("vadj frame_release_l L_VADJ [ ((L_TARG_ORG).z - (L_MY_ORG).z) ]");
			L_TARG_DIR += /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, L_VADJ));
		}
		L_TARG_DIR += VEC_ENGLISH;
		SpawnNPC(PROJ_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_TARG_DIR
		VEC_ENGLISH += "z";
	}

	void ext_hittarget()
	{
		VEC_ENGLISH = Vector3(0, 0, 0);
	}

	void frame_dodge()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, ROLL_DIR, 0));
	}

	void frame_dodge_up()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, ROLL_DIR, 150));
	}

	void friendly_fire()
	{
		float RND_PITCH = Random(85.00, 115.00);
		// svplaysound: svplaysound 2 10 SOUND_YELP 0.8 RND_PITCH
		EmitSound(2, 10, SOUND_YELP, 0.8, RND_PITCH);
		ROLL_DIR = 0;
		if (RandomInt(1, 2) == 1)
		{
			PlayAnim("critical", ANIM_DODGE);
		}
		else
		{
			PlayAnim("critical", ANIM_JUMP);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((DID_FAKE_DEATH)) return;
		DID_FAKE_DEATH = 1;
		EmitSound(GetOwner(), 2, SOUND_SUICIDE, 10);
		SetDamageResistance("cold", 0);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "end_fx");
		CL_SCRIPT_IDX = -1;
		update_cl_script();
		ClearFX();
		SetAlive(1);
		SetInvincible(true);
		SetHealth(1);
		npcatk_suspend_movement(ANIM_EXPLODE);
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_EXPLODE);
		ScheduleDelayedEvent(20.0, "remove_me");
	}

	void frame_explode_draw()
	{
		EmitSound(GetOwner(), 0, SOUND_FUSE_LIGHT, 10);
		update_submodels("activate", "both");
	}

	void frame_explode_land()
	{
	}

	void frame_explode_prep()
	{
	}

	void frame_explode_fin()
	{
		Effect("tempent", "gibs", "fleshgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 50, 50, 15, 20.0);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "end_fx");
		ClientEvent("new", "all", "effects/sfx_explode", GetEntityOrigin(GetOwner()), 256);
		// svplaysound: svplaysound HR_CHAN 0 SOUND_FUSE_LOOP
		EmitSound(HR_CHAN, 0, SOUND_FUSE_LOOP);
		// svplaysound: svplaysound HL_CHAN 0 SOUND_FUSE_LOOP
		EmitSound(HL_CHAN, 0, SOUND_FUSE_LOOP);
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 32), 256, DMG_SUICIDE, 0.1, GetOwner(), GetOwner(), "none", "generic", "dmgevent:suicide");
		ScheduleDelayedEvent(0.1, "remove_me");
		if ((StringToLower(GetMapName())).findFirst("rmine") == 0)
		{
			DROP_TNT = 1;
		}
		if ((DROP_TNT))
		{
			SpawnNPC("other/qitem", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: "tnt"
			float RND_YAW = Random(0, 359.99);
			SetVelocity(m_hLastCreated, /* TODO: $relvel */ $relvel(Vector3(0, RND_YAW, 0), 0, ",", 800, ",", 120));
			Effect("beam", "follow", "lgtning.spr", m_hLastCreated, 1, 1, 8.0, 200, Vector3(0, 255, 0));
		}
	}

	void set_drop_tnt()
	{
		DROP_TNT = 1;
	}

	void suicide_dodamage()
	{
		string CUR_TARGET = param2;
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
	}

	void remove_me()
	{
		if ((DID_FSUICIDE)) return;
		DID_FSUICIDE = 1;
		SetInvincible(false);
		SetEntityOrigin(GetOwner(), Vector3(20000, -20000, 20000));
		npc_suicide();
	}

}

}
