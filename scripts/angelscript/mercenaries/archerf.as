#pragma context server

#include "monsters/base_npc_attack.as"

namespace MS
{

class Archerf : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HUNT;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int MOVE_RANGE;
	string SND_ATTACK1;
	string SND_ATTACK2;
	string SND_ATTACK3;
	string SND_BOW;
	string SND_STRUCK1;
	string SND_STRUCK2;
	string SND_STRUCK3;
	string SOUND_PAINYELL;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;

	Archerf()
	{
		SND_STRUCK1 = "body/flesh1.wav";
		SND_STRUCK2 = "body/flesh2.wav";
		SND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAINYELL = "voices/human/male_hit1.wav";
		SOUND_WARCRY1 = "voices/human/male_guard_shout.wav";
		SOUND_WARCRY2 = "voices/human/male_guard_shout2.wav";
		SND_ATTACK1 = "voices/human/male_hit1.wav";
		SND_ATTACK2 = "voices/human/male_hit2.wav";
		SND_ATTACK3 = "voices/human/male_hit3.wav";
		SND_BOW = "weapons/bow/bow.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		CAN_FLINCH = 1;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "shootorcbow";
		const int ARROW_DAMAGE_LOW = 8;
		const int ARROW_DAMAGE_HIGH = 12;
		MOVE_RANGE = 600;
		ATTACK_RANGE = 650;
		const int ATTACK_SPEED = 700;
		const int ATTACK_CONE_OF_FIRE = 4;
		FLINCH_DELAY = 4;
		FLEE_HEALTH = 10;
		FLEE_CHANCE = 0.15;
		CAN_FLEE = 1;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
	}

	void OnSpawn() override
	{
		SetHealth(120);
		SetWidth(32);
		SetHeight(85);
		SetRace("human");
		SetName("Human Archer");
		SetRoam(true);
		SetSkillLevel(30);
		SetGold(RandomInt(6, 10));
		SetHearingSensitivity(3);
		SetModel("npc/archer.mdl");
		SetDamageResistance("all", ".8");
		SetModelBody(2, 2);
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		SetActionAnim("shootorcbow");
		GiveItem("proj_arrow_iron", 30);
		SetStat("parry", 5);
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void shoot_arrow()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= 30;
		SetAngles("add_view.x");
		string LCL_ATKDMG = RandomInt(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 6), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
		SetModelBody(3, 0);
		EmitSound(GetOwner(), SND_BOW);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(10);
		// PlayRandomSound from: SOUND_PAINYELL, SND_STRUCK2, SOUND_PAINYELL
		array<string> sounds = {SOUND_PAINYELL, SND_STRUCK2, SOUND_PAINYELL};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
