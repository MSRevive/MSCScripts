#pragma context server

#include "items/blunt_base_twohanded.as"
#include "items/base_vampire.as"

namespace MS
{

class BluntMithral : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_IDLE2;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_RAGE;
	int BASE_LEVEL_REQ;
	float DEMON_ATK_DURATION;
	int DEMON_CHARGES;
	int DEMON_DMG;
	float DEMON_DMG_DELAY;
	float DEMON_DURATION;
	int DEMON_RAGE_ON;
	string LAST_ERR;
	string LAST_RAGE;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int M_ATTACK;
	int OUT_O_CHARGES;
	float RAGE_DELAY;
	string SOUND_DEATH;
	string SOUND_RAGE;
	string SOUND_RAGE1;
	string SOUND_RAGE2;
	string SOUND_RAGE3;
	string SOUND_RAGE4;
	float VAMPIRE_RATIO;

	BluntMithral()
	{
		DEMON_CHARGES = 4;
		VAMPIRE_RATIO = 0.75;
		ANIM_LIFT1 = 15;
		ANIM_IDLE1 = 16;
		ANIM_IDLE2 = 17;
		ANIM_IDLE_TOTAL = 2;
		ANIM_ATTACK1 = 18;
		ANIM_ATTACK2 = 19;
		ANIM_ATTACK3 = 20;
		ANIM_RAGE = 21;
		BASE_LEVEL_REQ = 20;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 6;
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 10;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.1;
		DEMON_DMG_DELAY = 0.25;
		DEMON_ATK_DURATION = 0.7;
		MELEE_ENERGY = 2;
		MELEE_DMG = 400;
		DEMON_DMG = 750;
		MELEE_DMG_RANGE = 40;
		MELEE_ACCURACY = 0.75;
		MELEE_PARRY_AUGMENT = 0.2;
		SOUND_RAGE = "monsters/bludgeon/bludgeon_gaz_bat2.wav";
		SOUND_RAGE1 = "monsters/bludgeon/bludgeon_gaz_bat1.wav";
		SOUND_RAGE2 = "monsters/bludgeon/bludgeon_gaz_answer.wav";
		SOUND_RAGE3 = "monsters/bludgeon/bludgeon_gaz_spell.wav";
		SOUND_RAGE4 = "monsters/bludgeon/bludgeon_gaz_pain.wav";
		SOUND_DEATH = "monsters/bludgeon/bludgeon_gaz_death.wav";
		DEMON_DURATION = 20.0;
		RAGE_DELAY = 40.0;
		MELEE_DMG_TYPE = "blunt";
	}

	void weapon_spawn()
	{
		SetName("Bludgeon Hammer");
		SetDescription("A massive Bludgeon hammer, its former owner's soul is imprisoned within");
		SetWeight(80);
		SetSize(10);
		SetValue(3750);
		SetHUDSprite("hand", 126);
		SetHUDSprite("trade", 126);
		M_ATTACK = 1;
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		if ((DEMON_RAGE_ON)) return;
		if (GetSkillLevel(GetOwner(), "spellcasting") < 12)
		{
			SendColoredMessage(GetOwner(), "Bludgeon Hammer: Insufficient magic skill for demonic rage.");
		}
		if (!(GetSkillLevel(GetOwner(), "spellcasting") >= 12)) return;
		LogDebug("rage game.time vs LAST_RAGE");
		if (GetGameTime() < LAST_RAGE)
		{
			int EXIT_SUB = 1;
			if (GetGameTime() > LAST_ERR)
			{
			}
			if (!(OUT_O_CHARGES))
			{
				SendColoredMessage(GetOwner(), "Bludgeon Rage: You've not yet recovered from the previous bludgeon rage");
			}
			if ((OUT_O_CHARGES))
			{
				SendColoredMessage(GetOwner(), "Bludgeon Rage: Out of charges");
			}
			LAST_ERR = GetGameTime();
			LAST_ERR += 2.0;
		}
		if ((EXIT_SUB)) return;
		LAST_RAGE = GetGameTime();
		LAST_RAGE += RAGE_DELAY;
		CallExternal(GAME_MASTER, "item_demon_rage", GetEntityIndex(GetOwner()), GetEntityIndex(GetOwner()), DEMON_CHARGES);
	}

