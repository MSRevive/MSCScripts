#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_noclip.as"

namespace MS
{

class WraithSummoned : CGameScript
{
	int AM_DRAINING;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BASENOCLIP_NO_SETMOVEDEST;
	string CL_SCRIPT;
	int DMG_DRAIN;
	float FREQ_ROAM;
	int FWD_SPEED;
	int FWD_SPEED_STANDARD;
	string INITIAL_ORIGIN;
	int MP_DRAIN_AMT;
	int MY_CL_IDX;
	string MY_OWNER;
	int NPC_GIVE_EXP;
	string NPC_NOCLIP_DEST;
	string SOUND_DEATH;
	string SOUND_DRAIN_LOOP;
	string SOUND_DRAIN_START;
	string SOUND_HOVER_LOOP;
	string SOUND_KILL;
	string SOUND_MOAN;
	string SOUND_TELE;

	WraithSummoned()
	{
		ANIM_RUN = "idle";
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "idle";
		ANIM_WALK = "idle";
		ATTACK_RANGE = 128;
		ATTACK_MOVERANGE = 100;
		ATTACK_HITRANGE = 150;
		NPC_GIVE_EXP = 400;
		BASENOCLIP_NO_SETMOVEDEST = 1;
		FWD_SPEED_STANDARD = 20;
		FWD_SPEED = 20;
		DMG_DRAIN = 20;
		MP_DRAIN_AMT = 1;
		CL_SCRIPT = "monsters/wraith_cl";
		FREQ_ROAM = Random(5.0, 10.0);
		SOUND_MOAN = "crow/ghostwail.wav";
		SOUND_DEATH = "ichy/ichy_die2.wav";
		SOUND_DRAIN_START = "crow/Triggered/tomb5.wav";
		SOUND_DRAIN_LOOP = "x/x_teleattack1.wav";
		SOUND_HOVER_LOOP = "ambience/labdrone2.wav";
		SOUND_KILL = "houndeye/he_blast3.wav";
		SOUND_TELE = "magic/teleport.wav";
		Precache(SOUND_KILL);
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetName("Wraith");
		SetModel("monsters/netherspirit.mdl");
		SetWidth(20);
		SetHeight(80);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetHealth(750);
		SetRace("undead");
		SetBloodType("none");
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("stun", 0);
		SetSolid("slidebox");
		SetGravity(0);
		SetRoam(true);
		SetHearingSensitivity(11);
		ScheduleDelayedEvent(1.0, "sustain_renderprops");
		ScheduleDelayedEvent(0.5, "do_manual_roam");
	}

