#pragma context server

#include "items/base_weapon_new.as"

namespace MS
{

class BluntStaffA : CGameScript
{
	int AM_CHARGING;
	int ATK1_ACCURACY;
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
	int BEAM_ON;
	int BEAM_READY;
	int BWEAPON_CUSTOM_HITWALL;
	string BWEAPON_DESC;
	string BWEAPON_HANDS;
	int BWEAPON_INV_SPRITE_IDX;
	string BWEAPON_NAME;
	int BWEAPON_VALUE;
	int BWEAPON_WEIGHT;
	string CL_DARK_FX;
	string CL_FX_ID;
	string CL_STAFF_EYES;
	int CUR_CHARGE;
	string DMG_BEAM;
	float FINAL_CHARGE;
	float FREQ_CHARGE;
	string MAX_CHARGE;
	int MP_BURST;
	int MP_GCOD;
	int MP_LCOD;
	int MP_WRAITH;
	string NEXT_AF_UNDERSKILL_WARN;
	string NEXT_CHARGE;
	string OWNER_SKILL;
	string PANIM_EXT;
	string PANIM_IDLE;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	int PMODEL_IDX_HAND_LEFT;
	int PMODEL_IDX_HAND_RIGHT;
	string SOUND_BEAM_LOOP;
	string SOUND_CHARGE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_MELEE;
	int VANIM_BEAM_IDLE;
	int VANIM_BEAM_START;
	int VANIM_BURST;
	int VANIM_CHARGE_END;
	int VANIM_CHARGE_FAIL;
	int VANIM_CHARGE_START;
	int VANIM_DRAW;
	int VANIM_IDLE;
	int VANIM_MELEE;
	int VANIM_SPELL1;
	int VANIM_SPELL2;
	string VMODEL_FILE;
	int VMODEL_IDX;
	string WANIM_FLOOR;
	string WANIM_HAND;

	BluntStaffA()
	{
		Precache("calflame_small.spr");
		BASE_LEVEL_REQ = 25;
		FREQ_CHARGE = 1.5;
		FINAL_CHARGE = 3.5;
		MP_BURST = 30;
		MP_LCOD = 30;
		MP_GCOD = 100;
		MP_WRAITH = 50;
		BWEAPON_NAME = "Dark Staff";
		BWEAPON_DESC = "Greater staff of Affliction";
		BWEAPON_WEIGHT = 60;
		BWEAPON_VALUE = 7000;
		BWEAPON_INV_SPRITE_IDX = 72;
		BWEAPON_HANDS = "both";
		VMODEL_FILE = "viewmodels/v_polearms.mdl";
		VMODEL_IDX = 15;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 33;
		PMODEL_IDX_HANDS = 32;
		PMODEL_IDX_HAND_RIGHT = 32;
		PMODEL_IDX_HAND_LEFT = 32;
		PANIM_IDLE = "aim_blunt";
		PANIM_EXT = "blunt";
		VANIM_IDLE = 21;
		VANIM_DRAW = 21;
		VANIM_MELEE = 22;
		VANIM_SPELL1 = 23;
		VANIM_SPELL2 = 24;
		VANIM_BURST = 25;
		VANIM_BEAM_START = 26;
		VANIM_BEAM_IDLE = 27;
		VANIM_CHARGE_START = 28;
		VANIM_CHARGE_END = 29;
		VANIM_CHARGE_FAIL = 30;
		WANIM_FLOOR = "standard_floor_idle";
		WANIM_HAND = "standard_idle";
		ATK1_RANGE = 0;
		ATK1_DMG = 0;
		ATK1_DMG_RANGE = 0;
		ATK1_DMG_TYPE = "target";
		ATK1_STAMINA = 0;
		ATK1_SKILL = "spellcasting.affliction";
		ATK1_ACCURACY = 80;
		ATK1_DELAY_STRIKE = 0.6;
		ATK1_DURATION = 1.0;
		ATK1_CALLBACK = "beam";
		ATK1_PANIM = "swing_blunt";
		ATK1_VANIM = VANIM_SPELL1;
		SOUND_MELEE = "weapons/cbar_miss1.wav";
		ATK2_DMG = 0;
		ATK2_RANGE = 0;
		ATK2_VANIM = VANIM_SPELL2;
		ATK2_PANIM = "sword_double_swing";
		ATK2_CALLBACK = "spell2";
		BWEAPON_CUSTOM_HITWALL = 1;
		SOUND_HITWALL1 = "none";
		SOUND_HITWALL2 = "none";
		SOUND_BEAM_LOOP = "ambience/dronemachine1.wav";
		SOUND_CHARGE = "magic/spawn.wav";
		CL_FX_ID = "unset";
	}

