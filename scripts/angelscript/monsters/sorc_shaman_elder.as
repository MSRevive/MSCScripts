#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class SorcShamanElder : CGameScript
{
	int AM_TURRET;
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BALL_DMG;
	int BALL_SIZE;
	string BALL_TYPE;
	int BEAM_COUNT;
	string BEAM_ON;
	string BEAM_TARGET;
	int DID_WARCRY;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	string FREQ_REPULSE;
	int FROST_BOLT_DELAY;
	string LHOR_SUMMON_SCRIPT;
	string MISS_COUNT;
	int MOVE_RANGE;
	string NEXT_SUMMON;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	int REPULSE_DELAY;
	int SWIPE_SOUNDS;

	SorcShamanElder()
	{
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
		const string SOUND_BEAM = "weather/Storm_exclamation.wav";
		const string ANIM_BEAM = "battleaxe_swing1_L";
		FREQ_REPULSE = Random(15, 20);
		const string DMG_PUSH_BEAM = Random(10, 20);
		const string PROJ_SCRIPT = "proj_lightning_ball";
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 800;
		ANIM_ATTACK = "swordswing1_L";
		FLINCH_CHANCE = 0.45;
		MOVE_RANGE = 256;
		ATTACK_RANGE = 2000;
		const int ATTACK_SPEED = 300;
		const int ATTACK_CONE_OF_FIRE = 2;
		const int MELE_RANGE = 96;
		const int MELE_HITRANGE = 128;
		const int ATTACK_ACCURACY = 80;
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_FIRE = "swordswing1_L";
		const string ANIM_WARCRY = "warcry";
		const string ANIM_KICK = "kick";
		ANIM_IDLE = "idle1";
		const string SWIPE_DAMAGE = "$rand(25,65)";
		const string SOUND_MELEMISS = "zombie/claw_miss1.wav";
		const string SOUND_MELEHIT = "zombie/claw_strike3.wav";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		const string SOUND_DEATH_SHOOT = "magic/spawn.wav";
		const string SOUND_WARCRY1 = "monsters/orc/attack1.wav";
		const string SOUND_WARCRY2 = "monsters/orc/attack3.wav";
		const string FROST_BOLT_DAMAGE = "$rand(40,75)";
		const string FROST_STRIKE_DAMAGE = "$rand(30,60)";
		const float FROST_BOLT_FREQ = 1.5;
		const string DEATH_SCRIPT = "monsters/summon/summon_lightning_storm";
		BALL_SIZE = 5;
		BALL_DMG = 100;
		BALL_TYPE = "lightning";
		const int SORC_MAX_SUMMONS = 2;
		const string LELM_SUMMON_SCRIPT = "monsters/elemental_air2";
		const string SOUND_THUNDER = "magic/bolt_end.wav";
		const string TORNADO_MODEL = "weapons/magic/tornado.mdl";
		const string SOUND_LHOR = "monsters/magic/elecidlepop.wav";
		LHOR_SUMMON_SCRIPT = "monsters/horror_lightning";
		if (StringToLower(GetMapName()) == "sorc_villa")
		{
			LHOR_SUMMON_SCRIPT = "monsters/horror_lightning2";
		}
		const int LHOR_SUMMON_FREQ = 15;
	}

	void game_precache()
	{
		Precache("monsters/horror_lightning");
		Precache("monsters/elemental_air2");
		Precache("monsters/summon/tornado");
		Precache(SOUND_THUNDER);
		Precache(TORNADO_MODEL);
		Precache("monsters/summon/lightning_ball_guided");
		Precache("c-tele1.spr");
	}

	void orc_spawn()
	{
		SetHealth(1750);
		SetName("Elder Shadahar Shaman");
		SetHearingSensitivity(8);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("acid", 2.0);
		SetStat("spellcasting", 30);
		SetModel("monsters/sorc.mdl");
		SetModelBody(1, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void npc_selectattack()
	{
		string NME_RANGE = GetEntityRange(m_hLastSeen);
		if ((FROST_BOLT_DELAY))
		{
			if (NME_RANGE > MELE_HITRANGE)
			{
				ANIM_ATTACK = ANIM_FIRE;
			}
		}
		if (!(FROST_BOLT_DELAY))
		{
			ANIM_ATTACK = ANIM_FIRE;
		}
		if (!(NME_RANGE < MELE_HITRANGE)) return;
		if ((REPULSE_DELAY)) return;
		if ((GetEntityProperty(m_hAttackTarget, "nopush")))
		{
			int NO_BEAM = 1;
		}
		if (/* TODO: $get_takedmg */ $get_takedmg(m_hAttackTarget, "lightning") == 0)
		{
			NO_BEAM += 1;
		}
		REPULSE_DELAY = 1;
		FREQ_REPULSE("reset_repulse_delay");
		if (!(NO_BEAM < 2)) return;
		SetMoveAnim(ANIM_BEAM);
		SetIdleAnim(ANIM_BEAM);
		PlayAnim("critical", ANIM_BEAM);
		BEAM_TARGET = m_hAttackTarget;
		AS_ATTACKING = GetGameTime();
		BEAM_COUNT = 0;
		npcatk_suspend_ai();
		beam_push();
	}

	void reset_repulse_delay()
	{
		REPULSE_DELAY = 0;
	}

	void swing_sword()
	{
		if ((CanSee(m_hAttackTarget, MELE_RANGE)))
		{
			ANIM_ATTACK = ANIM_SWIPE;
			swipe_attack(GetEntityIndex(m_hAttackTarget));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ANIM_ATTACK = ANIM_FIRE;
		throw_frostbolt();
	}

	void throw_frostbolt()
	{
		if (!(false)) return;
		npcatk_faceattacker(m_hAttackTarget);
		FROST_BOLT_FREQ("reset_frostbolt");
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string FINAL_DAMAGE = FROST_BOLT_DAMAGE;
		if (EXT_DAMAGE_ADJUSTMENT != "EXT_DAMAGE_ADJUSTMENT")
		{
			FINAL_DAMAGE += EXT_DAMAGE_ADJUSTMENT;
		}
		TossProjectile(PROJ_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 18), m_hAttackTarget, ATTACK_SPEED, FINAL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		FROST_BOLT_DELAY = 1;
		MISS_COUNT += 1;
		if (MISS_COUNT >= 5)
		{
			chicken_run(1.0);
			MISS_COUNT = 0;
		}
	}

	void reset_frostbolt()
	{
		ANIM_ATTACK = ANIM_FIRE;
		DID_WARCRY = 0;
		FROST_BOLT_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetSolid("none");
		EmitSound(GetOwner(), 0, SOUND_DEATH_SHOOT, 10);
		string STORM_POS = GetMonsterProperty("origin");
		STORM_POS = "z";
		SpawnNPC(DEATH_SCRIPT, STORM_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), 40.0, 15.0
		string SPAWN_POS = GetEntityOrigin(GetOwner());
		SPAWN_POS += "z";
		if ((NO_SUMMON)) return;
		SpawnNPC(LELM_SUMMON_SCRIPT, SPAWN_POS, ScriptMode::Legacy);
	}

	void swipe_attack()
	{
		SWIPE_SOUNDS = 1;
		string FINAL_DAMAGE = SWIPE_DAMAGE;
		if (EXT_DAMAGE_ADJUSTMENT != "EXT_DAMAGE_ADJUSTMENT")
		{
			FINAL_DAMAGE += EXT_DAMAGE_ADJUSTMENT;
		}
		if (!(GetEntityRange(m_hLastStruckByMe) <= MELE_HITRANGE)) return;
		npcatk_dodamage(param1, MELE_HITRANGE, FINAL_DAMAGE, ATTACK_ACCURACY);
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param1, "effects/dot_lightning", RandomInt(5, 10), GetOwner(), FROST_STRIKE_DAMAGE);
	}

	void game_dodamage()
	{
		if ((param1))
		{
			MISS_COUNT = 0;
		}
		if (!(SWIPE_SOUNDS)) return;
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_MELEMISS, 10);
		}
		if ((param1))
		{
			EmitSound(GetOwner(), 0, SOUND_MELEHIT, 10);
		}
		SWIPE_SOUNDS = 0;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (!(GetEntityRange(m_hLastStruck) < MELE_RANGE)) return;
		npcatk_settarget(GetEntityIndex(m_hLastStruck));
	}

	void beam_push()
	{
		BEAM_COUNT += 1;
		if (BEAM_COUNT == 30)
		{
			npcatk_resume_ai();
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_RUN);
			BEAM_ON = 0;
		}
		if (!(BEAM_COUNT < 30)) return;
		ScheduleDelayedEvent(0.1, "beam_push");
		if (!(IsEntityAlive(BEAM_TARGET)))
		{
			BEAM_COUNT = 29;
		}
		if (!(IsEntityAlive(BEAM_TARGET))) return;
		npcatk_faceattacker(BEAM_TARGET);
		string BEAM_START = GetMonsterProperty("origin");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		BEAM_START += FINGER_ADJ;
		string BEAM_END = GetEntityOrigin(BEAM_TARGET);
		string BEAM_TRACE = TraceLine(BEAM_START, BEAM_END);
		if (!(BEAM_TRACE == BEAM_END)) return;
		EmitSound(GetOwner(), 0, SOUND_BEAM, 10);
		Effect("beam", "end", "lgtning.spr", 30, BEAM_START, BEAM_TARGET, 0, Vector3(200, 255, 50), 200, 30, 1.0);
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		MY_YAW += BEAM_COUNT;
		if (MY_YAW > 359)
		{
			MY_YAW -= 359;
		}
		string VEL_SET = /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(500, 1000, 30));
		SetVelocity(BEAM_TARGET, VEL_SET);
		DoDamage(BEAM_TARGET, "direct", DMG_PUSH_BEAM, 1.0, GetEntityIndex(GetOwner()));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(false))
		{
			ATTACK_MOVERANGE = GetMonsterProperty("moveprox");
		}
		if ((false))
		{
			ATTACK_MOVERANGE = ATTACK_RANGE;
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetGameTime() > NEXT_SUMMON)) return;
		if (!(LHOR_NSUMMONS < SORC_MAX_SUMMONS)) return;
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += LHOR_SUMMON_FREQ;
		summon_lhor();
	}

	void summon_lhor()
	{
		if ((NO_SUMMON)) return;
		string SUMMON_POS = GetEntityOrigin(GetOwner());
		SUMMON_POS += "z";
		SpawnNPC(LHOR_SUMMON_SCRIPT, SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), m_hAttackTarget
		LHOR_NSUMMONS += 1;
	}

	void horror_died()
	{
		LHOR_NSUMMONS -= 1;
		NEXT_SUMMON = GetGameTime();
		NEXT_SUMMON += LHOR_SUMMON_FREQ;
	}

	void set_turret()
	{
		AM_TURRET = 1;
		SetMoveAnim(ANIM_IDLE);
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
	}

	void OnPostSpawn() override
	{
		if (!(AM_TURRET)) return;
		SetMoveAnim(ANIM_IDLE);
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
	}

	void set_sorcpal_shaman1()
	{
		SetSayTextRange(2048);
		SayText("Fear the thunder! Feel the lightning!");
	}

}

}
