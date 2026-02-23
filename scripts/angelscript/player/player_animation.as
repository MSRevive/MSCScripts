#pragma context server

namespace MS
{

class PlayerAnimation : CGameScript
{
	string CURRENT_DEATH_ANIM;
	string LEGS_ANIM;
	string TORSO_ANIM;
	int anim.underwater;

	PlayerAnimation()
	{
		const string ANIM_STAND = "stand";
		const string ANIM_STAND_IDLE = "idle";
		const string ANIM_CROUCH = "crouch_idle";
		const string ANIM_CROUCHMOVE = "crawl";
		const string ANIM_WALK = "walk_slow";
		const string ANIM_RUN = "run";
		const string ANIM_JUMP = "jump";
		const string ANIM_TREAD = "treadwater";
		const string ANIM_SWIM = "swim";
		const string ANIM_DEATH = "die_simple";
		const string ANIM_DEATH2 = "die_forwards";
		const int ANIM_TYPE_WALK = 0;
		const int ANIM_TYPE_ONCE = 1;
		const int ANIM_TYPE_HOLD = 2;
		anim.underwater = 0;
	}

	void game_animate()
	{
		// TODO: setstatus remove swimming
		string L_WATERLEVEL = GetMonsterProperty("waterlevel");
		if (L_WATERLEVEL == 0)
		{
			anim.underwater = 0;
		}
		else
		{
			if (L_WATERLEVEL < 2)
			{
				if ((GetMonsterProperty("onground")))
				{
					anim.underwater = 0;
				}
				else
				{
					anim.underwater = 1;
				}
			}
			else
			{
				if (L_WATERLEVEL >= 2)
				{
					anim.underwater = 1;
				}
			}
		}
		if ((anim.underwater))
		{
			// TODO: setstatus add swimming
		}
		// TODO: UNCONVERTED: gaitframerate 0
		if (GetMonsterProperty("anim.type") == ANIM_TYPE_WALK)
		{
			walk_animate();
		}
		else
		{
			if (GetMonsterProperty("anim.type") == ANIM_TYPE_ONCE)
			{
				once_animate();
			}
			else
			{
				if (GetMonsterProperty("anim.type") == ANIM_TYPE_HOLD)
				{
					hold_animate();
				}
			}
		}
	}

	void walk_animate()
	{
		if (!(GetMonsterProperty("in_attack_stance")))
		{
			TORSO_ANIM = 0;
			float LEGS_FRAMERATE = 1.0;
			string L_CURRENT_SPEED = GetMonsterProperty("speed2D");
			string SPEED_SHOW_RUN_ANIM = GetMonsterProperty("walkspeed");
			SPEED_SHOW_RUN_ANIM += 60;
			if (!(anim.underwater))
			{
				int l.onground = 1;
				if ((l.onground))
				{
					if ((GetMonsterProperty("ducking")))
					{
						if (!(L_CURRENT_SPEED))
						{
							TORSO_ANIM = ANIM_CROUCH;
						}
						else
						{
							TORSO_ANIM = ANIM_CROUCHMOVE;
						}
						LEGS_ANIM = TORSO_ANIM;
					}
					else
					{
						if (L_CURRENT_SPEED == 0)
						{
							if ((GetMonsterProperty("currentitem")))
							{
								TORSO_ANIM = ANIM_STAND;
							}
							else
							{
								TORSO_ANIM = ANIM_STAND_IDLE;
							}
							LEGS_ANIM = TORSO_ANIM;
						}
						else
						{
							if (L_CURRENT_SPEED <= SPEED_SHOW_RUN_ANIM)
							{
								TORSO_ANIM = ANIM_WALK;
								LEGS_ANIM = TORSO_ANIM;
								// TODO: setgaitspeed game.monster.walkspeed
							}
							else
							{
								TORSO_ANIM = ANIM_RUN;
								LEGS_ANIM = 0;
								// TODO: setgaitspeed SPEED_SHOW_RUN_ANIM
							}
						}
					}
				}
				else
				{
					TORSO_ANIM = ANIM_JUMP;
					LEGS_ANIM = 0;
				}
			}
			else
			{
				if (GetMonsterProperty("forwardspeed") <= 75)
				{
					TORSO_ANIM = ANIM_TREAD;
					LEGS_ANIM = 0;
				}
				else
				{
					TORSO_ANIM = ANIM_SWIM;
					LEGS_ANIM = 0;
					// TODO: setstatus add swimming
				}
			}
		}
		else
		{
			TORSO_ANIM += "aim_";
			int L_USELEGS = 0;
			if ((GetMonsterProperty("ducking")))
			{
				L_USELEGS = 1;
			}
			if ((GetMonsterProperty("speed2D")))
			{
				L_USELEGS = 1;
			}
			if ((L_USELEGS))
			{
				legs_animate();
			}
			else
			{
				LEGS_ANIM = 0;
			}
		}
		// TODO: UNCONVERTED: setanimtorso TORSO_ANIM
		// TODO: UNCONVERTED: setanimlegs LEGS_ANIM
	}

