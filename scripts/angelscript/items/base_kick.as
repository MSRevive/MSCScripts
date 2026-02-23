#pragma context server

namespace MS
{

class BaseKick : CGameScript
{
	int DOING_KICK;

	BaseKick()
	{
		const int ANIM_KICK = 1;
		const string ANIM_FOOT_IDLE = "idle";
		const string OWNANIM_KICK = "stance_normal_highkick_r1";
		const string KICK_VIEW = "weapons/martialarts/foot.mdl";
		const string SOUND_KICKHIT = "";
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 100;
		int reg.attack.dmg = 200;
		int reg.attack.dmg.range = 10;
		string reg.attack.dmg.type = "blunt";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "martialarts";
		float reg.attack.hitchance = 0.9;
		int reg.attack.priority = 1;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "kickatk";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 5;
		RegisterAttack();
	}

	void kickatk_start()
	{
		DOING_KICK = 1;
		SetViewModel(KICK_VIEW);
		ScheduleDelayedEvent(0.1, "kick_go");
		if (!(true)) return;
		// svplaysound: svplaysound 0 8 $get(ent_owner,scriptvar,'PLR_SOUND_JAB2')
		EmitSound(0, 8, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void kick_go()
	{
		PlayViewAnim(ANIM_KICK);
		PlayOwnerAnim("critical", "stance_normal_highkick_r1");
		ScheduleDelayedEvent(0.5, "restore_hands");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(DOING_KICK)) return;
		DOING_KICK = 0;
		if (!("game.pvp"))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			return;
		}
		EmitSound(GetOwner(), 0, "weapons/cbar_hitbod1.wav", 8);
		string MA_SKILL = GetSkillLevel(GetOwner(), "martialarts");
		if (MA_SKILL >= 10)
		{
			if (GetEntityRange(param2) < 100)
			{
			}
			if (GetEntityMaxHealth(param2) < 1250)
			{
			}
			if (GetRelationship(param2) != "ally")
			{
			}
			if ((IsEntityAlive(param2)))
			{
			}
			if (GetEntityRace(param2) != 0)
			{
			}
			string PUSH_STR_LR = MA_SKILL;
			PUSH_STR_LR *= 15;
			string PUSH_STR_F = MA_SKILL;
			PUSH_STR_F *= 20;
			string PUSH_STR_V = MA_SKILL;
			PUSH_STR_V *= 5;
			if (PUSH_STR_LR > 300)
			{
				int PUSH_STR_LR = 300;
			}
			if (PUSH_STR_F > 400)
			{
				int PUSH_STR_F = 400;
			}
			if (PUSH_STR_V > 100)
			{
				int PUSH_STR_V = 100;
			}
			string L_R = RandomInt(50, PUSH_STR_LR);
			if (RandomInt(1, 2) == 1)
			{
				string L_R = /* TODO: $neg */ $neg(L_R);
			}
			string PUSH_VEL = /* TODO: $relvel */ $relvel(L_R, PUSH_STR_F, PUSH_STR_V);
			AddVelocity(GetEntityIndex(param2), PUSH_VEL);
		}
		if (MA_SKILL >= 20)
		{
			string STUN_DUR = MA_SKILL;
			STUN_DUR /= 3;
			if (STUN_DUR > 20)
			{
				int STUN_DUR = 20;
			}
			string TARG_HP = GetEntityHealth(param2);
			if (TARG_HP > 1000)
			{
				string FAIL_RATIO = RandomInt(1, 9999);
				if (FAIL_RATIO < TARG_HP)
				{
					int EXIT_SUB = 1;
				}
			}
			if (!(EXIT_SUB))
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", STUN_DUR, GetEntityIndex(GetOwner()));
		}
	}

	void restore_hands()
	{
		DOING_KICK = 0;
		SetViewModel(MODEL_VIEW);
	}

}

}
