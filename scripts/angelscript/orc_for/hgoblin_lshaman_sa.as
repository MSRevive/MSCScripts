#pragma context server

#include "orc_for/goblin_base.as"

namespace MS
{

class HgoblinLshamanSa : CGameScript
{
	int AIMING_CAGE;
	string ANIM_AIM;
	string ANIM_ATTACK;
	string ANIM_CAGE_SUSTAIN;
	int AOE_ZAP;
	int ATTACH_HAND;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string CAGE_TARGET;
	string CL_IDX_ZAP_AURA;
	string CL_SCRIPT;
	string CL_SCRIPT_IDX;
	string CUR_BEAM;
	string DID_INIT;
	string DID_WARN;
	int DMG_AXE;
	int DMG_CLUB;
	int DMG_SWORD;
	float DMG_ZAP;
	string DOING_REPEL;
	int DOT_CAGE;
	float DUR_ZAP;
	float FREQ_CAGE;
	float FREQ_FX_REFRESH;
	float FREQ_REPEL;
	int GOB_CHARGER;
	int GOB_JUMPER;
	int MOVE_RANGE;
	string NEXT_CAGE;
	string NEXT_CL_REFRESH;
	string NEXT_REPEL;
	string NEXT_UPDATE_LOOP_SOUND;
	string NPC_ADJ_DMG_MUTLI_TOKENS;
	string NPC_ADJ_HP_MUTLI_TOKENS;
	string NPC_ADJ_TIERS;
	int NPC_BASE_EXP;
	int NPC_SELF_ADJUST;
	string SOUND_BEAM_LOOP;
	string SOUND_BEAM_START;
	string SOUND_CAGE_PREP;
	string SOUND_GIGGLE;
	string SUSTAINING_CAGE;
	int SWIPE_ATTACK;
	string ZAP_TARGS;

	HgoblinLshamanSa()
	{
		ANIM_AIM = "zap_aim";
		ANIM_CAGE_SUSTAIN = "zap_cycle";
		ANIM_ATTACK = "swordswing1_L";
		NPC_SELF_ADJUST = 1;
		NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;10.0;";
		NPC_ADJ_HP_MUTLI_TOKENS = "1.0;2.0;3.0;5.0;7.5;10.0;";
		NPC_BASE_EXP = 300;
		DMG_CLUB = 20;
		DMG_AXE = 30;
		DMG_SWORD = 15;
		GOB_JUMPER = 0;
		GOB_CHARGER = 0;
		FREQ_CAGE = 30.0;
		DOT_CAGE = 60;
		FREQ_REPEL = Random(30.0, 40.0);
		ATTACK_HITCHANCE = 0.9;
		AOE_ZAP = 128;
		DUR_ZAP = 10.0;
		DMG_ZAP = 40.0;
		ATTACH_HAND = 0;
		CL_SCRIPT = "monsters/djinn_lightning_lesser_cl";
		FREQ_FX_REFRESH = 15.0;
		SOUND_BEAM_START = "magic/bolt_start.wav";
		SOUND_BEAM_LOOP = "magic/bolt_loop.wav";
		SOUND_CAGE_PREP = "magic/lightning_powerup.wav";
		SOUND_GIGGLE = "monsters/goblin/c_goblinwiz_bat1.wav";
	}

