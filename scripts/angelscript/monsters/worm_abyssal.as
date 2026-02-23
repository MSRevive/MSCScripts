#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_struck.as"

namespace MS
{

class WormAbyssal : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BEAM_DEST;
	int CL_IDX;
	float CUR_HIDE_THRESH;
	int CUR_RAWR;
	string DOING_IDLE_SOUND;
	string GIBBER_ACTIVE;
	string GIBBER_COUNT;
	string GIBBER_DELAY;
	string GIBBER_DIR;
	int HIDE_IN_PROGRESS;
	int HIDE_MODE;
	int IDLE_SOUNDS_ACTIVE;
	int MAP_RMINES_KEEP_CLEAR;
	string MY_HEAD;
	string NEXT_CL_REFRESH;
	string NEXT_EYEBEAM;
	string NEXT_GIBBER;
	string NEXT_IDLE_SOUND;
	string NEXT_MULTI_SOUND;
	string NEXT_TELEPORT;
	string NEXT_UNHIDE;
	string NEXT_WORM_CALM_HIDE;
	int NO_STUCK_CHECKS;
	int NPC_FLINCH_DISABLE;
	string NPC_FLINCH_DISABLE_ONCE;
	int NPC_GIVE_EXP;
	string NPC_HBAR_ADJ;
	int NPC_IS_BOSS;
	int NPC_IS_TURRET;
	int NPC_MUST_SEE_TARGET;
	int NPC_NO_ATTACK;
	int NPC_RANGED;
	string REPEL_POINT;
	string REPEL_TARGS;
	string WORM_REPEL;
	int WORM_TELE_IDX;
	string WORM_UNHIDING;

