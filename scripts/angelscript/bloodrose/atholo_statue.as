#pragma context server

namespace MS
{

class AtholoStatue : CGameScript
{
	string PASS_TARGET;

	AtholoStatue()
	{
		const string MONSTER_MODEL = "props/atholo_statue.mdl";
		Precache(MONSTER_MODEL);
		Precache("rockgibs.mdl");
		Precache("weapons/cbar_hitbod1.wav");
		Precache("weapons/cbar_hitbod2.wav");
		Precache("weapons/cbar_hitbod3.wav");
		Precache("controller/con_pain2.wav");
		Precache("zombie/claw_miss1.wav");
		Precache("zombie/claw_miss2.wav");
		Precache("garg/gar_die1.wav");
		Precache("garg/gar_die2.wav");
		Precache("nihilanth/nil_die.wav");
		Precache("garg/gar_idle2.wav");
		Precache("magic/fireball_strike.wav");
		Precache("monsters/skeleton_boss2.mdl");
		const string SOUND_SPAWN = "magic/spawn_loud.wav";
		const string SOUND_ROCKS = "debris/bustconcrete2.wav";
	}

	void OnSpawn() override
	{
		SetName("");
		SetName("atholo_statue");
		SetInvincible(true);
		SetWidth(40);
		SetHeight(100);
		SetSolid("npcsize");
		SetModel(MONSTER_MODEL);
	}

	void spawn_atholo()
	{
		PASS_TARGET = param1;
		Effect("glow", GetOwner(), Vector3(255, 0, 255), 512, 2, 2);
		EmitSound(GetOwner(), 0, SOUND_SPAWN, 10);
		ScheduleDelayedEvent(1.9, "gibify");
		ScheduleDelayedEvent(2.0, "summon_atholo");
	}

	void gibify()
	{
		EmitSound(GetOwner(), 0, SOUND_ROCKS, 10);
		Effect("tempent", "gibs", "rockgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

	void summon_atholo()
	{
		string MY_ANGLES = GetEntityAngles(GetOwner());
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(MY_ANGLES);
		SpawnNPC("bloodrose/atholo", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: MY_YAW, PASS_TARGET
		DeleteEntity(GetOwner());
	}

}

}
