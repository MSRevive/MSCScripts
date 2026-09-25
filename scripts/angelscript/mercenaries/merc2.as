#pragma context server

#include "monsters/summon/base_summon.as"
#include "help/first_hireling.as"

namespace MS
{

class Merc2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SITIDLE;
	string ANIM_WALK;
	int ARROW_DAMAGE_HIGH;
	int ARROW_DAMAGE_LOW;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CONVERSE_PLAYER;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int HIRE_PRICE;
	int IS_HIRED;
	string MASTER_NAME;
	int MERC_RESTING;
	int MOVE_RANGE;
	float RETALIATE_CHANGETARGET_CHANCE;
	int SEE_ENEMY;
	int SEE_PLAYER_NOW;
	string SOUND_ALERT1;
	string SOUND_PAIN;
	string SOUND_PAIN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SUMMON_MASTER;
	int SUMMON_VICINITY;
	string SUM_REPORT_SUFFIX;
	string SUM_SAY_ATTACK;
	string SUM_SAY_COME;
	string SUM_SAY_DEATH;
	string SUM_SAY_DEFEND;
	string SUM_SAY_HUNT;
	int VOLUME;

	Merc2()
	{
		SUM_SAY_COME = "Whaddya need?";
		SUM_SAY_ATTACK = "Right! Have at it then!";
		SUM_SAY_HUNT = "Hunt... Hunt... Hunt...";
		SUM_SAY_DEFEND = "Got your back - dunno who has mine though...";
		SUM_SAY_DEATH = "Gads! I knew I shoulda been a shop keeper!";
		SUM_REPORT_SUFFIX = ", boss.";
		ANIM_SITIDLE = "sitidle";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "shootorcbow";
		MOVE_RANGE = 600;
		ATTACK_RANGE = 650;
		ATTACK_SPEED = 1200;
		ARROW_DAMAGE_LOW = 7;
		ARROW_DAMAGE_HIGH = 15;
		ATTACK_CONE_OF_FIRE = 2;
		SOUND_ALERT1 = "npc/prepdie.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "player/chesthit1.wav";
		SOUND_PAIN2 = "player/armhit1.wav";
		VOLUME = 5;
		CAN_RETALIATE = 1;
		CAN_ATTACK = 0;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_FLEE = 0;
		CAN_HUNT = 0;
		CAN_HEAR = 1;
		CAN_FLINCH = 1;
		FLINCH_ANIM = "raflinch";
		FLINCH_CHANCE = 0.1;
		SUMMON_VICINITY = 360;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2);
		if (IS_HIRED == 0)
		{
		}
		SetRace("human");
		if ((false))
		{
		}
		standandtalk();
	}

	void summon_spawn()
	{
		SetHealth(150);
		SetName("Mercenary");
		SetWidth(32);
		SetHeight(64);
		SetRoam(false);
		SetHearingSensitivity(3);
		SetSkillLevel(0);
		SetRace("neutral");
		SetModel("npc/archer.mdl");
		SetModelBody(2, 2);
		SetIdleAnim(ANIM_SITIDLE);
		SetMoveAnim(ANIM_WALK);
		IS_HIRED = 0;
		CONVERSE_PLAYER = 0;
		SEE_PLAYER_NOW = 0;
		SEE_ENEMY = 0;
		SetStat("parry", 10);
		HIRE_PRICE = RandomInt(30, 50);
		string reg.mitem.id = "hire";
		string reg.mitem.access = "all";
		string reg.mitem.title = "Hire for ";
		reg.mitem.title += HIRE_PRICE;
		reg.mitem.title += " gold";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:";
		reg.mitem.data += HIRE_PRICE;
		string reg.mitem.callback = "hired_by_player";
		HealEntity(GetOwner(), -3);
		basesummon_attackall();
	}

	void hired_by_player()
	{
		RemoveMenuItem("hire");
		IS_HIRED = 1;
		ANIM_IDLE = "idle1";
		SUMMON_MASTER = param1;
		MASTER_NAME = GetEntityName(SUMMON_MASTER);
		CAN_HUNT = 1;
		CAN_ATTACK = 1;
		SetRace("human");
		SayText("Lead on , " + MASTER_NAME);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", "yes");
	}

	void npc_targetsighted()
	{
		if (HUNT_LASTTARGET == SUMMON_MASTER)
		{
			if (GetEntityDist(HUNT_LASTTARGET) < 256)
			{
			}
			SetMoveAnim(ANIM_WALK);
		}
		else
		{
			if (GetEntityIndex(m_hLastSeen) != HUNT_LASTTARGET)
			{
				// PlayRandomSound from: VOLUME, SOUND_ALERT1
				array<string> sounds = {VOLUME, SOUND_ALERT1};
				EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
	}

	void shoot_arrow()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		float LCL_ATKDMG = Random(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 16), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SND_BOW);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: VOLUME, SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {VOLUME, SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), "game.sound.body", sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((IS_HIRED))
		{
			rest_getup();
		}
	}

	void standandtalk()
	{
		if (!(CONVERSE_PLAYER == 0)) return;
		if (!(CanSee("ally", 90))) return;
		CONVERSE_PLAYER = 1;
		PlayAnim("once", "sitstand");
		SetIdleAnim("idle1");
		ScheduleDelayedEvent(5, "offer_1");
	}

	void offer_1()
	{
		SayText("You shouldn t be alone here.");
		Say("[30] [30] [30] [30] [20] [20] [30]");
		ScheduleDelayedEvent(2, "offer_2");
	}

	void offer_2()
	{
		SayText(I + " ll show you around these plains, if you pay me $int(HIRE_PRICE) gold");
		Say("[30] [30] [30] [30] [30] [30] [30] [30] [30]");
		PlayAnim("once", "yes");
		ScheduleDelayedEvent(5, "sitdown");
	}

	void sitdown()
	{
		if (!(IS_HIRED == 0)) return;
		SEE_PLAYER_NOW = 0;
		sitdownlater();
		sitdownnow();
	}

	void sitdownlater()
	{
		SetRace("human");
		LookAt(256);
		sitdownlater2();
	}

	void sitdownlater2()
	{
		LookAt(256);
		if (!(CanSee("player", 128))) return;
		SEE_PLAYER_NOW = 1;
		ScheduleDelayedEvent(5, "sitdown");
	}

	void sitdownnow()
	{
		if (!(SEE_PLAYER_NOW == 0)) return;
		CONVERSE_PLAYER = 0;
		SetIdleAnim(ANIM_IDLE);
	}

	void npcatk_target_lost()
	{
		if ((MERC_RESTING)) return;
		RandomInt(2, 5)("rest_checksit");
	}

	void game_movingto_dest()
	{
		if (!(MERC_RESTING)) return;
		rest_getup();
	}

	void rest_checksit()
	{
		if ((IS_HUNTING)) return;
		if ((IS_ATTACKING)) return;
		if ((SUMMON_RETURNING)) return;
		if (!(GetMonsterHP() < GetMonsterMaxHP())) return;
		MERC_RESTING = 1;
		SetIdleAnim(ANIM_SITIDLE);
		HealEntity(GetOwner(), 1);
		ScheduleDelayedEvent(5, "rest_checksit");
		if (!(GetMonsterHP() >= GetMonsterMaxHP())) return;
		ScheduleDelayedEvent(3, "rest_getup");
	}

	void rest_getup()
	{
		SetIdleAnim(ANIM_IDLE);
		MERC_RESTING = 0;
	}

	void game_recvoffer_gold()
	{
		if (!(CONVERSE_PLAYER == 1)) return;
		if ("game.offer.gold" == HIRE_PRICE)
		{
			ReceiveOffer("accept");
			hired_by_player(GetEntityIndex("ent_lastgave"));
		}
		else
		{
			if ("game.offer.gold" > HIRE_PRICE)
			{
				ReceiveOffer("reject");
				SayText("It s okay, really. $int(HIRE_PRICE) is all I need.");
				Say("[10] [10] [10] [10] [10] [10] [4]");
				PlayAnim("once", "no");
			}
			else
			{
				if ("game.offer.gold" < HIRE_PRICE)
				{
					ReceiveOffer("reject");
					SayText(I + "will not be persuaded for a lower price! " + int(HIRE_PRICE) + " . Nothing more , nothing less.");
					Say("[10] [10] [10] [6] [12] [4] [20] [10] [10]");
					PlayAnim("once", "no");
				}
			}
		}
	}

}

}
