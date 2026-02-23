#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandDivRejuvenate : CGameScript
{
	int BITCH_SLAPPED;
	int FAN_LOOP;
	string REGEN_DELAY;
	int SPELL_SKILL_REQUIRED;

	MagicHandDivRejuvenate()
	{
		const string SOUND_SHOOT = "magic/heal_strike.wav";
		const int MELEE_RANGE = 384;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 5;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "divination";
		const int SPELL_ENERGYDRAIN = 10;
		const int SPELL_MPDRAIN = 5;
		const string SPELL_STAT = "spellcasting.divination";
		const int EFFECT_MAXDURATION = 20;
		const int EFFECT_MINDURATION = 10;
		const string EFFECT_DURATION_STAT = GetStat(GetOwner(), "concentration.ratio");
		const string EFFECT_DURATION_FORMULA = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION, "inversed");
		const int HEAL_MAX = 75;
		const int HEAL_MIN = 30;
		const string HEAL_SKILL = GetSkillLevel(GetOwner(), "spellcasting.divination.ratio");
		const string LOOP_SOUND = "player/heartbeat_noloop.wav";
		const string LOOP_CHANNEL = "const.sound.item";
		Precache(LOOP_SOUND);
	}

	void spell_spawn()
	{
		SetName("Rejuvenation");
		SetDescription("Replenish yours or an ally's health.");
		FAN_LOOP = 0;
		add_delay();
		passive_regen();
	}

	void enable_passive_regen_check()
	{
		SetRepeatDelay(1.0);
		if (!(FAN_LOOP == 0)) return;
		if (REGEN_DELAY <= GetGameTime())
		{
			FAN_LOOP = 1;
		}
	}

	void spell_casted()
	{
		string DEMON_ON = GetEntityProperty(GetOwner(), "scriptvar");
		if ((DEMON_ON))
		{
			SendPlayerMessage("You", "cannot use divine magic while under the influence of Demon Blood!");
			spell_end();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_CASTER = GetEntityIndex(GetOwner());
		string L_SPELL_TARGET = GetEntityIndex(GetOwner());
		string L_HEAL_AMT = GetSkillLevel(GetOwner(), "spellcasting.divination");
		L_HEAL_AMT += HEAL_MIN;
		if (param1 == "npc")
		{
			if (GetRelationship(GetOwner()) == "ally")
			{
				string L_SPELL_TARGET = param3;
			}
		}
		if ((IsValidPlayer(param3)))
		{
			string L_SPELL_TARGET = param3;
		}
		if ((GetEntityProperty(param3, "scriptvar")))
		{
			string L_SPELL_TARGET = param3;
		}
		if (L_CASTER != L_SPELL_TARGET)
		{
			string L_TEN_PERCENT = GetEntityMaxHealth(L_SPELL_TARGET);
			L_TEN_PERCENT *= 0.1;
			L_HEAL_AMT += L_TEN_PERCENT;
			string L_HEAL_AMT = int(L_HEAL_AMT);
			if ((IsValidPlayer(L_SPELL_TARGET)))
			{
				int L_ADD_BONUS = 1;
			}
			if ((GetEntityProperty(L_SPELL_TARGET, "scriptvar")))
			{
				int L_ADD_BONUS = 1;
			}
			if ((L_ADD_BONUS))
			{
				if (GetEntityHealth(L_SPELL_TARGET) < GetEntityMaxHealth(L_SPELL_TARGET))
				{
				}
				CallExternal(GetOwner(), "add_dmg_points", /* TODO: $math(multiply) */ L_HEAL_AMT);
				int L_GAVE_DMG_POINTS = 1;
			}
		}
		else
		{
			L_HEAL_AMT *= 0.5;
		}
		// svplaysound: svplaysound game.sound.voice 10 SOUND_SHOOT
		EmitSound(CHAN_VOICE, 10, SOUND_SHOOT);
		heal_target(L_SPELL_TARGET, L_HEAL_AMT, L_GAVE_DMG_POINTS);
		if (L_SPELL_TARGET != L_CASTER)
		{
			CallExternal(SPELL_TARGET, "display_health");
		}
	}

	void heal_target()
	{
		string L_HEAL_TGT = param1;
		string L_HEAL_AMT = param2;
		string L_DP = param3;
		string L_CASTER_ID = GetEntityIndex(GetOwner());
		string L_MAX_HEALTH = GetEntityMaxHealth(L_HEAL_TGT);
		string L_CUR_HEALTH = GetEntityHealth(L_HEAL_TGT);
		if (L_HEAL_TGT != L_CASTER_ID)
		{
			int L_HEALING_OTHER = 1;
		}
		if (L_CUR_HEALTH < L_MAX_HEALTH)
		{
			HealEntity(L_HEAL_TGT, L_HEAL_AMT);
			int L_HEALED = 1;
			if ((L_HEALING_OTHER))
			{
				SendColoredMessage(L_CASTER_ID, "You heal GetEntityName(L_HEAL_TGT) for int(L_HEAL_AMT) hp");
				SendColoredMessage(L_HEAL_TGT, "GetEntityName(L_CASTER_ID) heals you for int(L_HEAL_AMT) hp");
				if ((L_DP))
				{
					if (GetPlayerCount() > 1)
					{
					}
					SendColoredMessage(L_CASTER_ID, "(Credited $int($math(multiply)),L_HEAL_AMT,5 ) ) damage points.)");
				}
			}
			else
			{
				SendColoredMessage(L_CASTER_ID, "You heal yourself for int(L_HEAL_AMT) hp");
			}
		}
		else
		{
			if ((L_HEALING_OTHER))
			{
				SendColoredMessage(L_CASTER_ID, "GetEntityName(L_HEAL_TGT) is at maximum health");
			}
			else
			{
				SendColoredMessage(L_CASTER_ID, "You are at maximum health");
			}
		}
		if (!(L_HEALED)) return;
		Effect("glow", L_HEAL_TGT, Vector3(0, 255, 0), 256, 1, 1);
	}

	void passive_regen()
	{
		SetRepeatDelay(0.5);
		if (!(FAN_LOOP >= 1)) return;
		FAN_LOOP += 1;
		if (FAN_LOOP == 3)
		{
			EmitSound(GetOwner(), LOOP_CHANNEL, LOOP_SOUND, 10);
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 64, 0.5, 0.5);
			FAN_LOOP = 1;
		}
		string MY_MAX_HEALTH = GetEntityMaxHealth(GetOwner());
		string MY_CUR_HEALTH = GetEntityHealth(GetOwner());
		string MY_SKILL = GetSkillLevel(GetOwner(), "spellcasting.divination");
		string MY_PASSIVE_RATE = MY_SKILL;
		MY_PASSIVE_RATE *= 0.1;
		MY_PASSIVE_RATE += 4;
		if (MY_CUR_HEALTH < MY_MAX_HEALTH)
		{
			HealEntity(GetOwner(), MY_PASSIVE_RATE);
		}
		CallExternal(GetEntityIndex(GetOwner()), "display_health");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(param4 != "target")) return;
		if (!(param3 > 0.01)) return;
		BITCH_SLAPPED = 1;
		spell_end();
	}

	void spell_end()
	{
		if ((BITCH_SLAPPED))
		{
			SendPlayerMessage("You", "cannot rejuvenate while being attacked!");
		}
		if (!(BITCH_SLAPPED))
		{
			SendPlayerMessage("The", "spell s duration ends.");
		}
		end_spell();
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
	}

	void end_spell()
	{
		DeleteEntity(GetOwner());
	}

	void add_delay()
	{
		REGEN_DELAY = GetGameTime();
		REGEN_DELAY += SPELL_PREPARE_TIME;
		enable_passive_regen_check();
	}

}

}
