#pragma context server

#include "items/base_item_extras.as"

namespace MS
{

class ProjBase : CGameScript
{
	string BOLT_TRACE_END;
	int BP_HIT_TARGET;
	string CLFX_ARROW_IDX;
	string CLFX_ARROW_INIT;
	string CLFX_ARROW_IN_FLIGHT;
	string CLFX_ARROW_SCRIPT;
	float CLFX_ARROW_UPDATE_RATE;
	string MODEL_WORLD;
	string MY_XBOW;
	int PROJ_COLLIDEHITBOX;
	string PROJ_DELETING;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_ON_NPC;

	ProjBase()
	{
		PROJ_COLLIDEHITBOX = 1;
		PROJ_IGNORENPC = 0;
		MODEL_WORLD = "none";
		PROJ_MOTIONBLUR = 1;
		PROJ_STICK_ON_NPC = 1;
		CLFX_ARROW_SCRIPT = "items/proj_simple_cl";
		CLFX_ARROW_UPDATE_RATE = 0.5;
	}

	void OnSpawn() override
	{
		// TODO: movetype projectile
		if (!(CLFX_ARROW))
		{
			SetModel(MODEL_WORLD);
			if (PROJ_ANIM_IDLE != "PROJ_ANIM_IDLE")
			{
				if (PROJ_ANIM_IDLE != "none")
				{
				}
				PlayAnim("once", PROJ_ANIM_IDLE);
			}
			if (MODEL_BODY_OFS != "MODEL_BODY_OFS")
			{
				SetModelBody(0, MODEL_BODY_OFS);
			}
		}
		else
		{
			SetWidth(32);
			SetHeight(32);
			SetModel("none");
		}
		if (!(HITSCAN_BOLT))
		{
			string reg.proj.dmg = PROJ_DAMAGE;
		}
		else
		{
			int reg.proj.dmg = 0;
		}
		if ((HEAVY_ONLY))
		{
			string reg.proj.dmg = PROJ_DAMAGE;
		}
		string reg.proj.dmgtype = PROJ_DAMAGE_TYPE;
		string reg.proj.aoe.range = PROJ_AOE_RANGE;
		string reg.proj.aoe.falloff = PROJ_AOE_FALLOFF;
		string reg.proj.stick.duration = PROJ_STICK_DURATION;
		string reg.proj.collidehitbox = PROJ_COLLIDEHITBOX;
		string reg.proj.ignorenpc = PROJ_IGNORENPC;
		SetMonsterClip(0);
		RegisterProjectile();
		projectile_spawn();
	}

	void game_fall()
	{
		if (MODEL_BODY_OFS != "MODEL_BODY_OFS")
		{
			SetModelBody(0, MODEL_BODY_OFS);
		}
	}

	void game_tossprojectile()
	{
		if ((CLFX_ARROW))
		{
			ScheduleDelayedEvent(0.01, "update_clfx_projectile");
		}
		MY_XBOW = GetActiveItem("ent_expowner");
		if (MODEL_BODY_OFS != "MODEL_BODY_OFS")
		{
			if (!(CLFX_ARROW))
			{
				SetModelBody(0, MODEL_BODY_OFS);
			}
		}
		SetUseable(0);
		if ((PROJ_MOTIONBLUR))
		{
			if (!(CLFX_ARROW))
			{
			}
			ClientEvent("new", "all_in_sight", "effects/sfx_motionblur", GetEntityIndex(GetOwner()), MODEL_BODY_OFS);
		}
		game_fall();
		if ((HITSCAN_BOLT))
		{
			hitscan_bolt();
		}
	}

