#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/sorc_base.as"

namespace MS
{

class SorcBrawler : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_KICK;
	string ANIM_SLAP;
	string ANIM_SMASH;
	string ANIM_SWIPE1;
	string ANIM_WARCRY;
	int ATTACKING;
	float ATTACK_ACCURACY;
	int ATTACK_DAMAGE;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	string ATTACK_PUSH;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	float BASE_MOVESPEED;
	int CHARGE_DELAY;
	int DONE_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	float KICK_DMG_DELAY;
	int MOVE_RANGE;
	string MY_SCRIPT_IDX;
	string NEXT_ATTACK;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	float SLAP_DMG_DELAY;
	string SOUND_KICK;
	string SOUND_KICKHIT;
	string SOUND_SLAP;
	string SOUND_SLAPHIT;
	string SOUND_TELE;
	string SOUND_WALK1;
	string SOUND_WALK2;
	string SOUND_WARCRY;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;
	float STUCK_CHECK_FREQUENCY;

	SorcBrawler()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(100, 200);
		NPC_GIVE_EXP = 500;
		BASE_MOVESPEED = 2.0;
		ANIM_ATTACK1 = "swordswing1_L";
		ANIM_SMASH = "battleaxe_swing1_L";
		ANIM_SWIPE1 = "swordswing1_L";
		ANIM_SLAP = "deflectcounter";
		ANIM_KICK = "kick";
		ANIM_WARCRY = "warcry";
		KICK_DMG_DELAY = 0.5;
		SLAP_DMG_DELAY = 0.5;
		FLINCH_CHANCE = 0.45;
		ATTACK_ACCURACY = 0.7;
		ATTACK_DAMAGE = RandomInt(50, 100);
		ATTACK_DMG_LOW = 10;
		ATTACK_DMG_HIGH = 20;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		ATTACK_MOVERANGE = 50;
		MOVE_RANGE = 50;
		SOUND_KICK = "zombie/claw_miss1.wav";
		SOUND_SLAP = "zombie/claw_miss2.wav";
		SOUND_KICKHIT = "zombie/claw_strike2.wav";
		SOUND_SLAPHIT = "zombie/claw_strike3.wav";
		SOUND_WARCRY = "monsters/troll/trollidle.wav";
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart14.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		SOUND_WALK1 = "monsters/troll/step1.wav";
		SOUND_WALK2 = "monsters/troll/step2.wav";
		SOUND_TELE = "magic/teleport.wav";
		STUCK_CHECK_FREQUENCY = 2.0;
	}

	void orc_spawn()
	{
		SetHealth(4000);
		SetWidth(38);
		SetHeight(96);
		SetName("Shadahar Thunderfist");
		SetHearingSensitivity(8);
		SetModel("monsters/sorc_big.mdl");
		SetMoveSpeed(2.0);
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 0);
	}

	void OnPostSpawn() override
	{
		ATTACK_MOVERANGE = 86;
		ATTACK_RANGE = 110;
		ATTACK_HITRANGE = 175;
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
			if (!(I_R_FROZEN))
			{
				SetMoveSpeed(2.0);
			}
			NEXT_ATTACK = 1;
		}
	}

	void kick_land()
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
		ClientEvent("new", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0);
		MY_SCRIPT_IDX = "game.script.last_sent_id";
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(m_hAttackTarget);
		if (!(I_R_FROZEN))
		{
			SetMoveSpeed(5.0);
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		NEXT_ATTACK = 4;
		CHARGE_DELAY = 1;
		ScheduleDelayedEvent(0.1, "boost_me");
		ScheduleDelayedEvent(0.5, "render_norm");
		ScheduleDelayedEvent(3.0, "charge_out");
		ScheduleDelayedEvent(10.0, "charge_reset");
	}

	void boost_me()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, 110));
	}

	void render_norm()
	{
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void charge_out()
	{
		ClientEvent("remove", "all", MY_SCRIPT_IDX);
		if ((I_R_FROZEN)) return;
		SetMoveSpeed(2.0);
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
			if (RandomInt(1, 20) == 1)
			{
				// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
				array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				Effect("glow", GetOwner(), Vector3(255, 255, 0), 128, 1, 1);
				Effect("screenfade", param2, 3, 1, Vector3(255, 255, 255), 255, "fadein");
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

	void run_step1()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK2, 8);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 128, 10, 1, 128);
	}

	void run_step2()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK1, 8);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 128, 10, 1, 128);
	}

}

}
