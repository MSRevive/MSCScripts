#pragma context server

namespace MS
{

class CannonMannedFixed : CGameScript
{
	int AM_AIMING;
	int AM_LOADED;
	int FIRE_DELAY;
	string SRC_YAW;

	CannonMannedFixed()
	{
		const string SPRITE_EXPLODE = "bigsmoke.spr";
		const string SOUND_CANNON = "weapons/explode3.wav";
		const float FREQ_FIRE = 30.0;
		const int DMG_CANNON = 1000;
	}

	void OnSpawn() override
	{
		SetName("Cannon");
		SetModel("props/cannon.mdl");
		SetBloodType("none");
		SetWidth(32);
		SetHeight(48);
		SetHealth(20);
		SetRace("human");
		SetRoam(false);
		SetMenuAutoOpen(1);
		SetDamageResistance("stun", 0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("lightning", 0.5);
		SetNoPush(true);
		ScheduleDelayedEvent(0.1, "get_src_yaw");
	}

	void get_src_yaw()
	{
		SRC_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
	}

	void game_menu_getoptions()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(AM_LOADED))
		{
			if (!(ItemExists(param1, "item_cannon_ball")))
			{
				string reg.mitem.title = "Load Cannon";
				string reg.mitem.type = "disabled";
			}
			else
			{
				string reg.mitem.title = "Load Cannon";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "item_cannon_ball";
				string reg.mitem.cb_failed = "no_balls";
				string reg.mitem.callback = "load_cannon";
			}
		}
		else
		{
			string reg.mitem.title = "Fire!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "fire_cannon";
		}
	}

	void no_balls()
	{
		SendColoredMessage(param1, "You need a cannon ball to load this weapon.");
	}

	void load_cannon()
	{
		AM_LOADED = 1;
	}

	void game_menu_cancel()
	{
		AM_AIMING = 0;
	}

	void fire_cannon()
	{
		AM_LOADED = 0;
		EmitSound(GetOwner(), 0, SOUND_CANNON, 10);
		SetAngles("view");
		TossProjectile("proj_cannon_ball", /* TODO: $relpos */ $relpos(0, 16, -16), "none", 400, DMG_CANNON, 0, "none");
		Effect("tempent", "spray", SPRITE_EXPLODE, /* TODO: $relpos */ $relpos(0, 0, 0), 0, 1, 0, 0);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 380, 20, 1, 512);
		FIRE_DELAY = 1;
		UseTrigger("cannon_fired");
		PlayAnim("critical", "shoot");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetMenuAutoOpen(0);
		EmitSound(GetOwner(), 0, "debris/bustcrate3.wav", 10);
		PlayAnim("critical", "die");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: "debris/wood1.wav", "debris/wood2.wav"
		array<string> sounds = {"debris/wood1.wav", "debris/wood2.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