	void cbeam_start()
	{
		PlayViewAnim(VANIM_BEAM_START);
		ScheduleDelayedEvent(0.6, "setup_beam");
	}

	void setup_beam()
	{
		if ((BEAM_ON)) return;
		BEAM_ON = 1;
		PlayViewAnim(VANIM_BEAM_IDLE);
		if (!(true)) return;
		ClientEvent("new", "all", "items/blunt_staff_a_cl", GetEntityIndex(GetOwner()));
		CL_FX_ID = "game.script.last_sent_id";
		DMG_BEAM = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") < 20)
		{
			DMG_BEAM *= 0.1;
			if (GetGameTime() > NEXT_AF_UNDERSKILL_WARN)
			{
			}
			NEXT_AF_UNDERSKILL_WARN = GetGameTime();
			NEXT_AF_UNDERSKILL_WARN += 5.0;
			SendColoredMessage(GetOwner(), GetEntityName(GetOwner()) + " underskilled req:affliction[20]");
		}
		// svplaysound: svplaysound 3 10 SOUND_BEAM_LOOP
		EmitSound(3, 10, SOUND_BEAM_LOOP);
		if (!(true)) return;
		beam_loop();
	}

	void beam_loop()
	{
		if (!(BEAM_ON)) return;
		if (GetActiveItem(GetOwner()) != GetEntityIndex(GetOwner()))
		{
			int END_BEAM = 1;
		}
		if (!(CanAttack(GetOwner())))
		{
			int END_BEAM = 1;
		}
		if (!(IsEntityAlive(GetOwner())))
		{
			int END_BEAM = 1;
		}
		if ((END_BEAM))
		{
			end_beam();
			CallClientItemEvent(GetOwner(), "end_beam");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.5, "beam_loop");
		string BEAM_END = GetEntityProperty(GetOwner(), "eyepos");
		string OWNER_VIEWANG = GetEntityProperty(GetOwner(), "viewangles");
		BEAM_END += /* TODO: $relpos */ $relpos(OWNER_VIEWANG, Vector3(0, 1280, 0));
		XDoDamage(GetEntityProperty(GetOwner(), "eyepos"), BEAM_END, DMG_BEAM, 100, GetOwner(), GetOwner(), "spellcasting.affliction", "dark", "nodecal;dmgevent:*beam");
		if ((CanAttack(GetOwner()))) return;
		end_beam();
	}

