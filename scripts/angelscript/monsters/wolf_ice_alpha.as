#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class WolfIceAlpha : CGameScript
{
	int AM_ALPHA;
	string ANIM_ATTACK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	float CHANCE_BURN;
	int CHANCE_CLAW;
	string CHARGE_ATTACK;
	int CUSTOM_WOLF;
	int CYCLES_STARTED;
	string DID_BOOST;
	int DMG_BITE;
	int DMG_CLAW;
	float DMG_STORM;
	string DOING_HOWL;
	int DOT_BURN;
	float FREQ_COMBAT_HOWL;
	float FREQ_LEAP;
	int LEAP_DELAY;
	string MONSTER_MODEL;
	int NEXT_HOWL;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string SOUND_BURN;
	float STORM_DUR;
	int STORM_RAD;

	WolfIceAlpha()
	{
		if ((StringToLower(GetMapName())).findFirst("lodagond") == 0)
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 8000;
		}
		else
		{
			NPC_GIVE_EXP = 2000;
		}
		NPC_BOSS_REGEN_RATE = 0.05;
		NPC_BOSS_RESTORATION = 0.25;
		CUSTOM_WOLF = 1;
		AM_ALPHA = 1;
		DOT_BURN = 70;
		DMG_BITE = RandomInt(50, 200);
		DMG_CLAW = RandomInt(50, 75);
		FREQ_COMBAT_HOWL = 30.0;
		CHANCE_BURN = 0.3;
		SOUND_BURN = "magic/frost_reverse.wav";
		CHANCE_CLAW = 5;
		MONSTER_MODEL = "monsters/wolf_huge.mdl";
		FREQ_LEAP = 15.0;
		ATTACK_RANGE = 92;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 72;
		DMG_STORM = 20.0;
		STORM_DUR = 20.0;
		STORM_RAD = 800;
	}

	void game_precache()
	{
		Precache("monsters/summon/uber_blizzard");
	}

	void OnSpawn() override
	{
		SetName("Winter Alpha Wolf");
		if ((StringToLower(GetMapName())).findFirst("aleyesu") >= 0)
		{
			SetRace("demon");
		}
		else
		{
			SetRace("rogue");
		}
		SetModel(MONSTER_MODEL);
		SetWidth(48);
		SetHeight(72);
		SetRoam(true);
		SetHealth(9000);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.0);
		SetModelBody(0, 1);
		SetHearingSensitivity(8);
		NEXT_HOWL = 0;
		SetGlobalVar("G_ALPHA", GetEntityIndex(GetOwner()));
	}

	void do_combat_howl()
	{
		if ((CYCLED_UP))
		{
			DOING_HOWL = 1;
			PlayAnim("critical", ANIM_HOWL);
			// PlayRandomSound from: SOUND_HOWL1, SOUND_HOWL2
			array<string> sounds = {SOUND_HOWL1, SOUND_HOWL2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ice_storm();
			DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 512, 0, 1.0, 0.0);
			ApplyEffect(GetOwner(), "effects/iceshield", 20, GetEntityIndex(GetOwner()), 0.4);
		}
		ScheduleDelayedEvent(0.1, "end_combat_howl");
	}

	void end_combat_howl()
	{
		EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
		DOING_HOWL = 0;
		FREQ_COMBAT_HOWL("do_combat_howl");
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if (!(DOING_HOWL))
			{
			}
			if (!(CHARGE_ATTACK))
			{
			}
			if (RandomInt(1, 100) < CHANCE_BURN)
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			ApplyEffect(param2, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), DOT_BURN);
			EmitSound(GetOwner(), 0, SOUND_BURN, 10);
			Effect("glow", GetOwner(), Vector3(0, 75, 255), 128, 1, 1);
		}
		if (!(DOING_HOWL)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_cold_freeze", 5, 1, 1);
		DOING_HOWL = 0;
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_COMBAT_HOWL("do_combat_howl");
	}

	void bite1()
	{
		ATTACK_TYPE = "bite";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, "slash");
		atk_sound();
		if (!(RandomInt(1, 100) < CHANCE_CLAW)) return;
		if ((LEAP_DELAY)) return;
		LEAP_DELAY = 1;
		FREQ_LEAP("reset_leap_delay");
		ANIM_ATTACK = ANIM_CLAW;
	}

	void reset_leap_delay()
	{
		LEAP_DELAY = 0;
	}

	void npcatk_attack()
	{
		if (ANIM_ATTACK == "attack2")
		{
			if (!(DID_BOOST))
			{
			}
			DID_BOOST = 1;
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 50));
			CHARGE_ATTACK = 1;
			ScheduleDelayedEvent(1.0, "reset_charge_attack");
			charge_loop();
		}
		if (ANIM_ATTACK != "attack2")
		{
			DID_BOOST = 0;
		}
	}

	void reset_charge_attack()
	{
		CHARGE_ATTACK = 0;
	}

	void charge_loop()
	{
		if (!(CHARGE_ATTACK)) return;
		ScheduleDelayedEvent(0.1, "charge_loop");
		XDoDamage(/* TODO: $relpos */ $relpos(0, 32, 0), 96, 20, 1.0, GetOwner(), GetOwner(), "none", "target", "dmgevent:push");
	}

	void push_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 1000, 0));
	}

	void ice_storm()
	{
		string BLIZ_LOC = /* TODO: $relpos */ $relpos(0, 0, 0);
		string SUMMON_POINT1 = FindEntityByName("summon_point1");
		if (((SUMMON_POINT1 !is null)))
		{
			string BLIZ_LOC = GetEntityOrigin(SUMMON_POINT1);
		}
		SpawnNPC("monsters/summon/uber_blizzard", BLIZ_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_STORM, STORM_DUR, STORM_RAD, 0.3
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			fade_blue();
		}
	}

	void fade_blue()
	{
		string CHECK_ENT = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CHECK_ENT) < STORM_RAD)) return;
		Effect("screenfade", CHECK_ENT, 5, 0, Vector3(0, 0, 192), 128, "fadein");
	}

	void npcatk_set_skill()
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if ((NPC_IS_BOSS))
		{
			NPC_GIVE_EXP = 4000;
		}
		if (!(NPC_IS_BOSS))
		{
			NPC_GIVE_EXP = 1000;
		}
		if ((L_MAP_NAME).findFirst("lodagond") >= 0)
		{
			NPC_GIVE_EXP *= 1.75;
		}
		if ((L_MAP_NAME).findFirst("old_helena") >= 0)
		{
			NPC_GIVE_EXP *= 0.5;
		}
		if ((NPC_EXP_MULTI))
		{
			NPC_GIVE_EXP *= NPC_EXP_MULTI;
		}
		if (NPC_GIVE_EXP != 0)
		{
			SetSkillLevel(NPC_GIVE_EXP);
		}
	}

}

}
