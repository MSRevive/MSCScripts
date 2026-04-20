#pragma context server

#include "items/base_elemental_resist.as"
#include "items/base_weapon_new.as"

namespace MS
{

class BluntStaffF : CGameScript
{
	float ATK1_ACCURACY;
	string ATK1_CALLBACK;
	float ATK1_DELAY_STRIKE;
	int ATK1_DMG;
	int ATK1_DMG_RANGE;
	string ATK1_DMG_TYPE;
	float ATK1_DURATION;
	string ATK1_PANIM;
	int ATK1_RANGE;
	string ATK1_SKILL;
	int ATK1_STAMINA;
	string ATK1_VANIM;
	string ATK2_CALLBACK;
	int ATK2_DMG;
	string ATK2_PANIM;
	int ATK2_RANGE;
	string ATK2_VANIM;
	int BASE_LEVEL_REQ;
	string BURN_TARG_ORG;
	int BURST_ATTACK;
	string BURST_ORG;
	string BWEAPON_DESC;
	string BWEAPON_HANDS;
	int BWEAPON_INV_SPRITE_IDX;
	string BWEAPON_NAME;
	int BWEAPON_VALUE;
	int BWEAPON_WEIGHT;
	float DOT_RATIO;
	int ELM_AMT;
	string ELM_NAME;
	string ELM_TYPE;
	int ELM_WEAPON;
	int IN_BURST_ATTACK;
	string MELEE_ATTACK;
	int MP_BURST;
	int MP_METEOR;
	int MP_VOLCANO;
	string NEXT_BURST;
	string NEXT_BURST_ATTEMPT;
	string PANIM_EXT;
	string PANIM_IDLE;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	int PMODEL_IDX_HAND_LEFT;
	int PMODEL_IDX_HAND_RIGHT;
	string SOUND_MELEE;
	string SPELL_POS;
	int STAFF_RADIUS1;
	int STAFF_RADIUS2;
	int VANIM_BURST;
	int VANIM_DRAW;
	int VANIM_IDLE;
	int VANIM_MELEE;
	int VANIM_SPELL1;
	int VANIM_SPELL2;
	string VMODEL_FILE;
	int VMODEL_IDX;
	int VOLCANO_ON;
	string WANIM_FLOOR;
	string WANIM_HAND;

	BluntStaffF()
	{
		BASE_LEVEL_REQ = 30;
		MP_VOLCANO = 100;
		MP_METEOR = 75;
		MP_BURST = 30;
		STAFF_RADIUS1 = 96;
		STAFF_RADIUS2 = 256;
		BWEAPON_NAME = "Phlame's Staff";
		BWEAPON_DESC = "A demonic staff of fire";
		BWEAPON_WEIGHT = 60;
		BWEAPON_VALUE = 7000;
		BWEAPON_INV_SPRITE_IDX = 52;
		BWEAPON_HANDS = "both";
		ELM_NAME = "phlame";
		ELM_TYPE = "cold";
		ELM_AMT = 20;
		ELM_WEAPON = 1;
		VMODEL_FILE = "viewmodels/v_polearms.mdl";
		VMODEL_IDX = 13;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 28;
		PMODEL_IDX_HANDS = 29;
		PMODEL_IDX_HAND_RIGHT = 29;
		PMODEL_IDX_HAND_LEFT = 29;
		PANIM_IDLE = "aim_blunt";
		PANIM_EXT = "blunt";
		VANIM_IDLE = 21;
		VANIM_DRAW = 21;
		VANIM_MELEE = 22;
		VANIM_SPELL1 = 23;
		VANIM_SPELL2 = 24;
		VANIM_BURST = 25;
		WANIM_FLOOR = "standard_floor_idle";
		WANIM_HAND = "standard_idle";
		ATK1_RANGE = 110;
		ATK1_DMG = 200;
		ATK1_DMG_RANGE = 20;
		ATK1_DMG_TYPE = "fire";
		ATK1_STAMINA = 0;
		ATK1_SKILL = "spellcasting.fire";
		ATK1_ACCURACY = 0.8;
		ATK1_DELAY_STRIKE = 0.6;
		ATK1_DURATION = 1.0;
		ATK1_CALLBACK = "spell1";
		ATK1_PANIM = "swing_blunt";
		ATK1_VANIM = VANIM_SPELL1;
		SOUND_MELEE = "weapons/cbar_miss1.wav";
		ATK2_DMG = 0;
		ATK2_RANGE = 0;
		ATK2_VANIM = VANIM_SPELL2;
		ATK2_PANIM = "sword_double_swing";
		ATK2_CALLBACK = "spell2";
		DOT_RATIO = 0.5;
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		if ((BITEM_UNDERSKILLED)) return;
		viewfinder_loop();
		ScheduleDelayedEvent(0.1, "elm_activate_effect");
	}

