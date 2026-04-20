#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntSnakeStaff : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BLUNT_NO_STUN;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	float MELEE_ENERGY;
	int MELEE_RANGE;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_PLAYER;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int SECONDARY_DMG;
	string SOUND_BITE;
	string SOUND_POISON;
	string SOUND_SUMMON;

	BluntSnakeStaff()
	{
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_PLAYER = "weapons/staff/snake_staff_player.mdl";
		MODEL_BODY_OFS = 58;
		ANIM_PREFIX = "khopesh";
		MELEE_STAT = "spellcasting.affliction";
		SECONDARY_DMG = 0;
		MELEE_DMG_TYPE = "poison";
		SOUND_SUMMON = "magic/spawn.wav";
		SOUND_BITE = "bullchicken/bc_bite2.wav";
		SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.6;
		MELEE_ENERGY = 0.3;
		MELEE_DMG = 30;
		MELEE_DMG_RANGE = 60;
		MELEE_ACCURACY = 0.65;
		BLUNT_NO_STUN = 1;
		Precache("monsters/summon/snake_cursed");
	}

	void weapon_spawn()
	{
		SetName("Snake Staff");
		SetDescription("A magic staff used by snake charmers");
		SetWeight(10);
		SetSize(1);
		SetValue(500);
		SetHUDSprite("hand", 79);
		SetHUDSprite("trade", 79);
	}

	void melee_strike()
	{
		if (!(GetEntityRange(m_hLastStruckByMe) < 100)) return;
		int random = RandomInt(1, 100);
		if (!(random < 15)) return;
		DoDamage(m_hLastSeen, "direct", 10, 1, MELEE_ACCURACY);
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", RandomInt(3, 6), GetEntityIndex(GetOwner()), Random(3, 10), "spellcasting.affliction");
		EmitSound(GetOwner(), 0, SOUND_BITE, 10);
		ScheduleDelayedEvent(0.1, "second_sound");
	}

	void second_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_POISON, 10);
	}

	void melee_start()
	{
		int VATTACK = RandomInt(1, 3);
		if (VATTACK == 1)
		{
			string VATTACK_ANIM = ANIM_ATTACK1;
		}
		if (VATTACK == 2)
		{
			string VATTACK_ANIM = ANIM_ATTACK2;
		}
		if (VATTACK == 3)
		{
			string VATTACK_ANIM = ANIM_ATTACK3;
		}
		PlayViewAnim(VATTACK_ANIM);
		if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
		{
			PlayOwnerAnim("once", PLAYERANIM_SWING);
		}
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void special_02_start()
	{
		PlayViewAnim(5);
		if (SNAKES_CREATED >= 20)
		{
			SendPlayerMessage("The", "staffs magic is depleted , it may recharge in time.");
		}
		if (!(SNAKES_CREATED < 20)) return;
		SNAKES_CREATED += 1;
		ApplyEffect(GetOwner(), "effects/dot_poison_blind", 5, GetEntityIndex(GetOwner()), Random(1, 5), "none");
		SendPlayerMessage("You", "have been poisoned by your snake staff!");
		int NCHARGES = 20;
		NCHARGES -= SNAKES_CREATED;
		int NCHARGES = int(NCHARGES);
		SendPlayerMessage("Staff", "has " + NCHARGES + " charges remaining");
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		string SPAWN_POS = /* TODO: $relpos */ $relpos(0, 60, 0);
		SPAWN_POS = "z";
		SpawnNPC("monsters/summon/snake_cursed", /* TODO: $relpos */ $relpos(0, 60, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		Effect("glow", m_hLastCreated, Vector3(0, 255, 0), 100, 1, 1);
	}

}

}
