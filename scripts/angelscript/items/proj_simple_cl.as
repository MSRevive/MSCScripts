#pragma context server

namespace MS
{

class ProjSimpleCl : CGameScript
{
	string BEST_BONE_DIST;
	int FX_ACTIVE;
	string FX_ANGLES;
	string FX_ANIM_IDX;
	string FX_DO_STICK;
	string FX_EXP_OWNER;
	float FX_FREMOVE_DELAY;
	string FX_GRAVITY;
	int FX_IN_FLIGHT;
	float FX_MAX_DURATION;
	string FX_MBLUR_ANGLES;
	string FX_MODEL_NAME;
	string FX_MODEL_OFS;
	string FX_ORIGIN;
	string FX_OWNER;
	float FX_SCALE;
	string FX_SPECIAL;
	string FX_STICK_ANGS;
	string FX_STICK_DIR;
	string FX_STICK_DIST;
	string FX_STICK_OFS_SET;
	int FX_STICK_TARGET;
	int FX_SV_UPDATE;
	int FX_UPDATE_ANG;
	int FX_UPDATE_ORG;
	int FX_UPDATE_SPECIAL;
	int FX_UPDATE_VEL;
	string FX_USE_BONE;
	string FX_USE_MOTIONBLUR;
	string FX_VELOCITY;

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_OWNER = param1;
		FX_EXP_OWNER = param2;
		string L_INFO_STRING = param3;
		FX_MODEL_NAME = param4;
		FX_MODEL_OFS = param5;
		FX_USE_MOTIONBLUR = param6;
		FX_SPECIAL = param7;
		FX_MAX_DURATION = 5.0;
		FX_SCALE = 1.0;
		FX_FREMOVE_DELAY = 0.25;
		FX_ACTIVE = 1;
		FX_IN_FLIGHT = 1;
		FX_UPDATE_ORG = 0;
		FX_UPDATE_ANG = 0;
		FX_UPDATE_VEL = 0;
		FX_ORIGIN = GetToken(L_INFO_STRING, 0, ";");
		FX_ANGLES = GetToken(L_INFO_STRING, 1, ";");
		FX_VELOCITY = GetToken(L_INFO_STRING, 2, ";");
		FX_ANIM_IDX = GetToken(L_INFO_STRING, 3, ";");
		FX_GRAVITY = GetToken(L_INFO_STRING, 4, ";");
		FX_DO_STICK = GetToken(L_INFO_STRING, 5, ";");
		FX_STICK_TARGET = 0;
		if (FX_ANIM_IDX == -1)
		{
			FX_ANIM_IDX = 0;
		}
		ClientEffect("tempent", "model", FX_MODEL_NAME, FX_ORIGIN, "make_clfx_proj", "update_clfx_proj", "collide_clfx_proj");
		FX_MAX_DURATION("end_fx");
	}

