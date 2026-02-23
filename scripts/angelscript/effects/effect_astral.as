#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectAstral : CGameScript
{
	string CL_IDX;
	int EFFECT_ACTIVE;
	int FB_ACCEL;
	int FX_ACTIVE;
	string FX_POS;
	string FX_VIEWANGLES;
	int RL_ACCEL;
	string game.cleffect.view_ofs.x;
	string game.cleffect.view_ofs.y;
	string game.cleffect.view_ofs.z;
	int game.effect.canattack;
	int game.effect.canduck;
	int game.effect.canjump;
	float game.effect.movespeed;

	EffectAstral()
	{
		const string EFFECT_ID = "astral_project";
		const int FX_MAXSPEED = 30;
		const int FX_KEYINC = 1;
		const float FX_DEC = 0.1;
	}

	void game_activate()
	{
		game.effect.movespeed = 0.0;
		game.effect.canjump = 0;
		game.effect.canduck = 0;
		game.effect.canattack = 0;
		ShowHelpTip(GetOwner(), "generic", "Astral Projection", "Right click to stop drifting.|Left click to return to your body.");
		ClientCommand(GetOwner(), "thirdperson");
		EFFECT_ACTIVE = 1;
		ClientEvent("new", GetOwner(), currentscript, GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "viewangles"));
		CL_IDX = "game.script.last_sent_id";
		key_loop();
	}

	void OnDamage(int damage) override
	{
		effect_die();
	}

	void key_loop()
	{
		if (!(EFFECT_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "key_loop");
		if ((IsKeyDown(GetOwner(), "attack1")))
		{
			effect_die();
		}
		else
		{
			ClientEvent("update", GetOwner(), CL_IDX, "key_status", IsKeyDown(GetOwner(), "forward"), IsKeyDown(GetOwner(), "back"), IsKeyDown(GetOwner(), "moveleft"), IsKeyDown(GetOwner(), "moveright"), GetEntityProperty(GetOwner(), "viewangles"), IsKeyDown(GetOwner(), "attack2"));
		}
	}

	void effect_die()
	{
		ClientCommand(GetOwner(), "thirdperson");
		EFFECT_ACTIVE = 0;
		ClientEvent("update", GetOwner(), CL_IDX, "remove_fx");
		RemoveScript();
	}

	void client_activate()
	{
		string L_FX_OWNERPOS = /* TODO: $getcl */ $getcl(param1, "origin");
		string L_ZDIST = Distance(L_FX_OWNERPOS, Vector3(0, 0, 0));
		string L_ZDIR = (Vector3(0, 0, 0) - L_FX_OWNERPOS).Normalize();
		FX_POS = L_FX_OWNERPOS;
		L_ZDIR *= L_ZDIST;
		FX_POS += L_ZDIR;
		FX_VIEWANGLES = param2;
		FX_POS += /* TODO: $relpos */ $relpos(FX_VIEWANGLES, Vector3(0, 64, 16));
		LogDebug("$currentscript startpos PARAM1 FX_POS");
		game.cleffect.view_ofs.x = (FX_POS).x;
		game.cleffect.view_ofs.y = (FX_POS).y;
		game.cleffect.view_ofs.z = (FX_POS).z;
		FX_ACTIVE = 1;
		FB_ACCEL = 0;
		RL_ACCEL = 0;
		view_loop();
	}

	void key_status()
	{
		string L_KEY_FORWARD = param1;
		string L_KEY_BACKWARD = param2;
		string L_KEY_LEFT = param3;
		string L_KEY_RIGHT = param4;
		FX_VIEWANGLES = param5;
		if ((L_KEY_FORWARD))
		{
			FB_ACCEL += FX_KEYINC;
		}
		if ((L_KEY_BACKWARD))
		{
			FB_ACCEL += /* TODO: $neg */ $neg(FX_KEYINC);
		}
		if ((L_KEY_RIGHT))
		{
			RL_ACCEL += FX_KEYINC;
		}
		if ((L_KEY_LEFT))
		{
			RL_ACCEL += /* TODO: $neg */ $neg(FX_KEYINC);
		}
		if ((param6))
		{
			FB_ACCEL = 0;
			RL_ACCEL = 0;
		}
		LogDebug("$currentscript key_status f L_KEY_FORWARD b L_KEY_BACKWARD l L_KEY_LEFT r L_KEY_RIGHT fb FB_ACCEL rl RL_ACCEL c PARAM6");
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		RemoveScript();
	}

	void view_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "view_loop");
		if (FB_ACCEL >= FX_DEC)
		{
			FB_ACCEL -= FX_DEC;
		}
		if (FB_ACCEL <= /* TODO: $neg */ $neg(FX_DEC))
		{
			FB_ACCEL += FX_DEC;
		}
		if (RL_ACCEL >= FX_DEC)
		{
			RL_ACCEL -= FX_DEC;
		}
		if (RL_ACCEL <= /* TODO: $neg */ $neg(FX_DEC))
		{
			RL_ACCEL += FX_DEC;
		}
		if (FB_ACCEL > FX_MAXSPEED)
		{
			FB_ACCEL = FX_MAXSPEED;
		}
		if (FB_ACCEL < /* TODO: $neg */ $neg(FX_MAXSPEED))
		{
			FB_ACCEL = /* TODO: $neg */ $neg(FX_MAXSPEED);
		}
		if (RL_ACCEL > FX_MAXSPEED)
		{
			RL_ACCEL = FX_MAXSPEED;
		}
		if (RL_ACCEL < /* TODO: $neg */ $neg(FX_MAXSPEED))
		{
			RL_ACCEL = /* TODO: $neg */ $neg(FX_MAXSPEED);
		}
		FX_POS += /* TODO: $relpos */ $relpos(FX_VIEWANGLES, Vector3(RL_ACCEL, FB_ACCEL, 0));
		game.cleffect.view_ofs.x = (FX_POS).x;
		game.cleffect.view_ofs.y = (FX_POS).y;
		game.cleffect.view_ofs.z = (FX_POS).z;
	}

}

}