	WormAbyssal()
	{
		NPC_IS_BOSS = 1;
		NPC_GIVE_EXP = 6000;
		ANIM_IDLE = "hide_idle";
		ANIM_WALK = "idle";
		ANIM_RUN = "idle2";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attacklow";
		NO_STUCK_CHECKS = 1;
		NPC_HBAR_ADJ = Vector3(0, 128, 200);
		ATTACK_RANGE = 628;
		ATTACK_HITRANGE = 628;
		ATTACK_MOVERANGE = 9999;
		NPC_MUST_SEE_TARGET = 0;
		NPC_RANGED = 1;
		NPC_IS_TURRET = 1;
		const string NPC_RANGE_TYPE = "range2D";
		const int NPC_NO_VADJ = 1;
		const string SOUND_DEATH = "monsters/aby_worm/death.wav";
		const string ANIM_FLINCH = "flinch1";
		const string ANIM_RISE = "rise";
		const string ANIM_LOWER = "lower";
		const string ANIM_IDLE_UP = "idle2";
		const string ANIM_FLINCH1 = "flinch1";
		const string ANIM_FLINCH2 = "flinch2";
		const string ANIM_RAWR = "scream";
		const string ANIM_HIDE = "hide_idle";
		const string ANIM_ATTACK_LONG = "attacklow";
		const string ANIM_ATTACK_SHORT = "attack";
		const string ANIM_ATTACK_STRONG = "attack_strong_close";
		const string ANIM_ATTACK_BITE_MED = "attack_bite_med";
		const string ANIM_ATTACK_MULTI = "attack_multi_close";
		const string ANIM_ATTACK_BITE_CLOSE = "attack_bite_close";
		const string ANIM_BEAM = "eyeblast";
		const int ATTACH_EYE = 0;
		const int ATTACH_CLAW = 2;
		HIDE_MODE = 1;
		const float FREQ_TELEPORT = 60.0;
		const string FREQ_EYEBEAM = Random(30.0, 60.0);
		CUR_HIDE_THRESH = 0.75;
		array<string> ARRAY_WORM_TELES;
		ARRAY_WORM_TELES.insertLast("worm_telepoint1");
		ARRAY_WORM_TELES.insertLast("worm_telepoint2");
		ARRAY_WORM_TELES.insertLast("worm_telepoint3");
		ARRAY_WORM_TELES.insertLast("worm_telepoint4");
		WORM_TELE_IDX = 1;
		const int DMG_CLAW = 100;
		const int DMG_STRONG = 200;
		const int DMG_BITE = 300;
		const int DMG_MULTI = 250;
		const int DOT_DMG = 30;
		const string DOT_EFFECT_SCRIPT = "effects/dot_dark";
		const int AOE_CLAW = 200;
		const int AOE_STRONG = 128;
		const int AOE_BEAM = 256;
		CL_IDX = -1;
		const string CL_SCRIPT = "monsters/worm_abyssal_cl";
		const float FREQ_CL_REFRESH = 30.0;
		const string SOUND_RAWR1 = "gonarch/gon_alert1.wav";
		const string SOUND_RAWR2 = "gonarch/gon_alert2.wav";
		const string SOUND_RAWR3 = "gonarch/gon_alert3.wav";
		CUR_RAWR = 0;
		const string SOUND_MULTI = "monsters/aby_worm/multi_attack.wav";
		const string SOUND_BITE = "monsters/aby_worm/bite.wav";
		const string SOUND_BEAM_CHARGE = "monsters/aby_worm/beam_charge.wav";
		const string SOUND_BEAM_FIRE = "monsters/aby_worm/beam_fire.wav";
		const string SOUND_GIBBER1 = "monsters/aby_worm/gibber1.wav";
		const string SOUND_GIBBER2 = "monsters/aby_worm/gibber2.wav";
		const string SOUND_IDLE1 = "bullchicken/bc_idle1.wav";
		const string SOUND_IDLE2 = "bullchicken/bc_idle2.wav";
		const string SOUND_IDLE3 = "bullchicken/bc_idle3.wav";
		const string SOUND_IDLE4 = "bullchicken/bc_idle4.wav";
		const string SOUND_IDLE5 = "bullchicken/bc_idle5.wav";
		const string FREQ_IDLE_SOUND = Random(5.0, 10.0);
		const string NPC_MATERIAL_TYPE = "carapace";
		const int NPC_USE_PAIN = 1;
		const int NPC_USE_FLINCH = 1;
		const string SOUND_PAIN1 = "gonarch/gon_pain2.wav";
		const string SOUND_PAIN2 = "gonarch/gon_pain4.wav";
		const string SOUND_PAIN3 = "gonarch/gon_pain5.wav";
		const string SOUND_FLINCH1 = "gonarch/gon_childdie1.wav";
		const string SOUND_FLINCH2 = "gonarch/gon_childdie2.wav";
		const string SOUND_FLINCH3 = "gonarch/gon_childdie3.wav";
		const string NPC_PITCH_PAIN = RandomInt(75, 90);
		const string NPC_PITCH_FLINCH = RandomInt(75, 90);
		const int NPC_STRUCK_CHANNEL = 0;
		const string NPC_STRUCK_SOUND_EVENT = "do_playsound";
	}

	void game_precache()
	{
		Precache("monsters/abyssal_worm_hitbox.mdl");
		Precache("monsters/zubat_sphere.mdl");
		Precache("3dmflagry.spr");
		Precache(CL_SCRIPT);
	}

