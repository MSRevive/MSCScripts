#pragma context server

#include "items/base_melee.as"
#include "items/base_kick.as"

namespace MS
{

class BluntGauntletsBear : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_BEAR_ATTACK1;
	int ANIM_BEAR_ATTACK2;
	int ANIM_BEAR_LIFT1;
	int ANIM_HANDS_DOWN;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LOWER;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	int BEAR_CLAWS_VOFS;
	string BEAR_IMAGE_ID;
	int BEAR_MODE;
	int DRAIN_RATE;
	string FISTS_LAST_ATTACK;
	float FREQ_BEAR_ATTACK;
	float FREQ_BEAR_IDLE;
	float FREQ_BEAR_RAWR;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	float MELEE_DELAY_BEAR;
	int MELEE_DMG;
	int MELEE_DMG_BEAR;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_OVERRIDE;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	int MELEE_RANGE_BEAR;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string NEXT_BEAR_IDLE;
	string NEXT_RIGHT_CLICK;
	int NO_IDLE;
	string PLAYERANIM_AIM;
	string PUNCH_ATTACK;
	string SOUND_BEAR_ATTACK1;
	string SOUND_BEAR_ATTACK2;
	string SOUND_BEAR_ATTACK3;
	string SOUND_BEAR_HITWALL1;
	string SOUND_BEAR_HITWALL2;
	string SOUND_BEAR_IDLE1;
	string SOUND_BEAR_IDLE2;
	string SOUND_BEAR_IDLE3;
	string SOUND_BEAR_TRANSFORM_ON;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWING;
	string SOUND_SWIPE;

	BluntGauntletsBear()
	{
		BASE_LEVEL_REQ = 30;
		DRAIN_RATE = -8;
		NO_IDLE = 1;
		MELEE_OVERRIDE = 1;
		ANIM_HANDS_DOWN = 0;
		ANIM_LIFT1 = 3;
		ANIM_LOWER = 4;
		ANIM_IDLE1 = 2;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 5;
		ANIM_ATTACK2 = 6;
		ANIM_SHEATH = 5;
		MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		MODEL_VIEW_IDX = 6;
		MODEL_BODY_OFS = 58;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MELEE_DMG = 190;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 0.85;
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.3;
		MELEE_ATK_DURATION = 0.9;
		MELEE_RANGE_BEAR = 80;
		MELEE_DELAY_BEAR = 0.3;
		MELEE_DMG_BEAR = 1000;
		MELEE_STAT = "martialarts";
		MELEE_SOUND = "weapons/swingsmall.wav";
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.0;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
		SOUND_SWING = "weapons/swingsmall.wav";
		ANIM_PREFIX = "standard";
		PLAYERANIM_AIM = "fists";
		SOUND_BEAR_IDLE1 = "monsters/bear/c_bear_yes.wav";
		SOUND_BEAR_IDLE2 = "monsters/bear/c_bear_bat1.wav";
		SOUND_BEAR_IDLE3 = "monsters/bear/c_bear_bat2.wav";
		SOUND_BEAR_TRANSFORM_ON = "monsters/bear/c_beardire_bat1.wav";
		SOUND_BEAR_ATTACK1 = "monsters/bear/c_bear_atk1.wav";
		SOUND_BEAR_ATTACK2 = "monsters/bear/c_bear_atk2.wav";
		SOUND_BEAR_ATTACK3 = "monsters/bear/c_bear_atk3.wav";
		FREQ_BEAR_IDLE = Random(3.0, 8.0);
		SOUND_BEAR_HITWALL1 = "debris/bustconcrete1.wav";
		SOUND_BEAR_HITWALL2 = "debris/bustconcrete2.wav";
		FREQ_BEAR_RAWR = Random(3.0, 10.0);
		BEAR_CLAWS_VOFS = 1;
		FREQ_BEAR_ATTACK = 0.75;
		ANIM_BEAR_ATTACK1 = 5;
		ANIM_BEAR_ATTACK2 = 6;
		ANIM_BEAR_LIFT1 = 1;
	}

	void game_precache()
	{
		Precache("monsters/companion/bear_image");
		Precache(SOUND_BEAR_IDLE1);
		Precache(SOUND_BEAR_IDLE2);
		Precache(SOUND_BEAR_IDLE3);
		Precache(SOUND_BEAR_TRANSFORM_ON);
		Precache(SOUND_BEAR_HITWALL1);
		Precache(SOUND_BEAR_HITWALL2);
	}

	void weapon_spawn()
	{
		SetName("Bear Claws");
		SetDescription("Magical claws enchanted with the spirit of a great bear");
		SetWeight(3);
		SetSize(1);
		SetValue(3000);
		SetHand("both");
		SetHUDSprite("hand", 138);
		SetHUDSprite("trade", 138);
	}

	void weapon_deploy()
	{
		SetModelBody(0, MODEL_BODY_OFS);
		PlayViewAnim(ANIM_HANDS_DOWN);
		if (!(BEAR_MODE)) return;
		bear_transformation_end();
	}

