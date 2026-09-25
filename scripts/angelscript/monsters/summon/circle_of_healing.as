#pragma context server

#include "monsters/summon/base_aoe.as"

namespace MS
{

class CircleOfHealing : CGameScript
{
	float AOE_FREQ;
	string AOE_FRIEND_FOE;
	int AOE_RADIUS;
	int CIRCLE_RADIUS;
	string DIV_SKILL;
	string HEAL_AMT;
	int IS_ACTIVE;
	string MY_DURATION;
	string MY_OWNER;
	string NEAR_SEAL;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	float PULSE_PLAYTIME;
	string SEAL_MODEL;
	int SEAL_OFS;
	int SET_DELETE;
	string SOUND_PULSE;

	CircleOfHealing()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		SEAL_OFS = 26;
		SOUND_PULSE = "ambience/alien_zonerator.wav";
		CIRCLE_RADIUS = 172;
		PULSE_PLAYTIME = 10.0;
		AOE_RADIUS = 172;
		AOE_FREQ = 1.0;
		AOE_FRIEND_FOE = "ally";
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DURATION = param2;
		HEAL_AMT = param3;
		DIV_SKILL = GetSkillLevel(MY_OWNER, "spellcasting.divination");
		OWNER_ISPLAYER = IsValidPlayer(param1);
		MY_DURATION("aoe_end");
	}

	void OnSpawn() override
	{
		SetName("Circle of Healing");
		SetHealth(1);
		SetInvincible(true);
		SetRace("beloved");
		SetGravity(0.0);
		SetBloodType("none");
		SetModel(SEAL_MODEL);
		SetModelBody(0, SEAL_OFS);
		SetSolid("none");
		DropToFloor();
		SetNoPush(true);
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(0.1, "make_seal");
		// svplaysound: svplaysound 2 10 SOUND_PULSE
		EmitSound(2, 10, SOUND_PULSE);
		SetScriptFlags(GetEntityIndex(GetOwner()), "add", "hc", "hc");
	}

	void make_seal()
	{
		NEAR_SEAL = FindEntitiesInSphere("ally", AOE_RADIUS);
		for (int i = 0; i < GetTokenCount(NEAR_SEAL, ";"); i++)
		{
			check_if_near();
		}
	}

	void check_if_near()
	{
		string CUR_ENT = GetToken(NEAR_SEAL, i, ";");
		if (!((GetEntityName(NEAR_SEAL)).findFirst("Healing") >= 0)) return;
		if ((SET_DELETE)) return;
		SET_DELETE = 1;
		SendColoredMessage(MY_OWNER, "Healing Circle: Cannot create one healing circle within another.");
	}

	void apply_aoe_effect()
	{
		if ((GetEntityName(param1)).findFirst("Spell") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(param1, "itemname")).findFirst("circle_of_heal") >= 0)
		{
			aoe_end();
		}
		if (!(GetEntityHealth(param1) < GetEntityMaxHealth(param1))) return;
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		ApplyEffect(param1, "effects/effect_rejuv2", 0, HEAL_AMT, MY_OWNER);
		if ((IsValidPlayer(param1)))
		{
			int L_ADD_POINTS = 1;
		}
		if ((GetEntityProperty(param1, "scriptvar")))
		{
			int L_ADD_POINTS = 1;
		}
		if ((L_ADD_POINTS))
		{
			if (param1 != MY_OWNER)
			{
			}
			CallExternal(MY_OWNER, "add_damage_points", HEAL_AMT);
		}
	}

	void aoe_end()
	{
		// svplaysound: svplaysound 2 0 SOUND_PULSE
		EmitSound(2, 0, SOUND_PULSE);
		IS_ACTIVE = 0;
		if (MY_SCRIPT_IDX > 0)
		{
			ClientEffect("remove", "all", MY_SCRIPT_IDX);
		}
		DeleteEntity(GetOwner());
	}

}

}