	void OnPostSpawn() override
	{
		if (!(NPC_DMG_MULTI > 1)) return;
		MP_DRAIN_AMT *= NPC_DMG_MULTI;
		DMG_DRAIN *= NPC_DMG_MULTI;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_MOVERANGE)
		{
			FWD_SPEED = 0;
		}
		else
		{
			FWD_SPEED = FWD_SPEED_STANDARD;
		}
		if ((IS_FLEEING))
		{
			NPC_NOCLIP_DEST = GetMonsterProperty("movedest.origin");
		}
		if (m_hAttackTarget != "unset")
		{
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARGET_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				TARGET_Z -= 46;
			}
			string MY_ORG = GetEntityOrigin(GetOwner());
			MY_ORG = "z";
			SetEntityOrigin(GetOwner(), MY_ORG);
			if (GetEntityRange(m_hAttackTarget) < 55)
			{
				float RND_ANG = Random(0, 359.99);
				NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 80, 0));
				NPC_NOCLIP_DEST = "z";
				SetEntityOrigin(GetOwner(), NPC_NOCLIP_DEST);
				EmitSound(GetOwner(), 0, SOUND_TELE, 10);
			}
			else
			{
				IS_FLEEING = 0;
				NPC_NOCLIP_DEST = GetEntityOrigin(m_hAttackTarget);
				NPC_NOCLIP_DEST = "z";
			}
		}
		if (!(m_hAttackTarget == "unset")) return;
		FREQ_ROAM("do_manual_roam");
		FWD_SPEED = FWD_SPEED_STANDARD;
		GetAllPlayers(PLAYER_LIST);
		ScrambleTokens(PLAYER_LIST, ";");
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			pick_target();
		}
	}

	void pick_target()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		if (!(GetEntityRange(CUR_TARG) < 1024)) return;
		npcatk_target(CUR_TARG);
	}

	void do_manual_roam()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		FREQ_ROAM("do_manual_roam");
		if (!(m_hAttackTarget == "unset")) return;
		NPC_NOCLIP_DEST = NPC_HOME_LOC;
		float RND_ANG = Random(0, 359.99);
		NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 512, 0));
	}

	void sustain_renderprops()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(5.0, "sustain_renderprops");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		// svplaysound: svplaysound 3 10 SOUND_HOVER_LOOP
		EmitSound(3, 10, SOUND_HOVER_LOOP);
		if (RandomInt(1, 10) == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_MOAN, 10);
		}
	}

	void turn_undead()
	{
		if ((NOT_SUMMONED)) return;
		string HOLY_CASTER = param2;
		string DMG_HOLY = GetEntityMaxHealth(GetOwner());
		DMG_HOLY *= 2.0;
		XDoDamage(GetOwner(), "direct", 1000, 1.0, HOLY_CASTER, HOLY_CASTER, "spellcasting.divination", "holy");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		AM_DRAINING = 0;
		SetAnimFrameRate(0);
		FWD_SPEED = 0;
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()), 5, 128);
		EmitSound(GetOwner(), 1, SOUND_DEATH, 10);
		// svplaysound: svplaysound 2 0 SOUND_DRAIN_LOOP
		EmitSound(2, 0, SOUND_DRAIN_LOOP);
		// svplaysound: svplaysound 3 0 SOUND_HOVER_LOOP
		EmitSound(3, 0, SOUND_HOVER_LOOP);
		if (MY_CL_IDX != 0)
		{
			ClientEvent("update", "all", MY_CL_IDX, "end_fx");
		}
		if (!(IsEntityAlive(MY_OWNER))) return;
		CallExternal(MY_OWNER, "ext_wraith_died");
	}

	void frame_attack_start()
	{
		// svplaysound: svplaysound 2 10 SOUND_DRAIN_LOOP
		EmitSound(2, 10, SOUND_DRAIN_LOOP);
		start_drain_attack();
	}

	void frame_attack_end()
	{
		end_drain_attack();
	}

	void end_drain_attack()
	{
		// svplaysound: svplaysound 2 0 SOUND_DRAIN_LOOP
		EmitSound(2, 0, SOUND_DRAIN_LOOP);
		ClientEvent("update", "all", MY_CL_IDX, "end_fx");
		AM_DRAINING = 0;
		MY_CL_IDX = 0;
	}

	void start_drain_attack()
	{
		ClientEvent("new", "all", CL_SCRIPT, GetEntityIndex(GetOwner()), GetEntityIndex(m_hAttackTarget), ATTACK_HITRANGE);
		MY_CL_IDX = "game.script.last_sent_id";
		AM_DRAINING = 1;
		drain_attack_loop();
	}

	void drain_attack_loop()
	{
		if (!(AM_DRAINING)) return;
		ScheduleDelayedEvent(0.1, "drain_attack_loop");
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			string SEE_TARGET = false;
			if ((SEE_TARGET))
			{
				if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
				{
				}
				GiveMP(m_hAttackTarget);
				if (GetGameTime() > LASTATK_MESSAGE)
				{
					LASTATK_MESSAGE = GetGameTime();
					LASTATK_MESSAGE += 2.0;
					SendPlayerMessage(m_hAttackTarget, "Your soul is being drained!");
					Effect("screenfade", m_hAttackTarget, 2, 1, Vector3(0, 0, 255), 180, "fadein");
				}
				if (GetEntityMP(m_hAttackTarget) <= 0)
				{
				}
				slay_target();
			}
		}
		else
		{
			if ((false))
			{
			}
			DoDamage(m_hAttackTarget, "direct", DMG_DRAIN, 1.0, GetOwner());
		}
	}

	void slay_target()
	{
		end_drain_attack();
		SendPlayerMessage(m_hAttackTarget, "Your soul has been drained.");
		DoDamage(m_hAttackTarget, "direct", 99999, 1.0, GetOwner());
		CallExternal(m_hAttackTarget, "ext_playsound_kiss", 1, 10, SOUND_KILL);
		EmitSound(GetOwner(), 0, SOUND_MOAN, 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		INITIAL_ORIGIN = param3;
		ScheduleDelayedEvent(0.1, "set_first_origin");
	}

	void set_first_origin()
	{
		SetEntityOrigin(GetOwner(), INITIAL_ORIGIN);
	}

	void ext_master_died()
	{
		if (!(param1 == MY_OWNER)) return;
		npc_suicide();
	}

}

}
