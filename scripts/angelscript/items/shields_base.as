#pragma context server

#include "items/base_melee.as"

namespace MS
{

class ShieldsBase : CGameScript
{
	int AM_SHIELD;
	string EXIT_BLOCK;
	int IS_DEPLOYED;
	string PARRY_MULTI_OUT;

	ShieldsBase()
	{
		AM_SHIELD = 1;
		const int ANIM_IDLE1 = 0;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_LIFT1 = 0;
		const int ANIM_THRUST1 = 1;
		const int ANIM_RETRACT1 = 2;
		const string MELEE_VIEWANIM_ATK = ANIM_THRUST1;
		const int BASEWEAPON_NO_HAND_IDLE = 1;
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string ANIM_PREFIX = "allshields";
		const string PLAYERANIM_AIM = "battleaxe";
		const string MELEE_STAT = "parry";
		const int MELEE_ACCURACY = 40;
		const float MELEE_DMG_DELAY = 0.1;
		const float MELEE_ATK_DURATION = 1.0;
		const int MELEE_ACCURACY = 40;
		const string MELEE_CALLBACK = "melee";
		const int MELEE_NOISE = 400;
		const int MELEE_SOUND_DELAY = 0;
		const float SHIELD_TAKEDMG = 0.5;
		const string SHIELD_BREAK_SOUND = "debris/bustmetal1.wav";
		const string SOUND_THRUST = "weapons/cbar_miss1.wav";
		const string SOUND_SWIPE = SOUND_THRUST;
		const string SOUND_BLOCK = "body/armour3.wav";
	}

	void weapon_spawn()
	{
		SetHand("left");
		SetWearable(1);
		string reg.attack.type = "hold-strike";
		string reg.attack.keys = "+attack1";
		int reg.attack.range = 0;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 100;
		string reg.attack.dmg.type = "block";
		int reg.attack.energydrain = 0;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 0;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = MELEE_CALLBACK;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.dmg.ignore = 1;
		RegisterAttack();
		PARRY_MULTI_OUT = PARRY_MULTI;
		shield_spawn();
	}

	void melee_start()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		CallExternal(GetOwner(), "ext_shield_up", 1);
	}

	void melee_hold()
	{
		PlayOwnerAnim("hold", "aim_axe_onehand");
	}

	void melee_end()
	{
		if ((false))
		{
			PlayViewAnim(ANIM_RETRACT1);
		}
		else
		{
			if ((GetEntityProperty(GetOwner(), "scriptvar")))
			{
			}
			CallExternal(GetOwner(), "ext_shield_up", 0);
			PlayOwnerAnim("break");
		}
	}

	void bweapon_effect_remove()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		CallExternal(GetOwner(), "ext_shield_up", 0);
	}

	void game_wear()
	{
		IS_DEPLOYED = 0;
		SetModel(MODEL_WEAR);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 3;
		SetModelBody(0, L_SUBMODEL);
	}

	void game_show()
	{
		SetModel(MODEL_WEAR);
		string L_SUBMODEL = MODEL_BODY_OFS;
		L_SUBMODEL += 3;
		SetModelBody(0, L_SUBMODEL);
	}

	void weapon_deploy()
	{
		IS_DEPLOYED = 1;
		string L_ANIM_IDLE = ANIM_PREFIX;
		L_ANIM_IDLE += "_idle";
		PlayAnim("once", L_ANIM_IDLE);
	}

	void game_viewanimdone()
	{
		if (!(ANIM_IDLE_TOTAL > 0)) return;
		if (("game.item.attacking")) return;
		if (!("game.item.wielded")) return;
		RandomInt(ANIM_IDLE_DELAY_LOW, ANIM_IDLE_DELAY_HIGH)("item_idle");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(IS_DEPLOYED)) return;
		if ((SHIELD_PRE_BLOCK_EFFECT))
		{
			EXIT_BLOCK = 0;
			string OUT_PAR1 = param1;
			string OUT_PAR2 = param2;
			string OUT_PAR4 = param4;
			shield_pre_block_effect(OUT_PAR1, OUT_PAR2, SHIELD_DMG_TAKEN, OUT_PAR4);
		}
		if ((EXIT_BLOCK)) return;
		if ((param4).findFirst("target") == 0)
		{
			int CANT_BLOCK = 1;
		}
		if ((param4).findFirst("effect") >= 0)
		{
			int CANT_BLOCK = 1;
		}
		if ((CANT_BLOCK)) return;
		string MY_OWNER = GetEntityIndex(GetOwner());
		string THE_ATTACKER = param2;
		if (!(GetEntityIndex(param1) != GetEntityIndex(GetOwner()))) return;
		string l.pos = GetEntityOrigin(GetOwner());
		string l.mypos = GetEntityOrigin(GetOwner());
		string l.myang = GetEntityAngles(GetOwner());
		string l.attpos = GetEntityOrigin(param1);
		if (!(WithinCone2D(l.attpos, l.mypos, l.myang))) return;
		if ((SHIELD_REPORT_HITS))
		{
			string THE_INFLICTOR = param2;
			shield_hit(THE_ATTACKER, THE_INFLICTOR, StringToLower(param3), StringToLower(param4));
		}
		if (("game.item.attacking"))
		{
			if (RandomInt(1, 100) <= BLOCK_CHANCE_UP)
			{
				SHIELD_DMG_TAKEN = param3;
				string ORIG_DMG = param3;
				SHIELD_DMG_TAKEN *= DMG_BLOCK_UP;
				SetDamage("dmg");
				shield_deflect(THE_ATTACKER);
			}
		}
		if (!("game.item.attacking"))
		{
			if (("game.item.wielded"))
			{
			}
			if (RandomInt(1, 100) <= BLOCK_CHANCE_DOWN)
			{
				SHIELD_DMG_TAKEN = param3;
				if (param3 > 0)
				{
					SendPlayerMessage(GetOwner(), "Deflected!");
				}
				SetDamage("hit");
				SetDamage("dmg");
				shield_deflect(THE_ATTACKER);
			}
		}
	}

	void shield_deflect()
	{
		EmitSound(GetOwner(), "const.snd.body", SOUND_BLOCK, "const.snd.fullvol");
		if (("game.item.attacking")) return;
		PlayViewAnim(ANIM_RETRACT1);
	}

	void OnPickup(CBaseEntity@ player) override
	{
	}

}

}
