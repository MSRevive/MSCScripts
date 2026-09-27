#pragma context server

#include "monsters/companion/pet_wolf.as"

namespace MS
{

class PetWolfIce : CGameScript
{
	string ACT_NAME;
	int ATTACK_HITCHANCE;
	int BASE_DMG;
	int BASE_HP;
	int CHANCE_CLAW;
	int COMPANION_MAXHP;
	string COMPANION_TYPE;
	float DMG_BITE;
	float DMG_CLAW;
	int DOT_ICE;
	string FREEZE_TARGS;
	float FREQ_COMBAT_HOWL;
	float FREQ_HOWL;
	float FREQ_IDLE;
	float FREQ_LOOK;
	int LEAP_RANGE;
	int MAX_DMG;
	int MELEE_ATTACK;
	string NEXT_COMBAT_HOWL;
	int NEXT_HOWL;
	string NPC_REVIVAL_SCRIPT;
	int SUMMON_CIRCLE_INDEX;
	float XPDMG_MULTI;

	PetWolfIce()
	{
		SUMMON_CIRCLE_INDEX = 7;
		BASE_HP = 1000;
		COMPANION_MAXHP = 8000;
		MAX_DMG = 125;
		XPDMG_MULTI = 0.02;
		BASE_DMG = 20;
		COMPANION_TYPE = "wolf";
		ACT_NAME = "pet winter wolf";
		NPC_REVIVAL_SCRIPT = currentscript;
		ATTACK_HITCHANCE = 90;
		LEAP_RANGE = 256;
		DMG_BITE = Random(10.0, 15.0);
		DMG_CLAW = Random(10.0, 20.0);
		FREQ_LOOK = 20.0;
		FREQ_IDLE = Random(10, 30);
		FREQ_HOWL = Random(30, 60);
		CHANCE_CLAW = 50;
		DOT_ICE = 5;
		FREQ_COMBAT_HOWL = 30.0;
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
			int FREEZE_CHANCE = RandomInt(1, 2);
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
