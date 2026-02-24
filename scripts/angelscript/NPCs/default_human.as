#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_civilian.as"
#include "monsters/base_xmass.as"

namespace MS
{

class DefaultHuman : CGameScript
{
	int AM_SCARED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NO_CHAT;
	float RETALIATE_CHANGETARGET_CHANCE;

	DefaultHuman()
	{
		ANIM_DEATH = "diesimple";
		MOVE_RANGE = 64;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "beatdoor";
		ANIM_DEATH = "diesimple";
		CAN_HUNT = 0;
		HUNT_AGRO = 0;
		CAN_ATTACK = 0;
		ATTACK_RANGE = 90;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 1.0;
		CAN_HEAR = 1;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_FLINCH = 1;
		FLINCH_ANIM = "flinch1";
		FLINCH_CHANCE = 0.5;
		FLINCH_DELAY = 1;
		NO_CHAT = 1;
		AM_SCARED = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(RandomInt(25, 35));
		if (!(AM_SCARED))
		{
		}
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		SetVolume(2);
		if (!(G_CHRISTMAS_MODE))
		{
			Say("chitchat[.5] [.2] [.55] [.55] [.23] [.22]");
		}
		if ((G_CHRISTMAS_MODE))
		{
			Say("xmass_male[.5] [.2] [.55] [.55] [.23] [.22]");
		}
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Commoner");
		SetRoam(true);
		SetBloodType("red");
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("walk");
		SetHearingSensitivity(4);
		SetSkillLevel(-10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetMoveDest(m_hLastStruck);
		SetMoveAnim(ANIM_RUN);
		AM_SCARED = 1;
		ScheduleDelayedEvent(20.0, "calm_down1");
	}

	void calm_down1()
	{
		SetMoveAnim("walk_scared");
		ScheduleDelayedEvent(10.0, "calm_down2");
	}

	void calm_down2()
	{
		SetMoveAnim(ANIM_WALK);
		AM_SCARED = 0;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if ((IsValidPlayer(LAST_HEARD))) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		SetMoveDest(LAST_HEARD);
		call_for_help(LAST_HEARD);
		AM_SCARED = 1;
		ScheduleDelayedEvent(20.0, "calm_down1");
	}

	void say_xmass()
	{
		if (!(G_CHRISTMAS_MODE)) return;
		PlayAnim("critical", "wave");
		SayText(A + " happy Hogswatch to you too!");
		// TODO: playmp3 all system xmass_annoy.mp3
		Say("xmass_male[.20] [.20] [.30] [.10] [.20] [.10] [.10] [.10] [.10]");
		if (!(IS_SNOWING))
		{
			CallExternal("players", "ext_weather_change", "snow");
		}
	}

}

}
