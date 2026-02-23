#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_noclip.as"

namespace MS
{

class ColdLady : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BEAM_ATTACK;
	int DEST_ROT;
	string DID_INTRO;
	int FWD_SPEED;
	int IS_UNHOLY;
	int MOVE_STEP;
	string MOVE_TARGET;
	int MOVING_IN;
	int NPC_GIVE_EXP;
	string NPC_NOCLIP_DEST;
	int N_VALID;
	string PICK_PLAYER_DELAY;
	string VALID_PLAYERS;

	ColdLady()
	{
		IS_UNHOLY = 1;
		const float FREQ_PICK = 5.0;
		const string DMG_ICE = RandomInt(100, 200);
		const string DOT_FREEZE = RandomInt(40, 80);
		ANIM_WALK = "treadwater";
		ANIM_RUN = "swim";
		ANIM_IDLE = "treadwater";
		ANIM_ATTACK = "crouch_shoot_onehanded";
		ATTACK_RANGE = 128;
		ATTACK_MOVERANGE = 100;
		ATTACK_HITRANGE = 200;
		NPC_GIVE_EXP = 400;
		const int FWD_SPEED_NORM = 10;
		const int FWD_SPEED_FAST = 30;
		const string VERT_WOBBLE_ACTIVE = Random(-128, 128);
		const int VERT_WOBBLE_IDLE = 0;
		FWD_SPEED = 10;
		const int ROAM_RANGE = 512;
		const int MAX_ROAM_RANGE = 4096;
		const string SOUND_FREEZE = "debris/beamstart14.wav";
		const string SOUND_ATTACK1 = "voices/icelady_giggle1.wav";
		const string SOUND_ATTACK2 = "voices/icelady_giggle2.wav";
		const string SOUND_ATTACK3 = "voices/icelady_giggle3.wav";
		const string SOUND_ALERT = "voices/icelady_taunt1.wav";
		const string SOUND_INTRO1 = "voices/icelady_taunt2.wav";
		const string SOUND_INTRO2 = "voices/icelady_taunt2b.wav";
		const string SOUND_PAIN1 = "voices/icelady_pain1.wav";
		const string SOUND_PAIN2 = "voices/icelady_pain2.wav";
		const string SOUND_STRUCK1 = "debris/glass1.wav";
		const string SOUND_STRUCK2 = "debris/glass2.wav";
		const string SOUND_DEATH = "voices/icelady_pain2.wav";
		ANIM_DEATH = "die_simple";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void OnSpawn() override
	{
		SetName("Cold Lady");
		SetBloodType("none");
		SetRace("demon");
		SetHealth(900);
		SetModel("monsters/icelady.mdl");
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("holy", 1.5);
		SetFly(true);
		SetWidth(32);
		SetHeight(96);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_RUN);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		DEST_ROT = 0;
		MOVE_STEP = 0;
		MOVE_TARGET = "unset";
		npcatk_suspend_ai();
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
	}

	void OnPostSpawn() override
	{
		NPC_NOCLIP_DEST = GetMonsterProperty("origin");
		npcatk_suspend_ai();
	}

	void clear_target()
	{
		LogDebug("targ_reset_cuz PARAM1");
		MOVE_TARGET = "unset";
		MOVE_STEP = 0;
		move_away("clear_targets");
	}

