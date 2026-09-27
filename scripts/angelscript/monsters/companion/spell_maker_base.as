#pragma context server

namespace MS
{

class SpellMakerBase : CGameScript
{
	string FADE_LEVEL;
	string FADE_RATE;
	int GLOW_AMT;
	string ITEM_CREATED_ME;
	string ITEM_TO_REMOVE;
	string MY_OWNER;
	string MY_SPAWN_HEIGHT;
	string SPAWNER_MODEL;
	int SPELL_MAKER_HEIGHT;
	string SPELL_TO_GRANT;

	SpellMakerBase()
	{
		SPELL_MAKER_HEIGHT = 64;
		GLOW_AMT = 50;
		SPAWNER_MODEL = "null.mdl";
	}

	void OnSpawn() override
	{
		SetName("Spell Spawner");
		SetRace("beloved");
		SetInvincible(true);
		SetFly(true);
		SetGravity(0);
		SetModel(SPAWNER_MODEL);
		SetSolid("none");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		if (MODEL_OFSET != "MODEL_OFSET")
		{
			SetModelBody(0, MODEL_OFSET);
		}
		if (ANIM_IDLE != "")
		{
			PlayAnim("loop", ANIM_IDLE);
		}
		if (SOUND_SPAWN != "SOUND_SPAWN")
		{
			EmitSound(GetOwner(), 0, SOUND_SPAWN, 10);
		}
		if ((FX_GLOW))
		{
			Effect("glow", GetOwner(), GLOW_COLOR, GLOW_AMT, REMOVE_DELAY, REMOVE_DELAY);
		}
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		SPELL_TO_GRANT = param2;
		if (SPELL_TO_GRANT != "none")
		{
			ITEM_CREATED_ME = param3;
			MY_SPAWN_HEIGHT = param4;
			ITEM_TO_REMOVE = param5;
			SetAngles("face.y");
		}
		if (SPAWNER_MODEL != "none")
		{
			FADE_LEVEL = 255;
			FADE_RATE = REMOVE_DELAY;
			FADE_RATE *= 0.1;
			stick_to_owner();
		}
		if ((SHOW_FX))
		{
			ScheduleDelayedEvent(0.1, "show_fx");
		}
		if (SPELL_TO_GRANT != "none")
		{
			ScheduleDelayedEvent(0.1, "remove_scroll");
		}
		REMOVE_DELAY("me_vanish");
	}

	void show_fx()
	{
		ClientEvent("new", "all", FX_SCRIPT, GetEntityIndex(GetOwner()), GetEntityIndex(MY_OWNER), EXTRA_PARAM1, EXTRA_PARAM2, EXTRA_PARAM3);
	}

	void remove_scroll()
	{
		if (ITEM_TO_REMOVE != "none")
		{
			CallExternal(ITEM_TO_REMOVE, "clear_hands");
		}
		ScheduleDelayedEvent(0.1, "grant_spell");
	}

	void grant_spell()
	{
		if (SPELL_TO_GRANT != "none")
		{
			// TODO: offer MY_OWNER SPELL_TO_GRANT
		}
		ScheduleDelayedEvent(0.1, "restore_scroll");
	}

	void restore_scroll()
	{
		if (ITEM_CREATED_ME != "none")
		{
			// TODO: offer MY_OWNER ITEM_CREATED_ME
		}
	}

	void me_vanish()
	{
		SetAlive(0);
		DeleteEntity(GetOwner());
	}

	void stick_to_owner()
	{
		FADE_LEVEL -= FADE_RATE;
		if (!(FADE_LEVEL > 0)) return;
		ScheduleDelayedEvent(0.1, "stick_to_owner");
		SetProp(GetOwner(), "rendermode", 1);
		SetProp(GetOwner(), "renderamt", int(FADE_LEVEL));
		SetAngles("face.yaw");
		string OWNER_POS = GetEntityOrigin(MY_OWNER);
		string OWNER_X = (OWNER_POS).x;
		string OWNER_Y = (OWNER_POS).y;
		string Z_POS = /* TODO: $get_ground_height */ $get_ground_height(OWNER_POS);
		Z_POS += SPELL_MAKER_HEIGHT;
		SetEntityOrigin(GetOwner(), Vector3(OWNER_X, OWNER_Y, Z_POS));
	}

}

}
