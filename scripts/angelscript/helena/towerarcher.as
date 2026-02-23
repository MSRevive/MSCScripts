#pragma context server

#include "monsters/base_npc_attack.as"

namespace MS
{

class Towerarcher : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_CONE_OF_FIRE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int CAN_FLEE;
	int CAN_HUNT;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int PLAYING_DEAD;
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

	Towerarcher()
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
		const int CAN_FLINCH = 1;
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "shootorcbow";
		const int ARROW_DAMAGE_LOW = 8;
		const int ARROW_DAMAGE_HIGH = 12;
		MOVE_RANGE = 600;
		ATTACK_RANGE = 1500;
		ATTACK_SPEED = 900;
		ATTACK_CONE_OF_FIRE = 4;
		FLINCH_DELAY = 4;
		CAN_FLEE = 0;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
	}

	void OnSpawn() override
	{
		SetHealth(120);
		SetFOV(180);
		SetWidth(32);
		SetHeight(85);
		SetRace("hguard");
		SetName("Watchtower Archer");
		SetRoam(false);
		SetSkillLevel(30);
		SetGold(RandomInt(6, 10));
		SetHearingSensitivity(5);
		SetModel("npc/archer.mdl");
		SetDamageResistance("all", ".8");
		SetModelBody(2, 2);
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		SetActionAnim("shootorcbow");
		GiveItem("proj_arrow_iron", 30);
		SetStat("parry", 2);
		SetAngles("face");
		PLAYING_DEAD = 1;
	}

	void grab_arrow()
	{
		SetModelBody(3, 1);
	}

	void shoot_arrow()
	{
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= 50;
		SetAngles("add_view.x");
		string LCL_ATKDMG = RandomInt(ARROW_DAMAGE_LOW, ARROW_DAMAGE_HIGH);
		TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 5), "none", ATTACK_SPEED, LCL_ATKDMG, ATTACK_CONE_OF_FIRE, "none");
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
