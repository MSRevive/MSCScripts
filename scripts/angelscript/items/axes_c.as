#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesC : CGameScript
{
	string CAXE_EFFECT;
	string CAXE_EFFECT_COUNT;
	string CAXE_EFFECT_DOT;
	string CAXE_EFFECT_DUR;
	string CAXE_EFFECT_SKILL;
	string CAXE_ELEMENT;
	int CAXE_SKILLED;
	string EFFECT_DOTS;
	string EFFECT_DURATIONS;
	string EFFECT_ELEMENTS;
	string EFFECT_LIST;
	string EFFECT_SKILLS;
	string EFFECT_TARGET;
	int ELEMENT_LOOP;
	string GAME_PVP;
	string MY_CL_IDX;
	string NEXT_ELEMENT_BLAST;
	string NEXT_RANDOM_ELEMENT;

	AxesC()
	{
		const int MP_ELEMENT_BLAST = 50;
		const int ECHAOS_AOE = 200;
		const int BASE_LEVEL_REQ = 25;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const int ANIM_ATTACK3 = 4;
		const int ANIM_SHEATH = 5;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		const int MODEL_VIEW_IDX = 8;
		const string MODEL_HANDS = "weapons/p_weapons4.mdl";
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 54;
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 100;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.5;
		const int MELEE_ENERGY = 3;
		const int MELEE_DMG = 450;
		const int MELEE_DMG_RANGE = 200;
		const string MELEE_DMG_TYPE = "slash";
		const int MELEE_ACCURACY = 50;
		const string MELEE_STAT = "axehandling";
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const int MELEE_PARRY_CHANCE = 25;
		Precache("3dmflagry.spr");
	}

	void weapon_spawn()
	{
		SetName("Axe of Chaos");
		SetDescription("Elemental chaos, in weapon form.");
		SetWeight(90);
		SetSize(25);
		SetValue(1200);
		SetHUDSprite("hand", 198);
		SetHUDSprite("trade", 198);
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		caxe_check_skill();
		if ((ELEMENT_LOOP)) return;
		ELEMENT_LOOP = 1;
		ScheduleDelayedEvent(1.0, "element_loop");
		GAME_PVP = "game.pvp";
	}

	void element_loop()
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (!(ELEMENT_LOOP)) return;
		if (!(GetGameTime() > NEXT_RANDOM_ELEMENT)) return;
		NEXT_RANDOM_ELEMENT = GetGameTime();
		NEXT_RANDOM_ELEMENT += 5.0;
		ScheduleDelayedEvent(10.0, "element_loop");
		choose_dot("none");
	}

	void caxe_check_skill()
	{
		CAXE_SKILLED = 1;
		if (GetSkillLevel(GetOwner(), "spellcasting.fire") < 10)
		{
			CAXE_SKILLED = 0;
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.ice") < 10)
		{
			CAXE_SKILLED = 0;
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.lightning") < 10)
		{
			CAXE_SKILLED = 0;
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.divination") < 10)
		{
			CAXE_SKILLED = 0;
		}
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") < 10)
		{
			CAXE_SKILLED = 0;
		}
		if (!(CAXE_SKILLED))
		{
			SendColoredMessage(GetOwner(), "Axe of Chaos: Insufficient magical talents for effects.");
		}
	}

	void melee_damaged_other()
	{
		if (!(true)) return;
		if ((CAXE_SKILLED))
		{
			apply_dot(param1);
		}
		choose_dot(param1);
		NEXT_RANDOM_ELEMENT = GetGameTime();
		NEXT_RANDOM_ELEMENT += 30.0;
	}

	void special_01_damaged_other()
	{
		if (!(true)) return;
		if ((CAXE_SKILLED))
		{
			apply_dot(param1);
		}
		choose_dot(param1);
		NEXT_RANDOM_ELEMENT = GetGameTime();
		NEXT_RANDOM_ELEMENT += 30.0;
	}

	void special_02_damaged_other()
	{
		if (!(true)) return;
		if ((CAXE_SKILLED))
		{
			apply_dot(param1);
		}
		choose_dot(param1);
		NEXT_RANDOM_ELEMENT = GetGameTime();
		NEXT_RANDOM_ELEMENT += 30.0;
	}

	void apply_dot()
	{
		if ((IsValidPlayer(param1)))
		{
			if (!(GAME_PVP))
			{
			}
			return;
		}
		if (CAXE_EFFECT != "CAXE_EFFECT")
		{
			LogDebug("apply_dot CAXE_EFFECT dur CAXE_EFFECT_DUR dot CAXE_EFFECT_DOT");
			ApplyEffect(param1, CAXE_EFFECT, CAXE_EFFECT_DUR, GetEntityIndex(GetOwner()), CAXE_EFFECT_DOT);
		}
	}

	void choose_dot()
	{
		EFFECT_LIST = "dot_acid;dot_fire;dot_cold;dot_poison;dot_dark;dot_lightning;dot_holy";
		EFFECT_ELEMENTS = "acid;fire;cold;poison;dark;lightning;holy";
		EFFECT_DURATIONS = "5.0;5.0;5.0;10.0;5.0;5.0;5.0";
		EFFECT_SKILLS = "affliction;fire;ice;affliction;affliction;lightning;holy";
		EFFECT_DOTS = "1.0;2.0;0.5;0.5;0.25;0.75;2.0";
		EFFECT_TARGET = param1;
		string L_SKIP_CL_UPDATE = param2;
		string L_N_EFFECTS = GetTokenCount(EFFECT_LIST, ";");
		if ((IsEntityAlive(EFFECT_TARGET)))
		{
			for (int i = 0; i < L_N_EFFECTS; i++)
			{
				filter_effects();
			}
			CAXE_EFFECT_COUNT = 0;
			for (int i = 0; i < L_N_EFFECTS; i++)
			{
				filter_effects2();
			}
			string L_N_EFFECTS = GetTokenCount(EFFECT_LIST, ";");
		}
		if (!(L_N_EFFECTS > 0)) return;
		L_N_EFFECTS -= 1;
		string L_RND_IDX = RandomInt(0, L_N_EFFECTS);
		string L_EFFECT = "effects/";
		L_EFFECT += GetToken(EFFECT_LIST, L_RND_IDX, ";");
		string L_DUR = GetToken(EFFECT_DURATIONS, L_RND_IDX, ";");
		string L_SKILL = "skill.spellcasting.";
		L_SKILL += GetToken(EFFECT_SKILLS, L_RND_IDX, ";");
		string L_DOT = GetEntityProperty(GetOwner(), "l_skill");
		L_DOT *= GetToken(EFFECT_DOTS, L_RND_IDX, ";");
		CAXE_EFFECT = L_EFFECT;
		CAXE_EFFECT_DUR = L_DUR;
		CAXE_EFFECT_DOT = L_DOT;
		CAXE_EFFECT_SKILL = L_SKILL;
		CAXE_ELEMENT = GetToken(EFFECT_ELEMENTS, L_RND_IDX, ";");
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 1);
		SetAttackProp("ent_me", 2);
		if (!(L_SKIP_CL_UPDATE))
		{
			update_cl();
		}
		LogDebug("choose_dot L_EFFECT dr L_DUR dot L_DOT");
	}

	void filter_effects()
	{
		string L_CUR_IDX = i;
		string L_CUR_ELEMENT = GetToken(EFFECT_ELEMENTS, L_CUR_IDX, ";");
		if (/* TODO: $get_takedmg */ $get_takedmg(EFFECT_TARGET, L_CUR_ELEMENT) == 0)
		{
			SetToken(EFFECT_ELEMENTS, L_CUR_IDX, "x", ";");
		}
	}

	void filter_effects2()
	{
		string L_CUR_IDX = CAXE_EFFECT_COUNT;
		string L_CUR_ELEMENT = GetToken(EFFECT_ELEMENTS, L_CUR_IDX, ";");
		if (L_CUR_ELEMENT == "x")
		{
			RemoveToken(EFFECT_LIST, L_CUR_IDX, ";");
			RemoveToken(EFFECT_ELEMENTS, L_CUR_IDX, ";");
			RemoveToken(EFFECT_DURATIONS, L_CUR_IDX, ";");
			RemoveToken(EFFECT_SKILLS, L_CUR_IDX, ";");
		}
		else
		{
			CAXE_EFFECT_COUNT += 1;
		}
	}

	void update_cl()
	{
		if (MY_CL_IDX == "MY_CL_IDX")
		{
			ClientEvent("new", GetOwner(), "items/axes_c_cl", GetEntityIndex(GetOwner()));
			MY_CL_IDX = "game.script.last_sent_id";
		}
		ClientEvent("update", GetOwner(), MY_CL_IDX, "update_caxe_sprite", CAXE_ELEMENT);
	}

	void remove_cl()
	{
		if (!(MY_CL_IDX != "MY_CL_IDX")) return;
		ClientEvent("update", GetOwner(), MY_CL_IDX, "end_fx");
		MY_CL_IDX = "MY_CL_IDX";
	}

	void bweapon_effect_remove()
	{
		if (!(true)) return;
		remove_cl();
		ELEMENT_LOOP = 0;
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_ELEMENT_BLAST)) return;
		NEXT_ELEMENT_BLAST = GetGameTime();
		NEXT_ELEMENT_BLAST += 1.0;
		if (GetEntityMP(GetOwner()) < MP_ELEMENT_BLAST)
		{
			string L_MSG = "Chaos Axe: Not enough mana for elemental chaos. (";
			SendColoredMessage(GetOwner(), "L_MSG");
			int EXIT_SUB = 1;
		}
		if (!(CAXE_SKILLED))
		{
			SendColoredMessage(GetOwner(), "Chaos Axe: Insufficient magical talent for elemental chaos. All Magic 10");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		// TODO: splayviewanim ent_me 9
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		ScheduleDelayedEvent(0.1, "do_chaos1");
	}

	void do_chaos1()
	{
		string L_FX_ORG = GetEntityOrigin(GetOwner());
		L_FX_ORG += "z";
		if ((IsDucking(GetOwner())))
		{
			L_FX_ORG += "z";
		}
		ClientEvent("new", "all", "effects/sfx_prism_blast", L_FX_ORG, ECHAOS_AOE, CAXE_ELEMENT);
		ScheduleDelayedEvent(0.1, "do_chaos2");
	}

	void do_chaos2()
	{
		string L_DMG = /* TODO: $math(multiply) */ CAXE_EFFECT_DOT;
		XDoDamage(GetEntityOrigin(GetOwner()), ECHAOS_AOE, L_DMG, 0, GetOwner(), GetOwner(), "axehandling", CAXE_ELEMENT, "dmgevent:*chaos");
		ScheduleDelayedEvent(0.5, "update_cl");
	}

	void chaos_dodamage()
	{
		if (!(param1)) return;
		apply_dot(param2);
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(GAME_PVP))
			{
			}
			return;
		}
		string L_CUR_TARG = param2;
		string L_TARG_HP = GetEntityHealth(L_CUR_TARG);
		string L_MAX_REPEL_HP = GetEntityMaxHealth(GetOwner());
		L_MAX_REPEL_HP *= 4;
		if (L_TARG_HP < L_MAX_REPEL_HP)
		{
			int L_DO_PUSH = 1;
		}
		if (!(L_DO_PUSH)) return;
		string L_TARG_ORG = GetEntityOrigin(L_CUR_TARG);
		string L_OWNER_ORG = GetEntityOrigin(GetOwner());
		string L_TARG_ANG = /* TODO: $angles */ $angles(L_OWNER_ORG, L_TARG_ORG);
		SetVelocity(L_CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, L_TARG_ANG, 0), Vector3(0, 1000, 0)));
	}

}

}