	void beam_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetEntityMP(GetOwner()) < GetEntityProperty(GetOwner(), "maxmp"))) return;
		GiveMP(GetOwner());
	}

	void game_attack1_down()
	{
		if ((true))
		{
			if (!(CanAttack(GetOwner())))
			{
				int EXIT_SUB = 1;
			}
			if (GetActiveItem(GetOwner()) != GetEntityIndex(GetOwner()))
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			if (!("game.localplayer.canattack"))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((AM_CHARGING)) return;
		if ((BEAM_ON)) return;
		if ((BEAM_READY)) return;
		BEAM_READY = 1;
		cbeam_start();
	}

	void game__attack1()
	{
		if (!(BEAM_ON)) return;
		end_beam();
	}

	void end_beam()
	{
		PlayViewAnim(VANIM_IDLE);
		BEAM_ON = 0;
		BEAM_READY = 0;
		if (!(true)) return;
		// svplaysound: svplaysound 3 0 SOUND_BEAM_LOOP
		EmitSound(3, 0, SOUND_BEAM_LOOP);
		ClientEvent("update", "all", CL_FX_ID, "end_fx");
		CL_FX_ID = "unset";
	}

	void bweapon_effect_remove()
	{
		BEAM_READY = 0;
		if ((BEAM_ON))
		{
			end_beam();
		}
		if ((AM_CHARGING))
		{
			end_charge();
		}
	}

	void game_hitworld()
	{
		if ((BEAM_ON)) return;
	}

	void game_+attack2()
	{
		if ((true))
		{
			if (!(CanAttack(GetOwner())))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			if (!("game.localplayer.canattack"))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (("game.item.attacking")) return;
		if ((BEAM_READY)) return;
		if ((BEAM_ON)) return;
		if (!(GetGameTime() > NEXT_CHARGE)) return;
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += 20.0;
		if (!(AM_CHARGING))
		{
			if ((true))
			{
			}
			// TODO: splayviewanim ent_me VANIM_CHARGE_START
		}
		AM_CHARGING = 1;
		CUR_CHARGE = 1;
		if ((true))
		{
			SetScriptFlags(GetOwner(), "add", "af_staff", "nopush", 1, -1, "none");
			ApplyEffect(GetOwner(), "effects/effect_tempnomove");
			OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.affliction");
			MAX_CHARGE = 0;
			if (OWNER_SKILL >= 25)
			{
				MAX_CHARGE = 1.5;
			}
			if (OWNER_SKILL >= 30)
			{
				MAX_CHARGE = 2.5;
			}
			if (OWNER_SKILL >= 35)
			{
				MAX_CHARGE = 3.5;
			}
			CallClientItemEvent(GetOwner(), "cl_set_maxcharge", MAX_CHARGE);
		}
		FREQ_CHARGE("add_charge");
		if (!(true)) return;
		if (OWNER_SKILL >= 25)
		{
			ScheduleDelayedEvent(0.75, "repulse_burst");
		}
		PlayOwnerAnim("critical", "aim_sword_double_idle");
		ClientEvent("new", GetOwner(), "items/blunt_staff_a_charge_cl", GetEntityIndex(GetOwner()));
		CL_STAFF_EYES = "game.script.last_sent_id";
	}

	void repulse_burst()
	{
		if (!(AM_CHARGING)) return;
		if (GetEntityMP(GetOwner()) < MP_BURST)
		{
			SendColoredMessage(GetOwner(), "Dark Staff: Not enough mana for Dark Burst");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		GiveMP(GetOwner());
		string BURST_DMG = OWNER_SKILL;
		CallExternal(GetOwner(), "ext_repel_burst", BURST_DMG, 128, 0, "dark_effect", "spellcasting.affliction", 800, 0);
		string SPELL_POS = GetEntityOrigin(GetOwner());
		SPELL_POS = "z";
		ClientEvent("new", "all", "effects/sfx_dark_burst", SPELL_POS, 8.0);
		CL_DARK_FX = "game.script.last_sent_id";
	}

	void cl_set_maxcharge()
	{
		MAX_CHARGE = param1;
	}

	void add_charge()
	{
		if (!(AM_CHARGING)) return;
		if (!(CUR_CHARGE < MAX_CHARGE)) return;
		CUR_CHARGE += 0.5;
		if (GetActiveItem(GetOwner()) != GetEntityIndex(GetOwner()))
		{
			int END_CHARGE = 1;
		}
		if (!(CanAttack(GetOwner())))
		{
			int END_CHARGE = 1;
		}
		if (!(IsEntityAlive(GetOwner())))
		{
			int END_CHARGE = 1;
		}
		if ((END_CHARGE))
		{
			end_charge();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		FREQ_CHARGE("add_charge");
		if (!(true)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		CallExternal(GetOwner(), "ext_repel_burst", 0, 128, 0, "none", "none", 300, (GetEntityMaxHealth(GetOwner()) * 3), GetEntityOrigin(GetOwner()));
		ClientEvent("update", GetOwner(), CL_STAFF_EYES, "add_charge_level", CUR_CHARGE);
		// PlayRandomSound from: "buttons/spark1.wav", "buttons/spark2.wav", "buttons/spark4.wav"
		array<string> sounds = {"buttons/spark1.wav", "buttons/spark2.wav", "buttons/spark4.wav"};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 5);
		if (CUR_CHARGE != int(CUR_CHARGE))
		{
			if (CUR_CHARGE < FINAL_CHARGE)
			{
				EmitSound(GetOwner(), 1, SOUND_CHARGE, 5);
			}
			if (CUR_CHARGE == FINAL_CHARGE)
			{
				EmitSound(GetOwner(), 1, SOUND_CHARGE, 10);
			}
		}
	}

	void game__attack2()
	{
		if (!(AM_CHARGING)) return;
		AM_CHARGING = 0;
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += 3.0;
		PlayViewAnim(VANIM_IDLE);
		LogDebug("staff_charge_finish CUR_CHARGE");
		if (!(true)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		end_charge();
		if (!(CanAttack(GetOwner()))) return;
		if ((EXIT_SUB)) return;
		if (CUR_CHARGE >= 1.5)
		{
			if (CUR_CHARGE < 2.5)
			{
			}
			LogDebug("lesser circle of death");
			if ((GetEntityProperty(GetOwner(), "scriptvar")))
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Can only maintain one Lesser Circle of Death.");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityMP(GetOwner()) < MP_LCOD)
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Insufficient mana for Lesser Circle of Death");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			GiveMP(GetOwner());
			string DMG_COD = GetSkillLevel(GetOwner(), "spellcasting.affliction");
			CallExternal(GetOwner(), "ext_lcod", GetEntityOrigin(GetOwner()), DMG_COD, 30.0);
		}
		if (CUR_CHARGE >= 2.5)
		{
			if (CUR_CHARGE < 3.5)
			{
			}
			LogDebug("greater circle of death");
			if ((GetEntityProperty(GetOwner(), "scriptvar")))
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Can only maintain one Greater Circle of Death.");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityMP(GetOwner()) < MP_GCOD)
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Insufficient mana for Greater Circle of Death");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			GiveMP(GetOwner());
			string DMG_COD = GetSkillLevel(GetOwner(), "spellcasting.affliction");
			CallExternal(GetOwner(), "ext_gcod", GetEntityOrigin(GetOwner()), DMG_COD, 30.0);
		}
		if (CUR_CHARGE == 3.5)
		{
			if ((GetEntityProperty(GetOwner(), "scriptvar")))
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Can only maintain one Lesser Wraith");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityMP(GetOwner()) < MP_WRAITH)
			{
				SendColoredMessage(GetOwner(), "Dark Staff: Insufficient mana for Lesser Wraith");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			GiveMP(GetOwner());
			string SUMMON_POS = GetEntityOrigin(GetOwner());
			SUMMON_POS = "z";
			string OWNER_YAW = GetEntityProperty(GetOwner(), "viewangles");
			string OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(OWNER_YAW);
			SUMMON_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 64, 0));
			SpawnNPC("monsters/summon/lesser_wraith", SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SUMMON_POS
		}
	}

	void end_charge()
	{
		if ((AM_CHARGING))
		{
			AM_CHARGING = 0;
			NEXT_CHARGE = GetGameTime();
			NEXT_CHARGE += 3.0;
			CallClientItemEvent(GetOwner(), "cl_end_charge");
		}
		if ((IsEntityAlive(GetOwner())))
		{
			SetScriptFlags(GetOwner(), "remove", "af_staff");
		}
		CallExternal(GetOwner(), "ext_end_tempnomove");
		ClientEvent("update", GetOwner(), CL_STAFF_EYES, "end_fx");
		ClientEvent("update", "all", CL_DARK_FX, "end_fx");
	}

	void cl_end_charge()
	{
		AM_CHARGING = 0;
	}

}

}