	void game_projectile_landed()
	{
		LogDebug("game_projectile_landed");
		if ((CLFX_ARROW))
		{
			CLFX_ARROW_IN_FLIGHT = 0;
			ClientEvent("update", "all", CLFX_ARROW_IDX, "end_fx", "landed");
		}
		// TODO: movetype none
		if (!(PROJ_STICK_ON_WALL_NEW))
		{
			SetExpireTime(0);
		}
		else
		{
			SetModel(MODEL_WORLD);
			SetModelBody(0, MODEL_BODY_OFS);
			SolidifyProjectile(GetOwner());
		}
		projectile_landed();
		if (PROJ_STICK_DURATION == 0)
		{
			remove_projectile("landed");
		}
		if (PROJ_STICK_DURATION > 0)
		{
			PROJ_STICK_DURATION("remove_projectile");
		}
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(PROJ_REMOVE_ON_USE)) return;
		if ((PROJ_DELETING)) return;
		LogDebug("GetEntityName(param1)");
		if ((IsKeyDown(param1, "use")))
		{
			PROJ_DELETING = 1;
			EmitSound(GetOwner(), 0, SOUND_HITWALL1, 10);
			remove_projectile("touch_used");
		}
		if ((IsValidPlayer(param1))) return;
		PROJ_DELETING = 1;
		remove_projectile("touch_remove");
		ClientEvent("update", "all", CLFX_ARROW_IDX, "ext_touch", GetEntityIndex(param1));
	}

	void game_projectile_hitwall()
	{
		// PlayRandomSound from: HITWALL_VOL, SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {HITWALL_VOL, SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (PROJ_STICK_DURATION == 0)
		{
			remove_projectile("hitwall");
		}
	}

	void ext_lighten()
	{
		SetGravity(param1);
		if ((CLFX_ARROW))
		{
			ClientEvent("update", "all", CLFX_ARROW_IDX, "ext_lighten", param1);
		}
	}

	void ext_scale()
	{
		SetProp(GetOwner(), "scale", param1);
		if ((CLFX_ARROW))
		{
			ClientEvent("update", "all", CLFX_ARROW_IDX, "ext_scale", param1);
		}
	}

	void hitscan_bolt()
	{
		if ((HEAVY_ONLY))
		{
			int EXIT_SUB = 1;
			if ((GetEntityName(MY_XBOW)).findFirst("Heavy") >= 0)
			{
				int EXIT_SUB = 0;
				SetGravity(0);
			}
			if ((GetEntityName(MY_XBOW)).findFirst("Steam") >= 0)
			{
				int EXIT_SUB = 0;
				SetGravity(0);
			}
		}
		if ((EXIT_SUB)) return;
		string START_TRACE = GetEntityOrigin(GetOwner());
		string V_MY_DEST = /* TODO: $relpos */ $relpos(Vector3(/* TODO: $neg */ $neg(GetMonsterProperty("angles.pitch")), GetMonsterProperty("angles.yaw"), GetMonsterProperty("angles.roll")), Vector3(0, 8000, 0));
		string MY_DEST = START_TRACE;
		MY_DEST += V_MY_DEST;
		string HIT_TARG = TraceLine(START_TRACE, MY_DEST);
		if (HIT_TARG == GetEntityIndex("ent_expowner"))
		{
			int EXIT_SUB = 1;
			ScheduleDelayedEvent(0.01, "hitscan_bolt");
		}
		if ((EXIT_SUB)) return;
		string MY_DAMAGE = GetSkillLevel("ent_expowner", "archery");
		MY_DAMAGE *= 0.01;
		MY_DAMAGE *= PROJ_DAMAGE;
		string DMG_MULTI = GetEntityProperty(MY_XBOW, "scriptvar");
		if (DMG_MULTI > 0)
		{
			MY_DAMAGE *= DMG_MULTI;
		}
		if (!(IsEntityAlive(HIT_TARG)))
		{
			SetEntityOrigin(GetOwner(), HIT_TARG);
			BOLT_TRACE_END = TraceLine(START_TRACE, MY_DEST);
			XDoDamage(START_TRACE, MY_DEST, MY_DAMAGE, 1.0, "ent_expowner", GetOwner(), "archery", PROJ_DAMAGE_TYPE, "dmgevent:*bolt");
		}
		if ((IsEntityAlive(HIT_TARG)))
		{
			SetEntityOrigin(GetOwner(), GetEntityOrigin(HIT_TARG));
			strike_target(HIT_TARG);
		}
	}

