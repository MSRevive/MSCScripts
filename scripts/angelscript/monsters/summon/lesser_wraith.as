#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_noclip.as"

namespace MS
{

class LesserWraith : CGameScript
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
	float CYCLE_TIME;
	int DMG_DRAIN;
	string FOLLOW_MODE;
	float FREQ_ROAM;
	int FWD_SPEED;
	int FWD_SPEED_STANDARD;
	string HOLD_POS;
	int IMMUNE_VAMPIRE;
	string INITIAL_ORIGIN;
	int IS_UNHOLY;
	int I_R_PET;
	string LAST_OWNER_YAW;
	int MP_DRAIN_AMT;
	int MY_CL_IDX;
	string MY_OWNER;
	string NAMEPREFIX;
	string NEXT_READY;
	string NEXT_SCAN;
	string NPCATK_TARGET;
	int NPC_BATTLE_ALLY;
	int NPC_EXTRA_VALIDATIONS;
	int NPC_GIVE_EXP;
	string NPC_NOCLIP_DEST;
	int NPC_NO_PLAYER_DMG;
	string NPC_PROPELL_SUSPEND;
	string OLD_WRAITH_TARG;
	string OWNER_OLD_POS;
	string SOUND_DEATH;
	string SOUND_DRAIN_LOOP;
	string SOUND_DRAIN_START;
	string SOUND_HOVER_LOOP;
	string SOUND_KILL;
	string SOUND_MOAN;
	string SOUND_TELE;
	string WRAITH_OLD_TARG;