	void melee_start()
	{
		if ((BEAR_MODE))
		{
			CallExternal(BEAR_IMAGE_ID, "ext_attack");
			// PlayRandomSound from: SOUND_BEAR_ATTACK1, SOUND_BEAR_ATTACK2, SOUND_BEAR_ATTACK3
			array<string> sounds = {SOUND_BEAR_ATTACK1, SOUND_BEAR_ATTACK2, SOUND_BEAR_ATTACK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((BEAR_MODE)) return;
		if (PUNCH_ATTACK == 0)
		{
			string l.punch_anim = "stance_normal_lowjab_r1";
			PUNCH_ATTACK = 1;
			PlayViewAnim(ANIM_ATTACK1);
		}
		else
		{
			if (PUNCH_ATTACK == 1)
			{
				string l.punch_anim = "stance_normal_lowjab_r2";
				PUNCH_ATTACK = 0;
				PlayViewAnim(ANIM_ATTACK2);
			}
		}
		PlayOwnerAnim("once", l.punch_anim);
		EmitSound(GetOwner(), 3, SOUND_SWING, 5);
		FISTS_LAST_ATTACK = GetGameTime();
		punch1_done();
	}

	void punch1_done()
	{
		if (!(FISTS_LAST_ATTACK)) return;
		float l_elapsedtime = GetGameTime();
		l_elapsedtime -= FISTS_LAST_ATTACK;
		if (!(l_elapsedtime > 5)) return;
		PlayViewAnim(ANIM_LOWER);
		FISTS_LAST_ATTACK = 0;
	}

	void hitwall()
	{
		if (!(BEAR_MODE))
		{
			// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
			array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_BEAR_HITWALL1, SOUND_BEAR_HITWALL2
			array<string> sounds = {SOUND_BEAR_HITWALL1, SOUND_BEAR_HITWALL2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_RIGHT_CLICK)) return;
		NEXT_RIGHT_CLICK = GetGameTime();
		NEXT_RIGHT_CLICK += 1.0;
		ScheduleDelayedEvent(0.1, "bear_mode_toggle");
	}

	void bear_mode_toggle()
	{
		if (!(BEAR_MODE))
		{
			if (GetEntityMP(GetOwner()) < 30)
			{
				SendColoredMessage(GetOwner(), "Bear Claws: Not enough mana to transform.");
			}
			else
			{
				if (GetSkillLevel(GetOwner(), "spellcasting") < 20)
				{
					SendColoredMessage(GetOwner(), "Bear Claws: You lack the magical talent to activate this item. Spellcasting:20");
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				ScheduleDelayedEvent(0.1, "bear_transformation");
			}
		}
		else
		{
			ScheduleDelayedEvent(0.1, "bear_transformation_end");
		}
	}

	void bear_transformation()
	{
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int IS_WIELDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int IS_WIELDED = 1;
		}
		if (!(IS_WIELDED)) return;
		// TODO: setviewmodelprop ent_me model none
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 1);
		// svplaysound: svplaysound 0 10 SOUND_BEAR_TRANSFORM_ON
		EmitSound(0, 10, SOUND_BEAR_TRANSFORM_ON);
		BEAR_MODE = 1;
		bear_loop();
		if (!(true)) return;
		SpawnNPC("monsters/companion/bear_image", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		BEAR_IMAGE_ID = GetEntityIndex(m_hLastCreated);
		CallExternal(GetOwner(), "ext_bear_mode", BEAR_IMAGE_ID);
	}

	void bear_transformation_end()
	{
		if (!(true)) return;
		if (!(BEAR_MODE)) return;
		BEAR_MODE = 0;
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int IS_WIELDED = 1;
		}
		if (GetEntityIndex(GetOwner()) == GetEntityProperty(GetOwner(), "scriptvar"))
		{
			int IS_WIELDED = 1;
		}
		if (param1 != "removed")
		{
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
		}
		if ((IsEntityAlive(GetOwner())))
		{
			CallExternal(GetOwner(), "ext_bear_mode_end", 1);
			CallExternal(BEAR_IMAGE_ID, "remove_bear");
			if ((IS_WIELDED))
			{
			}
			// TODO: setviewmodelprop ent_me model MODEL_VIEW
			// TODO: setviewmodelprop ent_me submodel MODEL_VIEW_IDX
			if (param1 != "removed")
			{
				ScheduleDelayedEvent(0.1, "sv_lift_arms");
			}
		}
		else
		{
			if (((BEAR_IMAGE_ID !is null)))
			{
				CallExternal(BEAR_IMAGE_ID, "ext_bear_die", "from_gauntlets");
			}
		}
	}

	void sv_lift_arms()
	{
		// TODO: splayviewanim ent_me ANIM_LIFT1
	}

	void bear_loop()
	{
		if (!(true)) return;
		if (!(BEAR_MODE)) return;
		if (!(IsEntityAlive(GetOwner())))
		{
			bear_transformation_end();
		}
		if (!(IsEntityAlive(GetOwner()))) return;
		if (GetEntityMP(GetOwner()) > 0)
		{
			GiveMP(GetOwner());
		}
		if (GetEntityMP(GetOwner()) <= 1)
		{
			SendColoredMessage(GetOwner(), "Bear Claws: You've run out of mana!");
			bear_transformation_end();
			int ExIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ScheduleDelayedEvent(0.5, "bear_loop");
		if (GetGameTime() > NEXT_BEAR_IDLE)
		{
			NEXT_BEAR_IDLE = GetGameTime();
			NEXT_BEAR_IDLE += FREQ_BEAR_IDLE;
			// PlayRandomSound from: SOUND_BEAR_IDLE1, SOUND_BEAR_IDLE2, SOUND_BEAR_IDLE3
			array<string> sounds = {SOUND_BEAR_IDLE1, SOUND_BEAR_IDLE2, SOUND_BEAR_IDLE3};
			EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void game_fall()
	{
		string WORLD_OFS = MODEL_BODY_OFS;
		WORLD_OFS += 1;
		SetModelBody(0, WORLD_OFS);
	}

	void bweapon_effect_remove()
	{
		LogDebug("Item Removed");
		bear_transformation_end("removed");
	}

}

}
