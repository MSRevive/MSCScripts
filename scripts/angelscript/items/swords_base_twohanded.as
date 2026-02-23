#pragma context server

#include "items/axes_base_onehanded.as"

namespace MS
{

class SwordsBaseTwohanded : CGameScript
{
	int IS_DEPLOYED;
	string NEXT_MANUAL_PARRY;
	int SWORD_CAN_PARRY;
	int SWORD_MANUAL_PARRY_ON;

	SwordsBaseTwohanded()
	{
		const int IS_TWO_HANDED_SWORD = 1;
		const int NO_IDLE = 1;
		const string PLAYERANIM_AIM = "sword_idle";
		const string PLAYERANIM_SWING = "sword_swing";
		const string SOUND_PARRY = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const float FREQ_MANUAL_PARRY = 2.0;
		const int ANIM_PARRY = 4;
		const int ANIM_UNPARRY = 5;
		const float SWORD_MANUAL_PARRY_RATIO = 0.5;
	}

	void weapon_spawn()
	{
		SetHand("both");
	}

	void OnDeploy() override
	{
		SWORD_CAN_PARRY = 1;
		IS_DEPLOYED = 1;
	}

	void bweapon_effect_remove()
	{
		SWORD_CAN_PARRY = 0;
		IS_DEPLOYED = 0;
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(IS_DEPLOYED)) return;
		if (!(SWORD_CAN_PARRY)) return;
		if ((param4).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((param4).findFirst("target") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((param4).findFirst("magic") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string l.pos = GetEntityOrigin(GetOwner());
		string l.mypos = GetEntityOrigin(GetOwner());
		string l.myang = GetEntityAngles(GetOwner());
		string l.attpos = GetEntityOrigin(param1);
		if (!(WithinCone2D(l.attpos, l.mypos, l.myang))) return;
		string PARRY_CHANCE = MELEE_NEW_PARRY_CHANCE;
		if (!(SWORD_MANUAL_PARRY_ON))
		{
			if ((PARRY_ON))
			{
				int PARRY_CHANCE = 100;
			}
			if (RandomInt(1, 100) <= PARRY_CHANCE)
			{
				string DMG_TAKEN = param3;
				SetVolume(5);
				EmitSound(GetOwner(), SOUND_PARRY);
				SendPlayerMessage("Sword", "parried! DMG_TAKEN hp");
				SetDamage("hit");
				SetDamage("dmg");
				ScheduleDelayedEvent(0.1, "parryanim");
			}
		}
		else
		{
			string DMG_TAKEN = param3;
			string DMG_BLOCKED = param3;
			DMG_TAKEN *= SWORD_MANUAL_PARRY_RATIO;
			DMG_BLOCKED -= DMG_TAKEN;
			EmitSound(GetOwner(), 2, SOUND_PARRY, 5);
			SendPlayerMessage("Sword", "blocked DMG_BLOCKED hp");
			SetDamage("dmg");
			return;
		}
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		ScheduleDelayedEvent(0.1, "play_parry");
	}

	void play_parry()
	{
		PlayViewAnim(ANIM_PARRY1);
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
		if (!(GetEntityRange(m_hLastStruck) < MELEE_RANGE)) return;
		string RIPOSTE_DAMAGE = GetSkillLevel(GetOwner(), "parry");
		SendPlayerMessage("You", "ripost� the attack! RIPOSTE_DAMAGE");
		string L_MY_OWNER = GetEntityIndex(GetOwner());
		XDoDamage(GetEntityIndex(m_hLastStruck), "direct", RIPOSTE_DAMAGE, 1.0, L_MY_OWNER, L_MY_OWNER, MELEE_STAT, MELEE_DMG_TYPE);
	}

	void melee_end()
	{
		PlayViewAnim(ANIM_IDLE1);
	}

	void special_01_end()
	{
		PlayViewAnim(ANIM_IDLE1);
	}

	void parryanim()
	{
		if (!(ANIM_PARRY != ANIM_PARRY)) return;
		// TODO: splayviewanim ent_me ANIM_PARRY
	}

	void register_charge1()
	{
		if ((CUSTOM_REGISTER_CHARGE1)) return;
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		reg.attack.range *= 1.5;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		float reg.attack.delay.strike = 1.3;
		float reg.attack.delay.end = 1.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void game_+attack2()
	{
		if (!(SWORD_MANUAL_PARRY)) return;
		if ((SWORD_MANUAL_PARRY_ON)) return;
		if (!(GetGameTime() > NEXT_MANUAL_PARRY)) return;
		NEXT_MANUAL_PARRY = GetGameTime();
		NEXT_MANUAL_PARRY += FREQ_MANUAL_PARRY;
		// TODO: splayviewanim ent_me ANIM_PARRY
		SWORD_MANUAL_PARRY_ON = 1;
	}

	void game__attack2()
	{
		if (!(SWORD_MANUAL_PARRY)) return;
		if (!(SWORD_MANUAL_PARRY_ON)) return;
		// TODO: splayviewanim ent_me ANIM_UNPARRY
		SWORD_MANUAL_PARRY_ON = 0;
		NEXT_MANUAL_PARRY = GetGameTime();
		NEXT_MANUAL_PARRY += FREQ_MANUAL_PARRY;
	}

}

}
