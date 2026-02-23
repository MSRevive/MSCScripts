#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class DjinnFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HUNT;
	int DID_ROAR_INTRO;
	string DROP_ITEM1;
	string DROP_ITEM1_CHANCE;
	string FIRE_SCRIPT;
	int HUNT_AGRO;
	int IS_UNHOLY;
	int I_ATTACKED;
	int MOVE_RANGE;
	string MY_ICE_TROLL;
	int NO_SUMMON;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string PUSH_VEL;
	string SUMMON_NEXT_CHECK;

	DjinnFire()
	{
		if (StringToLower(GetMapName()) == "demontemple")
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 3000;
			if ((G_DEVELOPER_MODE))
			{
				SendInfoMessageToAll("green Djinn Var-sul set BOSS MODE");
			}
		}
		else
		{
			NPC_GIVE_EXP = 800;
		}
		const float NPC_BOSS_REGEN_RATE = 0.1;
		const float NPC_BOSS_RESTORATION = 1.0;
		IS_UNHOLY = 1;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK1 = "monsters/troll/trollattack.wav";
		const string SOUND_ATTACK2 = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK = "monsters/troll/walk.wav";
		const string SOUND_SUMMON = "ambience/particle_suck2.wav";
		const string SOUND_ROAR = "monsters/troll/trollidle2.wav";
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		Precache(SOUND_STRUCK1);
		Precache(SOUND_STRUCK2);
		Precache(SOUND_ATTACK1);
		Precache(SOUND_ATTACK2);
		Precache(SOUND_WALK);
		Precache(SOUND_DEATH);
		Precache(SOUND_SUMMON);
		Precache(SOUND_ROAR);
		const int PUSH_CHANCE = 10;
		const int GOLD_BAGS = 1;
		const int GOLD_BAGS_PPLAYER = 3;
		const int GOLD_PER_BAG = 50;
		const int GOLD_RADIUS = 64;
		const int GOLD_MAX_BAGS = 32;
		ANIM_IDLE = "idle0";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "double_punch";
		ANIM_DEATH = "die_fall";
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		MOVE_RANGE = 100;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 1;
		const string SUMMON_SCRIPT = "monsters/troll_fire";
		const string TORCH_LIGHT_SCRIPT = "items/item_djinn_fire";
		const string FIRE_DAMAGE = "$rand(50,150)";
		Precache(TORCH_LIGHT_SCRIPT);
	}

	void OnSpawn() override
	{
		SetHealth(4000);
		SetWidth(100);
		SetHeight(100);
		SetRace("demon");
		SetName("Fire Djinn Val-sul");
		SetRoam(false);
		SetDamageResistance("all", 0.7);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("lightning", 0.5);
		SetHearingSensitivity(10);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("holy", 0.25);
		SetModel("monsters/troll.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		ScheduleDelayedEvent(10.0, "summon_firetroll");
		SetGlobalVar("ICE_TROLL_DEAD", 1);
		troll_spawn();
		ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), 1);
		FIRE_SCRIPT = "game.script.last_sent_id";
		Effect("glow", GetOwner(), Vector3(128, 50, 4), 64, -1, 0);
		Precache("monsters/firetroll.mdl");
		if (RandomInt(1, 16) < "game.playersnb")
		{
			DROP_ITEM1 = "item_eh";
			DROP_ITEM1_CHANCE = 100;
		}
	}

	void attack_1()
	{
		I_ATTACKED = 1;
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 30, 10);
		if (GetEntityRange(HUNT_LASTTARGET) <= ATTACK_HITRANGE)
		{
			XDoDamage(HUNT_LASTTARGET, "direct", Random(45, 80), 0.75, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:swing");
		}
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = "hit_down";
		}
		attack_sound();
	}

	void attack_2()
	{
		I_ATTACKED = 1;
		if (GetEntityRange(HUNT_LASTTARGET) <= ATTACK_HITRANGE)
		{
			XDoDamage(HUNT_LASTTARGET, "direct", Random(80, 200), 0.75, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:swing");
		}
		ANIM_ATTACK = "double_punch";
		if (RandomInt(1, PUSH_CHANCE) == 1)
		{
			ScheduleDelayedEvent(0.1, "rawr");
			ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
		}
		attack_sound();
	}

	void swing_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/dot_fire", 3, GetEntityIndex(GetOwner()), FIRE_DAMAGE);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK2};
		EmitSound(GetOwner(), CHAN_BODY, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", FIRE_SCRIPT);
		if (MY_ICE_TROLL != "MY_ICE_TROLL")
		{
			DeleteEntity(MY_ICE_TROLL, true); // fade out
		}
		ClientEvent("remove", "all", SCRIPT_ID);
		ClientEvent("remove", TORCH_LIGHT_SCRIPT);
		ClientEvent("remove", "all", TORCH_LIGHT_SCRIPT);
	}

	void summon_firetroll()
	{
		if ((NO_SUMMON)) return;
		ScheduleDelayedEvent(10.0, "summon_firetroll");
		if ((IsEntityAlive(MY_ICE_TROLL))) return;
		int EXIT_SUB = 0;
		if (!(SUMMON_NEXT_CHECK))
		{
			SUMMON_NEXT_CHECK = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(false)) return;
		if (MY_ICE_TROLL != "MY_ICE_TROLL")
		{
			DeleteEntity(MY_ICE_TROLL, true); // fade out
		}
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SUMMON);
		string SUMMON_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		PlayAnim("critical", "throw_rock");
		string SUMMON_POINT1 = FindEntityByName("summon_point1");
		if (((SUMMON_POINT1 !is null)))
		{
			string SUMMON_POS = GetEntityOrigin(SUMMON_POINT1);
		}
		if (!((SUMMON_POINT1 !is null)))
		{
			SetSolid("none");
		}
		SpawnNPC(SUMMON_SCRIPT, SUMMON_POS, ScriptMode::Legacy);
		ScheduleDelayedEvent(1, "solidify_djinn");
		MY_ICE_TROLL = GetEntityIndex(m_hLastCreated);
		if (I_AM_BEAR == 1)
		{
			CallExternal(MY_ICE_TROLL, "bearguard");
		}
		SUMMON_NEXT_CHECK = 0;
		if (!(IS_FLEEING))
		{
			npcatk_flee(MY_ICE_TROLL, 275, 3);
		}
	}

	void solidify_djinn()
	{
		string MY_LOC = GetEntityOrigin(GetOwner());
		string MY_PET_LOC = GetEntityOrigin(MY_ICE_TROLL);
		string PET_DISTANCE = Distance(MY_LOC, MY_PET_LOC);
		if (PET_DISTANCE > 80)
		{
			SetSolid("box");
		}
		if (PET_DISTANCE <= 80)
		{
			ScheduleDelayedEvent(0.25, "solidify_djinn");
		}
	}

	void npc_targetsighted()
	{
		if ((DID_ROAR_INTRO)) return;
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_ROAR);
		DID_ROAR_INTRO = 1;
	}

	void rawr()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_ROAR);
	}

	void my_pet_stuck()
	{
		DeleteEntity(MY_ICE_TROLL, true); // fade out
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SUMMON);
		string SUMMON_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		AS_ATTACKING = 20;
		PlayAnim("critical", "throw_rock");
		SetSolid("none");
		SpawnNPC(SUMMON_SCRIPT, SUMMON_POS, ScriptMode::Legacy);
		ScheduleDelayedEvent(1.0, "solidify_djinn");
		MY_ICE_TROLL = GetEntityIndex(m_hLastCreated);
		SUMMON_NEXT_CHECK = 0;
		if (!(IS_FLEEING))
		{
			npcatk_flee(MY_ICE_TROLL, 275, 3);
		}
	}

	void stomp_1()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK1, 8);
	}

	void stomp_2()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK2, 8);
	}

	void cycle_up()
	{
		if ((CYCLED_UP)) return;
		SetRoam(true);
	}

	void set_no_summons()
	{
		NO_SUMMON = 1;
	}

}

}
