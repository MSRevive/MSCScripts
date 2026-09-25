#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class WolfBase : CGameScript
{
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_BITE;
	string ANIM_CLAW;
	string ANIM_DEATH;
	string ANIM_EAT;
	string ANIM_FLINCH;
	string ANIM_FLINCH1;
	string ANIM_FLINCH2;
	string ANIM_FLINCH3;
	string ANIM_HOWL;
	string ANIM_IDLE;
	string ANIM_IDLE_SIT;
	string ANIM_IDLE_SIT2;
	string ANIM_IDLE_STAND;
	string ANIM_IDLE_STAND2;
	string ANIM_IDLE_STAND3;
	string ANIM_LEAP;
	string ANIM_RUN;
	string ANIM_TOSTAND;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int CAN_FLEE;
	int CHANCE_CLAW;
	int DID_ALLY_ALERT;
	float DMG_BITE;
	float DMG_CLAW;
	int FLEE_CHANCE;
	int FLEE_HEALTH;
	string FLINCH_ANIM;
	float FREQ_HOWL;
	float FREQ_IDLE;
	float FREQ_LOOK;
	int LEAP_RANGE;
	string MONSTER_MODEL;
	string MY_ALPHA;
	string NEXT_HOWL;
	int NPC_ALLY_RESPONSE_RANGE;
	int SEARCH_DELAY;
	int SIT_MODE;
	string SOUND_ATK1;
	string SOUND_ATK2;
	string SOUND_ATK3;
	string SOUND_DEATH;
	string SOUND_GROWL;
	string SOUND_HOWL1;
	string SOUND_HOWL2;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_YELP;

	WolfBase()
	{
		ANIM_WALK = "run";
		ANIM_RUN = "run";
		ANIM_IDLE = "standidle1";
		ANIM_DEATH = "die1";
		ANIM_ATTACK = "attack1";
		NPC_ALLY_RESPONSE_RANGE = 2048;
		ANIM_FLINCH = "hopback";
		ANIM_LEAP = "attack2";
		ANIM_CLAW = "attack2";
		ANIM_HOWL = "howl";
		ANIM_ALERT = "threat";
		ANIM_IDLE_SIT = "sit_idle1";
		ANIM_IDLE_SIT2 = "sit_idle2";
		ANIM_IDLE_STAND = "standidle1";
		ANIM_IDLE_STAND2 = "standidle2";
		ANIM_IDLE_STAND3 = "guard";
		ANIM_TOSTAND = "standup";
		ANIM_BITE = "attack1";
		ANIM_CLAW = "attack2";
		ANIM_EAT = "eat";
		ANIM_FLINCH1 = "hopback";
		ANIM_FLINCH2 = "pain1";
		ANIM_FLINCH3 = "pain2";
		ATTACK_RANGE = 92;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 72;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 25;
		ATTACK_HITCHANCE = 70;
		LEAP_RANGE = 256;
		DMG_BITE = Random(2, 5);
		DMG_CLAW = Random(1, 3);
		FREQ_LOOK = 20.0;
		FREQ_IDLE = Random(3, 20);
		FREQ_HOWL = Random(20, 30);
		CHANCE_CLAW = 50;
		SOUND_HOWL1 = "monsters/wolves/wolf_howl1.wav";
		SOUND_HOWL2 = "monsters/wolves/wolf_howl2.wav";
		SOUND_GROWL = "monsters/wolves/wolf_alert.wav";
		SOUND_ATK1 = "monsters/wolves/wolf_atk1.wav";
		SOUND_ATK2 = "monsters/wolves/wolf_atk2.wav";
		SOUND_ATK3 = "monsters/wolves/wolf_atk3.wav";
		SOUND_PAIN = "monsters/wolves/wolf_yelp1.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_YELP = "monsters/wolves/wolf_yelp2.wav";
		SOUND_DEATH = "monsters/wolves/wolf_death.wav";
		MONSTER_MODEL = "monsters/normal_wolf.mdl";
		Precache("monsters/normal_wolf.mdl");
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (!(AM_ALPHA))
		{
			if (MY_ALPHA != "unset")
			{
			}
			npcatk_setmovedest(G_ALPHA, ATTACK_MOVERANGE);
		}
		if (m_hAttackTarget == "unset")
		{
		}
		if (GetGameTime() > NEXT_HOWL)
		{
			LogDebug("idle howl");
			NEXT_HOWL = GetGameTime();
			NEXT_HOWL += FREQ_HOWL;
			do_howl();
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if ((SIT_MODE))
		{
			PlayAnim("critical", ANIM_IDLE_SIT2);
		}
		if (!(SIT_MODE))
		{
			int RND_IDLE = RandomInt(1, 2);
			if (RND_IDLE == 1)
			{
				atk_sound();
				PlayAnim("critical", ANIM_IDLE_STAND2);
			}
			if (RND_IDLE == 2)
			{
				EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
				PlayAnim("critical", ANIM_IDLE_STAND3);
			}
		}
		if ((AM_ALPHA))
		{
		}
		if (RandomInt(1, 2) == 1)
		{
		}
		if ((SIT_MODE))
		{
			ScheduleDelayedEvent(0.5, "sitmode_off");
		}
		if (!(SIT_MODE))
		{
			ScheduleDelayedEvent(0.5, "sitmode_on");
		}
	}

	void OnSpawn() override
	{
		SetName("Wolf");
		SetRace("rogue");
		SetModel(MONSTER_MODEL);
		SetHearingSensitivity(8);
		SetWidth(36);
		SetHeight(48);
		SetRoam(true);
		if (!(AM_ALPHA))
		{
			SetHealth(50);
			SetModelBody(0, 0);
			ScheduleDelayedEvent(3.0, "find_alpha");
		}
		if ((AM_ALPHA))
		{
			SetHealth(75);
			SetModelBody(0, 1);
			FLEE_HEALTH = 0;
		}
		if (StringToLower(GetMapName()) == "sfor")
		{
			if (RandomInt(1, 100) == 50)
			{
			}
			GiveItem(GetOwner(), "swords_wolvesbane");
		}
		NEXT_HOWL = 0;
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void find_alpha()
	{
		CallExternal("all", "ext_wolf_setalpha");
		if ((IsEntityAlive(G_ALPHA)))
		{
			MY_ALPHA = G_ALPHA;
		}
		if (!(IsEntityAlive(G_ALPHA)))
		{
			MY_ALPHA = "unset";
		}
	}

	void ext_wolf_setalpha()
	{
		if (!(AM_ALPHA)) return;
		SetGlobalVar("G_ALPHA", GetEntityIndex(GetOwner()));
	}

	void sitmode_off()
	{
		if ((SIT_MODE))
		{
			PlayAnim("critical", ANIM_TOSTAND);
		}
		SIT_MODE = 0;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
	}

	void sitmode_on()
	{
		SIT_MODE = 1;
		SetMoveAnim(ANIM_IDLE_SIT);
		SetIdleAnim(ANIM_IDLE_SIT);
	}

	void npcatk_checkflee()
	{
		if ((CANT_FLEE)) return;
		if (FLEE_HEALTH > 0)
		{
			if (GetMonsterHP() < FLEE_HEALTH)
			{
				if (RandomInt(1, 100) <= FLEE_CHANCE)
				{
					if (!(AM_ALPHA))
					{
					}
					if ((IsEntityAlive(MY_ALPHA)))
					{
						NPC_FORCED_MOVEDEST = 1;
						SetMoveDest(MY_ALPHA);
						npcatk_suspend_ai(2.0);
					}
					if (!(IsEntityAlive(MY_ALPHA)))
					{
						npcatk_flee(GetEntityIndex(m_hLastStruck), FLEE_DISTANCE, 10.0);
					}
				}
			}
		}
	}

	void bite1()
	{
		ATTACK_TYPE = "bite";
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:wolfatk");
		atk_sound();
		if (RandomInt(1, 100) < CHANCE_CLAW)
		{
			ANIM_ATTACK = ANIM_CLAW;
		}
	}

	void claw1()
	{
		ATTACK_TYPE = "claw";
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLAW, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:wolfatk");
		atk_sound();
		ANIM_ATTACK = ANIM_BITE;
	}

	void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)
	{
		CallExternal(NPC_ALLY_TO_AID, "being_aided");
	}

	void being_aided()
	{
		if ((DID_ALLY_ALERT)) return;
		DID_ALLY_ALERT = 1;
		do_howl();
	}

	void do_howl()
	{
		if ((IsEntityAlive(GetOwner())))
		{
			PlayAnim("critical", ANIM_HOWL);
		}
		// PlayRandomSound from: SOUND_HOWL1, SOUND_HOWL2
		array<string> sounds = {SOUND_HOWL1, SOUND_HOWL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_lost_sight()
	{
		if ((false)) return;
		if ((SEARCH_DELAY)) return;
		SEARCH_DELAY = 1;
		EmitSound(GetOwner(), 0, SOUND_GROWL, 10);
		FREQ_LOOK("reset_search_delay");
		do_howl();
	}

	void reset_search_delay()
	{
		SEARCH_DELAY = 0;
	}

	void OnFlinch()
	{
		int RND_FLINCH = RandomInt(1, 5);
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH2;
		}
		if (RND_FLINCH == 2)
		{
			FLINCH_ANIM = ANIM_FLINCH3;
		}
		if (RND_FLINCH > 2)
		{
			FLINCH_ANIM = ANIM_FLINCH1;
		}
		EmitSound(GetOwner(), 0, SOUND_YELP, 10);
	}

	void cycle_up()
	{
		if ((SIT_MODE))
		{
			sitmode_off();
		}
	}

	void atk_sound()
	{
		// PlayRandomSound from: SOUND_ATK1, SOUND_ATK2, SOUND_ATK3
		array<string> sounds = {SOUND_ATK1, SOUND_ATK2, SOUND_ATK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (ATTACK_TYPE == "bite")
		{
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-50, 110, 105));
		}
		if (ATTACK_TYPE == "claw")
		{
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-100, 130, 120));
		}
		ATTACK_TYPE = "none";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		int RND_DEATH = RandomInt(1, 2);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = "die1";
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = "die2";
		}
	}

	void my_target_died()
	{
		if ((false)) return;
		PlayAnim("once", ANIM_EAT);
	}

}

}