	void basenoclip_flight()
	{
		if (!(IsEntityAlive(MOVE_TARGET)))
		{
			if (MOVE_TARGET != "unset")
			{
			}
			clear_target("dead");
		}
		if (MOVE_TARGET == "unset")
		{
			if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) < ATTACK_MOVERANGE)
			{
				MOVE_STEP = 128;
				VERT_WOBBLE = VERT_WOBBLE_IDLE;
				NPC_NOCLIP_DEST = NPC_HOME_LOC;
				do_move_step();
			}
			if (!(PICK_PLAYER_DELAY))
			{
			}
			PICK_PLAYER_DELAY = 1;
			FREQ_PICK("reset_pplayer");
			pick_a_player();
		}
		if (!(DID_INTRO))
		{
			if ((false))
			{
			}
			DID_INTRO = 1;
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			ScheduleDelayedEvent(4.0, "do_intro");
		}
		if (MOVE_TARGET != "unset")
		{
			if ((MOVING_IN))
			{
				if (GetEntityRange(MOVE_TARGET) < ATTACK_RANGE)
				{
					do_attack(MOVE_TARGET);
				}
				if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) > MAX_ROAM_RANGE)
				{
					clear_targets("too_far_from_home");
				}
				if ((MOVING_IN))
				{
				}
				SetMoveAnim(ANIM_WALK);
				SetIdleAnim(ANIM_WALK);
				PlayAnim("once", ANIM_WALK);
				if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) < ATTACK_MOVERANGE)
				{
				}
				FWD_SPEED = FWD_SPEED_NORM;
				VERT_WOBBLE = VERT_WOBBLE_ACTIVE;
				if (GetEntityRange(MOVE_TARGET) < ATTACK_MOVERANGE)
				{
					move_away("in_range");
				}
				MOVE_STEP -= 100;
				if (MOVE_STEP < 0)
				{
					MOVE_STEP = 0;
				}
				NPC_NOCLIP_DEST = GetEntityOrigin(MOVE_TARGET);
				do_move_step();
			}
			if (!(MOVING_IN))
			{
				if (Distance(GetMonsterProperty("origin"), NPC_NOCLIP_DEST) < ATTACK_MOVERANGE)
				{
				}
				FWD_SPEED = FWD_SPEED_FAST;
				NPC_NOCLIP_DEST = GetEntityOrigin(MOVE_TARGET);
				VERT_WOBBLE = VERT_WOBBLE_IDLE;
				SetMoveAnim(ANIM_RUN);
				SetIdleAnim(ANIM_RUN);
				PlayAnim("once", ANIM_RUN);
				MOVE_STEP += 100;
				if (GetEntityRange(MOVE_TARGET) > ROAM_RANGE)
				{
					move_in("too_far");
				}
				NPC_NOCLIP_DEST = GetEntityOrigin(MOVE_TARGET);
				do_move_step();
			}
		}
	}

	void do_move_step()
	{
		DEST_ROT += 45;
		if (DEST_ROT > 359)
		{
			DEST_ROT -= 359;
		}
		NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, DEST_ROT, 0), Vector3(0, MOVE_STEP, VERT_WOBBLE));
	}

	void do_intro()
	{
		string INTRO_DIFF = GetGameTime();
		INTRO_DIFF -= G_ICELADY_INTRO;
		if (!(INTRO_DIFF > 10)) return;
		SetGlobalVar("G_ICELADY_INTRO", GetGameTime());
		// PlayRandomSound from: SOUND_INTRO1, SOUND_INTRO2
		array<string> sounds = {SOUND_INTRO1, SOUND_INTRO2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void reset_pplayer()
	{
		PICK_PLAYER_DELAY = 0;
	}

	void pick_a_player()
	{
		GetAllPlayers(PLAYER_LIST);
		VALID_PLAYERS = "";
		N_VALID = 0;
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			pick_player_loop();
		}
		if (N_VALID == 1)
		{
			move_in("new_target");
			MOVE_TARGET = GetToken(PLAYER_LIST, 0, ";");
		}
		if (N_VALID == 0)
		{
			MOVE_TARGET = "unset";
		}
		if (!(N_VALID > 1)) return;
		N_VALID -= 1;
		string RND_VALID = RandomInt(0, N_VALID);
		move_in("new_target_multi");
		MOVE_TARGET = GetToken(PLAYER_LIST, RND_VALID, ";");
	}

	void pick_player_loop()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < ROAM_RANGE)) return;
		if (VALID_PLAYERS.length() > 0) VALID_PLAYERS += ";";
		VALID_PLAYERS += i;
		N_VALID += 1;
	}

	void do_attack()
	{
		BEAM_ATTACK = 1;
		PlayAnim("once", ANIM_ATTACK);
		DoDamage(MOVE_TARGET, ATTACK_HITRANGE, DMG_ICE, 1.0, "cold");
		move_away("did_attack");
		ScheduleDelayedEvent(10.0, "check_froze");
	}

	void check_froze()
	{
		if ((GetEntityProperty(MOVE_TARGET, "scriptvar")))
		{
			pick_a_player();
		}
	}

	void game_dodamage()
	{
		if (!(BEAM_ATTACK)) return;
		BEAM_ATTACK = 0;
		string TRACE_START = GetEntityOrigin(GetOwner());
		string TRACE_END = GetEntityOrigin(MOVE_TARGET);
		string TRACE_IT = TraceLine(TRACE_START, TRACE_END);
		Effect("beam", "point", "lgtning.spr", 60, TRACE_START, TRACE_IT, Vector3(128, 128, 255), 200, 60, 1.0);
		if (!(param1)) return;
		if (!(GetEntityRange(param2) <= ATTACK_HITRANGE)) return;
		ApplyEffect(param2, "effects/dot_cold_freeze", 4.0, GetEntityIndex(GetOwner()), DOT_FREEZE);
		EmitSound(GetOwner(), 0, SOUND_FREEZE, 10);
		ScheduleDelayedEvent(0.5, "do_giggle");
	}

	void do_giggle()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(MOVE_TARGET == "unset")) return;
		if (!(GetRelationship(m_hLastStruck) == "enemy")) return;
		MOVE_TARGET = GetEntityIndex(m_hLastStruck);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetFly(false);
		SetGravity(1.0);
		SetVelocity(GetOwner(), Vector3(0, 0, -200));
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
	}

	void move_away()
	{
		LogDebug("moving_away PARAM1");
		MOVING_IN = 0;
	}

	void move_in()
	{
		LogDebug("moving_in PARAM1");
		MOVING_IN = 1;
	}

}

}