	void goblin_spawn()
	{
		SetName("Hobgoblin Lightning Shaman");
		SetModel("monsters/goblin_new.mdl");
		SetHealth(400);
		SetWidth(24);
		SetHeight(50);
		SetRace("goblin");
		SetBloodType("green");
		SetRoam(true);
		SetHearingSensitivity(2);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetProp(GetOwner(), "skin", 4);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("acid", 2.0);
		SetDamageResistance("poison", 1.25);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void goblin_pre_spawn()
	{
		ATTACK_RANGE = 128;
		ATTACK_HITRANGE = 256;
		ATTACK_MOVERANGE = 96;
		MOVE_RANGE = 96;
	}

	void npc_targetsighted()
	{
		if (!(DID_INIT))
		{
			DID_INIT = 1;
			NEXT_REPEL = GetGameTime();
			NEXT_REPEL += FREQ_REPEL;
			NEXT_CAGE = GetGameTime();
			NEXT_CAGE += 10.0;
		}
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			if (CL_SCRIPT_IDX != "CL_SCRIPT_IDX")
			{
				ClientEvent("update", "all", CL_SCRIPT_IDX, "remove_fx");
			}
			ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_FX_REFRESH);
			CL_SCRIPT_IDX = "game.script.last_sent_id";
			NEXT_CL_REFRESH = GetGameTime();
			NEXT_CL_REFRESH += FREQ_FX_REFRESH;
		}
		if ((AIMING_CAGE)) return;
		if ((SUSTAINING_CAGE)) return;
		if ((DOING_REPEL)) return;
		if (GetGameTime() > NEXT_REPEL)
		{
			if ((IsEntityAlive(m_hLastStruck)))
			{
				if (GetEntityRange(m_hLastStruck) < 128)
				{
					int WILL_DO_REPEL = 1;
				}
			}
			if (GetEntityRange(m_hAttackTarget) < 128)
			{
				int WILL_DO_REPEL = 1;
			}
			if ((WILL_DO_REPEL))
			{
			}
			NEXT_REPEL = GetGameTime();
			NEXT_REPEL += FREQ_REPEL;
			DOING_REPEL = 1;
			do_repel();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_CAGE)) return;
		NEXT_CAGE = GetGameTime();
		NEXT_CAGE += FREQ_CAGE;
		CAGE_TARGET = m_hAttackTarget;
		AIMING_CAGE = 1;
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_AIM);
		tracking_loop();
		ScheduleDelayedEvent(3.0, "do_cage");
		EmitSound(GetOwner(), 2, SOUND_CAGE_PREP, 10);
		EmitSound(GetOwner(), 1, SOUND_GIGGLE, 10);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "hand_powerup", 0);
		if (!(DID_WARN))
		{
			DID_WARN = 1;
			SendInfoMsg(CAGE_TARGET, "Goblin Lightning Shaman Beware, if the shaman traps you in a force cage, you'll have to be rescued!");
		}
	}

	void tracking_loop()
	{
		if (!(AIMING_CAGE)) return;
		SetMoveDest(CAGE_TARGET);
		ScheduleDelayedEvent(0.1, "tracking_loop");
	}

	void do_cage()
	{
		if ((GetEntityProperty(CAGE_TARGET, "scriptvar")))
		{
			AIMING_CAGE = 0;
			NEXT_CAGE = GetGameTime();
			NEXT_CAGE += 10.0;
			npcatk_resume_ai();
			npcatk_resume_movement();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			AIMING_CAGE = 0;
			SUSTAINING_CAGE = 1;
			do_cage2();
		}
		else
		{
			AIMING_CAGE = 0;
			NEXT_CAGE = GetGameTime();
			NEXT_CAGE += 10.0;
			npcatk_resume_ai();
			npcatk_resume_movement();
		}
	}

	void do_cage2()
	{
		// svplaysound: svplaysound 2 10 SOUND_BEAM_LOOP
		EmitSound(2, 10, SOUND_BEAM_LOOP);
		NEXT_UPDATE_LOOP_SOUND = GetGameTime();
		NEXT_UPDATE_LOOP_SOUND += 10.0;
		ApplyEffect(CAGE_TARGET, "effects/dot_lightning_cage", 0, GetEntityIndex(GetOwner()), DOT_CAGE);
		SendInfoMsg("all", GetEntityName(CAGE_TARGET) + " Has been trapped by a Lightning Shaman!");
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, CAGE_TARGET, 0, Vector3(255, 255, 0), 200, 20, -1);
		CUR_BEAM = GetEntityIndex(m_hLastCreated);
		npcatk_resume_movement();
		npcatk_suspend_movement(ANIM_CAGE_SUSTAIN);
		PlayAnim("critical", ANIM_CAGE_SUSTAIN);
		sustain_cage();
	}

	void sustain_cage()
	{
		if (!(GetEntityProperty(CAGE_TARGET, "haseffect")))
		{
			ext_end_cage();
			return;
		}
		PlayAnim("once", ANIM_CAGE_SUSTAIN);
		ScheduleDelayedEvent(1.0, "sustain_cage");
		if (!(GetGameTime() > NEXT_UPDATE_LOOP_SOUND)) return;
		NEXT_UPDATE_LOOP_SOUND = GetGameTime();
		NEXT_UPDATE_LOOP_SOUND += 10.0;
		// svplaysound: svplaysound 2 10 SOUND_BEAM_LOOP
		EmitSound(2, 10, SOUND_BEAM_LOOP);
	}

	void ext_end_cage()
	{
		// svplaysound: svplaysound 2 0 SOUND_BEAM_LOOP
		EmitSound(2, 0, SOUND_BEAM_LOOP);
		SUSTAINING_CAGE = 0;
		Effect("beam", "update", CUR_BEAM, "remove", 0.1);
		npcatk_resume_movement();
		npcatk_resume_ai();
		NEXT_CAGE = GetGameTime();
		NEXT_CAGE += FREQ_CAGE;
		leap_forward();
	}

	void do_repel()
	{
		// svplaysound: svplaysound 2 10 SOUND_BEAM_LOOP
		EmitSound(2, 10, SOUND_BEAM_LOOP);
		EmitSound(GetOwner(), 1, SOUND_BEAM_START, 10);
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_WARCRY);
		string ZAP_AURA_ORG = GetEntityOrigin(GetOwner());
		ZAP_AURA_ORG += "z";
		ClientEvent("new", "all", "effects/sfx_zap_aura", GetEntityIndex(GetOwner()), AOE_ZAP, DUR_ZAP);
		CL_IDX_ZAP_AURA = "game.script.last_sent_id";
		do_repel_loop();
		DUR_ZAP("end_repel");
	}

	void do_repel_loop()
	{
		if (!(DOING_REPEL)) return;
		PlayAnim("once", ANIM_WARCRY);
		ScheduleDelayedEvent(0.25, "do_repel_loop");
		ZAP_TARGS = FindEntitiesInSphere("enemy", AOE_ZAP);
		if (!(ZAP_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(ZAP_TARGS, ";"); i++)
		{
			repel_affect_targets();
		}
	}

	void repel_affect_targets()
	{
		string CUR_TARG = GetToken(ZAP_TARGS, i, ";");
		DoDamage(CUR_TARG, "direct", DMG_ZAP, 1.0, GetOwner());
		string TARGET_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 110)));
	}

	void end_repel()
	{
		// svplaysound: svplaysound 2 0 SOUND_BEAM_LOOP
		EmitSound(2, 0, SOUND_BEAM_LOOP);
		npcatk_resume_ai();
		npcatk_resume_movement();
		DOING_REPEL = 0;
		leap_forward();
		NEXT_REPEL = GetGameTime();
		NEXT_REPEL += FREQ_REPEL;
		if (!(GetGameTime() > NEXT_CAGE)) return;
		NEXT_CAGE = GetGameTime();
		NEXT_CAGE += 5.0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (CL_SCRIPT_IDX != "CL_SCRIPT_IDX")
		{
			ClientEvent("update", "all", CL_SCRIPT_IDX, "remove_fx");
		}
		if ((SUSTAINING_CAGE))
		{
			if ((GetEntityProperty(CAGE_TARGET, "haseffect")))
			{
				RemoveEffect(CAGE_TARGET, "dot_lightning_cage");
			}
			Effect("beam", "update", CUR_BEAM, "remove", 0.1);
			// svplaysound: svplaysound 2 0 SOUND_BEAM_LOOP
			EmitSound(2, 0, SOUND_BEAM_LOOP);
			string THE_RESCUER = GetEntityIndex(m_hLastStruck);
			LogDebug("rescuer_name GetEntityName(THE_RESCUER)");
			if (THE_RESCUER != CAGE_TARGET)
			{
				if ((IsValidPlayer(CAGE_TARGET)))
				{
				}
				if ((IsValidPlayer(THE_RESCUER)))
				{
				}
				LogDebug("sending_bonus");
				string BONUS_MSG = "for freeing ";
				BONUS_MSG += GetEntityName(CAGE_TARGET);
				CallExternal(THE_RESCUER, "ext_dmgpoint_bonus", 1000, BONUS_MSG);
			}
		}
		if ((DOING_REPEL))
		{
			ClientEvent("update", "all", CL_IDX_ZAP_AURA, "end_fx");
			// svplaysound: svplaysound 2 0 SOUND_BEAM_LOOP
			EmitSound(2, 0, SOUND_BEAM_LOOP);
		}
	}

	void swing_sword()
	{
		string ATTACK_START = GetEntityProperty(GetOwner(), "attachpos");
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(ATTACK_START, TARG_ORG);
		ANG_TO_TARG = "x";
		ClientEvent("update", "all", CL_SCRIPT_IDX, "hand_sprite", ANG_TO_TARG, ATTACH_HAND);
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		if (!(TARG_RANGE < ATTACK_HITRANGE)) return;
		TARG_RANGE /= ATTACK_HITRANGE;
		string DELAY_DMG = /* TODO: $ratio */ $ratio(TARG_RANGE, 0.1, 1.0);
		DELAY_DMG("swing_sword_delay_dmg");
	}

	void swing_sword_delay_dmg()
	{
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_ZAP, ATTACK_HITCHANCE, "lightning_effect");
	}

	void game_dodamage()
	{
		if ((SWIPE_ATTACK))
		{
			if ((param1))
			{
			}
			LogDebug("game_dodamage DMG_ZAP");
			ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DMG_ZAP);
		}
		SWIPE_ATTACK = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(SUSPEND_AI)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			if (CL_SCRIPT_IDX != "CL_SCRIPT_IDX")
			{
				ClientEvent("update", "all", CL_SCRIPT_IDX, "remove_fx");
			}
			ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), FREQ_FX_REFRESH);
			CL_SCRIPT_IDX = "game.script.last_sent_id";
			NEXT_CL_REFRESH = GetGameTime();
			NEXT_CL_REFRESH += FREQ_FX_REFRESH;
		}
	}

}

}
