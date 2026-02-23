#pragma context server

namespace MS
{

class TntBomb : CGameScript
{
	string BOMB_DURATION;
	string CL_INDEX;
	int GROUND_PULSE;
	int IS_ACTIVE;
	string MY_OWNER;
	string NEXT_DMG;
	int N_DMG_TIMES;
	string OLD_SPEED;
	int PLAYING_DEAD;
	string START_VEL;
	string TOUCH_TARG;

	TntBomb()
	{
		const string SPRITE_EXPLODE = "bigsmoke.spr";
		const string SOUND_EXPLODE = "weapons/explode3.wav";
		const string SOUND_FUSE_LOOP = "monsters/dwarf_bomber/fuse_loop.wav";
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		START_VEL = param2;
		SetCallback("touch", "enable");
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.01, "boost_and_scan");
		BOMB_DURATION = Random(5.0, 10.0);
		Effect("beam", "follow", "lgtning.spr", GetOwner(), 1, 1, BOMB_DURATION, 200, Vector3(255, 0, 0));
		ScheduleDelayedEvent(0.01, "setup_fx");
		BOMB_DURATION("go_splodie");
	}

	void setup_fx()
	{
		ClientEvent("new", "all", "monsters/summon/tnt_bomb_cl", GetEntityIndex(GetOwner()), BOMB_DURATION);
		LogDebug("setup_fx");
		CL_INDEX = "game.script.last_sent_id";
		SetProp(GetOwner(), "avelocity", /* TODO: $relvel */ $relvel(0, 60, 0));
		// svplaysound: svplaysound 1 5 SOUND_FUSE_LOOP
		EmitSound(1, 5, SOUND_FUSE_LOOP);
	}

	void OnSpawn() override
	{
		SetName("explosives");
		SetModel("monsters/dwarf_bomber_tnt.mdl");
		SetWidth(8);
		SetHeight(8);
		SetGravity(2);
		SetIdleAnim("tnt_idle");
		SetProp(GetOwner(), "movetype", "const.movetype.bounce");
		SetProp(GetOwner(), "friction", 0.2);
		SetInvincible(true);
		SetRace("hated");
		PLAYING_DEAD = 1;
		SetMonsterClip(0);
	}

	void boost_and_scan()
	{
		AddVelocity(GetOwner(), START_VEL);
		OLD_SPEED = GetEntitySpeed(GetOwner());
		N_DMG_TIMES = 0;
		GROUND_PULSE = 0;
		monitor_speed();
	}

	void monitor_speed()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "monitor_speed");
		string CUR_SPEED = GetEntitySpeed(GetOwner());
		if (CUR_SPEED < 200)
		{
			if (OLD_SPEED < 200)
			{
			}
			go_splodie();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		string MY_GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		MY_Z -= MY_GROUND_Z;
		if (MY_Z < 10)
		{
			GROUND_PULSE += 1;
			EmitSound(GetOwner(), 0, "debris/bustmetal2.wav", 10);
			if (GROUND_PULSE > 2)
			{
			}
			go_splodie();
		}
		OLD_SPEED = CUR_SPEED;
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(IS_ACTIVE)) return;
		TOUCH_TARG = param1;
		ScheduleDelayedEvent(0.01, "damage_touched");
	}

	void damage_touched()
	{
		if (!(GetGameTime() > NEXT_DMG)) return;
		NEXT_DMG = GetGameTime();
		NEXT_DMG += 0.25;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		ScheduleDelayedEvent(0.1, "go_splodie");
	}

	void go_splodie()
	{
		if (CL_INDEX > 0)
		{
			ClientEvent("update", "all", CL_INDEX, "end_fx");
		}
		// svplaysound: svplaysound 1 0 SOUND_FUSE_LOOP
		EmitSound(1, 0, SOUND_FUSE_LOOP);
		Effect("tempent", "spray", SPRITE_EXPLODE, GetMonsterProperty("origin"), 0, 1, 0, 0);
		SetModel("none");
		string DMG_AMT = GetEntityProperty(MY_OWNER, "scriptvar");
		if (GetEntityProperty(MY_OWNER, "dmgmulti") > 0)
		{
			DMG_AMT *= GetEntityProperty(MY_OWNER, "dmgmulti");
		}
		XDoDamage(GetEntityOrigin(GetOwner()), 128, DMG_AMT, 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:push_loop");
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (param1 == MY_OWNER)
		{
			int L_REDUCE = 1;
		}
		if (GetRelationship(MY_OWNER) == "ally")
		{
			int L_REDUCE = 1;
		}
		if (!(L_REDUCE))
		{
			if (GetRelationship(MY_OWNER) == "enemy")
			{
			}
			CallExternal(MY_OWNER, "ext_hittarget", param1);
		}
		if (!(L_REDUCE)) return;
		SetDamage("dmg");
		return;
	}

	void push_loop_dodamage()
	{
		string CUR_TARGET = param2;
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
		if (param2 == MY_OWNER)
		{
			CallExternal(MY_OWNER, "friendly_fire");
		}
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