	void strike_target()
	{
		if ((BP_HIT_TARGET)) return;
		BP_HIT_TARGET = 1;
		SetEntityOrigin(GetOwner(), GetEntityOrigin(param1));
		string MY_DAMAGE = GetSkillLevel("ent_expowner", "archery");
		MY_DAMAGE *= 0.01;
		MY_DAMAGE *= PROJ_DAMAGE;
		string DMG_MULTI = GetEntityProperty(MY_XBOW, "scriptvar");
		if (DMG_MULTI > 0)
		{
			MY_DAMAGE *= DMG_MULTI;
		}
		XDoDamage(param1, "direct", MY_DAMAGE, 1.0, "ent_expowner", "ent_expowner", "archery", PROJ_DAMAGE_TYPE);
		if (!(PROJ_STICK_ON_NPC))
		{
			remove_projectile("strike_target");
		}
	}

	void game_projectile_hitnpc()
	{
		if ((CLFX_ARROW))
		{
			CLFX_ARROW_IN_FLIGHT = 0;
			ClientEvent("update", "all", CLFX_ARROW_IDX, "ext_hitnpc", GetEntityIndex(param1));
		}
		if (!(HITSCAN_BOLT)) return;
		string OUT_TARG = param1;
		strike_target(OUT_TARG);
	}

	void remove_projectile()
	{
		if (CLFX_ARROW != "CLFX_ARROW")
		{
			CLFX_ARROW_IN_FLIGHT = 0;
			if ((CLFX_ARROW_NOSTICK))
			{
				ClientEvent("update", "all", CLFX_ARROW_IDX, "end_fx", param1);
			}
		}
		SetExpireTime(0);
		DeleteEntity(GetOwner());
	}

	void update_clfx_projectile()
	{
		if (!(CLFX_ARROW_INIT))
		{
			CLFX_ARROW_INIT = 1;
			CLFX_ARROW_IN_FLIGHT = 1;
			string L_INFO_TOKENS = GetEntityOrigin(GetOwner());
			if (L_INFO_TOKENS.length() > 0) L_INFO_TOKENS += ";";
			L_INFO_TOKENS += GetEntityAngles(GetOwner());
			if (L_INFO_TOKENS.length() > 0) L_INFO_TOKENS += ";";
			L_INFO_TOKENS += GetEntityVelocity(GetOwner());
			if (L_INFO_TOKENS.length() > 0) L_INFO_TOKENS += ";";
			L_INFO_TOKENS += int(PROJ_ANIM_IDLE);
			if (L_INFO_TOKENS.length() > 0) L_INFO_TOKENS += ";";
			L_INFO_TOKENS += GetEntityProperty(GetOwner(), "gravity");
			if (L_INFO_TOKENS.length() > 0) L_INFO_TOKENS += ";";
			L_INFO_TOKENS += PROJ_STICK_ON_NPC;
			string L_MODEL_BODY_OFS = MODEL_BODY_OFS;
			if (MODEL_BODY_OFS == "MODEL_BODY_OFS")
			{
				int L_MODEL_BODY_OFS = 0;
			}
			ClientEvent("new", "all", CLFX_ARROW_SCRIPT, GetEntityIndex(GetOwner()), GetEntityIndex("ent_expowner"), L_INFO_TOKENS, MODEL_WORLD, L_MODEL_BODY_OFS, PROJ_MOTIONBLUR, CLFX_ARROW_TAGS);
			CLFX_ARROW_IDX = "game.script.last_sent_id";
			CLFX_ARROW_UPDATE_RATE("update_clfx_projectile");
		}
		else
		{
			if ((CLFX_ARROW_IN_FLIGHT))
			{
			}
			ClientEvent("update", "all", CLFX_ARROW_IDX, "ext_update", GetEntityOrigin(GetOwner()), GetEntityAngles(GetOwner()), GetEntityVelocity(GetOwner()));
			CLFX_ARROW_UPDATE_RATE("update_clfx_projectile");
		}
	}

	void ext_render()
	{
		SetProp(GetOwner(), "rendermode", param1);
		SetProp(GetOwner(), "renderamt", param2);
	}

}

}
