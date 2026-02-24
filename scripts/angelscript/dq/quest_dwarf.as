#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_battle_ally.as"
#include "monsters/base_chat_array.as"
#include "monsters/base_struck.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class QuestDwarf : CGameScript
{
	int ALLY_FOLLOW_ON;
	int ALLY_MOVE_AWAY_DIST;
	string AM_SITTING;
	string ANIM_ALLY_JUMP;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SIT_IDLE;
	string ANIM_SIT_IDLE_CONVO1;
	string ANIM_SIT_IDLE_CONVO2;
	string ANIM_SIT_IDLE_NOLANTERN;
	string ANIM_SIT_IDLE_WOUNDED;
	string ANIM_WALK;
	int ATTACK2_ACCURACY;
	int ATTACK2_CHANCE;
	int ATTACK2_DAMAGE;
	float ATTACK2_DAMAGE_MULT;
	int ATTACK_ACCURACY;
	int ATTACK_DAMAGE;
	float ATTACK_DAMAGE_MULT;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string CHAT_CONV_ANIMS;
	string DWARF_COMVO_ANIMS;
	string DWARF_CONVO_ANIMS;
	int HEALTH_MULT;
	string INIT_IDLE_MODE;
	int NPC_BASE_EXP;
	string NPC_MATERIAL_TYPE;
	int NPC_NO_PLAYER_DMG;
	int NPC_USE_FLINCH;
	int NPC_USE_IDLE;
	int NPC_USE_PAIN;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ALERT3;
	string SOUND_ALLY_JUMP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3voices/dwarf/voices/dwarf/vs_nx0drogm_atk3.wav;
	string SOUND_DEATH;
	string SOUND_FLINCH1;
	string SOUND_FLINCH2;
	string SOUND_FLINCH3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;

	QuestDwarf()
	{
		CHAT_CONV_ANIMS = DWARF_CONVO_ANIMS;
		ATTACK_DAMAGE_MULT = 0.05;
		ATTACK2_DAMAGE_MULT = 0.15;
		HEALTH_MULT = 2;
		ALLY_FOLLOW_ON = 0;
		ANIM_ALLY_JUMP = "anim_roll_back";
		SOUND_ALLY_JUMP = "voices/dwarf/vs_nx0drogm_hit2.wav";
		ALLY_MOVE_AWAY_DIST = 128;
		NPC_MATERIAL_TYPE = "flesh";
		NPC_USE_PAIN = 1;
		NPC_USE_IDLE = 0;
		NPC_USE_FLINCH = 1;
		SOUND_PAIN1 = "voices/dwarf/vs_ndwarfm1_hit1.wav";
		SOUND_PAIN2 = "voices/dwarf/vs_ndwarfm1_bat1.wav";
		SOUND_PAIN3 = "voices/dwarf/vs_ndwarfm1_hit3.wav";
		SOUND_FLINCH1 = "voices/dwarf/vs_nx0drogm_heal.wav";
		SOUND_FLINCH2 = "voices/dwarf/vs_nx0drogm_help.wav";
		SOUND_FLINCH3 = "voices/dwarf/vs_nx0drogm_hit1.wav";
		ANIM_FLINCH = "none";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		NPC_BASE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_MOVERANGE = 48;
		SOUND_DEATH = "voices/dwarf/vs_nx0drogm_hit3.wav";
		ATTACK_DAMAGE = 50;
		ATTACK2_DAMAGE = 150;
		ATTACK2_CHANCE = 30;
		ATTACK_ACCURACY = 80;
		ATTACK2_ACCURACY = 90;
		SOUND_ALERT1 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat3.wav";
		SOUND_ALERT2 = "voices/dwarf/voices/dwarf/vs_nx0drogm_bat1.wav";
		SOUND_ALERT3 = "voices/dwarf/voices/dwarf/vs_ndwarfm1_bat3.wav";
		SOUND_ATTACK1 = "voices/dwarf/voices/dwarf/vs_nx0drogm_atk1.wav";
		SOUND_ATTACK2 = "voices/dwarf/voices/dwarf/vs_nx0drogm_atk2.wav";
		SOUND_ATTACK3voices/dwarf/voices/dwarf/vs_nx0drogm_atk3.wav = "";
		ANIM_SIT_IDLE = "anim_sit_idle_lantern";
		ANIM_SIT_IDLE_NOLANTERN = "anim_sit_idle_nolantern";
		ANIM_SIT_IDLE_WOUNDED = "anim_sit_wounded";
		ANIM_SIT_IDLE_CONVO1 = "anim_convo1";
		ANIM_SIT_IDLE_CONVO2 = "anim_convo2";
	}

	void OnSpawn() override
	{
		dwarf_spawn();
	}

	void dwarf_spawn()
	{
		SetName("Dwarven Miner");
		SetModel("dwarf/male1.mdl");
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(1000);
		SetHearingSensitivity(8);
		if ((USE_LANTERN))
		{
			set_lantern(LANTERN_COLOR);
		}
		if (!(NEW_RACE))
		{
			SetRace("human");
		}
		init_idle_anims();
	}

	void init_idle_anims()
	{
		if (INIT_IDLE_MODE == "INIT_IDLE_MODE")
		{
			if (QUEST_COMBATANT == 0)
			{
				INIT_IDLE_MODE = "wounded";
			}
			else
			{
				if (QUEST_COMBATANT == 1)
				{
					INIT_IDLE_MODE = "sitting";
				}
				else
				{
					INIT_IDLE_MODE = "wounded";
				}
			}
		}
		if (INIT_IDLE_MODE == "sitting")
		{
			if ((USE_LANTERN))
			{
				SetIdleAnim(ANIM_SIT_IDLE);
			}
			else
			{
				SetIdleAnim(ANIM_SIT_IDLE_NOLANTERN);
			}
			AM_SITTING = 1;
		}
		else
		{
			if (INIT_IDLE_MODE == "wounded")
			{
				SetIdleAnim(ANIM_SIT_IDLE_WOUNDED);
				AM_SITTING = 1;
			}
			else
			{
				if (INIT_IDLE_MODE == "standing")
				{
					SetIdleAnim(ANIM_IDLE);
					AM_SITTING = 0;
				}
			}
		}
		if ((AM_SITTING))
		{
			ANIM_FLINCH = "none";
			DWARF_CONVO_ANIMS = "anim_sit_convo1;anim_sit_convo2";
		}
		else
		{
			ANIM_FLINCH = "anim_xbow_flinch";
			DWARF_COMVO_ANIMS = "anim_convo1;anim_convo2";
		}
	}

	void attack_1()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		if ((QUEST_EXPERT_COMBATANT))
		{
			if (RandomInt(1, 100) < ATTACK2_CHANCE)
			{
				ANIM_ATTACK = "attack2";
			}
		}
	}

	void attack_2()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK2_DAMAGE, ATTACK2_ACCURACY, "slash");
		ANIM_ATTACK = "attack";
		if (GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)
		{
			ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/debuff_stun", RandomInt(2, 8), GetEntityIndex(GetOwner()));
			ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 2, /* TODO: $relvel */ $relvel(10, -200, 10), 0);
		}
	}

	void set_leader()
	{
		if (param1 != 0)
		{
			SetMoveSpeed(2.5);
			SetAnimMoveSpeed(2.5);
		}
		else
		{
			SetMoveSpeed(1.0);
			SetAnimMoveSpeed(1.0);
		}
	}

	void OnDamage(int damage) override
	{
		if (!(AM_SITTING))
		{
			if (!(NPC_IS_TURRET))
			{
				if (GetGameTime() > NEXT_DZOMB_FLEE)
				{
					NEXT_DZOMB_FLEE = GetGameTime();
					NEXT_DZOMB_FLEE += Random(5, 10);
					AS_ATTACKING = GetGameTime();
					AS_ATTACKING += 5.0;
					// svplaysound: svplaysound 2 10 SOUND_PAIN1
					EmitSound(2, 10, SOUND_PAIN1);
					PlayAnim("critical", ANIM_DODGE);
					int L_ROLL_DIR = -200;
					if ((AM_FLEEING))
					{
						int L_ROLL_DIR = 200;
					}
					AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(50, L_ROLL_DIR, 100));
				}
			}
		}
	}

	void frame_roll_back_push()
	{
		int L_ROLL_DIR = -100;
		if ((AM_FLEEING))
		{
			int L_ROLL_DIR = 100;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Random(-50, 50), L_ROLL_DIR, 100));
	}

	void quest_activate()
	{
		if (QUEST_COMBATANT == 1)
		{
			INIT_IDLE_MODE = "standing";
			init_idle_anims();
		}
		else
		{
			if (QUEST_ACTIVE_COMBATANT == 1)
			{
				INIT_IDLE_MODE = "standing";
				init_idle_anims();
			}
			else
			{
				if (QUEST_FOLLOWER == 1)
				{
					INIT_IDLE_MODE = "standing";
					init_idle_anims();
				}
				else
				{
					if (IS_LEADER == 1)
					{
						INIT_IDLE_MODE = "standing";
						init_idle_anims();
					}
				}
			}
		}
		string L_SET_HEALTH = ("game.players.avghp" * HEALTH_MULT);
		ext_set_health(L_SET_HEALTH, L_SET_HEALTH);
	}

}

}