	void viewfinder_loop()
	{
		if (!(true)) return;
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int BEW_IS_WEILDED = 1;
		}
		if ((BEW_IS_WEILDED))
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "phlames_viewfinder_on", GetEntityIndex(GetOwner()));
			ScheduleDelayedEvent(5.0, "cl_refresh_loop");
		}
		else
		{
			ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "phlames_viewfinder_off");
		}
	}

	void bweapon_effect_remove()
	{
		ClientEvent("update", GetOwner(), "const.localplayer.scriptID", "phlames_viewfinder_off");
	}

	void spell1_start()
	{
		PlayOwnerAnim("critical", ATK1_PANIM);
		string OWNER_TARG = GetEntityProperty(GetOwner(), "target");
		if (!(IsEntityAlive(OWNER_TARG)))
		{
			int DO_MELEE = 0;
		}
		else
		{
			if (GetEntityRange(OWNER_TARG) < ATK1_RANGE)
			{
				int DO_MELEE = 1;
			}
		}
		if ((BITEM_UNDERSKILLED))
		{
			int DO_MELEE = 1;
		}
		if (!(DO_MELEE))
		{
			SetAttackProp("ent_me", 0);
			MELEE_ATTACK = 0;
			// TODO: splayviewanim ent_me VANIM_SPELL1
		}
		else
		{
			SetAttackProp("ent_me", 0);
			MELEE_ATTACK = 1;
			EmitSound(GetOwner(), 1, SOUND_MELEE, 10);
			// TODO: splayviewanim ent_me VANIM_MELEE
		}
	}

	void get_spell_pos()
	{
		string L_OWNER_VIEW = GetEntityProperty(GetOwner(), "viewangles");
		string L_SEAL_POS = GetEntityOrigin(GetOwner());
		string TRACE_START = L_SEAL_POS;
		string TRACE_END = L_SEAL_POS;
		TRACE_END += /* TODO: $relpos */ $relpos(L_OWNER_VIEW, Vector3(0, 1000, 0));
		string reg.trace.ignorenet = GetEntityIndex(GetOwner());
		string MY_OWNER = GetEntityIndex(GetOwner());
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		TRACE_LINE = "z";
		string OWNER_ORG = GetEntityOrigin(GetOwner());
		if (Distance(L_SEAL_POS, OWNER_ORG) < 1024)
		{
			SPELL_POS = TRACE_LINE;
		}
		else
		{
			SPELL_POS = "outofrange";
			EmitSound(GetOwner(), 1, "magic/energy1.wav", 10);
			SendColoredMessage(GetOwner(), "Out of range.");
		}
	}

	void spell1_strike()
	{
		if (!(true)) return;
		if (!(MELEE_ATTACK))
		{
			get_spell_pos();
			if (SPELL_POS != "outofrange")
			{
			}
			ClientEvent("new", "all", "effects/sfx_fire_staff", SPELL_POS);
			BURN_TARG_ORG = SPELL_POS;
			BURN_TARG_ORG += "z";
			string DOT_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
			XDoDamage(BURN_TARG_ORG, STAFF_RADIUS1, DOT_FIRE, 0.01, GetOwner(), GetOwner(), "spellcasting.fire", "fire_effect");
		}
		else
		{
			if ((IsEntityAlive(param3)))
			{
			}
			if ((IsValidPlayer(param3)))
			{
				if (!(GAME_PVP))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetRelationship(param3) == "enemy")
			{
			}
			string DOT_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		}
		MELEE_ATTACK = 0;
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if (!(GAME_PVP))
			{
				if ((IsValidPlayer(param2)))
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			string DOT_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
			DOT_FIRE *= DOT_RATIO;
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE, "spellcasting.fire");
			if ((BURST_ATTACK))
			{
			}
			string MAX_HP = GetEntityMaxHealth(GetOwner());
			MAX_HP *= 3;
			MAX_HP = max(2000, min(10000, MAX_HP));
			if (GetEntityHealth(param2) < MAX_HP)
			{
			}
			string CUR_TARG = param2;
			string TARG_ORG = GetEntityOrigin(CUR_TARG);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
		}
	}

	void spell2_start()
	{
		PlayOwnerAnim("critical", ATK1_PANIM);
		// TODO: splayviewanim ent_me VANIM_SPELL2
	}

	void spell2_strike()
	{
		if (!(true)) return;
		if (GetEntityMP(GetOwner()) < MP_METEOR)
		{
			SendColoredMessage(GetOwner(), "Insufficient mana for Meteor.");
			EmitSound(GetOwner(), 1, "magic/energy1.wav", 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		get_spell_pos();
		if (!(SPELL_POS != "outofrange")) return;
		if (!(/* TODO: $get_under_sky */ $get_under_sky(SPELL_POS)))
		{
			SendColoredMessage(GetOwner(), "Can only summon Meteor under sky.");
			EmitSound(GetOwner(), 1, "magic/energy1.wav", 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string TRACE_START = SPELL_POS;
		string TRACE_END = SPELL_POS;
		TRACE_END += "z";
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		string METEOR_SPAWN = TRACE_LINE;
		METEOR_SPAWN += "z";
		GiveMP(GetOwner());
		SpawnNPC("monsters/summon/meteor_deployer", METEOR_SPAWN, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner())
	}

	void volcano_start()
	{
		PlayOwnerAnim("critical", ATK1_PANIM);
		// TODO: splayviewanim ent_me VANIM_SPELL2
	}

	void volcano_strike()
	{
		if (!(true)) return;
		get_spell_pos();
		if (!(SPELL_POS != "outofrange")) return;
		if ((VOLCANO_ON))
		{
			SendColoredMessage(GetOwner(), "Phlame's Staff can only sustain one volcano at a time.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityMP(GetOwner()) < MP_VOLCANO)
		{
			SendColoredMessage(GetOwner(), "Insufficient mana for Volcano.");
			EmitSound(GetOwner(), 1, "magic/energy1.wav", 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		VOLCANO_ON = 1;
		SpawnNPC("monsters/summon/preset_volcano", SPELL_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 0, 20, "spellcasting.fire"
		ScheduleDelayedEvent(20.0, "volcano_reset");
	}

	void volcano_reset()
	{
		VOLCANO_ON = 0;
	}

	void bitem_register_attacks()
	{
		int reg.attack.priority = 2;
		float reg.attack.chargeamt = 2.0;
		string reg.attack.type = ATK2_TYPE;
		string reg.attack.keys = ATK2_KEYS;
		string reg.attack.range = ATK2_RANGE;
		string reg.attack.dmg = ATK2_DMG;
		string reg.attack.dmg.range = ATK2_DMG_RANGE;
		string reg.attack.dmg.type = ATK2_DMG_TYPE;
		string reg.attack.energydrain = ATK2_STAMINA;
		string reg.attack.stat = ATK2_SKILL;
		string reg.attack.hitchance = ATK2_ACCURACY;
		string reg.attack.delay.strike = ATK2_DELAY_STRIKE;
		string reg.attack.delay.end = ATK2_DURATION;
		string reg.attack.ofs.startpos = ATK2_OFS;
		string reg.attack.ofs.aimang = ATK2_ANG;
		string reg.attack.callback = "volcano";
		string reg.attack.noise = ATK2_NOISE;
		string reg.attack.mpdrain = ATK2_MPDRAIN;
		string reg.attack.dmg.multi = ATK2_DMG_MULTI;
		string reg.attack.noautoaim = ATK2_NO_AUTOAIM;
		string reg.attack.reqskill = ATK2_SKILL_LEVEL;
		reg.attack.reqskill += ATK2_ADD_SKILL_REQ;
		if ((ATK2_IS_PROJECTILE))
		{
			string reg.attack.ammodrain = ATK2_AMMODRAIN;
			string reg.attack.projectile = ATK2_PROJECTILE;
			string reg.attack.COF = ATK2_COF;
		}
		RegisterAttack();
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_BURST_ATTEMPT)) return;
		NEXT_BURST_ATTEMPT = GetGameTime();
		NEXT_BURST_ATTEMPT += 1.0;
		if (GetEntityMP(GetOwner()) < MP_BURST)
		{
			SendColoredMessage(GetOwner(), "Insufficient mana for flame burst.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_BURST)) return;
		NEXT_BURST = GetGameTime();
		NEXT_BURST += 5.0;
		IN_BURST_ATTACK = 1;
		// TODO: splayviewanim ent_me VANIM_BURST
		GiveMP(GetOwner());
		ScheduleDelayedEvent(1.0, "do_burst_attack");
	}

	void do_burst_attack()
	{
		BURST_ORG = GetEntityOrigin(GetOwner());
		BURST_ORG = "z";
		ClientEvent("new", "all", "effects/sfx_flame_repulse", BURST_ORG);
		BURST_ATTACK = 1;
		ScheduleDelayedEvent(0.1, "end_burst_attack");
		BURST_ORG += "z";
		string DOT_FIRE = GetSkillLevel(GetOwner(), "spellcasting.fire");
		DOT_FIRE *= 1.5;
		XDoDamage(BURST_ORG, STAFF_RADIUS2, DOT_FIRE, 0.01, GetOwner(), GetOwner(), "spellcasting.fire", "fire_effect");
	}

	void end_burst_attack()
	{
		BURST_ATTACK = 0;
	}

}

}
