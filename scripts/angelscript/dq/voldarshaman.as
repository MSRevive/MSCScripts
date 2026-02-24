#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class Voldarshaman : CGameScript
{
	int AIM_RATIO;
	string ANIM_ATTACK;
	string ANIM_FIRE;
	string ANIM_SWIPE;
	string ANIM_WARCRY;
	int ATTACK_ACCURACY;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	float BURN_DAMAGE;
	string DEATH_SCRIPT;
	int DELAY_SOUND;
	int DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int FIRE_BALL_DAMAGE;
	int FIRE_BALL_DELAY;
	float FIRE_BALL_FREQ;
	float FLINCH_CHANCE;
	string GLOW_COLOR;
	int GLOW_RAD;
	int I_R_GLOWING;
	int MELE_HITRANGE;
	int MELE_RANGE;
	int MOVE_RANGE;
	string MY_LIGHT_SCRIPT;
	string NPC_DEATH_MSG;
	int NPC_GIVE_EXP;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	string SOUND_FIRECHARGE;
	string SOUND_FIRESHOOT;
	string SOUND_MELEHIT;
	string SOUND_MELEMISS;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;
	int SWIPE_DAMAGE;
	int SWIPE_SOUNDS;

	Voldarshaman()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 100;
		ANIM_ATTACK = "swordswing1_L";
		FLINCH_CHANCE = 0.45;
		AIM_RATIO = 50;
		MOVE_RANGE = 256;
		ATTACK_RANGE = 5500;
		ATTACK_SPEED = 200;
		ATTACK_CONE_OF_FIRE = 2;
		MELE_RANGE = 96;
		MELE_HITRANGE = 128;
		ATTACK_ACCURACY = 80;
		ANIM_SWIPE = "swordswing1_L";
		ANIM_FIRE = "swordswing1_L";
		ANIM_WARCRY = "warcry";
		SWIPE_DAMAGE = "$rand(25,65)";
		SOUND_MELEMISS = "zombie/claw_miss1.wav";
		SOUND_MELEHIT = "zombie/claw_strike3.wav";
		SOUND_FIRECHARGE = "bullchicken/bc_attack1.wav";
		SOUND_FIRESHOOT = "bullchicken/bc_attack3.wav";
		SOUND_WARCRY1 = "monsters/orc/attack1.wav";
		SOUND_WARCRY2 = "monsters/orc/attack3.wav";
		FIRE_BALL_DAMAGE = "$rand(75,100)";
		BURN_DAMAGE = "$randf(10,20)";
		FIRE_BALL_FREQ = 2.0;
		DEATH_SCRIPT = "monsters/horror";
		NPC_DEATH_MSG = "You have slain one of Voldar's shamans";
		Precache("controller/con_idle1.wav");
		Precache("controller/con_idle2.wav");
		Precache("controller/con_idle3.wav");
		Precache("controller/con_attack1.wav");
		Precache("controller/con_attack2.wav");
		Precache("controller/con_attack3.wav");
		Precache("controller/con_die1.wav");
		Precache("debris/bustflesh2.wav");
		Precache("controller/con_pain1.wav");
		Precache("controller/con_die2.wav");
		Precache("bullchicken/bc_attack3.wav");
		Precache("bullchicken/bc_attack2.wav");
		Precache("ambience/steamburst1.wav");
		Precache("monsters/bat/flap_big1.wav");
		Precache("monsters/bat/flap_big2.wav");
		Precache("player/pl_fallpain1.wav");
		Precache("monsters/edwardgorey.mdl");
	}

	void orc_spawn()
	{
		SetProp(GetOwner(), "skin", 3);
		SetHealth(220);
		SetName("one of|Voldar's Shamans");
		SetHearingSensitivity(8);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("lightning", 3.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		SetStat("spellcasting", 30);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void npc_selectattack()
	{
		if ((DELAY_SOUND)) return;
		if ((CanSee("enemy", MELE_RANGE))) return;
		DELAY_SOUND = 1;
		EmitSound(GetOwner(), 0, SOUND_FIRECHARGE, 10);
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
			if ((CanSee("enemy", MOVE_RANGE)))
			{
				ANIM_ATTACK = ANIM_WARCRY;
			}
		}
		if ((FIRE_BALL_DELAY)) return;
		ANIM_ATTACK = ANIM_FIRE;
		throw_fireball();
	}

	void throw_fireball()
	{
		if (!(false)) return;
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		TossProjectile("proj_acid_bolt", /* TODO: $relpos */ $relpos(0, 48, 18), "none", ATTACK_SPEED, FIRE_BALL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		DELAY_SOUND = 0;
	}

	void reset_fireball()
	{
		ANIM_ATTACK = ANIM_FIRE;
		DID_WARCRY = 0;
		FIRE_BALL_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SpawnNPC(DEATH_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 20), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(m_hLastStruck)
		SpawnNPC("monsters/summon/npc_poison_cloud2", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 10.0, 1
	}

	void swipe_attack()
	{
		if (GetEntityRange(m_hAttackTarget) > MELE_RANGE)
		{
			throw_fireball();
		}
		SWIPE_SOUNDS = 1;
		npcatk_dodamage(param1, MELE_HITRANGE, SWIPE_DAMAGE, ATTACK_ACCURACY);
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
			ApplyEffect(param2, "effects/dot_poison", RandomInt(5, 10), GetEntityIndex(GetOwner()), Random(10, 40));
		}
		SWIPE_SOUNDS = 0;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (!(GetEntityRange(m_hLastStruck) < MELE_RANGE)) return;
		ANIM_ATTACK = ANIM_SWIPE;
		npcatk_settarget(GetEntityIndex(m_hLastStruck));
	}

	void npc_attack()
	{
		if (!(ANIM_ATTACK == ANIM_WARCRY)) return;
		if ((DID_WARCRY)) return;
		// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2
		array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DID_WARCRY = 1;
	}

	void cycle_up()
	{
		if (!(true)) return;
		if (!(I_R_GLOWING))
		{
			light_on();
		}
	}

	void client_activate()
	{
		GLOW_RAD = 200;
		const int NO_LOOP_DETECT = 1;
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
	}

	void light_on()
	{
		if ((I_R_GLOWING)) return;
		I_R_GLOWING = 1;
		ClientEvent("persist", "all", currentscript, GetEntityIndex(GetOwner()), Vector3(0, 255, 0));
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
	}

}

}
