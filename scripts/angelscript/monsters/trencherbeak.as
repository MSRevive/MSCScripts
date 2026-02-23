#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_jumper.as"

namespace MS
{

class Trencherbeak : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int COMBAT_JUMP;
	string DEATH_GOAL;
	int DID_ALERT;
	string HALF_HP;
	int MOMMY_ESCORT;
	int MOVE_RANGE;
	string NEXT_COMBAT_JUMP;
	string NEXT_CUST_FLINCH;
	string NEXT_HEARD_ALERT;
	string NEXT_IDLE;
	string NEXT_JUMP;
	string NEXT_VICTORY;
	int NPC_GIVE_EXP;
	int NPC_JUMPER;
	int SUSPEND_AI;

	Trencherbeak()
	{
		ANIM_ATTACK = "bite";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		const string ANIM_SEARCH = "idlelookout";
		const string ANIM_ALERT1 = "roarangry";
		const string ANIM_ALERT2 = "hiss";
		const string ANIM_CUSTOM_FLINCH1 = "bigflinch";
		const string ANIM_CUSTOM_FLINCH2 = "smallflinch";
		const string ANIM_JUMP = "jumpscrape";
		ANIM_DEATH = "dietwitch";
		NPC_GIVE_EXP = 400;
		ATTACK_MOVERANGE = 40;
		MOVE_RANGE = 40;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 90;
		const int DMG_BITE = 200;
		const string FREQ_JUMP = Random(5.0, 8.0);
		const string SOUND_ATTACK1 = "monsters/beak/attack1.wav";
		const string SOUND_ATTACK2 = "monsters/beak/attack2.wav";
		const string SOUND_STRUCK1 = "monsters/tube/TubeCritter_Hit1.wav";
		const string SOUND_STRUCK2 = "monsters/tube/TuberCritter_Hit2.wav";
		const string SOUND_STRUCK3 = "monsters/tube/TubeCritter_Hit3.wav";
		const string SOUND_PAIN1 = "monsters/beak/pain1.wav";
		const string SOUND_PAIN2 = "monsters/beak/pain2.wav";
		const string SOUND_PAIN3 = "monsters/beak/suffer.wav";
		const string SOUND_IDLE = "monsters/beak/roar.wav";
		const string SOUND_ALERT1 = "monsters/beak/screech2.wav";
		const string SOUND_ALERT2 = "monsters/beak/screech6.wav";
		const string SOUND_ALERT3 = "monsters/beak/beakhiss.wav";
		const string SOUND_ALERT4 = "monsters/beak/alert1.wav";
		const string SOUND_ALERT5 = "monsters/beak/alert2.wav";
		const string SOUND_DEATH = "monsters/beak/die1.wav";
		const string SOUND_JUMP = "monsters/birds/flap_small.wav";
		const string ANIM_NPC_JUMP = "jumpscrape";
		NPC_JUMPER = 1;
	}

	void OnSpawn() override
	{
		SetName("Trencherbeak");
		SetModel("monsters/beak.mdl");
		SetWidth(32);
		SetHeight(32);
		SetRace("wildanimal");
		SetHealth(500);
		SetHearingSensitivity(8);
		ScheduleDelayedEvent(2.0, "finalize_me");
		SetRoam(true);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void finalize_me()
	{
		HALF_HP = GetEntityMaxHealth(GetOwner());
		HALF_HP *= 0.5;
	}

	void my_target_died()
	{
		if (!(GetGameTime() > NEXT_VICTORY)) return;
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += 15.0;
		PlayAnim("critical", "eating");
		npcatk_suspend_roam(2.0);
		EmitSound(GetOwner(), 0, "monsters/beak/eating.wav", 10);
		DID_ALERT = 0;
	}

	void npc_targetsighted()
	{
		if ((DID_ALERT)) return;
		npcatk_suspend_roam(2.0);
		SetMoveDest(m_hAttackTarget);
		DID_ALERT = 1;
		NEXT_JUMP = GetGameTime();
		NEXT_JUMP += FREQ_JUMP;
		string RND_ALERT = RandomInt(1, 2);
		if (RND_ALERT == 1)
		{
			PlayAnim("critical", ANIM_ALERT1);
			// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5
			array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (RND_ALERT == 2)
		{
			PlayAnim("critical", ANIM_ALERT2);
			// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5
			array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if ((IS_FLEEING)) return;
		if ((I_R_FROZEN)) return;
		if (m_hAttackTarget == "unset")
		{
			if (GetGameTime() > NEXT_IDLE)
			{
			}
			NEXT_IDLE = GetGameTime();
			NEXT_IDLE += Random(5.0, 15.0);
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
			PlayAnim("once", ANIM_SEARCH);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetGameTime() > NEXT_COMBAT_JUMP)) return;
		NEXT_COMBAT_JUMP = GetGameTime();
		NEXT_COMBAT_JUMP += FREQ_JUMP;
		COMBAT_JUMP = 1;
		PlayAnim("critical", ANIM_JUMP);
	}

	void npcatk_jump()
	{
		COMBAT_JUMP = 0;
		NEXT_COMBAT_JUMP = GetGameTime();
		NEXT_COMBAT_JUMP += FREQ_JUMP;
	}

	void frame_jump_boost()
	{
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
		if (!(COMBAT_JUMP)) return;
		string RND_LR = RandomInt(1, 2);
		if (RND_LR == 1)
		{
			int RND_LR = -200;
		}
		if (RND_LR == 2)
		{
			int RND_LR = 200;
		}
		string RND_VADJ = Random(200.0, 300.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LR, 150, RND_VADJ));
		COMBAT_JUMP = 0;
	}

	void set_hunt_on_spawn()
	{
		DID_ALERT = 1;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		GetAllPlayers(PLAYER_LIST);
		string SORT_LIST = /* TODO: $sort_entlist */ $sort_entlist(PLAYER_LIST, "range");
		npcatk_settarget(GetToken(SORT_LIST, 0, ";"));
	}

	void frame_bite_start()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_bite()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.8, "pierce");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string RND_RL = Random(-200, 200);
		AddVelocity(param2, /* TODO: $relvel */ $relvel(RND_RL, 110, 120));
	}

	void OnDamage(int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(GetGameTime() > NEXT_CUST_FLINCH)) return;
		NEXT_CUST_FLINCH = GetGameTime();
		NEXT_CUST_FLINCH += 5.0;
		npcatk_suspend_ai(1.5);
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_CUSTOM_FLINCH);
	}

	void npc_heard_player()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > NEXT_HEARD_ALERT)) return;
		NEXT_HEARD_ALERT = GetGameTime();
		NEXT_HEARD_ALERT += 10.0;
		PlayAnim("critical", ANIM_SEARCH);
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2, SOUND_ALERT3, SOUND_ALERT4, SOUND_ALERT5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_mommy_died()
	{
		if (!(MOMMY_ESCORT)) return;
		npcatk_suspend_ai();
		DEATH_GOAL = param1;
		PlayAnim("once", "break");
		PlayAnim("once", ANIM_RUN);
		SetMoveDest(DEATH_GOAL);
		death_goal_loop();
	}

	void death_goal_loop()
	{
		SetRoam(true);
		SUSPEND_AI = 1;
		ScheduleDelayedEvent(2.0, "death_goal_loop");
		SetMoveDest(DEATH_GOAL);
	}

	void set_mommy_escort()
	{
		MOMMY_ESCORT = 1;
	}

}

}
