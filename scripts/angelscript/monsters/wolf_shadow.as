#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class WolfShadow : CGameScript
{
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int CYCLES_STARTED;
	int DOING_HOWL;
	int DROPS_CONTAINER;
	int IS_UNHOLY;
	int NEXT_HOWL;
	int NPC_GIVE_EXP;
	string NPC_PET_TYPE;

	WolfShadow()
	{
		NPC_PET_TYPE = "wolf_shadow";
		const string NPC_PET_SCRIPT = "monsters/companion/pet_wolf_shadow";
		const int NPC_BASE_EXP = 300;
		IS_UNHOLY = 1;
		const int CUSTOM_WOLF = 1;
		const int AM_ALPHA = 1;
		const int DOT_BURN = 40;
		const string DMG_BITE = Random(20, 50);
		const string DMG_CLAW = Random(10, 30);
		const string FREQ_COMBAT_HOWL = Random(15, 20);
		const int CHANCE_BURN = 30;
		const string SOUND_BURN = "ambience/steamburst1.wav";
		NPC_GIVE_EXP = 150;
	}

	void OnSpawn() override
	{
		SetName("Shadow Wolf");
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetWidth(36);
		SetHeight(48);
		SetRoam(true);
		SetHealth(900);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("holy", 1.0);
		NPC_GIVE_EXP = 30;
		SetModelBody(0, 3);
		SetHearingSensitivity(8);
		NEXT_HOWL = 0;
		SetGlobalVar("G_ALPHA", GetEntityIndex(GetOwner()));
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
			ApplyEffect(param2, "effects/dot_fire", 10, GetEntityIndex(GetOwner()), DOT_BURN);
			EmitSound(GetOwner(), 0, SOUND_BURN, 10);
			Effect("glow", GetOwner(), Vector3(255, 75, 0), 128, 1, 1);
		}
	}

	void game_dodamage()
	{
		if (!(DOING_HOWL)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		SendPlayerMessage(param2, "You hear a stunning howl!");
		ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
		DOING_HOWL = 0;
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_COMBAT_HOWL("do_combat_howl");
	}

	void sfor_extra_wolf()
	{
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 1.0;
		CONTAINER_SCRIPT = "chests/sfor_wolf";
	}

}

}
