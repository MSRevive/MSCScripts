#pragma context server

#include "player/client/halos.as"
#include "player/player_cl_effects_weather.as"

namespace MS
{

class PlayerClEffectsSpecial : CGameScript
{
	string CL_HBAR_FRAME;
	string CL_HBAR_INDEX;
	string CL_HBAR_POS;
	string CL_HBAR_SCALE;
	string CL_HBAR_SPRITE;
	string CL_TELE1_ORG;
	string CORPSE_ANG;
	string CORPSE_ANIM_IDX;
	string CORPSE_BODY_IDX;
	string CORPSE_RENDERAMT;
	string CORPSE_RENDERMODE;
	string CORPSE_SCALE;
	string CORPSE_SKIN;
	string CYCLE_BEAM;
	string FX_SMITH_EFFECTS;
	string FX_SMITH_ICESPRITE;
	string FX_SMITH_SPRITE;
	string FX_SMITH_TYPE;
	string KH_BREATH_COLOR;
	int KH_DRAG_COUNT;
	string KH_DRAG_PAT01;
	string KH_DRAG_PAT02;
	string KH_DRAG_PAT03;
	string KH_DRAG_PAT04;
	string KH_DRAG_PAT05;
	string KH_DRAG_PAT06;
	string KH_DRAG_PAT07;
	string KH_DRAG_PAT08;
	string KH_DRAG_PAT09;
	string KH_DRAG_PAT10;
	string KH_DRAG_PAT11;
	string KH_DRAG_PAT12;
	string KH_DRAG_PAT13;
	string KH_DRAG_PAT14;
	string KH_DRAG_PAT15;
	string KH_DRAG_PAT16;
	string KH_DRAG_POS;
	string KH_DRAINER_ANGS;
	int KH_DRAINER_SPEED;
	int KH_FIRE_BREATH;
	string KH_FLAME_SPRITE;
	int KH_FLIGHT_SPRITES_ON;
	string KH_FS_ANG_COUNT;
	string KH_FS_ROT_COUNT;
	string KH_GLOW_SPRITE;
	int KH_HAND_SPRITES_ON;
	string KH_HAND_SPRITE_COLOR;
	string KH_SKEL;
	string KH_SPRITE_DRAINER;
	string KH_TEMP_ROW;
	int KH_X_COUNT;
	string KH_ZAP_NERF;
	int KH_ZAP_ON;
	string KH_ZAP_TARGET;
	string LIGHTSYS_ANY_VALID;
	int LIGHTSYS_N_LIGHTS;
	string LIGHTSYS_TRACK_LIGHTS;
	string L_INRENDER;
	int MIRRORS_ON;
	string MIRROR_ANGLES;
	int MIRROR_ANGLE_COUNTER;
	int MIRROR_MODE;
	string MIRROR_MODEL;
	int MIRROR_RENDERAMT;
	string MIRROR_VEL;
	string NEXT_LIGHT_DEBUG;
	string PHL_HIDE;
	string PHL_NEXT_SEAL;
	int PHL_ON;
	string PHL_OWNER;
	string PHL_POS;
	string PLAYER_MODEL;
	int SB_CYCLE_ANGLE;
	string SB_STUN_POS;
	string SB_STUN_RADIUS;
	string SETUP_TEST_ARRAY;
	int SFX_B_CYCLE;
	float SFX_B_CYCLE_PM;
	int SFX_G_CYCLE;
	float SFX_G_CYCLE_PM;
	string SFX_METAL_CAVE_LIGHT;
	int SFX_METAL_CAVE_LIGHT_ACTIVE;
	string SFX_METAL_CAVE_MDL;
	int SFX_R_CYCLE;
	float SFX_R_CYCLE_PM;
	string TN_GLOW_SPR;
	string TN_IDX;
	int TN_SPRITE_LOOP;
	string TN_TELE_SPR;
	string game.cleffect.view_ofs.z;

	PlayerClEffectsSpecial()
	{
		LIGHTSYS_N_LIGHTS = 16;
		PLAYER_MODEL = "human/reference.mdl";
		CL_HBAR_SPRITE = "health_bar.spr";
		array<string> ARRAY_LIGHT_COLOR;
		array<string> ARRAY_LIGHT_RAD;
		array<string> ARRAY_LIGHT_IDLIST;
		KH_SPRITE_DRAINER = "fire1_fixed.spr";
		KH_DRAINER_SPEED = 30;
		KH_GLOW_SPRITE = "3dmflaora.spr";
	}

	void ext_cl_clientcmd()
	{
		LogDebug("*** ext_cl_clientcmd /* TODO: $quote */ $quote(param1)");
		ClientEffect("clientcmd", param1);
	}

	void game_prerender()
	{
		if ((LIGHTSYS_TRACK_LIGHTS))
		{
			for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
			{
				lightsys_render_lights();
			}
		}
		if ((SFX_METAL_CAVE_LIGHT_ACTIVE))
		{
			cl_metal_cave_cycle();
		}
	}

	void cl_error()
	{
		LogError(param1);
	}

	void kh_setup()
	{
		KH_SKEL = param1;
	}

	void kh_make_drain_sprite()
	{
		string SPAWN_LOC = param1;
		KH_DRAINER_ANGS = param3;
		ClientEffect("tempent", "sprite", KH_SPRITE_DRAINER, SPAWN_LOC, "kh_setup_drainer");
		if ((param4))
		{
			EmitSound3D("magic/energy1_loud.wav", 10, SPAWN_LOC);
		}
	}

