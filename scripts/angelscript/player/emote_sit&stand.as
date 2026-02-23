#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EmoteSit&stand : CGameScript
{
	int AM_SITTING;
	int FULL_ALERT;
	string L_HEIGHTOFS;
	float PLR_SPEED_SPEED_RATIO;
	string SCRIPT_ID;
	string STRUCK_TIME;
	string VIEW_DIRECTION;
	string VIEW_STARTTIME;
	string game.cleffect.move_scale.forward;
	string game.cleffect.move_scale.right;
	string game.cleffect.view_ofs.z;
	string game.cleffect.viewmodel_ofs.z;
	string game.effect.anim.framerate;
	string game.effect.canattack;
	string game.effect.canduck;
	string game.effect.canjump;
	string game.effect.canmove;
	string game.effect.canrun;
	string game.effect.displayname;
	string game.effect.movespeed;
	string game.effect.updateplayer;
	int regen.hp.amt;

	EmoteSit&stand()
	{
		const string EFFECT_ID = "player_sitstand";
		const string EFFECT_FLAGS = "player_action";
		const string EFFECT_SCRIPT = currentscript;
		const int game.effect.removeondeath = 0;
		const string TEXT_SIT = #ACTION_SIT;
		const string TEXT_STAND = #ACTION_STAND;
		game.effect.displayname = TEXT_SIT;
		AM_SITTING = 0;
		FULL_ALERT = 0;
		PLR_SPEED_SPEED_RATIO = 1.0;
		const int VIEW_LOWERTIME = 1;
		const int VIEW_RAISETIME = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(5);
		if (STRUCK_TIME > 0)
		{
			STRUCK_TIME -= 1;
		}
		if (STRUCK_TIME == "STRUCK_TIME")
		{
			STRUCK_TIME = 1;
		}
		if (STRUCK_TIME <= 1)
		{
			if ((AM_SITTING))
			{
				string DEMON_ON = GetEntityProperty(GetOwner(), "scriptvar");
				if (!(DEMON_ON))
				{
				}
				MAX_HEALTH = GetEntityMaxHealth(GetOwner());
				REGEN_RATE = 0.05;
				REGEN_RATE *= MAX_HEALTH;
				REGEN_INT = int(REGEN_RATE);
				if (REGEN_INT < 2)
				{
					REGEN_INT = 2;
				}
				regen.hp.amt += REGEN_INT;
				HealEntity(GetOwner(), regen.hp.amt);
				DrainStamina(GetOwner());
				string SHOWIT_ON = GetEntityProperty(GetOwner(), "scriptvar");
				if ((SHOWIT_ON))
				{
				}
				string MY_HP = GetEntityHealth(GetOwner());
				string MY_MAXHP = GetEntityMaxHealth(GetOwner());
				string MY_HP = int(MY_HP);
				string MY_MAXHP = int(MY_MAXHP);
			}
			else
			{
				regen.hp.amt = 1;
			}
			if ((AM_SITTING))
			{
				MAX_MANA = GetEntityProperty(GetOwner(), "maxmp");
				MANA_RATE = 0.20;
				MANA_RATE *= MAX_MANA;
				MANA_INT = int(MANA_RATE);
				if (MANA_INT < 4)
				{
					MANA_INT = 4;
				}
				regen.mp.amt += MANA_INT;
				GiveMP(GetOwner());
				if ((SHOWIT_ON))
				{
				}
				string MY_MP = GetEntityMP(GetOwner());
				string MY_MAXMP = GetEntityProperty(GetOwner(), "maxmp");
				string MY_MP = int(MY_MP);
				string MY_MAXMP = int(MY_MAXMP);
				FULL_ALERT += 1;
				if (GetEntityMP(GetOwner()) == GetEntityProperty(GetOwner(), "maxmp"))
				{
					string MY_MP = "MAX";
				}
				if (GetEntityHealth(GetOwner()) == GetEntityMaxHealth(GetOwner()))
				{
					string MY_HP = "MAX";
				}
				if (GetEntityMP(GetOwner()) < GetEntityProperty(GetOwner(), "maxmp"))
				{
					FULL_ALERT = 0;
				}
				if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
				{
					FULL_ALERT = 0;
				}
				if (FULL_ALERT == 1)
				{
					SendColoredMessage(GetOwner(), "You are fully rested.");
				}
				if (FULL_ALERT == 0)
				{
					SendColoredMessage(GetOwner(), "Resting... HP: MY_HP / MY_MAXHP MANA: MY_MP / MY_MAXMP");
				}
			}
			else
			{
				regen.mp.amt = 1;
			}
		}
	}

	void game_activate()
	{
		ScheduleDelayedEvent(0.5, "send_emote");
	}

	void send_emote()
	{
		ClientEvent("new", GetOwner(), currentscript);
		SCRIPT_ID = "game.script.last_sent_id";
	}

	void game_player_activate()
	{
		if (!(AM_SITTING))
		{
			if (!(CanAttack(GetOwner())))
			{
				SendColoredMessage(GetOwner(), "Can't use this emote while unable to attack.");
				return;
			}
			CallExternal(GetOwner(), "emote_stop");
			PlayAnim("hold", "sitdown");
			CallExternal(GetEntityProperty(GetOwner(), "scriptvar"), "ext_player_sit");
			game.effect.canmove = 0;
			game.effect.canattack = 0;
			game.effect.canrun = 0;
			game.effect.canjump = 0;
			game.effect.canduck = 0;
			// TODO: setstatus add sitting
			AM_SITTING = 1;
			ClientEvent("update", GetOwner(), SCRIPT_ID, "view_change", 1);
			game.effect.displayname = TEXT_STAND;
			game.effect.updateplayer = 1;
		}
		else
		{
			ClientEvent("update", GetOwner(), SCRIPT_ID, "view_change", 0);
			VIEW_RAISETIME("player_sit_freedom");
			// TODO: setstatus remove sitting
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		STRUCK_TIME = 5;
		regen.hp.amt = 0;
	}

	void player_sit_freedom()
	{
		PlayAnim("once", "break");
		game.effect.canmove = 1;
		game.effect.canattack = 1;
		game.effect.canrun = 1;
		game.effect.canjump = 1;
		game.effect.canduck = 1;
		AM_SITTING = 0;
		game.effect.displayname = TEXT_SIT;
		game.effect.updateplayer = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(AM_SITTING)) return;
		ClientEvent("update", GetOwner(), SCRIPT_ID, "view_change", 0);
	}

	void view_change()
	{
		const int VIEW_LOWERHEIGHT = -28;
		VIEW_DIRECTION = param1;
		VIEW_STARTTIME = GetGameTime();
		view_update();
	}

	void view_update()
	{
		string L_TIMEDELTA = GetGameTime();
		L_TIMEDELTA -= VIEW_STARTTIME;
		string L_RATIO = L_TIMEDELTA;
		L_RATIO /= VIEW_LOWERTIME;
		// TODO: capvar L_RATIO 0 1
		string L_HEIGHTOFS = L_RATIO;
		if (!(VIEW_DIRECTION))
		{
			string L_RATIO_OLD = L_RATIO;
			L_HEIGHTOFS = 1;
			L_HEIGHTOFS -= L_RATIO_OLD;
		}
		L_HEIGHTOFS *= VIEW_LOWERHEIGHT;
		game.cleffect.view_ofs.z = L_HEIGHTOFS;
		game.cleffect.viewmodel_ofs.z = L_HEIGHTOFS;
		if (!(L_RATIO < 1)) return;
		ScheduleDelayedEvent(0.01, "view_update");
	}

	void plr_change_speed()
	{
		LogDebug("$currentscript plr_change_speed PARAM1 PARAM2 PARAM3");
		if (param1 == "normal")
		{
			PLR_SPEED_SPEED_RATIO = 1.0;
			ClientEvent("update", GetOwner(), SCRIPT_ID, "plr_update_speed_client", PLR_SPEED_SPEED_RATIO);
			game.effect.movespeed = /* TODO: $math(multiply) */ PLR_SPEED_SPEED_RATIO;
			game.effect.anim.framerate = PLR_SPEED_SPEED_RATIO;
			SetScriptFlags(GetOwner(), "cleartype", "speed");
			return;
		}
		string L_ESPEED_DURATION = param1;
		string L_ESPEED_SPEED_RATIO = param2;
		string L_ESPEED_TAG = param3;
		string L_ACTION = "add";
		if ((/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), L_ESPEED_TAG, "name_exists")))
		{
			string L_ACTION = "edit";
		}
		SetScriptFlags(GetOwner(), L_ACTION, L_ESPEED_TAG, "speed", L_ESPEED_SPEED_RATIO, L_ESPEED_DURATION);
		plr_get_total_speed();
	}

	void plr_update_speed_effects()
	{
		string L_ACTION = param1;
		string L_TAG = param2;
		LogDebug("plr_update_speed_effects PARAM1 PARAM2");
		if (L_ACTION == "remove")
		{
			LogDebug("$currentscript - plr_update_speed_effects remove PARAM2");
			SetScriptFlags(GetOwner(), "remove", L_TAG);
		}
		plr_get_total_speed();
	}

	void ext_scriptflag_expired()
	{
		if (!(PLR_SPEED_SPEED_RATIO != 1.0)) return;
		ScheduleDelayedEvent(0.1, "plr_get_total_speed");
	}

	void plr_update_speed_client()
	{
		game.cleffect.move_scale.forward = param1;
		game.cleffect.move_scale.right = param1;
	}

	void plr_get_total_speed()
	{
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "speed", "type_exists")))
		{
			plr_change_speed("normal");
			return;
		}
		string L_SPEED_FLAG_TOTAL = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "speed", "type_value");
		string L_SPEED_FLAG_COUNT = /* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "speed", "type_count");
		string L_NEW_SPEED = /* TODO: $math(divide) */ L_SPEED_FLAG_TOTAL;
		PLR_SPEED_SPEED_RATIO = L_NEW_SPEED;
		plr_apply_speed();
		LogDebug("$currentscript plr_get_total_speed - tot L_SPEED_FLAG_TOTAL count L_SPEED_FLAG_COUNT new PLR_SPEED_SPEED_RATIO / /* TODO: $math(multiply) */ PLR_SPEED_SPEED_RATIO");
	}

	void plr_apply_speed()
	{
		if (SCRIPT_ID == "SCRIPT_ID")
		{
			ClientEvent("new", GetOwner(), currentscript);
			SCRIPT_ID = "game.script.last_sent_id";
		}
		ClientEvent("update", GetOwner(), SCRIPT_ID, "plr_update_speed_client", PLR_SPEED_SPEED_RATIO);
		game.effect.anim.framerate = PLR_SPEED_SPEED_RATIO;
		game.effect.movespeed = /* TODO: $math(multiply) */ PLR_SPEED_SPEED_RATIO;
	}

}

}
