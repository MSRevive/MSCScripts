#pragma context server

#include "monsters/summon/base_aoe2.as"

namespace MS
{

class NpcPoisonCloud : CGameScript
{
	string AOE_DURATION;
	string AOE_OWNER;
	int FX_ACTIVE;
	string FX_ORIGIN;
	string FX_SPRITE_COLOR;
	string MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;

	NpcPoisonCloud()
	{
		const string SMOKE_SPRITE = "poison_cloud.spr";
		const string SPAWN_SOUND = "ambience/steamburst1.wav";
		const string EFFECT_SCRIPT = "effects/dot_poison";
		const int AOE_RADIUS = 128;
		const string AOE_SCAN_TYPE = "tsphere";
		const Vector3 SPRITE_COLOR = Vector3(0, 0, 0);
		const string CHECK_EFFECT = "DOT_poison";
		const int CLOUD_HEIGHT = 40;
		const int CLOUD_WIDTH = 96;
		const int CLOUD_NEGWIDTH = -96;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_BASE_DAMAGE = param3;
		MY_DURATION = param4;
		AOE_OWNER = MY_OWNER;
		AOE_DURATION = MY_DURATION;
		string MY_ORG = GetEntityOrigin(GetOwner());
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(MY_ORG);
		if ((MY_ORG).z != MY_GROUND)
		{
			MY_GROUND += 20;
			MY_ORG += "z";
			if ((MY_ORG).z > MY_GROUND)
			{
			}
			LogDebug("game_dynamically_created adjusting height");
			SetEntityOrigin(GetOwner(), MY_ORG);
		}
		string CL_DURATION = MY_DURATION;
		CL_DURATION -= 2.5;
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), SPRITE_COLOR, CL_DURATION);
	}

	void OnSpawn() override
	{
		SetName("Poison Cloud");
		ScheduleDelayedEvent(0.1, "spawn_sound");
	}

	void spawn_sound()
	{
		EmitSound(GetOwner(), 0, SPAWN_SOUND, 10);
	}

	void aoe_affect_target()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, EFFECT_SCRIPT, 5.0, MY_OWNER, MY_BASE_DAMAGE);
	}

	void aoe_end()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_ACTIVE = 1;
		FX_SPRITE_COLOR = param2;
		fx_loop();
		PARAM3("poison_end_cl");
	}

	void poison_end_cl()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "fx_loop");
		smokes_shoot();
	}

	void smokes_shoot()
	{
		string x = Random(CLOUD_NEGWIDTH, CLOUD_WIDTH);
		string y = Random(CLOUD_NEGWIDTH, CLOUD_WIDTH);
		string SPR_POS = /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(x, y, 0));
		string SPR_GROUND = /* TODO: $get_ground_height */ $get_ground_height(SPR_POS);
		string L_POS = /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(x, y, 32));
		L_POS += FX_ORIGIN;
		if (!(/* TODO: $get_contents */ $get_contents(L_POS) == "empty")) return;
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
	}

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
