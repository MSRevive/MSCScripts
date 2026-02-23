#pragma context server

#include "monsters/spider_base.as"

namespace MS
{

class SpiderMiniPoison : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;

	SpiderMiniPoison()
	{
		const int DELETE_ON_DEATH = 1;
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SND_STRUCK4 = SOUND_PAIN;
		const string SND_STRUCK5 = SOUND_PAIN;
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 30;
		ATTACK_RANGE = 38;
		const float ATTACK_DAMAGE_LOW = 1.0;
		const float ATTACK_DAMAGE_HIGH = 2.0;
		const float ATTACK_ACCURACY = 0.4;
		NPC_GIVE_EXP = 25;
		const int SPIDER_IDLE_VOL = 1;
		const float SPIDER_IDLE_DELAY = 3.6;
		const int SPIDER_VOLUME = 5;
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetWidth(16);
		SetHeight(20);
		SetHearingSensitivity(3);
		SetName("Poisonous Spider");
		NPC_GIVE_EXP = 20;
		SetModel("monsters/fer_spider_mini.mdl");
		SetModelBody(0, 2);
	}

	void bite_dodamage()
	{
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", RandomInt(3, 5), GetEntityIndex(GetOwner()), RandomInt(1, 5));
	}

}

}
