#pragma context server

namespace MS
{

class FireWall2 : CGameScript
{
	int AM_SUMMONED;
	int DMG_STEP;
	string FLAME_ANGLE;
	string FLAME_POSITION;
	int FLAMING;
	int HEIGHT;
	int IS_ACTIVE;
	string MY_ANGLES;
	string MY_BASE_DMG;
	string MY_CL_IDX;
	float MY_DURATION;
	string MY_OWNER;
	int PLAYING_DEAD;
	string SCAN_TARGETS;
	int TIME_LIVE;
	int WIDTH;

	FireWall2()
	{
		MY_DURATION = 15.0;
		HEIGHT = 60;
		WIDTH = 2;
		TIME_LIVE = 14;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(6);
		if ((FLAMING))
		{
		}
		EmitSound(GetOwner(), CHAN_ITEM, "items/torch1.wav", 7);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(Random(0.25, 0.5));
		if ((FLAMING))
		{
		}
		flames_shoot();
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(Random(0.25, 0.5));
		if ((FLAMING))
		{
		}
		flames_shoot();
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
		MY_OWNER = param1;
		MY_ANGLES = param2;
		SetAngles("face.y");
		MY_BASE_DMG = param3;
		if ((param3).findFirst("PARAM") == 0)
		{
			MY_BASE_DMG = 300;
		}
		StoreEntity("ent_expowner");
		SetRace(GetEntityRace(MY_OWNER));
	}

	void OnSpawn() override
	{
		SetName("Fire Wall Trap");
		SetHealth(1);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetModel("null.mdl");
		ScheduleDelayedEvent(0.1, "define_vars");
		MY_DURATION("end_effect");
	}

	void define_vars()
	{
		if (!(AM_SUMMONED))
		{
			SetRace("hated");
			MY_OWNER = GetEntityIndex(GetOwner());
			MY_BASE_DMG = 300;
			MY_ANGLES = GetEntityProperty(GetOwner(), "angles.y");
		}
		ScheduleDelayedEvent(0.1, "activate_effect");
	}

	void activate_effect()
	{
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), MY_ANGLES);
		MY_CL_IDX = "game.script.last_sent_id";
		IS_ACTIVE = 1;
		DMG_STEP = 0;
		ScheduleDelayedEvent(2.0, "damage_cycle");
	}

	void damage_cycle()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.2, "damage_cycle");
		if (DMG_STEP == 3)
		{
			DMG_STEP = 0;
		}
		DMG_STEP += 1;
		if (DMG_STEP == 1)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		}
		if (DMG_STEP == 2)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, 96, 0);
		}
		if (DMG_STEP == 3)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, -96, 0);
		}
		SCAN_TARGETS = FindEntitiesInSphere("enemy", 96);
		if (!(SCAN_TARGETS != "none")) return;
		GetTokenCount(SCAN_TARGETS, ";")("apply_aoe_effect");
	}

	void apply_aoe_effect()
	{
		string CUR_TARGET = GetToken(SCAN_TARGETS, i, ";");
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 2, MY_OWNER, MY_BASE_DMG);
	}

	void end_effect()
	{
		IS_ACTIVE = 0;
		ClientEvent("remove", "all", MY_CL_IDX);
		ScheduleDelayedEvent(0.1, "final_remove");
	}

	void final_remove()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		FLAME_POSITION = param1;
		FLAME_ANGLE = Vector3(0, param2, 0);
		ScheduleDelayedEvent(2, "flames_start");
	}

	void flames_start()
	{
		EmitSound(GetOwner(), CHAN_ITEM, "items/torch1.wav", 7);
		FLAMING = 1;
	}

	void flames_shoot()
	{
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		int x = RandomInt(-30, 30);
		int y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		int yar = RandomInt(1, 0);
		if ((yar))
		{
			ClientEffect("tempent", "sprite", "fire1_fixed.spr", L_POS, "setup_flames");
		}
		int x = RandomInt(-96, 96);
		int y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		int yar = RandomInt(1, 0);
		if ((yar))
		{
			ClientEffect("tempent", "sprite", "fire1_fixed.spr", L_POS, "setup_flames");
		}
		int x = RandomInt(-192, 192);
		int y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		int yar = RandomInt(1, 0);
		if ((yar))
		{
			ClientEffect("tempent", "sprite", "fire1_fixed.spr", L_POS, "setup_flames");
		}
	}

	void setup_flames()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.6, 1.0));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.1, 1.0));
		ClientEffect("tempent", "set_current_prop", "collide", "all");
	}

}

}
