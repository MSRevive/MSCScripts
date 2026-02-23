#pragma context server

namespace MS
{

class MegaIceWall : CGameScript
{
	string ANIM_DEATH;
	int CAN_ATTACK;
	int CAN_HUNT;

	MegaIceWall()
	{
		Precache("blueflare1.spr");
		ANIM_DEATH = "";
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		const int CANT_TURN = 1;
	}

	void OnSpawn() override
	{
		SetHealth(2999);
		SetName("Mega Ice Wall");
		SetRoam(false);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel("misc/icewall.mdl");
		SetWidth(140);
		SetHeight(170);
		SetProp(GetOwner(), "scale", 2.5);
		SetBloodType("none");
		SetRace("hated");
		SetTurnRate(0.01);
		icewall_up();
		SetDamageResistance("all", 1.2);
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("cold", 1.2);
		SetDamageResistance("poison", 1.2);
		SetDamageResistance("acid", 1.2);
		SetDamageResistance("lightning", 1.2);
		SetDamageResistance("holy", 1.2);
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("pierce", 1.2);
		SetDamageResistance("slash", 1.2);
	}

	void icewall_up()
	{
		PlayAnim("hold", "up");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ice_death_fx();
	}

	void ice_death()
	{
		DeleteEntity(GetOwner());
		ice_death_fx();
	}

	void ice_death_fx()
	{
		SetCallback("touch", "disable");
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 32), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 32), /* TODO: $relpos */ $relpos(0, 0, 64), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 64), /* TODO: $relpos */ $relpos(0, 0, 96), 5, 0.1, 3, 30, 0);
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "stun resist 33";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "stun_resist";
		float reg.mitem.data = 0.66;
		string reg.mitem.title = "stun resist 66";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "stun_resist";
		float reg.mitem.data = 0.33;
		string reg.mitem.title = "stun resist 100";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "stun_resist";
		int reg.mitem.data = 0;
		string reg.mitem.title = "Die";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "ice_death";
	}

	void stun_resist()
	{
		SetDamageResistance("stun", param2);
		SendInfoMsg("all", "Stun takedmg /* TODO: $get_takedmg */ $get_takedmg(GetOwner(), "stun")");
	}

}

}
