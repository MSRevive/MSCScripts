#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class SorcShamanLesser : CGameScript
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
	int MOVE_RANGE;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	int REPULSE_DELAY;
	int SWIPE_SOUNDS;

	SorcShamanLesser()
	{
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
		const string SOUND_BEAM = "weather/Storm_exclamation.wav";
		const string ANIM_BEAM = "battleaxe_swing1_L";
		FREQ_REPULSE = Random(15, 20);
		const string DMG_PUSH_BEAM = Random(2, 6);
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 220;
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
		const string FROST_BOLT_DAMAGE = "$rand(25,60)";
		const string FROST_STRIKE_DAMAGE = "$rand(10,20)";
		const float FROST_BOLT_FREQ = 1.5;
		const string DEATH_SCRIPT = "monsters/summon/summon_lightning_storm";
		BALL_SIZE = 3;
		BALL_DMG = 10;
		BALL_TYPE = "lightning";
	}

	void orc_spawn()
	{
		SetHealth(750);
		SetName("Shadahar Shaman Initiate");
		SetHearingSensitivity(8);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("poison", 2.0);
		SetDamageResistance("acid", 2.0);
		SetStat("spellcasting", 30);
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 0);
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
		REPULSE_DELAY = 1;
		FREQ_REPULSE("reset_repulse_delay");
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
		TossProjectile("proj_lightning_ball", /* TODO: $relpos */ $relpos(0, 48, 18), m_hAttackTarget, ATTACK_SPEED, FINAL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		FROST_BOLT_DELAY = 1;
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
		string BALL_DEST = /* TODO: $relpos */ $relpos(0, 0, 2000);
		EmitSound(GetOwner(), 0, SOUND_DEATH_SHOOT, 10);
		string STORM_POS = GetMonsterProperty("origin");
		STORM_POS = "z";
		SpawnNPC(DEATH_SCRIPT, STORM_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), 40.0, 15.0
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
		if (!(m_hAttackTarget != "unset")) return;
		if (!(false))
		{
			ATTACK_MOVERANGE = GetMonsterProperty("moveprox");
		}
		if ((false))
		{
			ATTACK_MOVERANGE = ATTACK_RANGE;
		}
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

}

}