	void end_fx()
	{
		if ((FX_DO_STICK))
		{
			if (param1 == "touch_remove")
			{
				int L_ABORT_REMOVE = 1;
			}
			if (param1 == "strike_target")
			{
				int L_ABORT_REMOVE = 1;
			}
			if (param1 == "landed")
			{
				int L_ABORT_REMOVE = 1;
			}
			if ((L_ABORT_REMOVE))
			{
			}
			ScheduleDelayedEvent(5.0, "end_fx");
			return;
		}
		FX_ACTIVE = 0;
		FX_FREMOVE_DELAY("remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void ext_scale()
	{
		FX_SCALE = param1;
		FX_UPDATE_SPECIAL = 1;
	}

	void ext_lighten()
	{
		FX_GRAVITY = param1;
		FX_UPDATE_SPECIAL = 1;
	}

	void ext_touch()
	{
		if ((/* TODO: $getcl */ $getcl(param1, "isalive"))) return;
		end_fx();
	}

	void ext_hitnpc()
	{
		FX_STICK_TARGET = param1;
		FX_IN_FLIGHT = 0;
	}

	void ext_update()
	{
		if (!(FX_IN_FLIGHT)) return;
		FX_SV_UPDATE = 1;
		FX_ORIGIN = param1;
		FX_ANGLES = param2;
		FX_VELOCITY = param3;
	}

	void make_clfx_proj()
	{
		ClientEffect("tempent", "set_current_prop", "origin", FX_ORIGIN);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", FX_GRAVITY);
		ClientEffect("tempent", "set_current_prop", "angles", FX_ANGLES);
		ClientEffect("tempent", "set_current_prop", "velocity", FX_VELOCITY);
		if ((FX_DO_STICK))
		{
			ClientEffect("tempent", "set_current_prop", "collide", "world");
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		}
		ClientEffect("tempent", "set_current_prop", "body", FX_MODEL_OFS);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "sequence", FX_ANIM_IDX);
	}

	void update_clfx_proj()
	{
		if ((FX_ACTIVE))
		{
			if ((FX_IN_FLIGHT))
			{
				if ((FX_SV_UPDATE))
				{
					FX_SV_UPDATE = 0;
					string L_MY_POS = "game.tempent.origin";
					if (Distance(FX_UPDATE_ORG, L_MY_POS) > 100)
					{
						ClientEffect("tempent", "set_current_prop", "origin", FX_ORIGIN);
					}
					ClientEffect("tempent", "set_current_prop", "angles", FX_ANGLES);
					ClientEffect("tempent", "set_current_prop", "velocity", FX_VELOCITY);
				}
				if ((FX_UPDATE_SPECIAL))
				{
					FX_UPDATE_SPECIAL = 0;
					ClientEffect("tempent", "set_current_prop", "scale", FX_SCALE);
					ClientEffect("tempent", "set_current_prop", "gravity", FX_GRAVITY);
				}
				if ((FX_USE_MOTIONBLUR))
				{
					fx_motion_blur();
				}
			}
			else
			{
				if ((FX_DO_STICK))
				{
					if (FX_STICK_TARGET != 0)
					{
						if ((/* TODO: $getcl */ $getcl(FX_STICK_TARGET, "exists")))
						{
							ClientEffect("tempent", "set_current_prop", "movetype", 0);
							ClientEffect("tempent", "set_current_prop", "gravity", 0);
							ClientEffect("tempent", "set_current_prop", "collide", "none");
							ClientEffect("tempent", "set_current_prop", "velocity", 0);
							string L_STICK_POINT = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "origin");
							if (FX_USE_BONE > -1)
							{
								string L_STICK_POINT = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "bonepos", FX_USE_BONE);
							}
							string L_MY_POS = "game.tempent.origin";
							if (!(FX_STICK_OFS_SET))
							{
								FX_STICK_OFS_SET = 1;
								FX_STICK_DIR = (L_MY_POS - L_STICK_POINT).Normalize();
								FX_STICK_DIST = Distance(L_MY_POS, L_STICK_POINT);
								FX_STICK_DIR *= FX_STICK_DIST;
								ClientEffect("tempent", "set_current_prop", "framerate", 0);
								ClientEffect("tempent", "set_current_prop", "gravity", 0);
								ClientEffect("tempent", "set_current_prop", "collide", "none");
								FX_STICK_ANGS = "game.tempent.angles";
							}
							string L_TARG_YAW = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "angles");
							string L_TARG_YAW = (L_TARG_YAW).y;
							L_TARG_YAW += 180;
							if (L_TARG_YAW > 359.99)
							{
								L_TARG_ANG -= 359.99;
							}
							string L_NEW_ANG = FX_STICK_ANGS;
							L_NEW_ANG = "y";
							ClientEffect("tempent", "set_current_prop", "angles", L_NEW_ANG);
							L_STICK_POINT += FX_STICK_DIR;
							ClientEffect("tempent", "set_current_prop", "origin", L_STICK_POINT);
						}
						else
						{
							end_fx();
						}
					}
				}
				else
				{
					end_fx();
				}
			}
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(5000, 5000, 5000));
		}
	}

	void fx_motion_blur()
	{
		FX_MBLUR_ANGLES = "game.tempent.angles";
		ClientEffect("tempent", "model", FX_MODEL_NAME, "game.tempent.origin", "setup_motion_blur");
	}

	void setup_motion_blur()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.15);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", FX_MBLUR_ANGLES);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "body", FX_MODEL_OFS);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
	}

	void collide_clfx_proj()
	{
		FX_IN_FLIGHT = 0;
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		if ((FX_DO_STICK))
		{
			if (param1 != "world")
			{
			}
			if (param1 > 0)
			{
			}
			FX_STICK_TARGET = param1;
			string L_N_BONES = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "bonecount");
			if (L_N_BONES == 0)
			{
				FX_USE_BONE = -1;
			}
			else
			{
				BEST_BONE_DIST = 9999;
				FX_PROJ_POS = "game.tempent.origin";
				for (int i = 0; i < L_N_BONES; i++)
				{
					find_nearest_bone();
				}
			}
			string L_MY_POS = "game.tempent.origin";
			string L_STICK_POINT = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "origin");
			if (FX_USE_BONE > -1)
			{
				string L_STICK_POINT = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "bonepos", FX_USE_BONE);
			}
			FX_STICK_OFS_SET = 1;
			FX_STICK_DIR = (L_MY_POS - L_STICK_POINT).Normalize();
			FX_STICK_DIST = Distance(L_MY_POS, L_STICK_POINT);
			FX_STICK_DIR *= FX_STICK_DIST;
			L_STICK_POINT += FX_STICK_DIST;
			ClientEffect("tempent", "set_current_prop", "origin", L_STICK_POINT);
			FX_STICK_ANGS = "game.tempent.angles";
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(5000, 5000, 5000));
		}
	}

	void find_nearest_bone()
	{
		string L_CUR_BONE = i;
		if (!(L_CUR_BONE > 0)) return;
		string L_CUR_BONE_POS = /* TODO: $getcl */ $getcl(FX_STICK_TARGET, "bonepos", L_CUR_BONE);
		string L_CUR_BONE_DIST = Distance(FX_PROJ_POS, L_CUR_BONE_POS);
		if (L_CUR_BONE_DIST < BEST_BONE_DIST)
		{
			FX_USE_BONE = L_CUR_BONE;
			BEST_BONE_DIST = L_CUR_BONE_DIST;
		}
	}

}

}
