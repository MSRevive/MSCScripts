#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_npc_attack.as"

namespace MS
{

class IceWall : CGameScript
{
	string ANIM_DEATH;
	int CAN_ATTACK;
	int CAN_HUNT;
	int f1;
	int f2;
	int r1;
	int r2;
	string rotate;

	IceWall()
	{
		ANIM_DEATH = "";
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetWidth(64);
		SetHeight(64);
		SetName("Ice Wall");
		SetRoam(false);
		SetDamageResistance("fire", 10.0);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel("misc/icewall.mdl");
		SetBloodType("none");
		SetRace("hated");
		ScheduleDelayedEvent(0, "icewall_up");
	}

	void game_dynamically_created()
	{
		PARAM1++;
		SetAngles("face.y");
		if (!(param2 == "PARAM2")) return;
		rotate = GetEntityProperty(GetOwner(), "angles.yaw");
		rotate++;
		r1 = RandomInt(50, 70);
		r2 = RandomInt(50, 70);
		r2 *= -1;
		f1 = RandomInt(-5, 5);
		f2 = RandomInt(-5, 5);
		SpawnNPC("traps/ice_wall", /* TODO: $relpos */ $relpos(f1, r1, 0), ScriptMode::Legacy); // params: rotate, 1
		SpawnNPC("traps/ice_wall", /* TODO: $relpos */ $relpos(f2, r2, 0), ScriptMode::Legacy); // params: rotate, 1
		SpawnNPC("traps/ice_wall", /* TODO: $relpos */ $relpos(f1, f1, 0), ScriptMode::Legacy); // params: rotate, 1
		SpawnNPC("traps/ice_wall", /* TODO: $relpos */ $relpos(r2, r2, 0), ScriptMode::Legacy); // params: rotate, 1
	}

	void icewall_up()
	{
		PlayAnim("hold", "up");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 32), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 32), /* TODO: $relpos */ $relpos(0, 0, 64), 2, 0.1, 3, 30, 0);
		Effect("tempent", "trail", "blueflare1.spr", /* TODO: $relpos */ $relpos(0, 0, 64), /* TODO: $relpos */ $relpos(0, 0, 96), 5, 0.1, 3, 30, 0);
		DeleteEntity(GetOwner());
	}

}

}
