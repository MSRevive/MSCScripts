#pragma context server

namespace MS
{

class SummonFireWall : CGameScript
{
	string ACTIVE_SKILL;
	string FIRE_DURATION;
	string FLAME_ANGLE;
	string FLAME_POSITION;
	int FLAMING;
	string GAME_PVP;
	int I_DO_FIRE_DAMAGE;
	string MY_BASE_DMG;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	int SCAN_PASS;

	SummonFireWall()
	{
		const int TIME_LIVE = 14;
		I_DO_FIRE_DAMAGE = 1;
		Precache("fire1_fixed.spr");
		const int HEIGHT = 60;
		const int WIDTH = 2;
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
		SetRepeatDelay(Random(0.0, 0.5));
		if ((FLAMING))
		{
		}
		flames_shoot();
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(Random(0.0, 0.5));
		if ((FLAMING))
		{
		}
		flames_shoot();
	}

	void flames_start()
	{
		EmitSound(GetOwner(), CHAN_ITEM, "items/torch1.wav", 7);
		FLAMING = 1;
		flames_attack();
	}

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetName("Fire Wall");
		SetHealth(1);
		SetInvincible(true);
		SetRoam(false);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetBloodType("none");
		ScheduleDelayedEvent(2, "flames_start");
		// svplaysound: emitsound ent_me $get(ent_me,origin) 192 TIME_LIVE danger 192
		EmitSound(GetOwner(), GetEntityOrigin(GetOwner()), 192, TIME_LIVE, "danger", 192);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		GAME_PVP = "game.pvp";
		MY_BASE_DMG = param3;
		MY_BASE_DMG *= 3;
		FIRE_DURATION = param4;
		ACTIVE_SKILL = param5;
		if (ACTIVE_SKILL == "PARAM5")
		{
			ACTIVE_SKILL = "spellcasting.fire";
		}
		FIRE_DURATION("firewall_death");
		StoreEntity("ent_expowner");
		SetAngles("face.y");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), param2);
		SCAN_PASS = 0;
	}

	void flames_attack()
	{
		if (!(FLAMING)) return;
		ScheduleDelayedEvent(0.1, "flames_attack");
		SCAN_PASS += 1;
		if (SCAN_PASS > 3)
		{
			SCAN_PASS = 0;
		}
		if (SCAN_PASS == 1)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, 0, 0);
		}
		if (SCAN_PASS == 2)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, 96, 0);
		}
		if (SCAN_PASS == 3)
		{
			string SCAN_POS = /* TODO: $relpos */ $relpos(0, -96, 0);
		}
		string SCAN_RESULT = /* TODO: $get_insphere */ $get_insphere("any", 48, SCAN_POS);
		if (!(GetRelationship(SCAN_RESULT) == "enemy")) return;
		if ((IsValidPlayer(SCAN_RESULT)))
		{
			if ((OWNER_ISPLAYER))
			{
			}
			if (GAME_PVP < 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(SCAN_RESULT, "effects/dot_fire", 10, MY_OWNER, MY_BASE_DMG, ACTIVE_SKILL);
	}

	void firewall_death()
	{
		FLAMING = 0;
		firewall_end_cl();
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		FLAME_POSITION = param1;
		FLAME_ANGLE = Vector3(0, param2, 0);
		ScheduleDelayedEvent(2, "flames_start");
		TIME_LIVE("firewall_end_cl");
	}

	void firewall_end_cl()
	{
		RemoveScript();
	}

	void flames_shoot()
	{
		string NEGWIDTH = WIDTH;
		NEGWIDTH *= -1;
		string x = RandomInt(-30, 30);
		string y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		string yar = RandomInt(1, 0);
		if ((yar))
		{
			ClientEffect("tempent", "sprite", "fire1_fixed.spr", L_POS, "setup_flames");
		}
		string x = RandomInt(-96, 96);
		string y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		string yar = RandomInt(1, 0);
		if ((yar))
		{
			ClientEffect("tempent", "sprite", "fire1_fixed.spr", L_POS, "setup_flames");
		}
		string x = RandomInt(-192, 192);
		string y = RandomInt(NEGWIDTH, WIDTH);
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(x, y, HEIGHT));
		L_POS += FLAME_POSITION;
		string yar = RandomInt(1, 0);
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
