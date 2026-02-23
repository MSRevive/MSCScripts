#pragma context server

#include "monsters/orc_base_ranged.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcShamanFire : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_RANGE;
	string BURN_DAMAGE;
	int DID_WARCRY;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string FIRE_BALL_DAMAGE;
	int FIRE_BALL_DELAY;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	string MY_CL_SCRIPT_IDX;
	int NPC_GIVE_EXP;
	int NPC_IGNORE_PLAYERS;
	string POISON_TARGS;
	int SWIPE_SOUNDS;
	string WEAK_ATTACK;

	OrcShamanFire()
	{
		const string PROJECTILE_SCRIPT = "proj_fire_ball";
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 30);
		NPC_GIVE_EXP = 200;
		ANIM_ATTACK = "swordswing1_L";
		FLINCH_CHANCE = 0.45;
		const int AIM_RATIO = 50;
		MOVE_RANGE = 256;
		ATTACK_RANGE = 5500;
		const int ATTACK_SPEED = 500;
		const int ATTACK_CONE_OF_FIRE = 2;
		const string FIRE_BALL_DAMAGE_NORM = "$rand(75,100)";
		const string FIRE_BALL_DAMAGE_ALT = "$rand(5,10)";
		const int MELE_RANGE = 96;
		const int MELE_HITRANGE = 128;
		const int ATTACK_ACCURACY = 80;
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_FIRE = "swordswing1_L";
		const string ANIM_WARCRY = "warcry";
		const string SWIPE_DAMAGE = "$rand(25,65)";
		const string WEAK_SWIPE_DAMAGE = "$rand(5,20)";
		const string SOUND_MELEMISS = "zombie/claw_miss1.wav";
		const string SOUND_MELEHIT = "zombie/claw_strike3.wav";
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		const string SOUND_WARCRY1 = "monsters/orc/attack1.wav";
		const string SOUND_WARCRY2 = "monsters/orc/attack3.wav";
		const int BASE_BURN_DAMAGE = 15;
		BURN_DAMAGE = BASE_BURN_DAMAGE;
		const float FIRE_BALL_FREQ = 3.0;
		const string DEATH_SCRIPT = "traps/fire_wall2";
		const string FIRE_FIST_SCRIPT = "monsters/fire_fist_cl";
		Precache(DEATH_SCRIPT);
	}

	void orc_spawn()
	{
		SetHealth(220);
		SetName("Orc Fire Shaman");
		SetHearingSensitivity(8);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetStat("spellcasting", 30);
		FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_NORM;
		if (StringToLower(GetMapName()) == "mscave")
		{
			FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_ALT;
		}
		ClientEvent("persist", "all", FIRE_FIST_SCRIPT, GetEntityIndex(GetOwner()), 19);
		MY_CL_SCRIPT_IDX = "game.script.last_sent_id";
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void npc_selectattack()
	{
		if ((BO_ZOMBIE_MODE)) return;
		if ((FIRE_BALL_DELAY)) return;
		if ((CanSee("enemy", MELE_RANGE))) return;
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
		if ((BO_ZOMBIE_MODE)) return;
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
		if ((ORC_SHAMAN_CUSTOM_FIREBALL)) return;
		if (!(false)) return;
		FIRE_BALL_FREQ("reset_fireball");
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		string TARGET_ID = GetEntityIndex(m_hLastSeen);
		string AIM_ANGLE = GetEntityDist(TARGET_ID);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		string L_TARGET_RANGE = GetEntityRange(TARGET_ID);
		if (L_TARGET_RANGE <= 800)
		{
			TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 18), "none", ATTACK_SPEED, FIRE_BALL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		}
		if (L_TARGET_RANGE > 800)
		{
			TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 18), TARGET_ID, ATTACK_SPEED, FIRE_BALL_DAMAGE, ATTACK_CONE_OF_FIRE, "none");
		}
		float LIGHTEN_AMT = 0.4;
		if (L_TARGET_RANGE > 800)
		{
			float LIGHTEN_AMT = 0.01;
		}
		CallExternal(GetEntityIndex("ent_lastprojectile"), "lighten", BURN_DAMAGE, LIGHTEN_AMT);
		FIRE_BALL_DELAY = 1;
	}

	void reset_fireball()
	{
		ANIM_ATTACK = ANIM_FIRE;
		DID_WARCRY = 0;
		FIRE_BALL_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		orc_shaman_death();
	}

	void orc_shaman_death()
	{
		if ((ORC_SHAMAN_CUSTOM_DEATH)) return;
		ClientEvent("remove", "all", MY_CL_SCRIPT_IDX);
		if (!(GetGameTime() > G_FIRE_WALL_DELAY)) return;
		SetGlobalVar("G_FIRE_WALL_DELAY", GetGameTime());
		G_FIRE_WALL_DELAY += 2.0;
		if (!(BO_ZOMBIE_MODE))
		{
			CallExternal(GAME_MASTER, "gm_createnpc", 0.1, DEATH_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"));
		}
		else
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 0);
			EmitSound(GetOwner(), 0, "weapons/explode3.wav", 10);
			XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 256, 300, 0, GetOwner(), GetOwner(), "none", "fire_effect");
			ClientEvent("new", "all", "effects/sfx_explode", GetEntityOrigin(GetOwner()), 256);
			POISON_TARGS = FindEntitiesInSphere("enemy", 256);
			if (POISON_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(POISON_TARGS, ";"); i++)
			{
				poison_affect_targets();
			}
		}
	}

	void poison_affect_targets()
	{
		string CUR_TARG = GetToken(POISON_TARGS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), 100);
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void swipe_attack()
	{
		SWIPE_SOUNDS = 1;
		if (!(WEAK_ATTACK))
		{
			npcatk_dodamage(param1, MELE_HITRANGE, SWIPE_DAMAGE, ATTACK_ACCURACY);
		}
		if ((WEAK_ATTACK))
		{
			npcatk_dodamage(param1, MELE_HITRANGE, WEAK_SWIPE_DAMAGE, ATTACK_ACCURACY);
		}
		string DOT_FIRE = RandomInt(20, 40);
		if ((BO_ZOMBIE_MODE))
		{
			string DOT_FIRE = RandomInt(40, 100);
		}
		ApplyEffect(param1, "effects/dot_fire", RandomInt(5, 10), GetOwner(), DOT_FIRE);
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

	void OnPostSpawn() override
	{
		if (StringToLower(GetMapName()) == "mscave")
		{
			if (!(BO_ZOMBIE_MODE))
			{
			}
			SetName("Orc Fire Shaman Initiate");
			WEAK_ATTACK = 1;
			DROP_GOLD = 1;
			DROP_GOLD_AMT = RandomInt(15, 30);
			NPC_GIVE_EXP = 100;
			FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_ALT;
			BURN_DAMAGE = 5;
		}
	}

	void npcatk_setup_siege()
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME != "old_helena")) return;
		if (!(GetEntityRace(GetOwner()) != "hguard")) return;
		if (!(GetEntityRace(GetOwner()) != "human")) return;
		if (!(RandomInt(1, 3) == 1)) return;
		NPC_IGNORE_PLAYERS = 1;
		npcatk_npc_hunter_loop();
		if ((G_DEVELOPER_MODE))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 255);
		}
	}

}

}
