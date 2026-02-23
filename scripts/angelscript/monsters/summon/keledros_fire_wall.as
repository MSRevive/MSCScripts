#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class KeledrosFireWall : CGameScript
{
	int FIRE_DURATION;
	string FLAME_ANGLE;
	string FLAME_POSITION;
	int FLAMING;
	int I_DO_FIRE_DAMAGE;
	string MY_BASE_DMG;
	string MY_OWNER;
	int PLAYING_DEAD;

	KeledrosFireWall()
	{
		I_DO_FIRE_DAMAGE = 1;
		const int TIME_LIVE = 10;
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
	}

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetName("Fire Wall");
		SetHealth(1);
		SetInvincible(true);
		SetSolid("none");
		SetFOV(90);
		SetWidth(32);
		SetHeight(32);
		SetRoam(false);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetBloodType("none");
		SetModel("none");
		ScheduleDelayedEvent(2, "flames_start");
		// svplaysound: emitsound ent_me $get(ent_me,origin) 192 TIME_LIVE danger 192
		EmitSound(GetOwner(), GetEntityOrigin(GetOwner()), 192, TIME_LIVE, "danger", 192);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_BASE_DMG = param3;
		FIRE_DURATION = 10;
		FIRE_DURATION("firewall_death");
		StoreEntity("ent_expowner");
		SetAngles("face.y");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), param2);
	}

	void flames_attack()
	{
		SetRepeatDelay(0.5);
		if (!(FLAMING)) return;
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 96, MY_BASE_DMG, 1.0, 0);
		DoDamage(/* TODO: $relpos */ $relpos(0, 96, 0), 96, MY_BASE_DMG, 1.0, 0);
		DoDamage(/* TODO: $relpos */ $relpos(0, -96, 0), 96, MY_BASE_DMG, 1.0, 0);
	}

	void firewall_death()
	{
		FLAMING = 0;
		firewall_end_cl();
		SetAlive(0);
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
