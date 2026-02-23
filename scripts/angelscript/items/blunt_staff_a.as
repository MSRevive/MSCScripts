#pragma context server

#include "items/base_weapon_new.as"

namespace MS
{

class BluntStaffA : CGameScript
{
	int AM_CHARGING;
	int BEAM_ON;
	int BEAM_READY;
	string CL_DARK_FX;
	string CL_FX_ID;
	string CL_STAFF_EYES;
	int CUR_CHARGE;
	string DMG_BEAM;
	string MAX_CHARGE;
	string NEXT_AF_UNDERSKILL_WARN;
	string NEXT_CHARGE;
	string OWNER_SKILL;

	BluntStaffA()
	{
		Precache("calflame_small.spr");
		const int BASE_LEVEL_REQ = 25;
		const float FREQ_CHARGE = 1.5;
		const float FINAL_CHARGE = 3.5;
		const int MP_BURST = 30;
		const int MP_LCOD = 30;
		const int MP_GCOD = 100;
		const int MP_WRAITH = 50;
		const string BWEAPON_NAME = "Dark Staff";
		const string BWEAPON_DESC = "Greater staff of Affliction";
		const int BWEAPON_WEIGHT = 60;
		const int BWEAPON_VALUE = 7000;
		const int BWEAPON_INV_SPRITE_IDX = 72;
		const string BWEAPON_HANDS = "both";
		const string VMODEL_FILE = "viewmodels/v_polearms.mdl";
		const int VMODEL_IDX = 15;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 33;
		const int PMODEL_IDX_HANDS = 32;
		const int PMODEL_IDX_HAND_RIGHT = 32;
		const int PMODEL_IDX_HAND_LEFT = 32;
		const string PANIM_IDLE = "aim_blunt";
		const string PANIM_EXT = "blunt";
		const int VANIM_IDLE = 21;
		const int VANIM_DRAW = 21;
		const int VANIM_MELEE = 22;
		const int VANIM_SPELL1 = 23;
		const int VANIM_SPELL2 = 24;
		const int VANIM_BURST = 25;
		const int VANIM_BEAM_START = 26;
		const int VANIM_BEAM_IDLE = 27;
		const int VANIM_CHARGE_START = 28;
		const int VANIM_CHARGE_END = 29;
		const int VANIM_CHARGE_FAIL = 30;
		const string WANIM_FLOOR = "standard_floor_idle";
		const string WANIM_HAND = "standard_idle";
		const int ATK1_RANGE = 0;
		const int ATK1_DMG = 0;
		const int ATK1_DMG_RANGE = 0;
		const string ATK1_DMG_TYPE = "target";
		const int ATK1_STAMINA = 0;
		const string ATK1_SKILL = "spellcasting.affliction";
		const int ATK1_ACCURACY = 80;
		const float ATK1_DELAY_STRIKE = 0.6;
		const float ATK1_DURATION = 1.0;
		const string ATK1_CALLBACK = "beam";
		const string ATK1_PANIM = "swing_blunt";
		const string ATK1_VANIM = VANIM_SPELL1;
		const string SOUND_MELEE = "weapons/cbar_miss1.wav";
		const int ATK2_DMG = 0;
		const int ATK2_RANGE = 0;
		const string ATK2_VANIM = VANIM_SPELL2;
		const string ATK2_PANIM = "sword_double_swing";
		const string ATK2_CALLBACK = "spell2";
		const int BWEAPON_CUSTOM_HITWALL = 1;
		const string SOUND_HITWALL1 = "none";
		const string SOUND_HITWALL2 = "none";
		const string SOUND_BEAM_LOOP = "ambience/dronemachine1.wav";
		const string SOUND_CHARGE = "magic/spawn.wav";
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
			SendColoredMessage(GetOwner(), "GetEntityName(GetOwner()) underskilled req:affliction[20]");
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
		CallExternal(GetOwner(), "ext_repel_burst", 0, 128, 0, "none", "none", 300, /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()), GetEntityOrigin(GetOwner()));
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