	void once_animate()
	{
		if ((GetMonsterProperty("anim.uselegs")))
		{
			legs_animate();
			// TODO: UNCONVERTED: setanimlegs LEGS_ANIM
		}
		if (GetMonsterProperty("anim.current_frame") >= GetMonsterProperty("anim.max_frames"))
		{
			PlayAnim("once", "break");
			walk_animate();
		}
	}

	void hold_animate()
	{
	}

	void legs_animate()
	{
		int CUSTOM_LEGS_ANIM = 0;
		int CUSTOM_EXT = 0;
		float LEGS_FRAMERATE = 2.3;
		LEGS_ANIM = "game.player.currentitem.anim_legs";
		if ((GetMonsterProperty("ducking")))
		{
			if (!(GetMonsterProperty("speed2D")))
			{
				LEGS_ANIM = ANIM_CROUCHMOVE;
				CUSTOM_EXT = "crouchidle_";
			}
			else
			{
				LEGS_ANIM = ANIM_CROUCHMOVE;
				CUSTOM_EXT = "crouchwalk_";
			}
		}
		else
		{
			string SPEED_SHOW_RUN_ANIM = GetMonsterProperty("walkspeed");
			SPEED_SHOW_RUN_ANIM++;
			if (!(anim.underwater))
			{
				if (!(GetMonsterProperty("speed2D")))
				{
					LEGS_ANIM = ANIM_STAND;
					CUSTOM_EXT = "stand_";
				}
				else
				{
					if (GetMonsterProperty("speed2D") <= SPEED_SHOW_RUN_ANIM)
					{
						LEGS_ANIM = ANIM_WALK;
						CUSTOM_EXT = "walk_";
					}
					else
					{
						if (GetMonsterProperty("speed2D") > SPEED_SHOW_RUN_ANIM)
						{
							LEGS_ANIM = ANIM_RUN;
							CUSTOM_EXT = "run_";
						}
					}
				}
			}
			else
			{
				LEGS_ANIM = ANIM_TREAD;
				CUSTOM_EXT = "tread_";
				// TODO: UNCONVERTED: gaitframerate -0.1
			}
		}
		CUSTOM_LEGS_ANIM += CUSTOM_EXT;
		if (/* TODO: $anim_exists */ $anim_exists(CUSTOM_LEGS_ANIM) > -1)
		{
			LEGS_ANIM = CUSTOM_LEGS_ANIM;
		}
	}

	void animate_death()
	{
		if (RandomInt(0, 1) == 0)
		{
			CURRENT_DEATH_ANIM = ANIM_DEATH;
		}
		else
		{
			CURRENT_DEATH_ANIM = ANIM_DEATH2;
		}
		PlayAnim("critical", CURRENT_DEATH_ANIM);
	}

}

}
