#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcShamanIce : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	int ATTACK_RANGE;
	int DID_WARCRY;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	int FROST_BOLT_DELAY;
	int IS_FLEEING;
	int MADE_BLIZZARD;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int PURE_FLEE;
	int SWIPE_SOUNDS;

	MorcShamanIce()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 100;
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
		const string SOUND_ICESHOOT = "magic/ice_strike.wav";
		const string SOUND_DEATH_SHOOT = "magic/spawn.wav";
		const string SOUND_WARCRY1 = "monsters/orc/attack1.wav";
		const string SOUND_WARCRY2 = "monsters/orc/attack3.wav";
		const string SOUND_MAKEBLIZZ = "magic/heal_powerup.wav";
		const string FROST_BOLT_DAMAGE = "$rand(10,50)";
		const string FROST_STRIKE_DAMAGE = "$rand(10,20)";
		const float FROST_BOLT_FREQ = 1.0;
		const float BLIZZARD_DELAY = 20.0;
		const string DEATH_SCRIPT = "monsters/summon/ice_blast";
		Precache("monsters/summon/summon_blizzard");
		Precache("snow1.spr");
		Precache(DEATH_SCRIPT);
	}

	void orc_spawn()
	{
		SetHealth(320);
		SetName("Marogar Ice Shaman");
		SetRace("orc");
		SetHearingSensitivity(8);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.0);
		SetStat("spellcasting", 30);
		Precache("monsters/morc.mdl");
		SetModel("monsters/morc.mdl");
		BLIZZARD_DELAY("make_blizzard");
		SetModelBody(0, 0);
		SetModelBody(1, 2);
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
		if (NME_RANGE < MELE_HITRANGE)
		{
			if (RandomInt(1, 4) == 1)
			{
				ANIM_ATTACK = ANIM_KICK;
			}
		}
	}

	void swing_sword()
	{
		if ((CanSee("enemy", MELE_RANGE)))
		{
			ANIM_ATTACK = ANIM_SWIPE;
			swipe_attack(GetEntityIndex(m_hLastSeen));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			if (!(CanSee("enemy", MOVE_RANGE)))
			{
				ANIM_ATTACK = ANIM_RUN;
			}
		}
		ANIM_ATTACK = ANIM_FIRE;
		throw_frostbolt();
	}

	void throw_frostbolt()
	{
		if (!(false)) return;
		FROST_BOLT_FREQ("reset_frostbolt");
		EmitSound(GetOwner(), 0, SOUND_ICESHOOT, 10);
		string FINAL_DAMAGE = FROST_BOLT_DAMAGE;
		if (EXT_DAMAGE_ADJUSTMENT != "EXT_DAMAGE_ADJUSTMENT")
		{
			FINAL_DAMAGE += EXT_DAMAGE_ADJUSTMENT;
		}
		TossProjectile("proj_ice_bolt", /* TODO: $relpos */ $relpos(0, 48, 18), "none", ATTACK_SPEED, FINAL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
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
		SpawnNPC(DEATH_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
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
		ApplyEffect(param1, "effects/dot_cold", RandomInt(5, 10), GetOwner(), FROST_STRIKE_DAMAGE);
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

	void make_blizzard()
	{
		if ((MADE_BLIZZARD)) return;
		if (!(false))
		{
			BLIZZARD_DELAY("make_blizzard");
		}
		if (!(false)) return;
		npcatk_faceattacker(m_hAttackTarget);
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY1, 10);
		MADE_BLIZZARD = 1;
		IS_FLEEING = 1;
		PURE_FLEE = 1;
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 128, 3, 3);
		ScheduleDelayedEvent(1.5, "really_make_blizzard");
	}

	void really_make_blizzard()
	{
		string EFFECT_SCRIPT = "monsters/summon/summon_blizzard";
		int SET_DAMAGE = 20;
		int SET_DURATION = 10;
		EmitSound(GetOwner(), 0, SOUND_MAKEBLIZZ, 10);
		SpawnNPC(EFFECT_SCRIPT, GetEntityOrigin(m_hLastSeen), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), SET_DAMAGE, SET_DURATION
	}

	void warcry_done()
	{
		IS_FLEEING = 0;
		PURE_FLEE = 0;
	}

	void kick_land()
	{
		SWIPE_SOUNDS = 1;
		ANIM_ATTACK = ANIM_SWIPE;
		string FINAL_DAMAGE = SWIPE_DAMAGE;
		if (EXT_DAMAGE_ADJUSTMENT != "EXT_DAMAGE_ADJUSTMENT")
		{
			FINAL_DAMAGE += EXT_DAMAGE_ADJUSTMENT;
		}
		npcatk_dodamage(m_hLastStruckByMe, MELE_HITRANGE, FINAL_DAMAGE, ATTACK_ACCURACY);
		if (!(GetEntityRange(m_hLastStruckByMe) <= MELE_HITRANGE)) return;
		ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 50), 0);
		PURE_FLEE = 1;
		npcatk_flee(m_hLastSeen, 800, 5);
	}

}

}
