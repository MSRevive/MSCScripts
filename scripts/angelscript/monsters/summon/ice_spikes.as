#pragma context server

namespace MS
{

class IceSpikes : CGameScript
{
	string CENTER_POINT;
	string CL_NSPIKES;
	string CL_RADIUS;
	string DMG_ICE;
	string MY_OWNER;
	string MY_RADIUS;
	string MY_SCRIPT_ID;
	string NUM_SPIKES;
	int PLAYING_DEAD;

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		DMG_ICE = param2;
		MY_RADIUS = param3;
		NUM_SPIKES = param4;
		ScheduleDelayedEvent(0.1, "apply_damage");
	}

	void OnSpawn() override
	{
		SetName("Ice Spikes");
		SetSolid("none");
		SetWidth(32);
		SetHeight(32);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetInvincible(true);
	}

	void apply_damage()
	{
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), MY_RADIUS, NUM_SPIKES);
		MY_SCRIPT_ID = "game.script.last_sent_id";
		string DMG_POS = GetMonsterProperty("origin");
		CallExternal(MY_OWNER, "send_damage", DMG_POS, MY_RADIUS, DMG_ICE, 1.0, 0, "reflective", "pierce");
		XDoDamage(DMG_POS, MY_RADIUS, DMG_ICE, 0, MY_OWNER, MY_OWNER, "spellcasting.ice", "ice");
		EmitSound(GetOwner(), 0, "magic/freeze.wav", 10);
		ScheduleDelayedEvent(5.0, "remove_me");
	}

	void remove_me()
	{
		ClientEvent("remove", "all", MY_SCRIPT_ID);
		ScheduleDelayedEvent(1.0, "remove_me2");
	}

	void remove_me2()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		CENTER_POINT = param1;
		CL_RADIUS = param2;
		CL_NSPIKES = param3;
		for (int i = 0; i < CL_NSPIKES; i++)
		{
			spawn_spikes();
		}
	}

	void spawn_spikes()
	{
		string SPIKE_POS = CENTER_POINT;
		string F_ADJ = RandomInt(0, CL_RADIUS);
		string YAW_ADJ = RandomInt(0, 359);
		SPIKE_POS += /* TODO: $relpos */ $relpos(Vector3(0, YAW_ADJ, 0), Vector3(0, F_ADJ, 0));
		ClientEffect("tempent", "sprite", "glassgibs.mdl", SPIKE_POS, "setup_spike");
	}

	void setup_spike()
	{
		int PITCH_ADJ = 0;
		string YAW_ADJ = RandomInt(0, 359);
		string ROLL_ADJ = RandomInt(200, 320);
		string SCALE_ADJ = Random(5.0, 20.0);
		Vector3 ANGLE_ADJ = Vector3(PITCH_ADJ, YAW_ADJ, ROLL_ADJ);
		string BODY_ADJ = RandomInt(0, 7);
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.7);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", SCALE_ADJ);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", ANGLE_ADJ);
		ClientEffect("tempent", "set_current_prop", "angle", ANGLE_ADJ);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", 1);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
