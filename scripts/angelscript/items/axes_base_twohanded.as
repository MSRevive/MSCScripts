#pragma context server

#include "items/base_melee.as"

namespace MS
{

class AxesBaseTwohanded : CGameScript
{
	AxesBaseTwohanded()
	{
		const string PLAYERANIM_AIM = "axe_twohand";
		const string PLAYERANIM_SWING = "axe_twohand_swing";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const float BWEAPON_DBL_CHARGE_ADJ = 2.5;
	}

	void OnSpawn() override
	{
		SetHand("both");
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		reg.attack.dmg *= BWEAPON_DBL_CHARGE_ADJ;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= BWEAPON_DBL_CHARGE_ADJ;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		int reg.attack.priority = 1;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_01";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 2;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
		if ((CUSTOM_AXE_SECONDARY)) return;
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 90;
		string reg.attack.dmg = MELEE_DMG;
		reg.attack.dmg *= 3;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		int reg.attack.aoe.range = 100;
		float reg.attack.aoe.falloff = 1.5;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		reg.attack.hitchance += 0.1;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.7;
		float reg.attack.delay.end = 2.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
	}

	void special_02_start()
	{
		Effect("screenfade", GetOwner(), 1, 2, Vector3(200, 10, 10), 100, "fadein");
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SWORDREADY')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
		ScheduleDelayedEvent(1, "swing_in_air");
	}

	void swing_in_air()
	{
		PlayViewAnim(MELEE_VIEWANIM_ATK);
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		if ((IsOnGround(GetOwner())))
		{
			string l.forwardangles = GetEntityAngles(GetOwner());
			Vector3 l.forwardangles = Vector3(0, (l.forwardangles).y, 0);
			string l.vel = /* TODO: $relvel */ $relvel(l.forwardangles, Vector3(0, 430, 0));
			int l.up = 240;
			AddVelocity(GetOwner(), Vector3((l.vel).x, (l.vel).y, l.up));
		}
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void special_02_strike()
	{
		if (!(param1 == "npc")) return;
		string l.dir = (GetEntityOrigin(param3) - GetEntityOrigin(GetOwner())).Normalize();
		l.dir *= 300;
		AddVelocity(param3, Vector3((l.dir).x, (l.dir).y, 200));
	}

}

}