	void demon_rage()
	{
		SendPlayerMessage("Bludgeon", "rage: " + int(param1) + " charges remaining");
		// TODO: splayviewanim ent_me ANIM_RAGE
		EmitSound(GetOwner(), 0, SOUND_RAGE, 10);
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
		string L_DEMON_DMG = DEMON_DMG;
		L_DEMON_DMG *= 2.0;
		SetAttackProp("ent_me", 1);
		DEMON_RAGE_ON = 1;
		DEMON_DURATION("demon_rage_end");
		demon_rage_loop();
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, DEMON_DURATION, DEMON_DURATION);
	}

	void demon_rage_loop()
	{
		if (!(DEMON_RAGE_ON)) return;
		Effect("screenfade", GetOwner(), 2.0, 1.0, Vector3(255, 0, 0), RandomInt(64, 128), "fadin");
		if (RandomInt(1, 10) == 1)
		{
			// PlayRandomSound from: SOUND_RAGE1, SOUND_RAGE2, SOUND_RAGE3, SOUND_RAGE4
			array<string> sounds = {SOUND_RAGE1, SOUND_RAGE2, SOUND_RAGE3, SOUND_RAGE4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		ScheduleDelayedEvent(1.0, "demon_rage_loop");
	}

	void demon_rage_end()
	{
		DEMON_RAGE_ON = 0;
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
		string L_MELEE_DMG = MELEE_DMG;
		L_MELEE_DMG *= 2.0;
		SetAttackProp("ent_me", 1);
	}

	void demon_rage_maxed()
	{
		OUT_O_CHARGES = 1;
		SendColoredMessage(GetOwner(), "Bludgeon Rage: Out of charges");
	}

	void game_dodamage()
	{
		if (!(DEMON_RAGE_ON)) return;
		if (!(param1)) return;
		string HEAL_AMT = GetEntityProperty(param2, "scriptvar");
		HEAL_AMT *= VAMPIRE_RATIO;
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 60, 1, 1);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param2), HEAL_AMT);
	}

	void melee_strike()
	{
		if (!(DEMON_RAGE_ON)) return;
		if (!(IsEntityAlive(param3))) return;
		if (GetEntityMaxHealth(param3) < 3000)
		{
			int L_R = RandomInt(50, 200);
			if (RandomInt(1, 2) == 1)
			{
				string L_R = /* TODO: $neg */ $neg(L_R);
			}
			string PUSH_VEL = /* TODO: $relvel */ $relvel(L_R, 300, 10);
			AddVelocity(GetEntityIndex(param3), PUSH_VEL);
		}
	}

	void melee_start()
	{
		if (!(DEMON_RAGE_ON))
		{
			// TODO: splayviewanim ent_me MELEE_VIEWANIM_ATK
			if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
			{
				PlayOwnerAnim("once", PLAYERANIM_SWING);
			}
			MELEE_SOUND_DELAY("melee_playsound");
		}
		if (!(DEMON_RAGE_ON)) return;
		if (M_ATTACK == 1)
		{
			// TODO: splayviewanim ent_me ANIM_ATTACK1
		}
		if (M_ATTACK == 2)
		{
			// TODO: splayviewanim ent_me ANIM_ATTACK2
		}
		if (M_ATTACK == 3)
		{
			// TODO: splayviewanim ent_me ANIM_ATTACK3
			M_ATTACK = 1;
		}
		M_ATTACK += 1;
	}

	void item_idle()
	{
		if ((DEMON_RAGE_ON)) return;
		if (("game.item.attacking")) return;
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (!("baseitem.canidle")) return;
		int l.anim = RandomInt(1, ANIM_IDLE_TOTAL);
		if (l.anim == 1)
		{
			PlayViewAnim(ANIM_IDLE1);
		}
		else
		{
			if (l.anim == 2)
			{
				PlayViewAnim(ANIM_IDLE2);
			}
			else
			{
				if (l.anim == 3)
				{
					PlayViewAnim(ANIM_IDLE3);
				}
				else
				{
					if (l.anim == 4)
					{
						PlayViewAnim(ANIM_IDLE4);
					}
					else
					{
						if (l.anim == 5)
						{
							PlayViewAnim(ANIM_IDLE5);
						}
					}
				}
			}
		}
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		DEMON_RAGE_ON = 0;
		EmitSound(GetOwner(), 0, "monsters/bludgeon/bludgeon_gaz_death.wav", 10);
	}

	void game_removefromowner()
	{
		if ((DEMON_RAGE_ON))
		{
			demon_rage_end();
		}
	}

	void game_putinpack()
	{
		if ((DEMON_RAGE_ON))
		{
			demon_rage_end();
		}
	}

}

}
