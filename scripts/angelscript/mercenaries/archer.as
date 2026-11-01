#pragma context server

namespace MS
{

class Archer : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int FLINCH_DELAY;
	int IS_FLEEING;
	int MOVE_RANGE;
	int SEE_ENEMY;
	string SND_ATTACK1;
	string SND_ATTACK2;
	string SND_ATTACK3;
	string SND_BOW;
	string SND_STRUCK1;
	string SND_STRUCK2;
	string SND_STRUCK3;
	string SOUND_PAINYELL;
	string SOUND_WARCRY1;

	void OnSpawn() override
	{
		SetHealth(120);
		SetWidth(32);
		SetHeight(85);
		SetRace("orc");
		SetName("Human Archer");
		SetRoam(true);
		SetSkillLevel(0);
		SetGold(RandomInt(6, 10));
		SetHearingSensitivity(3);
		SetModel("npc/archer.mdl");
		SetDamageResistance("all", ".8");
		SetModelBody(0, 2);
		SetModelBody(1, 1);
		SetModelBody(2, 3);
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		SetActionAnim("shootorcbow");
		SND_STRUCK1 = "body/flesh1.wav";
		SND_STRUCK2 = "body/flesh2.wav";
		SND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAINYELL = "voices/human/male_hit1.wav";
		SOUND_WARCRY1 = "voices/human/male_guard_shout.wav";
		SND_ATTACK1 = "voices/human/male_hit1.wav";
		SND_ATTACK2 = "voices/human/male_hit2.wav";
		SND_ATTACK3 = "voices/human/male_hit3.wav";
		SND_BOW = "weapons/bow/bow.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		CAN_FLINCH = 1;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		MOVE_RANGE = 40;
		ATTACK_RANGE = 600;
		ATTACK_HITRANGE = 650;
		ATTACK_DAMAGE = 7;
		ATTACK_HITCHANCE = 0.9;
		FLINCH_DELAY = 4;
		FLEE_HEALTH = 10;
		FLEE_CHANCE = 0.15;
		IS_FLEEING = 0;
		SetStat("parry", 5);
		hunt_look();
	}

	void wield_battleaxe()
	{
		SetModelBody(2, 2);
	}

	void drop_battleaxe()
	{
		SetModelBody(2, 0);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void hunt_look()
	{
		SetRepeatDelay(0.2);
		CanSee("enemy");
		warcry();
		SetMoveAnim(ANIM_RUN);
		SetMoveDest(m_hLastSeen);
		SEE_ENEMY = 1;
		hunt_attack();
	}

	void wander()
	{
		SetMoveAnim(ANIM_WALK);
		SEE_ENEMY = 0;
	}

	void hunt_attack()
	{
		if (!(LASTSEENENTITY_DISTANCE <= ATTACK_RANGE)) return;
		SetMoveDest(m_hLastSeen);
		// TODO: UNCONVERTED: attack anim
	}

	void shoot_arrow()
	{
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 0), m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, 0, "none");
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SND_BOW);
	}

	void warcry()
	{
		SEE_ENEMY = "equals";
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_WARCRY1);
	}

	void attackstrike()
	{
		SetVolume(10);
		// PlayRandomSound from: SND_ATTACK1, SND_ATTACK2, SND_ATTACK3
		array<string> sounds = {SND_ATTACK1, SND_ATTACK2, SND_ATTACK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void struck()
	{
		SetVolume(10);
		// PlayRandomSound from: SOUND_PAINYELL, SND_STRUCK2, SOUND_PAINYELL
		array<string> sounds = {SOUND_PAINYELL, SND_STRUCK2, SOUND_PAINYELL};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		flinch();
		retaliate();
	}

	void flinch()
	{
		if (!(CAN_FLINCH == 1)) return;
		PlayAnim("critical", "flinch");
		CAN_FLINCH = 0;
		ScheduleDelayedEvent(FLINCH_DELAY, "resetflinch");
	}

	void resetflinch()
	{
		CAN_FLINCH = 1;
	}

	void retaliate()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		SetMoveDest(m_hLastStruck);
		LookAt(GetOwner());
		hunt_look();
	}

	void checkflee()
	{
		if (!(CURRENT_HEALTH <= FLEE_HEALTH)) return;
		if (!(RandomInt(0, 100) < FLEE_CHANCE)) return;
		SetMoveAnim(ANIM_RUN);
		SetMoveDest("flee");
		IS_FLEEING = 1;
		ScheduleDelayedEvent(0.5, "stopflee");
	}

	void stopflee()
	{
		IS_FLEEING = 0;
	}

	void facenewenemy()
	{
		if (!(IS_FLEEING == 0)) return;
		SetMoveDest("moveto");
		LookAt(1024);
	}

	void death()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_DEATH);
		SetModelBody(2, 0);
		dropstuff();
	}

	void dropstuff()
	{
		if (!(RandomInt(0, 100) >= 40)) return;
		GiveItem("proj_arrow_iron", 30);
		if (!(RandomInt(0, 100) >= 10)) return;
		GiveItem(GetOwner(), "bows_shortbow");
	}

}

}
