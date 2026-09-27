#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Guard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK1_DAMAGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int HUNT_AGRO;
	int INNOCENT;
	int MOVE_RANGE;
	string NPC_MOVE_TARGET;
	string PERP;
	float RETALIATE_CHANGETARGET_CHANCE;
	int SEE_ENEMY;
	string SEE_ENEMY_NOW;
	string SND_DISMISS;
	string SND_DISMISS2;
	string SND_SHOUT;
	string SND_SHOUT2;
	string SOUND_DIE;
	string SOUND_HIT;
	string SOUND_HIT2;
	string SOUND_HIT3;
	string SOUND_STRUCK1;
	int SURRENDER;
	int SURRENDERED;

	Guard()
	{
		ATTACK_RANGE = 100;
		ATTACK1_DAMAGE = 5;
		ATTACK_PERCENTAGE = 0.8;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "swordswing1_L";
		ANIM_DEATH = "diesimple";
		MOVE_RANGE = 64;
		SEE_ENEMY_NOW = "equals";
		SEE_ENEMY = 0;
		INNOCENT = 0;
		SURRENDER = 0;
		SURRENDERED = 0;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_HUNT = 1;
		CAN_ATTACK = 1;
		HUNT_AGRO = 0;
		SOUND_STRUCK1 = "body/armour4.wav";
		SOUND_HIT = "voices/human/male_hit1.wav";
		SOUND_HIT2 = "voices/human/male_hit2.wav";
		SOUND_HIT3 = "voices/human/male_hit3.wav";
		SOUND_DIE = "voices/human/male_die.wav";
		SND_SHOUT = "voices/human/male_guard_shout.wav";
		SND_SHOUT2 = "voices/human/male_guard_shout2.wav";
		SND_DISMISS = "voices/human/male_guard_dismiss.wav";
		SND_DISMISS2 = "voices/human/male_guard_dismiss2.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(45);
		CanSee("player");
		SetMoveDest(m_hLastSeen);
		if (SURRENDERED == 1)
		{
		}
		SetVolume(7);
		// PlayRandomSound from: SND_DISMISS, SND_DISMISS2
		array<string> sounds = {SND_DISMISS, SND_DISMISS2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(2);
		if (!(SURRENDERED))
		{
		}
		NPC_MOVE_TARGET = PERP;
	}

	void OnSpawn() override
	{
		SetHealth(60);
		SetMaxHealth(60);
		SetGold(RandomInt(1, 4));
		SetWidth(32);
		SetHeight(72);
		SetRace("hguard");
		SetSkillLevel(13);
		SetName("Guard");
		SetRoam(true);
		SetModel("npc/guard1.mdl");
		SetMoveAnim(ANIM_WALK);
		SetStepSize(25);
		SetActionAnim(ANIM_ATTACK);
		CatchSpeech("say_surrender", I);
		CatchSpeech("say_surrender", "give");
		CatchSpeech("say_surrender", "mercy");
		CatchSpeech("say_nothing", I);
		CatchSpeech("say_nothing", I);
		CatchSpeech("say_nothing", I);
		CatchSpeech("say_nothing", I);
		CatchSpeech("say_nothing", "innocent");
	}

	void game_dynamically_created()
	{
		NPC_MOVE_TARGET = param1;
		PERP = param1;
		ScheduleDelayedEvent(1.0, "set_target");
	}

	void set_target()
	{
		npcatk_settarget(NPC_MOVE_TARGET);
	}

	void say_surrender()
	{
		SURRENDERED = 1;
		SURRENDER = RandomInt(1, 2);
		SetRace("human");
		surrender1();
		surrender2();
		NPC_MOVE_TARGET = "enemy";
		ScheduleDelayedEvent(60, "disappear");
	}

	void surrender1()
	{
		if (!(SURRENDER == 1)) return;
		SayText("All right , but stay out of trouble next time.");
		npcatk_clear_targets();
	}

	void surrender2()
	{
		if (!(SURRENDER == 2)) return;
		SayText("All right , but stay out of trouble next time.");
		npcatk_clear_targets();
	}

	void say_nothing()
	{
		if (!(SURRENDERED == 0)) return;
		if (!(INNOCENT == 0)) return;
		SetMoveAnim(ANIM_WALK);
		SayText("Is that so? Well , off with you , then , and don t let me see you again, because if I do, you re in trouble!");
		INNOCENT = 1;
		npcatk_clear_targets();
		ScheduleDelayedEvent(40, "reset_hostility");
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(10);
		// PlayRandomSound from: SOUND_STRUCK1
		array<string> sounds = {SOUND_STRUCK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// PlayRandomSound from: SOUND_HIT, SOUND_HIT2, SOUND_HIT3
		array<string> sounds = {SOUND_HIT, SOUND_HIT2, SOUND_HIT3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void disappear()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
