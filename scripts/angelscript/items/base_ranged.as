#pragma context server

#include "items/base_weapon.as"

namespace MS
{

class BaseRanged : CGameScript
{
	int NO_PARRY;
	string RANGED_DMG_TYPE;
	int RANGED_NOISE;
	string UNDER_SKILLED;
	string WEAPON_DMG_MULTI;
	string WEAPON_PRIMARY_SKILL;

	BaseRanged()
	{
		NO_PARRY = 1;
		RANGED_NOISE = 650;
		RANGED_DMG_TYPE = "pierce";
	}

	void weapon_spawn()
	{
		if ((CUSTOM_ATTACK)) return;
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = RANGED_HOLD_MINMAX;
		string reg.attack.dmg.type = RANGED_DMG_TYPE;
		string reg.attack.dmg.multi = RANGED_DMG_MULTI;
		string reg.attack.range = RANGED_FORCE;
		string reg.attack.energydrain = RANGED_ENERGY;
		string reg.attack.stat = RANGED_STAT;
		string reg.attack.COF = RANGED_ACCURACY;
		string reg.attack.projectile = RANGED_PROJECTILE;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = RANGED_DMG_DELAY;
		string reg.attack.delay.end = RANGED_ATK_DURATION;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		string reg.attack.callback = "ranged";
		string reg.attack.noise = RANGED_NOISE;
		WEAPON_PRIMARY_SKILL = reg.attack.stat;
		WEAPON_DMG_MULTI = RANGED_DMG_MULTI;
		RegisterAttack();
	}

	void game_dodamage()
	{
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		ScheduleDelayedEvent(0.1, "skill_check");
	}

	void skill_check()
	{
		string FIND_MELEE_STAT = "skill.";
		FIND_MELEE_STAT += RANGED_STAT;
		LogDebug("game_deploy GetEntityProperty(GetOwner(), "find_melee_stat") FIND_MELEE_STAT BASE_LEVEL_REQ");
		if (GetEntityProperty(GetOwner(), "find_melee_stat") < BASE_LEVEL_REQ)
		{
			SendColoredMessage(GetOwner(), "You lack the skill to properly wield this weapon!");
			string OUT_STR = "You lack the proficiency to wield this weapon. ( requires: ";
			OUT_STR += RANGED_STAT;
			OUT_STR += " proficiency ";
			OUT_STR += BASE_LEVEL_REQ;
			OUT_STR += " )";
			SendInfoMsg(GetOwner(), "Insufficient Skill " + OUT_STR);
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
			SetAttackProp("ent_me", 1);
			SetAttackProp("ent_me", 1);
			WEAPON_DMG_MULTI = 0.1;
			UNDER_SKILLED = 1;
			LogDebug("skill_check Underskilled");
			bow_underskilled();
		}
		else
		{
			if ((UNDER_SKILLED))
			{
				LogDebug("skill_check ResetToNorm");
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 0);
				SetAttackProp("ent_me", 1);
				SetAttackProp("ent_me", 1);
				SetAttackProp("ent_me", 1);
				WEAPON_DMG_MULTI = RANGED_DMG_MULTI;
				UNDER_SKILLED = 0;
				bow_underskilled_restore();
			}
			UNDER_SKILLED = 0;
			LogDebug("skill_check restore");
		}
	}

}

}
