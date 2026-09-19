#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class WolfIce : CGameScript
{
	int AM_ALPHA;
	float CHANCE_BURN;
	int CUSTOM_WOLF;
	int CYCLES_STARTED;
	int DMG_BITE;
	int DMG_CLAW;
	int DOING_HOWL;
	int DOT_BURN;
	float FREQ_COMBAT_HOWL;
	int NEXT_HOWL;
	string NPC_GIVE_EXP;
	string NPC_PET_SCRIPT;
	string NPC_PET_TYPE;
	string SOUND_BURN;

	WolfIce()
	{
		NPC_PET_TYPE = "wolf_ice";
		NPC_PET_SCRIPT = "monsters/companion/pet_wolf_ice";
		if ((StringToLower(GetMapName())).findFirst("lodagond") >= 0)
		{
			NPC_GIVE_EXP = 800;
		}
		else
		{
			NPC_GIVE_EXP = 400;
		}
		CUSTOM_WOLF = 1;
		AM_ALPHA = 0;
		DOT_BURN = 70;
		DMG_BITE = RandomInt(50, 200);
		DMG_CLAW = RandomInt(50, 75);
		FREQ_COMBAT_HOWL = Random(15, 20);
		CHANCE_BURN = 0.3;
		SOUND_BURN = "magic/frost_reverse.wav";
	}

	void OnSpawn() override
	{
		SetName("Winter Wolf");
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetWidth(36);
		SetHeight(48);
		SetRoam(true);
		SetHealth(2000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.0);
		SetModelBody(0, 2);
		SetHearingSensitivity(8);
		NEXT_HOWL = 0;
	}

	void do_combat_howl()
	{
		if ((I_R_FROZEN)) return;
		DOING_HOWL = 1;
		PlayAnim("critical", ANIM_HOWL);
		// PlayRandomSound from: SOUND_HOWL1, SOUND_HOWL2
		array<string> sounds = {SOUND_HOWL1, SOUND_HOWL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(GetEntityOrigin(GetOwner()), 200, 0, 1.0, 0.0);
		ScheduleDelayedEvent(0.1, "end_combat_howl");
	}

	void end_combat_howl()
	{
		DOING_HOWL = 0;
		FREQ_COMBAT_HOWL("do_combat_howl");
	}

	void wolfatk_dodamage()
	{
		if ((param1))
		{
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
	}

	void game_dodamage()
	{
		if (!(DOING_HOWL)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		SendPlayerMessage(param2, "You hear a chilling howl!");
		ApplyEffect(param2, "effects/dot_cold_freeze", 5, GetOwner(), 1);
		DOING_HOWL = 0;
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_COMBAT_HOWL("do_combat_howl");
	}

}

}