	void kh_sprite_splode()
	{
		string SPARK_ORG = param1;
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPARK_ORG, "kh_setup_spark");
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPARK_ORG, "kh_setup_spark");
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPARK_ORG, "kh_setup_spark");
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPARK_ORG, "kh_setup_spark");
		EmitSound3D("turret/tu_die2.wav", 10, SPARK_ORG);
	}

	void kh_setup_drainer()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.1);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", KH_DRAINER_ANGS);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(KH_DRAINER_ANGS, Vector3(0, KH_DRAINER_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void kh_setup_spark()
	{
		float L_RND_ANG = Random(0, 359);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, L_RND_ANG, 0), Vector3(0, 120, 110)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void kh_setup_hand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(Random(-20, 20), 0, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", KH_HAND_SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void kh_end_effects()
	{
		MIRRORS_ON = 0;
		KH_FIRE_BREATH = 0;
		KH_FLIGHT_SPRITES_ON = 0;
	}

	void kh_hand_sprites()
	{
		string SPRITE_DURATION = param1;
		KH_HAND_SPRITE_COLOR = param2;
		KH_HAND_SPRITES_ON = 1;
		SPRITE_DURATION("kh_end_hand_sprites");
		kh_hand_sprite_loop();
	}

	void kh_hand_sprite_loop()
	{
		if (!(KH_HAND_SPRITES_ON)) return;
		ScheduleDelayedEvent(0.1, "kh_hand_sprite_loop");
		string SPAWN_POS = /* TODO: $getcl */ $getcl(KH_SKEL, "bonepos", 20);
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPAWN_POS, "kh_setup_hand_sprite");
		string SPAWN_POS = /* TODO: $getcl */ $getcl(KH_SKEL, "bonepos", 16);
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPAWN_POS, "kh_setup_hand_sprite");
	}

	void kh_end_hand_sprites()
	{
		KH_HAND_SPRITES_ON = 0;
	}

	void kh_spawn_mirrors()
	{
		MIRROR_MODEL = param1;
		string MIRROR_START = param2;
		MIRROR_ANGLES = param3;
		const int MIRROR_DIST = 96;
		const float MIRROR_LIFE = 5.0;
		MIRROR_ANGLE_COUNTER = 0;
		MIRRORS_ON = 1;
		MIRROR_MODE = 1;
		MIRROR_RENDERAMT = 0;
		int MIRROR_START_SPEED = 5;
		int MIRROR_SANG = 0;
		MIRROR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, MIRROR_SANG, 0), Vector3(0, MIRROR_START_SPEED, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, MIRROR_START, "kh_setup_mirror", "kh_update_mirror0");
		MIRROR_SANG += 72;
		MIRROR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, MIRROR_SANG, 0), Vector3(0, MIRROR_START_SPEED, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, MIRROR_START, "kh_setup_mirror", "kh_update_mirror1");
		MIRROR_SANG += 72;
		MIRROR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, MIRROR_SANG, 0), Vector3(0, MIRROR_START_SPEED, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, MIRROR_START, "kh_setup_mirror", "kh_update_mirror2");
		MIRROR_SANG += 72;
		MIRROR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, MIRROR_SANG, 0), Vector3(0, MIRROR_START_SPEED, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, MIRROR_START, "kh_setup_mirror", "kh_update_mirror3");
		MIRROR_SANG += 72;
		MIRROR_VEL = /* TODO: $relvel */ $relvel(Vector3(0, MIRROR_SANG, 0), Vector3(0, MIRROR_START_SPEED, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, MIRROR_START, "kh_setup_mirror", "kh_update_mirror4");
		MIRROR_LIFE("kh_refresh_mirrors");
	}

	void kh_update_mirror0()
	{
		kh_mirror_update(0);
	}

	void kh_update_mirror1()
	{
		kh_mirror_update(72);
	}

	void kh_update_mirror2()
	{
		kh_mirror_update(144);
	}

	void kh_update_mirror3()
	{
		kh_mirror_update(216);
	}

	void kh_update_mirror4()
	{
		kh_mirror_update(288);
		MIRROR_ANGLE_COUNTER += 1;
		if (MIRROR_ANGLE_COUNTER > 359)
		{
			MIRROR_ANGLE_COUNTER -= 359;
		}
	}

	void kh_mirror_update()
	{
		if (!(MIRRORS_ON))
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
		}
		if (!(MIRRORS_ON)) return;
		if (MIRROR_MODE == 1)
		{
			MIRROR_RENDERAMT += 5;
			if (MIRROR_RENDERAMT >= 255)
			{
				ClientEffect("tempent", "set_current_prop", "renderamt", 255);
				MIRROR_MODE = 2;
			}
			else
			{
				ClientEffect("tempent", "set_current_prop", "renderamt", MIRROR_RENDERAMT);
			}
		}
		if (MIRROR_MODE == 2)
		{
			string ANG_ADJ = param1;
			string L_ANG = MIRROR_ANGLE_COUNTER;
			L_ANG += ANG_ADJ;
			if (L_ANG > 359)
			{
				L_ANG -= 359;
			}
			string MIRROR_POS = /* TODO: $getcl */ $getcl(KH_SKEL, "origin");
			string DBG_POS = MIRROR_POS;
			MIRROR_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_ANG, 0), Vector3(0, MIRROR_DIST, 0));
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
			ClientEffect("tempent", "set_current_prop", "angles", /* TODO: $getcl */ $getcl(KH_SKEL, "angles"));
			ClientEffect("tempent", "set_current_prop", "origin", MIRROR_POS);
			ClientEffect("tempent", "set_current_prop", "velocity", 0);
		}
	}

	void kh_refresh_mirrors()
	{
		LogDebug("**** kh_refresh_mirrors");
		if (!(MIRRORS_ON)) return;
		MIRROR_ANGLES = /* TODO: $getcl */ $getcl(KH_SKEL, "angles");
		string L_MIRROR_ANG = MIRROR_ANGLE_COUNTER;
		if (L_MIRROR_ANG > 359)
		{
			L_MIRROR_ANG -= 359;
		}
		string L_MIRROR_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, L_MIRROR_POS, "kh_setup_mirror", "kh_update_mirror0");
		string L_MIRROR_ANG = MIRROR_ANGLE_COUNTER;
		L_MIRROR_ANG += 72;
		if (L_MIRROR_ANG > 359)
		{
			L_MIRROR_ANG -= 359;
		}
		string L_MIRROR_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, L_MIRROR_POS, "kh_setup_mirror", "kh_update_mirror1");
		string L_MIRROR_ANG = MIRROR_ANGLE_COUNTER;
		L_MIRROR_ANG += 144;
		if (L_MIRROR_ANG > 359)
		{
			L_MIRROR_ANG -= 359;
		}
		string L_MIRROR_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, L_MIRROR_POS, "kh_setup_mirror", "kh_update_mirror2");
		string L_MIRROR_ANG = MIRROR_ANGLE_COUNTER;
		L_MIRROR_ANG += 216;
		if (L_MIRROR_ANG > 359)
		{
			L_MIRROR_ANG -= 359;
		}
		string L_MIRROR_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, L_MIRROR_POS, "kh_setup_mirror", "kh_update_mirror3");
		string L_MIRROR_ANG = MIRROR_ANGLE_COUNTER;
		L_MIRROR_ANG += 288;
		if (L_MIRROR_ANG > 359)
		{
			L_MIRROR_ANG -= 359;
		}
		string L_MIRROR_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, L_MIRROR_POS, "kh_setup_mirror", "kh_update_mirror4");
		MIRROR_LIFE("kh_refresh_mirrors");
	}

	void kh_setup_mirror()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", MIRROR_LIFE);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", /* TODO: $getcl */ $getcl(KH_SKEL, "angles"));
		ClientEffect("tempent", "set_current_prop", "velocity", MIRROR_VEL);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 999);
	}

	void kh_mirror_poof()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.25);
		ClientEffect("tempent", "set_current_prop", "angles", /* TODO: $getcl */ $getcl(KH_SKEL, "angles"));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 999);
	}

	void kh_mirrors_off()
	{
		MIRRORS_ON = 0;
		string POOF_POS_ANG = MIRROR_ANGLE_COUNTER;
		string POOF_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, POOF_POS, "kh_mirror_poof");
		string POOF_POS_ANG = MIRROR_ANGLE_COUNTER;
		POOF_POS_ANG += 72;
		if (POOF_POS_ANG > 359)
		{
			POOF_POS_ANG -= 359;
		}
		string POOF_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, POOF_POS, "kh_mirror_poof");
		string POOF_POS_ANG = MIRROR_ANGLE_COUNTER;
		POOF_POS_ANG += 144;
		if (POOF_POS_ANG > 359)
		{
			POOF_POS_ANG -= 359;
		}
		string POOF_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, POOF_POS, "kh_mirror_poof");
		string POOF_POS_ANG = MIRROR_ANGLE_COUNTER;
		POOF_POS_ANG += 216;
		if (POOF_POS_ANG > 359)
		{
			POOF_POS_ANG -= 359;
		}
		string POOF_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, POOF_POS, "kh_mirror_poof");
		string POOF_POS_ANG = MIRROR_ANGLE_COUNTER;
		POOF_POS_ANG += 288;
		if (POOF_POS_ANG > 359)
		{
			POOF_POS_ANG -= 359;
		}
		string POOF_POS = /* TODO: $relpos */ $relpos(Vector3(0, POOF_POS_ANG, 0), Vector3(0, MIRROR_DIST, 0));
		ClientEffect("tempent", "model", MIRROR_MODEL, POOF_POS, "kh_mirror_poof");
	}

	void kh_ice_spikes()
	{
		const string SOUND_FREEZE = "magic/freeze.wav";
		string SPAWN_POS = param1;
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", SPAWN_POS, "kh_setup_ice_spikes", "kh_update_ice_spikes");
		EmitSound3D(SOUND_FREEZE, 10, SPAWN_POS);
	}

	void kh_update_ice_spikes()
	{
		if (!("game.tempent.fuser2" != 1)) return;
		string CUR_ANIM = "game.tempent.anim";
		string CUR_FRAME = "game.tempent.frame";
		if (CUR_ANIM == 17)
		{
			string RAISE_TIME = "game.tempent.fuser1";
			RAISE_TIME += 0.5;
			if (GetGameTime() > RAISE_TIME)
			{
				ClientEffect("tempent", "set_current_prop", "sequence", 18);
				ClientEffect("tempent", "set_current_prop", "framerate", 0.1);
				ClientEffect("tempent", "set_current_prop", "frame", 0);
				ClientEffect("tempent", "set_current_prop", "fuser2", 1);
			}
		}
	}

	void kh_setup_ice_spikes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 2.0);
		ClientEffect("tempent", "set_current_prop", "frames", 999);
		ClientEffect("tempent", "set_current_prop", "body", 45);
		ClientEffect("tempent", "set_current_prop", "sequence", 17);
		ClientEffect("tempent", "set_current_prop", "fuser1", GetGameTime());
		ClientEffect("tempent", "set_current_prop", "fuser2", 69);
	}

	void kh_fire_breath_on()
	{
		KH_FIRE_BREATH = 1;
		KH_BREATH_COLOR = Vector3(0, 0, 0);
		KH_FLAME_SPRITE = param1;
		LogDebug("**** kh_fire_breath_on KH_FLAME_SPRITE at /* TODO: $getcl */ $getcl(KH_SKEL, "attachment2") ang /* TODO: $getcl */ $getcl(KH_SKEL, "angles.yaw")");
		kh_fire_breath_loop();
	}

	void kh_fire_breath_loop()
	{
		if (!(KH_FIRE_BREATH)) return;
		ScheduleDelayedEvent(0.01, "kh_fire_breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(KH_SKEL, "attachment2");
		ClientEffect("tempent", "sprite", KH_FLAME_SPRITE, CLOUD_ORG, "setup_fire_breath");
		ClientEffect("tempent", "sprite", KH_FLAME_SPRITE, CLOUD_ORG, "setup_fire_breath");
	}

	void kh_fire_breath_off()
	{
		KH_FIRE_BREATH = 0;
	}

	void kh_poison_breath_on()
	{
		KH_FIRE_BREATH = 1;
		KH_BREATH_COLOR = Vector3(0, 255, 0);
		KH_FLAME_SPRITE = param1;
		kh_fire_breath_loop();
	}

	void kh_poison_breath_loop()
	{
		if (!(KH_FIRE_BREATH)) return;
		ScheduleDelayedEvent(0.01, "kh_poison_breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(KH_SKEL, "attachment2");
		ClientEffect("tempent", "sprite", KH_FLAME_SPRITE, CLOUD_ORG, "setup_fire_breath");
		ClientEffect("tempent", "sprite", KH_FLAME_SPRITE, CLOUD_ORG, "setup_fire_breath");
	}

	void kh_poison_breath_off()
	{
		KH_FIRE_BREATH = 0;
	}

	void setup_fire_breath()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", KH_BREATH_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		float RND_RL = Random(-20, 20);
		float RND_UD = Random(-20, 20);
		string MY_ANG = /* TODO: $getcl */ $getcl(KH_SKEL, "angles");
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(MY_ANG, Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void kh_zap_target_on()
	{
		KH_ZAP_ON = 1;
		KH_ZAP_TARGET = param1;
		kh_zap_target_loop();
		KH_ZAP_NERF = GetGameTime();
		KH_ZAP_NERF += 1.0;
	}

	void kh_zap_target_loop()
	{
		if (!(KH_ZAP_ON)) return;
		ScheduleDelayedEvent(0.1, "kh_zap_target_loop");
		if (GetGameTime() > KH_ZAP_NERF)
		{
			int EXIT_SUB = RandomInt(0, 1);
		}
		if ((EXIT_SUB)) return;
		string BEAM_START = /* TODO: $getcl */ $getcl(KH_SKEL, "origin");
		string BEAM_END = /* TODO: $getcl */ $getcl(KH_SKEL, "origin");
		BEAM_START += "z";
		float RND_PITCH = Random(0, 359);
		float RND_YAW = Random(0, 359);
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, 32, 0));
		float RND_PITCH = Random(0, 359);
		float RND_YAW = Random(0, 359);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, 32, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.2, 2, 9, 0.3, 0.1, 30, Vector3(2, 1.5, 0.25));
	}

	void kh_zap_target_off()
	{
		KH_ZAP_ON = 0;
	}

	void kh_flight_sprites()
	{
		if ((param1))
		{
			KH_FLIGHT_SPRITES_ON = 1;
			KH_FS_ROT_COUNT = 0;
			KH_FS_ANG_COUNT = 0;
			for (int i = 0; i < 18; i++)
			{
				kh_spawn_flight_sprites();
			}
			ScheduleDelayedEvent(10.0, "kh_refresh_flight_sprites");
		}
		else
		{
			KH_FLIGHT_SPRITES_ON = 0;
		}
	}

	void kh_spawn_flight_sprites()
	{
		string SPAWN_POS = /* TODO: $getcl */ $getcl(KH_SKEL, "origin");
		SPAWN_POS += /* TODO: $relpos */ $relpos(Vector3(0, KH_FS_ANG_COUNT, 0), Vector3(0, 64, 0));
		ClientEffect("tempent", "sprite", KH_GLOW_SPRITE, SPAWN_POS, "kh_setup_flight_sprite", "kh_update_flight_sprite");
		KH_FS_ANG_COUNT += 40;
	}

	void kh_refresh_flight_sprites()
	{
		if (!(KH_FLIGHT_SPRITES_ON)) return;
		KH_FS_ANG_COUNT = 0;
		for (int i = 0; i < 9; i++)
		{
			kh_spawn_flight_sprites();
		}
		ScheduleDelayedEvent(10.0, "kh_refresh_flight_sprites");
	}

	void kh_update_flight_sprite()
	{
		if ((KH_FLIGHT_SPRITES_ON))
		{
			if ("game.tempent.fuser1" == 0)
			{
				KH_FS_ROT_COUNT += 1;
				if (KH_FS_ROT_COUNT > 359)
				{
				}
				KH_FS_ROT_COUNT -= 359;
			}
			string MY_ROT = KH_FS_ROT_COUNT;
			MY_ROT += "game.tempent.fuser1";
			if (MY_ROT > 359)
			{
				MY_ROT -= 359;
			}
			string MY_POS = /* TODO: $getcl */ $getcl(KH_SKEL, "origin");
			MY_POS += /* TODO: $relpos */ $relpos(Vector3(0, MY_ROT, 0), Vector3(0, 64, 0));
			ClientEffect("tempent", "set_current_prop", "origin", MY_POS);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.01);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		}
	}

	void kh_setup_flight_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(Random(-20, 20), 0, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", KH_FS_ANG_COUNT);
	}

	void kh_dragon_death()
	{
		KH_DRAG_POS = param1;
		KH_DRAG_POS = "z";
		KH_DRAG_PAT01 = "0;0;0;1;0;1;0;1;0;0;0;0";
		KH_DRAG_PAT02 = "0;1;0;0;1;1;1;0;0;0;1;0";
		KH_DRAG_PAT03 = "1;0;0;0;1;1;1;0;0;0;0;1";
		KH_DRAG_PAT04 = "1;1;0;0;0;1;0;0;0;0;1;1";
		KH_DRAG_PAT05 = "0;1;1;0;0;1;0;0;1;1;1;0";
		KH_DRAG_PAT06 = "0;0;1;1;1;1;1;1;1;1;0;0";
		KH_DRAG_PAT07 = "0;0;0;1;1;1;1;1;1;0;0;0";
		KH_DRAG_PAT08 = "0;0;0;0;1;1;1;0;0;0;0;0";
		KH_DRAG_PAT09 = "0;0;0;0;0;1;0;0;0;0;0;0";
		KH_DRAG_PAT10 = "0;0;0;0;0;1;0;0;0;0;0;0";
		KH_DRAG_PAT11 = "0;0;0;0;0;1;0;0;0;0;0;0";
		KH_DRAG_PAT12 = "0;0;0;0;0;1;0;0;0;0;0;0";
		KH_DRAG_PAT13 = "0;0;0;0;0;1;0;0;0;0;0;0";
		KH_DRAG_PAT14 = "0;0;0;0;0;0;0;0;0;0;0;0";
		KH_DRAG_PAT15 = "0;0;0;0;0;0;1;0;0;0;0;0";
		KH_DRAG_PAT16 = "0;0;0;0;0;0;0;1;0;0;0;0";
		KH_DRAG_COUNT = 0;
		kh_dragon_death_loop();
	}

	void kh_dragon_death_loop()
	{
		if (KH_DRAG_COUNT < 16)
		{
			ScheduleDelayedEvent(0.2, "kh_dragon_death_loop");
		}
		KH_DRAG_COUNT += 1;
		if (KH_DRAG_COUNT == 1)
		{
			kh_make_row(KH_DRAG_PAT01);
		}
		if (KH_DRAG_COUNT == 2)
		{
			kh_make_row(KH_DRAG_PAT02);
		}
		if (KH_DRAG_COUNT == 3)
		{
			kh_make_row(KH_DRAG_PAT03);
		}
		if (KH_DRAG_COUNT == 4)
		{
			kh_make_row(KH_DRAG_PAT04);
		}
		if (KH_DRAG_COUNT == 5)
		{
			kh_make_row(KH_DRAG_PAT05);
		}
		if (KH_DRAG_COUNT == 6)
		{
			kh_make_row(KH_DRAG_PAT06);
		}
		if (KH_DRAG_COUNT == 7)
		{
			kh_make_row(KH_DRAG_PAT07);
		}
		if (KH_DRAG_COUNT == 8)
		{
			kh_make_row(KH_DRAG_PAT08);
		}
		if (KH_DRAG_COUNT == 9)
		{
			kh_make_row(KH_DRAG_PAT09);
		}
		if (KH_DRAG_COUNT == 10)
		{
			kh_make_row(KH_DRAG_PAT10);
		}
		if (KH_DRAG_COUNT == 11)
		{
			kh_make_row(KH_DRAG_PAT11);
		}
		if (KH_DRAG_COUNT == 12)
		{
			kh_make_row(KH_DRAG_PAT12);
		}
		if (KH_DRAG_COUNT == 13)
		{
			kh_make_row(KH_DRAG_PAT13);
		}
		if (KH_DRAG_COUNT == 14)
		{
			kh_make_row(KH_DRAG_PAT14);
		}
		if (KH_DRAG_COUNT == 15)
		{
			kh_make_row(KH_DRAG_PAT15);
		}
		if (KH_DRAG_COUNT == 16)
		{
			kh_make_row(KH_DRAG_PAT16);
		}
	}

	void kh_make_row()
	{
		KH_TEMP_ROW = param1;
		KH_X_COUNT = 8;
		for (int i = 0; i < GetTokenCount(KH_TEMP_ROW, ";"); i++)
		{
			kh_make_row_loop();
		}
	}

	void kh_make_row_loop()
	{
		string CUR_IDX = i;
		if (!(GetToken(KH_TEMP_ROW, CUR_IDX, ";") == 1)) return;
		int KH_X_COUNT = 16;
		KH_X_COUNT *= CUR_IDX;
		KH_X_COUNT -= 96;
		string SPRITE_POS = KH_DRAG_POS;
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(KH_X_COUNT, 0, 0));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_POS, "kh_dragon_sprite");
	}

	void kh_dragon_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", -0.05);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void titan_setup()
	{
		TN_IDX = param1;
		TN_TELE_SPR = param2;
		const int TN_TELE_FRAMES = 25;
		TN_GLOW_SPR = param3;
	}

	void titan_summon_sprite()
	{
		ClientEffect("tempent", "sprite", TN_TELE_SPR, param1, "titan_tele_sprite");
		if ((TN_SPRITE_LOOP)) return;
		TN_SPRITE_LOOP = 1;
		titan_sprite_loop();
		ScheduleDelayedEvent(2.5, "titan_end_sprite_loop");
	}

	void titan_sprite_loop()
	{
		if (!(TN_SPRITE_LOOP)) return;
		ScheduleDelayedEvent(0.25, "titan_sprite_loop");
		ClientEffect("tempent", "sprite", TN_GLOW_SPR, /* TODO: $getcl */ $getcl(TN_IDX, "attachment1"), "titan_hand_sprite_setup");
		ClientEffect("tempent", "sprite", TN_GLOW_SPR, /* TODO: $getcl */ $getcl(TN_IDX, "attachment2"), "titan_hand_sprite_setup");
	}

	void titan_end_sprite_loop()
	{
		TN_SPRITE_LOOP = 0;
	}

	void titan_tele_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 3.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", TN_TELE_FRAMES);
	}

	void titan_hand_sprite_setup()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void fx_stunburst_go_cl()
	{
		const string SB_STUN_SPRITE = "fire1_fixed.spr";
		SB_CYCLE_ANGLE = 0;
		const int SB_TOTAL_OFS = 10;
		SB_STUN_POS = param1;
		SB_STUN_RADIUS = param2;
		EmitSound3D("magic/boom.wav", 10, SB_STUN_POS);
		string POS_GROUND = /* TODO: $get_ground_height */ $get_ground_height(SB_STUN_POS);
		STUN_POS = "z";
		for (int i = 0; i < 17; i++)
		{
			fx_stun_burst_fx();
		}
	}

	void fx_stun_burst_fx()
	{
		string FLAME_POS = SB_STUN_POS;
		FLAME_POS += /* TODO: $relpos */ $relpos(Vector3(0, SB_CYCLE_ANGLE, 0), Vector3(0, SB_TOTAL_OFS, 0));
		ClientEffect("tempent", "sprite", SB_STUN_SPRITE, FLAME_POS, "fx_stunburst_flame");
		SB_CYCLE_ANGLE += 20;
	}

	void fx_stunburst_flame()
	{
		float SB_FADE_DEL = 1.0;
		int SB_SPRITE_SPEED = 100;
		if (SB_STUN_RADIUS > 128)
		{
			float SB_FADE_DEL = 2.0;
			int SB_SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", SB_FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string SB_FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, SB_CYCLE_ANGLE, 0), Vector3(0, SB_SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", SB_FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void set_view_dist()
	{
		SetEnvironment("maxviewdist", param1);
	}

	void fx_spark()
	{
		ClientEffect("spark", param1);
		if (!(FX_SMITH_EFFECTS)) return;
		if ((FX_SMITH_TYPE).findFirst("dark") >= 0)
		{
			string SPR_POS = param1;
			SPR_POS += "z";
			ClientEffect("tempent", "sprite", FX_SMITH_SPRITE, SPR_POS, "fx_smith_setup_dark_sprite");
			EmitSound3D("magic/spookie1.wav", 10, param1);
		}
		if ((FX_SMITH_TYPE).findFirst("fire") >= 0)
		{
			string SPR_POS = param1;
			SPR_POS += "z";
			ClientEffect("tempent", "model", "weapons/projectiles.mdl", SPR_POS, "fx_smith_setup_fire_sprite", "fx_smith_update_fire_sprite");
			EmitSound3D("magic/volcano_start.wav", 10, param1);
		}
		if ((FX_SMITH_TYPE).findFirst("ice") >= 0)
		{
			string SPR_POS = param1;
			SPR_POS += "z";
			ClientEffect("tempent", "sprite", FX_SMITH_ICESPRITE, SPR_POS, "fx_smith_setup_ice_sprite");
			EmitSound3D("magic/freeze.wav", 10, param1);
		}
	}

	void fx_smith_effect()
	{
		if (param1 == "end")
		{
			FX_SMITH_EFFECTS = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		FX_SMITH_EFFECTS = 1;
		FX_SMITH_TYPE = param1;
		FX_SMITH_SPRITE = param2;
		FX_SMITH_ICESPRITE = param3;
	}

	void fx_smith_setup_fire_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.25);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1.25);
	}

	void fx_smith_update_fire_sprite()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		CUR_SIZE -= 0.01;
		if (!(CUR_SIZE > 0)) return;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
	}

	void fx_smith_setup_dark_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
	}

	void fx_smith_setup_ice_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void phlames_viewfinder_on()
	{
		PHL_OWNER = param1;
		if ((PHL_ON)) return;
		PHL_ON = 1;
		phlames_viewfinder_locator();
	}

	void phlames_viewfinder_off()
	{
		PHL_ON = 0;
	}

	void phlames_viewfinder_locator()
	{
		if (!(PHL_ON)) return;
		ScheduleDelayedEvent(0.01, "phlames_viewfinder_locator");
		string L_OWNER_VIEW = /* TODO: $getcl */ $getcl(PHL_OWNER, "viewangles");
		string L_SEAL_POS = /* TODO: $getcl */ $getcl(PHL_OWNER, "origin");
		string TRACE_START = L_SEAL_POS;
		string TRACE_END = L_SEAL_POS;
		TRACE_END += /* TODO: $relpos */ $relpos(L_OWNER_VIEW, Vector3(0, 1000, 0));
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		TRACE_LINE = "z";
		PHL_POS = TRACE_LINE;
		if (Distance(L_SEAL_POS, PHL_POS) > 1024)
		{
			PHL_HIDE = 1;
		}
		else
		{
			PHL_HIDE = 0;
		}
		if (!(GetGameTime() > PHL_NEXT_SEAL)) return;
		PHL_NEXT_SEAL = GetGameTime();
		PHL_NEXT_SEAL += 10.0;
		ClientEffect("tempent", "model", "weapons/magic/seals.mdl", PHL_POS, "phlames_setup_seal", "phlames_update_seal");
	}

	void phlames_update_seal()
	{
		if (!(PHL_ON))
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
		if (!(PHL_ON)) return;
		ClientEffect("tempent", "set_current_prop", "origin", PHL_POS);
		string L_OWNER_ORG = /* TODO: $getcl */ $getcl(PHL_OWNER, "origin");
		if ((PHL_HIDE))
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
			ClientEffect("tempent", "set_current_prop", "renderamt", 1);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		}
	}

	void phlames_setup_seal()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "fade", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 39);
	}

	void cl_playsound()
	{
		EmitSound(GetOwner(), 0, param1, 10);
		EmitSound3D(param1, param2, param3);
	}

	void show_hbar()
	{
		if ((param2).findFirst("PARAM") == 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CL_HBAR_POS = param1;
		CL_HBAR_FRAME = param2;
		CL_HBAR_FRAME -= 22;
		CL_HBAR_SCALE = param3;
		CL_HBAR_INDEX = param4;
		if ((/* TODO: $getcl */ $getcl(CL_HBAR_INDEX, "isplayer")))
		{
			if (!("game.localplayer.thirdperson"))
			{
			}
			if ("game.localplayer.index" == CL_HBAR_INDEX)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ClientEffect("tempent", "sprite", CL_HBAR_SPRITE, CL_HBAR_POS, "setup_hbar");
	}

	void setup_hbar()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.9);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "frame", CL_HBAR_FRAME);
		ClientEffect("tempent", "set_current_prop", "scale", CL_HBAR_SCALE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

	void set_test_beam()
	{
		ClientEffect("beam_ents", param1, 1, param2, 1, "lgtning.spr", 60.0, 10, 0.1, 0.3, 0.1, 30, Vector3(2, 1.5, 0.25));
	}

	void cl_svplaysound()
	{
		EmitSound3D(param3, param2, param4, param1);
	}

	void game_cl_playsound()
	{
		LogDebug("*** game_cl_playsound PARAM3 PARAM2 PARAM4 PARAM1");
		EmitSound3D(param3, param2, param4, param1);
	}

	void lightsys_render_lights()
	{
		string L_CUR_LIGHT_COLOR = ARRAY_LIGHT_COLOR[int(i)];
		if (!(L_CUR_LIGHT_COLOR != -1)) return;
		int L_CUR_LIGHT_OWNER = int(i);
		string L_CUR_LIGHT_RAD = ARRAY_LIGHT_RAD[int(i)];
		string L_CUR_LIGHT_POS = /* TODO: $getcl */ $getcl(L_CUR_LIGHT_OWNER, "origin");
		string L_CUR_LIGHT_ID = ARRAY_LIGHT_IDLIST[int(i)];
		ClientEffect("light", L_CUR_LIGHT_ID, L_CUR_LIGHT_POS, L_CUR_LIGHT_RAD, L_CUR_LIGHT_COLOR, 1.0);
		if (GetGameTime() > NEXT_LIGHT_DEBUG)
		{
			NEXT_LIGHT_DEBUG = GetGameTime();
			NEXT_LIGHT_DEBUG += 5.0;
		}
	}

	void cl_light_update()
	{
		string L_ACTION = param1;
		string L_OWNER = param2;
		string L_COLOR = param3;
		string L_RAD = param4;
		if (!(GetCvar("ms_showotherglow")))
		{
			if (L_OWNER != "game.localplayer.index")
			{
				return;
			}
		}
		string L_PLAYER_IDX = L_OWNER;
		if (L_ACTION == "new")
		{
			LIGHTSYS_TRACK_LIGHTS = 1;
			if (!(LIGHTSYS_INITIALIZED))
			{
				for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
				{
					lightsys_make_lights();
				}
				LIGHTSYS_INITIALIZED = 1;
			}
			if (ARRAY_LIGHT_COLOR[int(L_PLAYER_IDX)] == -1)
			{
				ClientEffect("light", "new", /* TODO: $getcl */ $getcl(L_OWNER, "origin"), L_COLOR, L_RAD, 5.0);
				string L_LIGHT_ID = "game.script.last_light_id";
				ARRAY_LIGHT_IDLIST[L_PLAYER_IDX] = L_LIGHT_ID;
				ARRAY_LIGHT_COLOR[L_PLAYER_IDX] = L_COLOR;
				ARRAY_LIGHT_RAD[L_PLAYER_IDX] = L_RAD;
			}
			else
			{
				string L_ACTION = "update";
			}
		}
		if (L_ACTION == "update")
		{
			ARRAY_LIGHT_COLOR[L_PLAYER_IDX] = L_COLOR;
			ARRAY_LIGHT_RAD[L_PLAYER_IDX] = L_RAD;
			LIGHTSYS_TRACK_LIGHTS = 1;
		}
		if (L_ACTION == "remove")
		{
			ARRAY_LIGHT_COLOR[L_PLAYER_IDX] = -1;
			ARRAY_LIGHT_IDLIST[L_PLAYER_IDX] = -1;
			ARRAY_LIGHT_RAD[L_PLAYER_IDX] = -1;
			LIGHTSYS_ANY_VALID = 0;
			for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
			{
				lightsys_check_valid_lights();
			}
			if (!(LIGHTSYS_ANY_VALID))
			{
				LIGHTSYS_TRACK_LIGHTS = 0;
			}
		}
		if (L_ACTION == "clear")
		{
			for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
			{
				lightsys_light_remove();
			}
		}
	}

	void lightsys_dumplights()
	{
		for (int i = 0; i < LIGHTSYS_N_LIGHTS; i++)
		{
			lightsys_dumplights_loop();
		}
	}

	void lightsys_dumplights_loop()
	{
		string CUR_IDX = i;
		LogDebug("int(CUR_IDX) ARRAY_LIGHT_IDLIST[int(CUR_IDX)] ARRAY_LIGHT_COLOR[int(CUR_IDX)] ARRAY_LIGHT_RAD[int(CUR_IDX)]");
	}

	void lightsys_make_lights()
	{
		ARRAY_LIGHT_IDLIST.insertLast(-1);
		ARRAY_LIGHT_COLOR.insertLast(-1);
		ARRAY_LIGHT_RAD.insertLast(-1);
	}

	void lightsys_check_valid_lights()
	{
		string L_CUR_LIGHT = ARRAY_LIGHT_COLOR[int(i)];
		if (!(L_CUR_LIGHT != -1)) return;
		LIGHTSYS_ANY_VALID = 1;
	}

	void lightsys_light_remove()
	{
		string CUR_IDX = i;
		ARRAY_LIGHT_COLOR[CUR_IDX] = -1;
		ARRAY_LIGHT_RAD[CUR_IDX] = 0;
		ARRAY_LIGHT_IDLIST[CUR_IDX] = 0;
	}

	void cl_tele1_fx()
	{
		CL_TELE1_ORG = param1;
		EmitSound3D("debris/beamstart1.wav", 10, CL_TELE1_ORG);
		cl_tele1_fx_go();
		ScheduleDelayedEvent(0.2, "cl_tele1_fx_go");
		ScheduleDelayedEvent(0.4, "cl_tele1_fx_go");
		ClientEffect("light", "new", CL_TELE1_ORG, 128, Vector3(255, 0, 0), 2.0);
	}

	void cl_tele1_fx_go()
	{
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", CL_TELE1_ORG, "cl_tele1_fx_sprite");
	}

	void cl_tele1_fx_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "body", 54);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.3);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

	void cl_metal_cave_light()
	{
		if ((SFX_METAL_CAVE_LIGHT_ACTIVE)) return;
		SFX_METAL_CAVE_MDL = param1;
		SFX_R_CYCLE = 254;
		SFX_G_CYCLE = 1;
		SFX_B_CYCLE = 254;
		SFX_R_CYCLE_PM = 0.02;
		SFX_G_CYCLE_PM = -0.02;
		SFX_B_CYCLE_PM = 0.02;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SFX_METAL_CAVE_MDL, "origin"), 768, Vector3(255, 0, 255), 5.0);
		SFX_METAL_CAVE_LIGHT = "game.script.last_light_id";
		SFX_METAL_CAVE_LIGHT_ACTIVE = 1;
	}

	void cl_metal_cave_light_end()
	{
		SFX_METAL_CAVE_LIGHT_ACTIVE = 0;
	}

	void cl_metal_cave_cycle()
	{
		string L_CYCLE = SFX_R_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		SFX_R_CYCLE += L_CYCLE;
		if (SFX_R_CYCLE < 0)
		{
			SFX_R_CYCLE_PM *= -1;
			SFX_R_CYCLE = 0;
		}
		if (SFX_R_CYCLE > 255)
		{
			SFX_R_CYCLE_PM *= -1;
			SFX_R_CYCLE = 255;
		}
		string L_CYCLE = SFX_G_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		SFX_G_CYCLE += L_CYCLE;
		if (SFX_G_CYCLE < 0)
		{
			SFX_G_CYCLE_PM *= -1;
			SFX_G_CYCLE = 0;
		}
		if (SFX_G_CYCLE > 255)
		{
			SFX_G_CYCLE_PM *= -1;
			SFX_G_CYCLE = 255;
		}
		string L_CYCLE = SFX_B_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		SFX_B_CYCLE += L_CYCLE;
		if (SFX_B_CYCLE < 0)
		{
			SFX_B_CYCLE_PM *= -1;
			SFX_B_CYCLE = 0;
		}
		if (SFX_B_CYCLE > 255)
		{
			SFX_B_CYCLE_PM *= -1;
			SFX_B_CYCLE = 255;
		}
		Vector3 L_COLOR = Vector3(int(SFX_R_CYCLE), int(SFX_G_CYCLE), int(SFX_B_CYCLE));
		ClientEffect("light", SFX_METAL_CAVE_LIGHT, /* TODO: $getcl */ $getcl(SFX_METAL_CAVE_MDL, "origin"), 768, L_COLOR, 1.0);
	}

	void s_test()
	{
		string L_PLR = "game.localplayer.index";
		string L_PLR_ORG = /* TODO: $getcl */ $getcl(L_PLR, "origin");
		string L_SCAN_RAD = param1;
		if ((param2).findFirst(PARAM) == 0)
		{
			string SCAN_FLAGS = param2;
		}
		string SCAN_RESULT = /* TODO: $getcl_tsphere */ $getcl_tsphere(L_PLR_ORG, L_SCAN_RAD, SCAN_FLAGS);
		LogDebug("s_test SCAN_RESULT");
	}

	void cl_set_height()
	{
		LogDebug("cl_set_height PARAM1");
		game.cleffect.view_ofs.z = param1;
	}

	void ext_sbfollow()
	{
		string L_VIEWMODEL_IDX = "game.localplayer.viewmodel.active.id";
		int L_ATTACH = 1;
		if ((param1).findFirst(PARAM) == 0)
		{
			string L_VIEWMODEL_IDX = param1;
		}
		if ((param2).findFirst(PARAM) == 0)
		{
			string L_ATTACH = param2;
		}
		ClientEffect("beam_follow", L_VIEWMODEL_IDX, L_ATTACH, "lgtning.spr", 20.0, 30, Vector3(1, 0, 0), 1);
		LogDebug("*** ext_sbfollow PARAM1 PARAM2 [ game.script.last_beam_id ]");
		CYCLE_BEAM = "game.script.last_beam_id";
	}

	void ext_sbent()
	{
		string L_VIEWMODEL_IDX = "game.localplayer.viewmodel.active.id";
		int L_ATTACH1 = 1;
		int L_ATTACH2 = 2;
		if ((param1).findFirst(PARAM) == 0)
		{
			string L_VIEWMODEL_IDX = param1;
		}
		if ((param2).findFirst(PARAM) == 0)
		{
			string L_ATTACH1 = param2;
		}
		if ((param3).findFirst(PARAM) == 0)
		{
			string L_ATTACH2 = param3;
		}
		ClientEffect("beam_ents", L_VIEWMODEL_IDX, L_ATTACH1, L_VIEWMODEL_IDX, L_ATTACH2, "lgtning.spr", 20.0, 5, 1, 0.5, 100, 30, Vector3(1, 0, 1));
		LogDebug("*** ext_sbent PARAM1 PARAM2 PARAM3 [ game.script.last_beam_id ]");
		CYCLE_BEAM = "game.script.last_beam_id";
	}

	void ext_sbents()
	{
		string L_ENT1 = param1;
		string L_ENT2 = param2;
		ClientEffect("beam_ents", L_ENT1, 0, L_ENT2, 0, "lgtning.spr", 120.0, 5, 1, 255, 100, 30, Vector3(255, 0, 255));
		LogDebug("*** ext_sbent PARAM1 PARAM2 [ game.script.last_beam_id ] [ GAME_BULLSHIT ]");
		CYCLE_BEAM = "game.script.last_beam_id";
	}

	void edit_beam()
	{
		ClientEffect("beam_update", CYCLE_BEAM, param1, param2);
	}

	void get_beam()
	{
		LogDebug("*** beamprop PARAM1 is /* TODO: $getcl_beam */ $getcl_beam(CYCLE_BEAM, param1)");
	}

	void clear_beams()
	{
		LogDebug("*** clear_beams");
		ClientEffect("beam_update", "removeall");
	}

	void change_sky()
	{
		SetEnvironment("sky.texture", param1);
	}

	void cl_show_text()
	{
		// TODO: localmenu.reset
		string reg.local.menu.title = "Test title";
		// TODO: registerlocal.menu
		string reg.local.button.text = "Button1";
		int reg.local.button.closeonclick = 0;
		int reg.local.button.enabled = 1;
		int reg.local.button.docallback = 1;
		string reg.local.button.callback = "cb_test1";
		// TODO: registerlocal.button
		string reg.local.button.text = "Button2";
		int reg.local.button.closeonclick = 1;
		int reg.local.button.enabled = 0;
		int reg.local.button.docallback = 0;
		string reg.local.button.callback = "cb_test1";
		// TODO: registerlocal.button
		string reg.local.button.text = "Button3";
		int reg.local.button.closeonclick = 1;
		int reg.local.button.enabled = 1;
		int reg.local.button.docallback = 0;
		// TODO: registerlocal.button
		string reg.local.paragraph.source.type = "local";
		string reg.local.paragraph.source = "#LOCALPAGE_TEST1";
		// TODO: registerlocal.paragraph
		LogMessage("ent_me OPENING");
		// TODO: localmenu.open
	}

	void cb_test1()
	{
		// TODO: localmenu.close
	}

	void cb_test2()
	{
	}

	void spawn_corpse()
	{
		CORPSE_ANG = /* TODO: $getcl */ $getcl(param1, "angles");
		CORPSE_ANIM_IDX = param2;
		CORPSE_SCALE = GetToken(param3, 0, ";");
		if (CORPSE_SCALE == 0)
		{
			CORPSE_SCALE = 1;
		}
		L_INRENDER = GetToken(param3, 1, ";");
		CORPSE_RENDERMODE = "normal";
		if (L_INRENDER == 2)
		{
			CORPSE_RENDERMODE = "texture";
		}
		if (L_INRENDER == 5)
		{
			CORPSE_RENDERMODE = "add";
		}
		CORPSE_RENDERAMT = GetToken(param3, 2, ";");
		if (CORPSE_RENDERAMT == 0)
		{
			CORPSE_RENDERAMT = 255;
		}
		CORPSE_BODY_IDX = GetToken(param3, 3, ";");
		CORPSE_SKIN = GetToken(param3, 4, ";");
		LogDebug("*** clplayer spawn_corpse PARAM1 PARAM2 model: /* TODO: $getcl */ $getcl(param1, "model") scale: CORPSE_SCALE rmode: CORPSE_RENDERMODE ramt: CORPSE_RENDERAMT bodyidx: CORPSE_BODY_IDX origin: /* TODO: $getcl */ $getcl(param1, "origin")");
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(param1, "model"), /* TODO: $getcl */ $getcl(param1, "origin"), "setup_corpse");
	}

	void setup_corpse()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20.0);
		ClientEffect("tempent", "set_current_prop", "scale", CORPSE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, -50));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 50);
		ClientEffect("tempent", "set_current_prop", "body", CORPSE_BODY_IDX);
		ClientEffect("tempent", "set_current_prop", "sequence", CORPSE_ANIM_IDX);
		ClientEffect("tempent", "set_current_prop", "angles", CORPSE_ANG);
		ClientEffect("tempent", "set_current_prop", "rendermode", CORPSE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "renderamt", CORPSE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "skin", CORPSE_SKIN);
	}

	void cl_array_test()
	{
		if (!(SETUP_TEST_ARRAY))
		{
			array<string> ARRAY_TEST;
			SETUP_TEST_ARRAY = 1;
		}
		ARRAY_TEST.insertLast("yes");
	}

}

}