	void OnSpawn() override
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		worm_spawn();
	}

	void worm_spawn()
	{
		SetName("Abyssal Worm");
		SetName("aby_worm");
		SetModel("monsters/abyssal_worm.mdl");
		SetWidth(128);
		SetHeight(700);
		SetSolid("trigger");
		SetRace("demon");
		SetHealth(8000);
		SetDamageResistance("holy", 1.5);
		SetHearingSensitivity(11);
		npcatk_suspend_ai();
		SetInvincible(true);
	}

	void OnPostSpawn() override
	{
		as_tele_stuck_check();
		SpawnNPC("monsters/worm_abyssal_head", GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		MY_HEAD = m_hLastCreated;
		if (!(StringToLower(GetMapName()) == "undermines")) return;
		MAP_RMINES_KEEP_CLEAR = 1;
	}

	void dinner_bell()
	{
		NEXT_WORM_CALM_HIDE = GetGameTime();
		NEXT_WORM_CALM_HIDE += 15.0;
		if ((HIDE_IN_PROGRESS)) return;
		if ((HIDE_MODE))
		{
			LogDebug("dinner_bell GetEntityName(param1) game.time vs. NEXT_UNHIDE");
			if (GetGameTime() > NEXT_UNHIDE)
			{
			}
			NEXT_EYEBEAM = GetGameTime();
			NEXT_EYEBEAM += FREQ_EYEBEAM;
			HIDE_MODE = 0;
			WORM_UNHIDING = 1;
			PlayAnim("critical", ANIM_RISE);
			if ((FINAL_TELEPORT))
			{
				ScheduleDelayedEvent(0.5, "brk_wall");
			}
		}
		else
		{
			worm_find_target();
		}
	}

	void brk_wall()
	{
		UseTrigger("brk_worm");
	}

	void frame_rise_done()
	{
		SetInvincible(false);
		NPC_NO_ATTACK = 0;
		refresh_cl();
		ANIM_IDLE = ANIM_IDLE_UP;
		SetIdleAnim(ANIM_IDLE_UP);
		SetMoveAnim(ANIM_IDLE_UP);
		ANIM_RUN = ANIM_IDLE_UP;
		ANIM_WALK = ANIM_IDLE_UP;
		ANIM_IDLE = ANIM_IDLE_UP;
		npcatk_resume_ai();
		PlayAnim("critical", ANIM_RAWR);
		worm_find_target();
		NEXT_TELEPORT = GetGameTime();
		NEXT_TELEPORT += FREQ_TELEPORT;
		IDLE_SOUNDS_ACTIVE = 1;
		NEXT_IDLE_SOUND = GetGameTime();
		NEXT_IDLE_SOUND += FREQ_IDLE_SOUND;
		WORM_UNHIDING = 0;
		Effect("screenshake", GetEntityOrigin(MY_HEAD), 400, 10, 3, 1024);
		CUR_RAWR += 1;
		if (CUR_RAWR == 1)
		{
			do_playsound(0, 10, SOUND_RAWR1, 0.8, RandomInt(30, 60));
		}
		if (CUR_RAWR == 2)
		{
			do_playsound(0, 10, SOUND_RAWR2, 0.8, RandomInt(30, 60));
		}
		if (CUR_RAWR == 3)
		{
			do_playsound(0, 10, SOUND_RAWR3, 0.8, RandomInt(30, 60));
			CUR_RAWR = 0;
		}
	}

	void worm_find_target()
	{
		string L_TARGS = FindEntitiesInSphere("enemy", 1024);
		if (!(L_TARGS != "none")) return;
		string L_TARGS = /* TODO: $sort_entlist */ $sort_entlist(L_TARGS, "range");
		npcatk_settarget(GetToken(L_TARGS, 0, ";"));
	}

	void game_applyeffect()
	{
		LogDebug("game_applyeffect PARAM3");
		if ((HIDE_MODE))
		{
			ReturnData("abort");
		}
		if ((param3).findFirst("freeze_solid") >= 0)
		{
			if ((IsValidPlayer(param5)))
			{
				SendColoredMessage(param5, "GetEntityProperty(GetOwner(), "name.full") is too large to be encased in ice.");
			}
			ReturnData("abort");
		}
	}

	void OnDamage(int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((HIDE_MODE))
		{
			SetDamage("hit");
			SetDamage("dmg");
			ReturnData(0);
		}
		if (m_hAttackTarget == "unset")
		{
			npcatk_settarget(GetEntityIndex(param1));
		}
		else
		{
			if (!(IsValidPlayer(m_hAttackTarget)))
			{
				npcatk_settarget(GetEntityIndex(param1));
			}
			if (GetEntityRange(m_hAttackTarget) > GetEntityRange(param1))
			{
				npcatk_settarget(GetEntityIndex(param1));
			}
		}
		if ((param3).findFirst("dark") >= 0)
		{
			SetDamage("dmg");
			ReturnData(0);
			string L_HEAL_AMT = param2;
			L_HEAL_AMT *= 2;
			HealEntity(GetOwner(), L_HEAL_AMT);
			if (GetGameTime() > NEXT_GLOW)
			{
				NEXT_GLOW = GetGameTime();
				NEXT_GLOW += 5.0;
				Effect("glow", GetOwner(), Vector3(0, 255, 0), 30, 5.0, 5.0);
			}
			return;
		}
		if ((FINAL_TELEPORT)) return;
		string L_NEXT_HIDE_THRESH = GetEntityMaxHealth(GetOwner());
		L_NEXT_HIDE_THRESH *= CUR_HIDE_THRESH;
		string L_CUR_HP = GetEntityHealth(GetOwner());
		L_CUR_HP -= param2;
		if (L_CUR_HP <= L_NEXT_HIDE_THRESH)
		{
			string L_NEW_HP = L_NEXT_HIDE_THRESH;
			L_NEW_HP -= 1;
			SetHealth(L_NEW_HP);
			SetDamage(0);
			ReturnData(0);
			LogDebug("game_damaged body cur L_CUR_HP hide@ L_NEXT_HIDE_THRESH thrsh CUR_HIDE_THRESH newhp L_NEW_HP");
			if (CUR_HIDE_THRESH == 0.75)
			{
				if ((DID_HIDE_STAGE1))
				{
				}
				return;
			}
			if (CUR_HIDE_THRESH == 0.5)
			{
				if ((DID_HIDE_STAGE2))
				{
				}
				return;
			}
			if (CUR_HIDE_THRESH == 0.25)
			{
				if ((DID_HIDE_STAGE3))
				{
				}
				return;
			}
			if (CUR_HIDE_THRESH == 0.75)
			{
				DID_HIDE_STAGE1 = 1;
			}
			else
			{
				if (CUR_HIDE_THRESH == 0.50)
				{
					DID_HIDE_STAGE2 = 1;
				}
				else
				{
					if (CUR_HIDE_THRESH == 0.25)
					{
						DID_HIDE_STAGE3 = 1;
					}
				}
			}
			CUR_HIDE_THRESH -= 0.25;
			if (CUR_HIDE_THRESH <= 0)
			{
				FINAL_TELEPORT = 1;
			}
			do_teleport();
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			refresh_cl();
		}
		if ((IDLE_SOUNDS_ACTIVE))
		{
			if (GetGameTime() > NEXT_IDLE_SOUND)
			{
			}
			NEXT_IDLE_SOUND = GetGameTime();
			DOING_IDLE_SOUND = 1;
			NEXT_IDLE_SOUND += FREQ_IDLE_SOUND;
			string L_RND_IDLE = RandomInt(1, 5);
			if (L_RND_IDLE == 1)
			{
				do_playsound(0, 10, SOUND_IDLE1, 0.8, Random(50, 70));
			}
			else
			{
				if (L_RND_IDLE == 2)
				{
					do_playsound(0, 10, SOUND_IDLE2, 0.8, Random(50, 70));
				}
				else
				{
					if (L_RND_IDLE == 3)
					{
						do_playsound(0, 10, SOUND_IDLE3, 0.8, Random(50, 70));
					}
					else
					{
						if (L_RND_IDLE == 4)
						{
							do_playsound(0, 10, SOUND_IDLE4, 0.8, Random(50, 70));
						}
						else
						{
							if (L_RND_IDLE == 5)
							{
								do_playsound(0, 10, SOUND_IDLE5, 0.8, Random(50, 70));
							}
						}
					}
				}
			}
		}
		if (!(FINAL_TELEPORT))
		{
			if (!(HIDE_MODE))
			{
			}
			if (GetGameTime() > NEXT_WORM_CALM_HIDE)
			{
			}
			NEXT_TELEPORT = GetGameTime();
			NEXT_TELEPORT += FREQ_TELEPORT;
			do_teleport();
		}
		if ((WORM_REPEL))
		{
			REPEL_TARGS = FindEntitiesInSphere("any", 128);
			if (REPEL_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(REPEL_TARGS, ";"); i++)
			{
				repel_targets();
			}
		}
		if (GetGameTime() > NEXT_GIBBER)
		{
			NEXT_GIBBER = GetGameTime();
			NEXT_GIBBER += Random(10.0, 20.0);
			GIBBER_ACTIVE = 1;
			GIBBER_COUNT = 0;
			GIBBER_DELAY = 0.01;
			if (RandomInt(1, 2) == 1)
			{
				do_playsound(2, 10, SOUND_GIBBER1, 0.8, RandomInt(75, 125));
			}
			else
			{
				do_playsound(2, 10, SOUND_GIBBER2, 0.8, RandomInt(75, 125));
			}
			do_gibber();
			ScheduleDelayedEvent(5.0, "end_gibber");
		}
		if ((SUSPEND_AI)) return;
		if (!(FINAL_TELEPORT))
		{
			if (GetGameTime() > NEXT_TELEPORT)
			{
			}
			NEXT_TELEPORT = GetGameTime();
			NEXT_TELEPORT += FREQ_TELEPORT;
			do_teleport();
		}
		if (!(m_hAttackTarget != "unset")) return;
		SetMoveDest(m_hAttackTarget);
		if (GetEntityProperty(m_hAttackTarget, "range2d") > ATTACK_RANGE)
		{
			NEXT_EYEBEAM -= 1.0;
		}
		if (GetGameTime() > NEXT_EYEBEAM)
		{
			if (GetEntityProperty(m_hAttackTarget, "range2d") < 1024)
			{
			}
			NEXT_TELEPORT = GetGameTime();
			NEXT_TELEPORT += FREQ_TELEPORT;
			do_eyebeam();
		}
	}

	void refresh_cl()
	{
		if (CL_IDX > -1)
		{
			ClientEvent("update", "all", CL_IDX, "end_fx");
		}
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_CL_REFRESH);
		CL_IDX = "game.script.last_sent_id";
		NEXT_CL_REFRESH = GetGameTime();
		NEXT_CL_REFRESH += FREQ_CL_REFRESH;
		if (!(MAP_RMINES_KEEP_CLEAR)) return;
		CallExternal("all", "ext_rmines_clear");
	}

	void OnFlinch()
	{
		if ((HIDE_MODE))
		{
			NPC_FLINCH_DISABLE_ONCE = 1;
			return;
		}
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
		if (RandomInt(1, 2) == 1)
		{
			ANIM_FLINCH = ANIM_FLINCH1;
		}
		else
		{
			ANIM_FLINCH = ANIM_FLINCH2;
		}
	}

	void do_eyebeam()
	{
		NEXT_EYEBEAM = GetGameTime();
		NEXT_EYEBEAM += FREQ_EYEBEAM;
		BEAM_DEST = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai();
		}
		PlayAnim("critical", ANIM_BEAM);
		refresh_cl();
	}

	void frame_beam_charge()
	{
		do_playsound(0, 10, SOUND_BEAM_CHARGE);
		ClientEvent("update", "all", CL_IDX, "beam_charge", BEAM_DEST);
	}

	void frame_beam_fire()
	{
		npcatk_resume_ai();
		do_playsound(0, 10, SOUND_BEAM_FIRE);
		ClientEvent("update", "all", CL_IDX, "beam_fire", BEAM_DEST);
		XDoDamage(BEAM_DEST, AOE_BEAM, DMG_BEAM, 0.01, GetOwner(), GetOwner(), "none", "dark_effect", "dmgevent:beam");
	}

	void beam_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, DOT_EFFECT_SCRIPT, 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		ApplyEffect(param2, "effects/effect_stun", 8.0, 0, 1, GetEntityIndex(GetOwner()));
	}

	void npc_selectattack()
	{
		string L_RANGE = GetEntityProperty(m_hAttackTarget, "range2d");
		string L_POSSIBLE_ATTACKS = "";
		if (L_RANGE > 500)
		{
			if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
			L_POSSIBLE_ATTACKS += ANIM_ATTACK_LONG;
		}
		if (L_RANGE < 500)
		{
			if (L_RANGE > 350)
			{
				if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
				L_POSSIBLE_ATTACKS += ANIM_ATTACK_SHORT;
			}
		}
		if (L_RANGE < 425)
		{
			if (L_RANGE > 230)
			{
				if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
				L_POSSIBLE_ATTACKS += ANIM_ATTACK_STRONG;
			}
			if (L_RANGE > 250)
			{
				if (L_RANGE < 325)
				{
				}
				if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
				L_POSSIBLE_ATTACKS += ANIM_ATTACK_BITE_MED;
			}
			if (L_RANGE < 280)
			{
				if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
				L_POSSIBLE_ATTACKS += ANIM_ATTACK_MULTI;
			}
			if (L_RANGE < 250)
			{
				if (L_POSSIBLE_ATTACKS.length() > 0) L_POSSIBLE_ATTACKS += ";";
				L_POSSIBLE_ATTACKS += ANIM_ATTACK_BITE_CLOSE;
			}
		}
		string L_NPATKS = GetTokenCount(L_POSSIBLE_ATTACKS, ";");
		L_NPATKS -= 1;
		string L_RND_ATTACK = RandomInt(0, L_NPATKS);
		ANIM_ATTACK = GetToken(L_POSSIBLE_ATTACKS, L_RND_ATTACK, ";");
	}

	void repel_targets()
	{
		string CUR_TARG = GetToken(REPEL_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 500, 0)));
	}

	void frame_claw()
	{
		npcatk_suspend_attack(2.0);
		string L_ATTACK_POS = GetEntityProperty(GetOwner(), "attachpos");
		string L_MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		L_ATTACK_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_YAW, 0), Vector3(0, 64, 0));
		L_ATTACK_POS = "z";
		L_ATTACK_POS += "z";
		LogDebug("frame_claw L_ATTACK_POS");
		ClientEvent("update", "all", CL_IDX, "dark_burst", L_ATTACK_POS, AOE_CLAW);
		XDoDamage(L_ATTACK_POS, AOE_CLAW, DMG_CLAW, 0.01, GetOwner(), GetOwner(), "none", "dark", "dmgevent:burst");
	}

	void frame_strong()
	{
		npcatk_suspend_attack(2.0);
		string L_ATTACK_POS = GetEntityProperty(GetOwner(), "attachpos");
		string L_MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		L_ATTACK_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_YAW, 0), Vector3(0, 64, 0));
		L_ATTACK_POS = "z";
		L_ATTACK_POS += "z";
		LogDebug("frame_strong L_ATTACK_POS");
		ClientEvent("update", "all", CL_IDX, "dark_burst", L_ATTACK_POS, AOE_STRONG);
		XDoDamage(L_ATTACK_POS, AOE_STRONG, DMG_STRONG, 0.01, GetOwner(), GetOwner(), "none", "dark", "dmgevent:burst");
	}

	void burst_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, DOT_EFFECT_SCRIPT, 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void frame_maw0()
	{
		set_maw(0);
	}

	void frame_maw1()
	{
		set_maw(1);
	}

	void frame_maw2()
	{
		set_maw(2);
	}

	void frame_bite()
	{
		set_maw(3);
		do_playsound(0, 10, SOUND_BITE);
		XDoDamage(GetEntityProperty(GetOwner(), "attachpos"), GetEntityOrigin(m_hAttackTarget), DMG_BITE, 90, GetOwner(), GetOwner(), "none", "slash");
	}

	void frame_multi()
	{
		XDoDamage(GetEntityProperty(GetOwner(), "attachpos"), GetEntityOrigin(m_hAttackTarget), DMG_MULTI, 80, GetOwner(), GetOwner(), "none", "pierce");
		if (!(GetGameTime() > NEXT_MULTI_SOUND)) return;
		NEXT_MULTI_SOUND = GetGameTime();
		NEXT_MULTI_SOUND += 10.0;
		do_playsound(1, 10, SOUND_MULTI, 0.8, RandomInt(90, 110));
	}

	void frame_gibber_start()
	{
		GIBBER_ACTIVE = 1;
		GIBBER_COUNT = 0;
		GIBBER_DELAY = 0.01;
		NEXT_GIBBER = GetGameTime();
		NEXT_GIBBER += Random(10.0, 15.0);
		do_gibber();
	}

	void frame_gibber_end()
	{
		SetProp(GetOwner(), "skin", 0);
		GIBBER_ACTIVE = 0;
	}

	void set_maw()
	{
		GIBBER_ACTIVE = 0;
		NEXT_GIBBER = GetGameTime();
		NEXT_GIBBER += Random(5.0, 10.0);
		SetProp(GetOwner(), "skin", param1);
	}

	void do_gibber()
	{
		if (!(GIBBER_ACTIVE)) return;
		if (GIBBER_COUNT == 0)
		{
			GIBBER_DIR = 1;
		}
		if (GIBBER_COUNT == 3)
		{
			GIBBER_DIR = -1;
		}
		GIBBER_COUNT += GIBBER_DIR;
		SetProp(GetOwner(), "skin", GIBBER_COUNT);
		GIBBER_DELAY("do_gibber");
		GIBBER_DELAY += 0.01;
	}

	void end_gibber()
	{
		SetProp(GetOwner(), "skin", 0);
		GIBBER_ACTIVE = 0;
	}

	void check_porters()
	{
		string L_PORTER = FindEntityByName("telepoint_abyssal4");
		LogDebug("check_porters L_PORTER GetEntityOrigin(L_PORTER) GetEntityAngles(L_PORTER)");
		string L_START = GetEntityOrigin(GetOwner());
		string L_END = L_START;
		L_END += "z";
		Effect("beam", "point", "lgtning.spr", 30, L_START, L_END, Vector3(255, 0, 255), 200, 0, 120.0);
		string L_OFS = /* TODO: $math(divide) */ GetEntityWidth(GetOwner());
		string L_NEG_OFS = /* TODO: $neg */ $neg(/* TODO: $math(divide) */ GetEntityWidth(GetOwner()));
		LogDebug("check_porters ofs Vector3(L_NEG_OFS, L_NEG_OFS, 0) - Vector3(L_OFS, L_OFS, 0)");
		string L_START = GetEntityOrigin(GetOwner());
		L_START += Vector3(L_OFS, L_OFS, 0);
		string L_END = L_START;
		L_END += "z";
		Effect("beam", "point", "lgtning.spr", 5, L_START, L_END, Vector3(255, 255, 0), 200, 0, 120.0);
		string L_START = GetEntityOrigin(GetOwner());
		L_START += Vector3(L_NEG_OFS, L_NEG_OFS, 0);
		string L_END = L_START;
		L_END += "z";
		Effect("beam", "point", "lgtning.spr", 5, L_START, L_END, Vector3(255, 255, 0), 200, 0, 120.0);
		string L_START = GetEntityOrigin(GetOwner());
		L_START += Vector3(L_NEG_OFS, L_OFS, 0);
		string L_END = L_START;
		L_END += "z";
		Effect("beam", "point", "lgtning.spr", 5, L_START, L_END, Vector3(255, 255, 0), 200, 0, 120.0);
		string L_START = GetEntityOrigin(GetOwner());
		L_START += Vector3(L_OFS, L_NEG_OFS, 0);
		string L_END = L_START;
		L_END += "z";
		Effect("beam", "point", "lgtning.spr", 5, L_START, L_END, Vector3(255, 255, 0), 200, 0, 120.0);
	}

	void do_teleport()
	{
		ClearFX();
		npcatk_suspend_ai();
		HIDE_MODE = 1;
		HIDE_IN_PROGRESS = 1;
		SetMoveAnim(ANIM_LOWER);
		SetIdleAnim(ANIM_LOWER);
		ANIM_RUN = ANIM_LOWER;
		ANIM_WALK = ANIM_LOWER;
		ANIM_IDLE = ANIM_LOWER;
		SetInvincible(true);
		NEXT_UNHIDE = GetGameTime();
		NEXT_UNHIDE += 5.0;
		PlayAnim("critical", ANIM_LOWER);
		NEXT_TELEPORT = GetGameTime();
		NEXT_TELEPORT += FREQ_TELEPORT;
		string L_RND_SOUND = RandomInt(1, 3);
		if (L_RND_SOUND == 1)
		{
			do_playsound(0, 10, SOUND_FLINCH1, 0.8, Random(40, 60));
		}
		else
		{
			if (L_RND_SOUND == 2)
			{
				do_playsound(0, 10, SOUND_FLINCH2, 0.8, Random(40, 60));
			}
			else
			{
				if (L_RND_SOUND == 3)
				{
					do_playsound(0, 10, SOUND_FLINCH3, 0.8, Random(40, 60));
				}
			}
		}
	}

	void frame_lower_done()
	{
		HIDE_IN_PROGRESS = 0;
		SetMoveAnim(ANIM_HIDE);
		SetIdleAnim(ANIM_HIDE);
		ANIM_RUN = ANIM_HIDE;
		ANIM_WALK = ANIM_HIDE;
		ANIM_IDLE = ANIM_HIDE;
		NPC_NO_ATTACK = 1;
		if (!(FINAL_TELEPORT))
		{
			string L_TELE_NAME = /* TODO: $get_array */ $get_array(ARRAY_WORM_TELES, WORM_TELE_IDX);
		}
		else
		{
			string L_TELE_NAME = "worm_telepoint_final";
			UseTrigger("light_worm");
			string L_REPEL_POINT = FindEntityByName("worm_repel_point");
			REPEL_POINT = GetEntityOrigin(L_REPEL_POINT);
			WORM_REPEL = 1;
		}
		string L_TELE_ID = FindEntityByName(L_TELE_NAME);
		SetEntityOrigin(GetOwner(), GetEntityOrigin(L_TELE_ID));
		string L_TELE_YAW = GetEntityProperty(L_TELE_ID, "angles.yaw");
		SetAngles("face");
		WORM_TELE_IDX += 1;
		string L_NTELES = /* TODO: $get_array_amt */ $get_array_amt(ARRAY_WORM_TELES);
		L_NTELES -= 1;
		if (WORM_TELE_IDX > L_NTELES)
		{
			WORM_TELE_IDX = 0;
		}
	}

	void OnSuspendAI()
	{
		NPC_FLINCH_DISABLE = 1;
	}

	void npcatk_resume_ai()
	{
		NPC_FLINCH_DISABLE = 0;
	}

	void do_playsound()
	{
		if (!(DOING_IDLE_SOUND))
		{
			string L_NEXT_IDLE = NEXT_IDLE_SOUND;
			L_NEXT_IDLE -= GetGameTime();
			if (L_NEXT_IDLE < 3)
			{
				NEXT_IDLE_SOUND += Random(2.0, 4.0);
			}
		}
		DOING_IDLE_SOUND = 0;
		string L_PASS1 = param1;
		string L_PASS2 = param2;
		string L_PASS3 = param3;
		if ("game.event.params" > 3)
		{
			string L_PASS4 = param4;
		}
		if ("game.event.params" > 4)
		{
			string L_PASS5 = param5;
		}
		if ("game.event.params" > 3)
		{
			CallExternal(MY_HEAD, "ext_playsound", L_PASS1, L_PASS2, L_PASS3, L_PASS4, L_PASS5);
		}
		else
		{
			CallExternal(MY_HEAD, "ext_playsound", L_PASS1, L_PASS2, L_PASS3);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "gm_suspend_mob_spawns", 0);
		ClientEvent("update", "all", CL_IDX, "end_fx");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(G_LESSER_DEV_MODE)) return;
		SetDamage("dmg");
		ReturnData(0.01);
	}

}

}
