#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandHealingCircle : CGameScript
{
	string LAST_ATTACK;
	int MANA_COST;
	int MELEE_ATK_DURATION;
	string NEAR_SEAL;
	int NO_REGISTER;
	string OWNER_LOC;
	int SET_DELETE;
	string SOUND_SHOOT;
	int SPELL_ENERGYDRAIN;
	int SPELL_PREPARE_TIME;
	string SPELL_SCRIPT;
	int SPELL_SKILL_REQUIRED;

	MagicHandHealingCircle()
	{
		NO_REGISTER = 1;
		SOUND_SHOOT = "magic/cast.wav";
		SPELL_SKILL_REQUIRED = 18;
		SPELL_PREPARE_TIME = 1;
		SPELL_ENERGYDRAIN = 50;
		MANA_COST = 150;
		MELEE_ATK_DURATION = 4;
		SPELL_SCRIPT = "monsters/summon/circle_of_healing";
		Precache(SPELL_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Healing Circle");
		SetDescription("A large magic circle that heals all allies within");
	}

	void game_attack1()
	{
		float TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_ATTACK;
		if (!(TIME_DIFF > MELEE_ATK_DURATION)) return;
		LAST_ATTACK = GetGameTime();
		// TODO: splayviewanim ent_me ANIM_CAST
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		EmitSound(GetOwner(), "game.sound.item", SOUND_CHARGE, "game.sound.maxvol");
		if (GetEntityMP(GetOwner()) < MANA_COST)
		{
			SendColoredMessage(GetOwner(), "Insufficient mana.");
		}
		if (!(GetEntityMP(GetOwner()) >= MANA_COST)) return;
		ScheduleDelayedEvent(0.5, "make_circle");
	}

	void make_circle()
	{
		SET_DELETE = 0;
		OWNER_LOC = GetEntityOrigin(GetOwner());
		NEAR_SEAL = FindEntitiesInSphere("any", 230);
		if ((G_DEVELOPER_MODE))
		{
			SendColoredMessage(GetOwner(), "make_circle: " + GetTokenCount(NEAR_SEAL, ";"));
		}
		for (int i = 0; i < GetTokenCount(NEAR_SEAL, ";"); i++)
		{
			check_if_near();
		}
		ScheduleDelayedEvent(0.1, "make_circle2");
	}

	void check_if_near()
	{
		string CUR_ENT = GetToken(NEAR_SEAL, i, ";");
		if ((G_DEVELOPER_MODE))
		{
			LogMessage("ent_owner make_circle->check_if_near: found " + GetEntityName(CUR_ENT));
		}
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(CUR_ENT, "hc", "name_exists"))) return;
		if ((SET_DELETE)) return;
		SET_DELETE = 1;
		SendColoredMessage(GetOwner(), "Healing Circle: Cannot create one healing circle within another.");
	}

	void make_circle2()
	{
		if ((SET_DELETE)) return;
		// svplaysound: svplaysound 0 10 SOUND_SHOOT
		EmitSound(0, 10, SOUND_SHOOT);
		GiveMP(/* TODO: $neg */ $neg(MANA_COST));
		CallExternal(GetOwner(), "mana_drain");
		string HEAL_POWER = GetSkillLevel(GetOwner(), "spellcasting.divination");
		HEAL_POWER /= 2;
		OWNER_LOC = "z";
		SpawnNPC(SPELL_SCRIPT, OWNER_LOC, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetStat(GetOwner(), "concentration"), HEAL_POWER
		DeleteEntity(GetOwner());
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_CHARGE
		EmitSound(0, 0, SOUND_CHARGE);
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

}

}
