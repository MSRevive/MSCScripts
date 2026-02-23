#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class Shadahar : CGameScript
{
	string AS_ATTACKING;
	int CIRCLE_ON;
	string DID_WARCRY;
	int NPC_GIVE_EXP;
	int PURE_FLEE;

	Shadahar()
	{
		const int SKEL_HP = 1000;
		const float ATTACK_HITCHANCE = 0.85;
		const float ATTACK_DAMAGE_LOW = 15.5;
		const float ATTACK_DAMAGE_HIGH = 25.5;
		NPC_GIVE_EXP = 150;
		const string ANIM_CIRCLE = "throw_scientist";
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
		const string ANIM_BLAST = "rlflinch";
		const string SOUND_BOLT = "magic/ice_strike.wav";
		const float CIRCLE_FREQ = 30.0;
		const string SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		const string SOUND_WARCRY = "monsters/skeleton/calrain3.wav";
		Precache("weapons/magic/seals.mdl");
		Precache("magic/temple.wav");
		Precache("magic/pulsemachine_noloop.wav");
		Precache("magic/frost_reverse.wav");
		Precache("skull.spr");
	}

	void skeleton_spawn()
	{
		if ((LIGHTNING_SKELE)) return;
		SetName("Shadahar");
		if (GetMapName() != "mscave")
		{
			SetGold(RandomInt(25, 75));
			SetName("Gold Forged Skeleton");
			NPC_GIVE_EXP = 150;
		}
		if (GetMapName() == "mscave")
		{
			NPC_GIVE_EXP = 4000;
			SetGold(RandomInt(80, 150));
			if (RandomInt(1, 100) == 1)
			{
				string PIC_THREE = RandomInt(1, 3);
				if (PIC_THREE == 1)
				{
					GiveItem(GetOwner(), "scroll2_poison_cloud");
				}
				if (PIC_THREE == 2)
				{
					GiveItem(GetOwner(), "mana_forget");
				}
				if (PIC_THREE == 3)
				{
					GiveItem(GetOwner(), "armor_helm_gaz1");
				}
			}
		}
		if ((LIGHTNING_SKELE))
		{
			SetName("Lightning Forged Skeleton");
		}
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetModel("monsters/skeleton.mdl");
		SetHearingSensitivity(8);
		SetModelBody(0, 8);
		SetModelBody(1, 0);
		string MY_SKY = GetMonsterProperty("origin");
		MY_SKY += Vector3(0, 0, 4096);
		string MY_CENTER = GetEntityOrigin(GetOwner());
		MY_CENTER += Vector3(0, 0, -48);
		ClientEvent("new", "all_in_sight", "effects/sfx_lightning", MY_CENTER, MY_SKY, 1, 1);
		ScheduleDelayedEvent(10.0, "circle_check");
	}

	void circle_check()
	{
		if (!(false))
		{
			ScheduleDelayedEvent(5.0, "circle_check");
		}
		if (!(false)) return;
		CIRCLE_FREQ("circle_check");
		if ((I_R_FROZEN)) return;
		if (!(CYCLED_UP)) return;
		circle_prep();
	}

	void circle_prep()
	{
		if ((CIRCLE_ON)) return;
		ScheduleDelayedEvent(15.0, "circle_reset");
		CIRCLE_ON = 1;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10;
		PlayAnim("critical", ANIM_CIRCLE);
		if ((LIGHTNING_SKELE))
		{
			SetModelBody(1, 9);
		}
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		can_reach_nme();
		ScheduleDelayedEvent(2.0, "circle_spawn");
	}

	void circle_spawn()
	{
		if ((LIGHTNING_SKELE))
		{
			do_lightning();
		}
		if (!(LIGHTNING_SKELE))
		{
			SpawnNPC("monsters/summon/circle_of_death", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 200, 10.0
			ScheduleDelayedEvent(1.0, "circle_bait");
		}
	}

	void circle_bait()
	{
		PURE_FLEE = 1;
		npcatk_flee(GetEntityIndex(m_hLastSeen), 500, 5.0);
	}

	void circle_reset()
	{
		CIRCLE_ON = 0;
	}

	void circle_kill()
	{
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
	}

	void skel_death()
	{
		UseTrigger("beam11");
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		}
	}

}

}