	LesserWraith()
	{
		ANIM_RUN = "wraith_idle";
		ANIM_IDLE = "wraith_idle";
		ANIM_WALK = "wraith_idle";
		NPC_EXTRA_VALIDATIONS = 1;
		I_R_PET = 1;
		NPC_NO_PLAYER_DMG = 1;
		NPC_BATTLE_ALLY = 1;
		ANIM_ATTACK = "wraith_attack";
		ANIM_DEATH = "wraith_idle";
		ATTACK_RANGE = 128;
		ATTACK_MOVERANGE = 100;
		ATTACK_HITRANGE = 150;
		NPC_GIVE_EXP = 0;
		BASENOCLIP_NO_SETMOVEDEST = 1;
		FWD_SPEED_STANDARD = 20;
		FWD_SPEED = 20;
		DMG_DRAIN = 10;
		MP_DRAIN_AMT = 1;
		CL_SCRIPT = "monsters/summon/lesser_wraith_cl";
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
		SetName("Lesser Wraith");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 72);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
		SetWidth(0);
		SetHeight(0);
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
		SetMenuAutoOpen(1);
		SetBloodType("none");
		SetHealth(1000);
		SetRace("human");
		SetDamageResistance("slash", 0.25);
		SetDamageResistance("pierce", 0.25);
		SetDamageResistance("blunt", 0.25);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("generic", 0.25);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 3.0);
		SetDamageResistance("holy", 4.0);
		SetDamageResistance("stun", 0);
		SetSolid("none");
		SetNoPush(true);
		SetGravity(0);
		SetRoam(false);
		SetHearingSensitivity(11);
		OLD_WRAITH_TARG = "unset";
		ScheduleDelayedEvent(1.0, "sustain_renderprops");
		ScheduleDelayedEvent(0.5, "do_manual_roam");
	}

	void npc_targetvalidate()
	{
		if ((FOLLOW_MODE))
		{
			NPCATK_TARGET = "unset";
			int EXIT_SUB = 1;
		}
		if (GetEntityRace(m_hAttackTarget) == "hguard")
		{
			string HGUARD_TARGET = GetEntityProperty(m_hAttackTarget, "scriptvar");
			if (HGUARD_TARGET == MY_OWNER)
			{
				int GO_HOSTILE = 1;
			}
			if (HGUARD_TARGET == GetEntityIndex(GetOwner()))
			{
				int GO_HOSTILE = 1;
			}
			if (GetRelationship(HGUARD_TARGET) == "ally")
			{
				int GO_HOSTILE = 1;
			}
			if (!(GO_HOSTILE))
			{
			}
			NPCATK_TARGET = "unset";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(OLD_WRAITH_TARG != m_hAttackTarget)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		string TRACE_START = GetEntityOrigin(MY_OWNER);
		string TRACE_END = GetEntityOrigin(m_hAttackTarget);
		string HALF_HEIGHT = GetEntityHeight(m_hAttackTarget);
		HALF_HEIGHT *= 0.5;
		TRACE_END += "z";
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (TRACE_LINE != TRACE_END)
		{
			NPCATK_TARGET = OLD_WRAITH_TARG;
		}
		else
		{
			OLD_WRAITH_TARG = m_hAttackTarget;
		}
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
		CallExternal(MY_OWNER, "ext_wraith_active", 0);
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
		ScheduleDelayedEvent(0.5, "drain_attack_loop");
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
		if ((IsEntityAlive(MY_OWNER)))
		{
			if (GetEntityMP(MY_OWNER) < GetEntityProperty(MY_OWNER, "maxmp"))
			{
			}
			GiveMP(MY_OWNER);
		}
		if (!(IsEntityAlive(m_hAttackTarget)))
		{
			end_drain_attack();
		}
	}

	void slay_target()
	{
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		end_drain_attack();
		SendPlayerMessage(m_hAttackTarget, "Your soul has been drained.");
		DoDamage(m_hAttackTarget, "direct", 99999, 1.0, GetOwner());
		CallExternal(m_hAttackTarget, "ext_playsound_kiss", 1, 10, SOUND_KILL);
		EmitSound(GetOwner(), 0, SOUND_MOAN, 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		ScheduleDelayedEvent(0.1, "circle_in");
		NEXT_READY = GetGameTime();
		NEXT_READY += 2.0;
		NAMEPREFIX = GetEntityName(MY_OWNER);
		NAMEPREFIX += "s";
		NAMEPREFIX += " ";
		NAMEPREFIX += GetEntityName(GetOwner());
		SetName(NAMEPREFIX);
		INITIAL_ORIGIN = param2;
		ScheduleDelayedEvent(0.1, "set_first_origin");
		ScheduleDelayedEvent(300.0, "end_wraith");
		CallExternal(MY_OWNER, "ext_wraith_active", 1);
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

	void OnHuntTarget(CBaseEntity@ target)
	{
		CYCLE_TIME = 0.1;
		if (!((MY_OWNER !is null)))
		{
			int REMOVE_ME = 1;
		}
		if (!(IsEntityAlive(MY_OWNER)))
		{
			int REMOVE_ME = 1;
		}
		if ((REMOVE_ME))
		{
			end_wraith();
		}
		if ((REMOVE_ME)) return;
		FWD_SPEED = FWD_SPEED_STANDARD;
		if ((IS_FLEEING))
		{
			NPC_NOCLIP_DEST = GetMonsterProperty("movedest.origin");
		}
		if (m_hAttackTarget != "unset")
		{
			if (m_hAttackTarget != WRAITH_OLD_TARG)
			{
				SendPlayerMessage(MY_OWNER, "Your Lesser Wraith has targeted " + GetEntityProperty(m_hAttackTarget, "name.full"));
			}
			WRAITH_OLD_TARG = m_hAttackTarget;
			NPC_PROPELL_SUSPEND = 0;
			if (GetEntityRange(m_hAttackTarget) < ATTACK_MOVERANGE)
			{
				FWD_SPEED = 0;
			}
			else
			{
				FWD_SPEED = FWD_SPEED_STANDARD;
			}
			if (GetEntityRange(m_hAttackTarget) > 1024)
			{
				NPCATK_TARGET = "unset";
				zap_to_owner();
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
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
		string MY_ORG = GetEntityOrigin(GetOwner());
		HOLD_POS = GetEntityOrigin(MY_OWNER);
		if (GetEntityRange(MY_OWNER) > 64)
		{
			LAST_OWNER_YAW = GetEntityProperty(MY_OWNER, "viewangles");
			LAST_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(LAST_OWNER_YAW);
		}
		if (OWNER_OLD_POS != GetEntityOrigin(MY_OWNER))
		{
			LAST_OWNER_YAW = GetEntityProperty(MY_OWNER, "viewangles");
			LAST_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(LAST_OWNER_YAW);
		}
		HOLD_POS += /* TODO: $relpos */ $relpos(Vector3(0, LAST_OWNER_YAW, 0), Vector3(0, -48, -20));
		string OWNER_GROUND = GetEntityOrigin(MY_OWNER);
		string OWNER_GROUND = /* TODO: $get_ground_height */ $get_ground_height(OWNER_GROUND);
		OWNER_GROUND += 10;
		HOLD_POS = "z";
		if (Distance(MY_ORG, HOLD_POS) < 64)
		{
			SetMoveDest("none");
			FWD_SPEED = 0;
			string CUR_YAW = GetEntityProperty(MY_OWNER, "viewangles");
			string CUR_YAW = /* TODO: $vec.yaw */ $vec.yaw(CUR_YAW);
			SetAngles("face");
			NPC_PROPELL_SUSPEND = 1;
			SetEntityOrigin(GetOwner(), HOLD_POS);
		}
		else
		{
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARGET_Z = (HOLD_POS).z;
			MY_ORG = "z";
			SetEntityOrigin(GetOwner(), MY_ORG);
			NPC_PROPELL_SUSPEND = 0;
			FWD_SPEED = FWD_SPEED_STANDARD;
			NPC_NOCLIP_DEST = HOLD_POS;
			SetMoveDest(HOLD_POS);
		}
		OWNER_OLD_POS = GetEntityOrigin(MY_OWNER);
		if (GetGameTime() > NEXT_SCAN)
		{
			NEXT_SCAN = GetGameTime();
			NEXT_SCAN += 5.0;
			string OWNER_TARG = GetEntityProperty(MY_OWNER, "target");
			if (GetRelationship(OWNER_TARG) == "enemy")
			{
				NPCATK_TARGET = OWNER_TARG;
				npcatk_targetvalidate(m_hAttackTarget);
			}
			if (m_hAttackTarget == "unset")
			{
			}
			string TARG_LIST = FindEntitiesInSphere("enemy", 768);
			string TARG_LIST = /* TODO: $sort_entlist */ $sort_entlist(TARG_LIST, "range");
			NPCATK_TARGET = GetToken(TARG_LIST, 0, ";");
			npcatk_targetvalidate(m_hAttackTarget);
		}
	}

	void delay_tele_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
	}

	void end_wraith()
	{
		if ((IsEntityAlive(MY_OWNER)))
		{
			SendPlayerMessage(MY_OWNER, "Your wraith has vanished!");
		}
		CallExternal(MY_OWNER, "ext_wraith_active", 0);
		npc_suicide();
	}

	void game_menu_getoptions()
	{
		if (!(param1 == MY_OWNER)) return;
		string reg.mitem.title = "Report Health";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "report";
		string reg.mitem.callback = "bs_global_command";
		if (!(FOLLOW_MODE))
		{
			if (m_hAttackTarget == "unset")
			{
				string reg.mitem.title = "Don't Attack";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "follow";
				string reg.mitem.callback = "bs_global_command";
			}
			else
			{
				string reg.mitem.title = "Disengage Enemy";
				string reg.mitem.type = "callback";
				string reg.mitem.data = "follow";
				string reg.mitem.callback = "bs_global_command";
			}
		}
		else
		{
			string reg.mitem.title = "Attack on Sight";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "hunt";
			string reg.mitem.callback = "bs_global_command";
		}
		string reg.mitem.title = "Unsummon";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "vanish";
		string reg.mitem.callback = "bs_global_command";
	}

	void bs_global_command()
	{
		if (!(param1 == MY_OWNER)) return;
		if (param2 == "vanish")
		{
			end_wraith();
			int ENDED_WRAITH = 1;
		}
		if ((ENDED_WRAITH)) return;
		EmitSound(GetOwner(), 0, SOUND_KILL, 10);
		if (param2 == "follow")
		{
			if (m_hAttackTarget == "unset")
			{
				SendColoredMessage(MY_OWNER, "Lesser Wraith set non agro.");
			}
			else
			{
				SendColoredMessage(MY_OWNER, "Lesser Wraith disengaging.");
			}
			NPCATK_TARGET = "unset";
			FOLLOW_MODE = 1;
			zap_to_owner();
		}
		if (param2 == "hunt")
		{
			SendColoredMessage(MY_OWNER, "Lesser Wraith set agro.");
			FOLLOW_MODE = 0;
		}
		if (param2 == "defend")
		{
			SendColoredMessage(MY_OWNER, "Lesser Wraith set defensive.");
			FOLLOW_MODE = 0;
		}
		if (param2 == "report")
		{
			int HEALTH_STRING = int(GetEntityHealth(GetOwner()));
			HEALTH_STRING += "/";
			HEALTH_STRING += int(GetEntityMaxHealth(GetOwner()));
			HEALTH_STRING += "hp";
			SendColoredMessage(MY_OWNER, "Lesser Wraith Reports: " + HEALTH_STRING);
		}
	}

	void zap_to_owner()
	{
		NPC_NOCLIP_DEST = GetEntityOrigin(MY_OWNER);
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "viewangles");
		string OWNER_YAW = (MY_OWNER).z;
		OWNER_YAW += Random(-45.0, 45.0);
		NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, -256, 0));
		SetEntityOrigin(GetOwner(), NPC_NOCLIP_DEST);
		ScheduleDelayedEvent(0.1, "delay_tele_sound");
	}

	void circle_in()
	{
		string CIRCLE_ORG = GetEntityOrigin(GetOwner());
		CIRCLE_ORG = "z";
		ClientEvent("new", "all", "effects/sfx_summon_circle", CIRCLE_ORG, 3);
	}

}

}
