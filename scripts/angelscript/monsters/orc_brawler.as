#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcBrawler : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	int ATTACKING;
	string ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	string ATTACK_PUSH;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int CHARGE_DELAY;
	int DONE_WARCRY;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int MOVE_RANGE;
	string NEXT_ATTACK;
	int NPC_GIVE_EXP;

	OrcBrawler()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(30, 60);
		NPC_GIVE_EXP = 200;
		DROP_ITEM1 = "blunt_gauntlets";
		DROP_ITEM1_CHANCE = 0.2;
		ANIM_ATTACK1 = "swordswing1_L";
		const string ANIM_SMASH = "battleaxe_swing1_L";
		const string ANIM_SWIPE1 = "swordswing1_L";
		const string ANIM_SLAP = "deflectcounter";
		const string ANIM_KICK = "kick";
		const string ANIM_WARCRY = "warcry";
		const float KICK_DMG_DELAY = 0.5;
		const float SLAP_DMG_DELAY = 0.5;
		FLINCH_CHANCE = 0.45;
		const float ATTACK_ACCURACY = 0.7;
		ATTACK_DAMAGE = RandomInt(50, 100);
		const int ATTACK_DMG_LOW = 10;
		const int ATTACK_DMG_HIGH = 20;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		ATTACK_MOVERANGE = 50;
		MOVE_RANGE = 50;
		const string SOUND_KICK = "zombie/claw_miss1.wav";
		const string SOUND_SLAP = "zombie/claw_miss2.wav";
		const string SOUND_KICKHIT = "zombie/claw_strike2.wav";
		const string SOUND_SLAPHIT = "zombie/claw_strike3.wav";
		const string SOUND_WARCRY = "monsters/troll/trollidle.wav";
		const string SOUND_CHARGE = "garg/gar_alert3.wav";
		const float STUCK_CHECK_FREQUENCY = 2.0;
		const float ZORC_DMG_MULTI = 4.0;
		const float ZORC_HP_MULTI = 3.0;
	}

	void orc_spawn()
	{
		if ((G_SHAD_PRESENT))
		{
			ScheduleDelayedEvent(0.1, "bo_zombie_mode");
		}
		SetHealth(1000);
		if (StringToLower(GetMapName()) == "mscave")
		{
			SetWidth(32);
		}
		if (StringToLower(GetMapName()) != "mscave")
		{
			SetWidth(38);
		}
		SetHeight(72);
		SetName("Orcish Brawler");
		SetHearingSensitivity(8);
		SetModel("monsters/orc_big.mdl");
		SetMoveSpeed(2.0);
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 0);
		if (ORC_SHIELD == 1)
		{
			if (!(BO_ZOMBIE_MODE))
			{
			}
			SetModelBody(2, 6);
		}
	}

	void npc_selectattack()
	{
		ATTACK_PUSH = "none";
		if ((ATTACKING)) return;
		if (NEXT_ATTACK == "NEXT_ATTACK")
		{
			ATTACK_TYPE = RandomInt(1, 4);
		}
		if (NEXT_ATTACK != "NEXT_ATTACK")
		{
			ATTACK_TYPE = NEXT_ATTACK;
		}
		ATTACKING = 1;
		if (ATTACK_TYPE == 1)
		{
			ATTACK_PUSH = /* TODO: $relvel */ $relvel(-200, 230, 220);
			ATTACK_DAMAGE = RandomInt(50, 150);
			ANIM_ATTACK = ANIM_SMASH;
			PlayAnim("critical", ANIM_SMASH);
			ATTACK_TYPE = RandomInt(1, 4);
		}
		if (ATTACK_TYPE == 2)
		{
			ATTACK_DAMAGE = RandomInt(25, 100);
			ATTACK_PUSH = /* TODO: $relvel */ $relvel(-100, 130, 120);
			ANIM_ATTACK = ANIM_SWIPE1;
			PlayAnim("critical", ANIM_SWIPE1);
			ATTACK_TYPE = RandomInt(1, 4);
		}
		if (ATTACK_TYPE == 3)
		{
			ATTACK_DAMAGE = RandomInt(25, 50);
			ATTACK_PUSH = /* TODO: $relvel */ $relvel(-10, 13, 12);
			ANIM_ATTACK = ANIM_SLAP;
			PlayAnim("critical", ANIM_SLAP);
			EmitSound(GetOwner(), 0, SOUND_SLAP, 10);
			SLAP_DMG_DELAY("slap_damage");
			NEXT_ATTACK = 1;
		}
		if (ATTACK_TYPE == 4)
		{
			ATTACK_DAMAGE = RandomInt(50, 100);
			ATTACK_PUSH = /* TODO: $relvel */ $relvel(-300, 330, 320);
			ANIM_ATTACK = ANIM_KICK;
			PlayAnim("critical", ANIM_KICK);
			EmitSound(GetOwner(), 0, SOUND_KICK, 10);
			KICK_DMG_DELAY("kick_damage");
			if (!(I_R_FROZEN))
			{
				SetMoveSpeed(2.0);
			}
			NEXT_ATTACK = 1;
		}
	}

	void kick_damage()
	{
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
		ATTACKING = 0;
	}

	void slap_damage()
	{
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
		ATTACKING = 0;
	}

	void swing_axe()
	{
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
		baseorc_yell();
		ATTACKING = 0;
	}

	void swing_sword()
	{
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY);
		baseorc_yell();
		ATTACKING = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(DID_WARCRY))
		{
			if ((IsValidPlayer(m_hLastSeen)))
			{
				PlayAnim("critical", ANIM_WARCRY);
				EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
				DID_WARCRY = 1;
				DONE_WARCRY = 0;
				ScheduleDelayedEvent(3.0, "warcry_over");
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if (!(DONE_WARCRY)) return;
		string NME_RANGE = GetEntityRange(m_hLastSeen);
		if (!(NME_RANGE > 200)) return;
		if ((CHARGE_DELAY)) return;
		start_charge();
	}

	void start_charge()
	{
		ApplyEffect(GetOwner(), "effects/sfx_motionblur", GetEntityIndex(GetOwner()), 0);
		if (!(I_R_FROZEN))
		{
			SetMoveSpeed(5.0);
		}
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		NEXT_ATTACK = 4;
		CHARGE_DELAY = 1;
		ScheduleDelayedEvent(3.0, "charge_out");
		ScheduleDelayedEvent(10.0, "charge_reset");
	}

	void charge_out()
	{
		if (!(I_R_FROZEN))
		{
			SetMoveSpeed(2.0);
		}
	}

	void charge_reset()
	{
		CHARGE_DELAY = 0;
	}

	void warcry_over()
	{
		DONE_WARCRY = 1;
	}

	void game_dodamage()
	{
		ATTACKING = 0;
		if (!(param1)) return;
		if (ATTACK_TYPE == 1)
		{
			if (RandomInt(1, 5) == 1)
			{
				ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", RandomInt(5, 10), GetEntityIndex(GetOwner()));
			}
		}
		if (ATTACK_TYPE == 2)
		{
			if (RandomInt(1, 10) == 1)
			{
				ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", RandomInt(5, 10), GetEntityIndex(GetOwner()));
			}
		}
		if (ATTACK_TYPE == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_SLAPHIT, 10);
			if (RandomInt(1, 10) == 1)
			{
				ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", RandomInt(5, 10), GetEntityIndex(GetOwner()));
			}
		}
		if (ATTACK_TYPE == 4)
		{
			EmitSound(GetOwner(), 0, SOUND_KICKHIT, 10);
			if (RandomInt(1, 2) == 1)
			{
				ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 200, 30));
			}
			ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", RandomInt(5, 10), GetEntityIndex(GetOwner()));
		}
	}

	void freeze_solid_end()
	{
		SetMoveSpeed(2.0);
	}

	void bo_zombie_mode()
	{
		npc_suicide();
	}

}

}
