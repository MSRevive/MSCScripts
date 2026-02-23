#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcChief : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_AXE;
	string ANIM_KICK;
	string ANIM_SWAT;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int DOING_SPEC_ATK;
	string ICECHIEF_AXING;
	int ICECHIEF_GO;
	int ICE_SELECT_ATK;
	int MONSTER_WIDTH;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int SPEC_ATK_CNT;
	float STUCK_CHECK_FREQUENCY;

	MorcChief()
	{
		if (StringToLower(GetMapName()) == "ms_snow")
		{
			NPC_IS_BOSS = 1;
		}
		const float NPC_BOSS_REGEN_RATE = 0.1;
		const float NPC_BOSS_RESTORATION = 0.5;
		const int GOLD_BAGS = 1;
		const int GOLD_BAGS_PPLAYER = 5;
		const int GOLD_PER_BAG = 50;
		const int GOLD_RADIUS = 64;
		const int GOLD_MAX_BAGS = 32;
		NPC_GIVE_EXP = 500;
		ATTACK_RANGE = 104;
		ATTACK_HITRANGE = 138;
		MOVE_RANGE = 84;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ANIM_AXE = "battleaxe_swing1_L";
		ANIM_SWAT = "swordswing1_L";
		ANIM_KICK = "kick";
		const int SPEC_ATK_FREQ = 3;
		SPEC_ATK_CNT = 1;
		ICE_SELECT_ATK = 0;
		const float BLIZARD_FREQ = 50.0;
		const float ATTACK_ACCURACY = 0.85;
		const int ATTACK_DMG_LOW = 400;
		const int ATTACK_DMG_HIGH = 800;
		const int ATTACK_SPECRANGE = 160;
		const string SOUND_SWAT = "monsters/orc/battlecry.wav";
		const string SOUND_KICK = "monsters/orc/attack3.wav";
		const string SOUND_WARCRY = "monsters/troll/trollidle.wav";
		const string SOUND_UPSWING = "monsters/orc/attack1.wav";
		const string SOUND_SWINGHIT = "monsters/orc/pain.wav";
		const string SOUND_SWINGMISS = "debris/bustmetal2.wav";
		const string SOUND_SWIPEMISS = "zombie/claw_miss2.wav";
		const string SOUND_BOOM = "monsters/bear/giantbearstep2.wav";
		STUCK_CHECK_FREQUENCY = 4.1;
		MONSTER_WIDTH = 48;
		Precache("monsters/summon/summon_blizzard");
		Precache("monsters/morc_big.mdl");
	}

	void orc_spawn()
	{
		SetHealth(5000);
		SetName("Talnorgah , Chief of Clan Marogar");
		if (StringToLower(GetMapName()) != "ms_snow")
		{
			SetName("Marogar Giant");
		}
		SetHearingSensitivity(10);
		SetStat("spellcasting", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 2.0);
		SetDamageResistance("cold", 0.0);
		SetStat("parry", 90);
		SetWidth(48);
		SetHeight(96);
		SetRoam(false);
		Precache("monsters/morc_big.mdl");
		SetModel("monsters/morc_big.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 5);
	}

	void npc_selectattack()
	{
		if (SPEC_ATK_CNT < SPEC_ATK_FREQ)
		{
			ANIM_ATTACK = ANIM_AXE;
		}
		if (!(SPEC_ATK_CNT >= SPEC_ATK_FREQ)) return;
		if ((DOING_SPEC_ATK)) return;
		ICE_SELECT_ATK += 1;
		if (ICE_SELECT_ATK == 1)
		{
			ANIM_ATTACK = ANIM_KICK;
		}
		if (ICE_SELECT_ATK == 2)
		{
			ANIM_ATTACK = ANIM_SWAT;
			ICE_SELECT_ATK = 0;
		}
		DOING_SPEC_ATK = 1;
	}

	void swing_dodamage()
	{
		if (!(param1))
		{
			if (ANIM_ATTACK == ANIM_SWAT)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_SWIPEMISS, 10);
			}
			if (ANIM_ATTACK == ANIM_KICK)
			{
				EmitSound(GetOwner(), CHAN_ITEM, SOUND_SWIPEMISS, 10);
			}
			ICECHIEF_AXING = 0;
		}
		if (!(param1)) return;
		if ((ICECHIEF_AXING))
		{
			EmitSound(GetOwner(), CHAN_ITEM, SOUND_SWINGHIT, 10);
		}
		if (ANIM_ATTACK == ANIM_SWAT)
		{
			EmitSound(GetOwner(), CHAN_ITEM, SOUND_SWINGHIT, 10);
		}
		ICECHIEF_AXING = 0;
		if (!(GetEntityRange(param2) <= ATTACK_HITRANGE)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		ApplyEffect(param2, "effects/dot_cold", RandomInt(5, 10), GetOwner(), RandomInt(40, 80));
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((ICECHIEF_GO)) return;
		SetRoam(true);
		BLIZARD_FREQ("throw_blizzard");
		ICECHIEF_GO = 1;
	}

	void throw_blizzard()
	{
		BLIZARD_FREQ("throw_blizzard");
		if (!(false)) return;
		npcatk_faceattacker(m_hAttackTarget);
		PlayAnim("critical", "warcry");
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_WARCRY, 10);
		ScheduleDelayedEvent(1.5, "create_blizzard");
	}

	void power_kick()
	{
		SPEC_ATK_CNT = 1;
		DOING_SPEC_ATK = 0;
		if (!(false)) return;
		npcatk_faceattacker(m_hAttackTarget);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_KICK, 10);
		if (!(GetEntityRange(m_hLastStruckByMe) < ATTACK_SPECRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
	}

	void swing_sword()
	{
		SPEC_ATK_CNT = 1;
		DOING_SPEC_ATK = 0;
		if (!(false)) return;
		npcatk_faceattacker(m_hAttackTarget);
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_SWAT, 10);
		if (!(GetEntityRange(m_hLastStruckByMe) < ATTACK_SPECRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/debuff_stun", 10, GetEntityIndex(GetOwner()));
	}

	void swing_start()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_UPSWING, 10);
	}

	void swing_axe()
	{
		SPEC_ATK_CNT += 1;
		ICECHIEF_AXING = 1;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_SWINGMISS, 10);
	}

	void create_blizzard()
	{
		SpawnNPC("monsters/summon/summon_blizzard", GetEntityOrigin(m_hLastSeen), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), 50, 20
	}

	void baseorc_yell()
	{
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 190, 20, 1, 0);
		EmitSound(GetOwner(), CHAN_ITEM, SOUND_BOOM, 10);
	}

}

}
