#pragma context server

#include "monsters/companion/pet_wolf.as"

namespace MS
{

class PetWolfIce : CGameScript
{
	string ACT_NAME;
	string COMPANION_TYPE;
	string FREEZE_TARGS;
	int MELEE_ATTACK;
	string NEXT_COMBAT_HOWL;
	int NEXT_HOWL;
	string NPC_REVIVAL_SCRIPT;

	PetWolfIce()
	{
		const int SUMMON_CIRCLE_INDEX = 7;
		const int BASE_HP = 1000;
		const int COMPANION_MAXHP = 8000;
		const int MAX_DMG = 125;
		const float XPDMG_MULTI = 0.02;
		const int BASE_DMG = 20;
		COMPANION_TYPE = "wolf";
		ACT_NAME = "pet winter wolf";
		NPC_REVIVAL_SCRIPT = currentscript;
		const int ATTACK_HITCHANCE = 90;
		const int LEAP_RANGE = 256;
		const string DMG_BITE = Random(10.0, 15.0);
		const string DMG_CLAW = Random(10.0, 20.0);
		const float FREQ_LOOK = 20.0;
		const string FREQ_IDLE = Random(10, 30);
		const string FREQ_HOWL = Random(30, 60);
		const int CHANCE_CLAW = 50;
		const int DOT_ICE = 5;
		const float FREQ_COMBAT_HOWL = 30.0;
	}

	void pet_spawn()
	{
		SetName("pet winter wolf");
		SetRace("human");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(0, 3);
		SetHearingSensitivity(8);
		SetWidth(36);
		SetHeight(48);
		SetRoam(false);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", 0);
		SetDamageResistance("fire", 1.5);
		NEXT_HOWL = 0;
		CatchSpeech("say_sit", "sit");
		CatchSpeech("say_speak", "speak");
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (RandomInt(1, 4) == 1)
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			if (!(IsValidPlayer(param2)))
			{
			}
			ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_ICE);
			EmitSound(GetOwner(), 0, "magic/frost_reverse.wav", 10);
			Effect("glow", GetOwner(), Vector3(0, 75, 255), 128, 1, 1);
		}
		MELEE_ATTACK = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) < 75)) return;
		if (!(GetGameTime() > NEXT_COMBAT_HOWL)) return;
		NEXT_COMBAT_HOWL = GetGameTime();
		NEXT_COMBAT_HOWL += FREQ_COMBAT_HOWL;
		do_combat_howl();
	}

	void do_combat_howl()
	{
		npcatk_suspend_ai(1.0);
		if ((IsEntityAlive(GetOwner())))
		{
			PlayAnim("critical", ANIM_HOWL);
		}
		// PlayRandomSound from: SOUND_HOWL1, SOUND_HOWL2
		array<string> sounds = {SOUND_HOWL1, SOUND_HOWL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ClientEvent("new", "all", "effects/sfx_ice_burst", GetEntityOrigin(GetOwner()), 128, 1, Vector3(128, 128, 255));
		FREEZE_TARGS = FindEntitiesInSphere("enemy", 128);
		if (!(FREEZE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FREEZE_TARGS, ";"); i++)
		{
			freeze_targets();
		}
	}

	void freeze_targets()
	{
		string CUR_TARG = GetToken(FREEZE_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG))) return;
		int FREEZE_CHANCE = 1;
		if (GetEntityMaxHealth(GetOwner()) > 3000)
		{
			string FREEZE_CHANCE = RandomInt(1, 2);
		}
		if (FREEZE_CHANCE == 1)
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_ICE);
		}
		else
		{
			ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", 5.0, GetEntityIndex(GetOwner()));
		}
	}

}

}
