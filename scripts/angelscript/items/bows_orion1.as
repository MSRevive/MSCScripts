#pragma context server

#include "items/bows_base.as"

namespace MS
{

class BowsOrion1 : CGameScript
{
	int AM_CHARGING;
	string BALL_DMG;
	int BALL_SIZE;
	string BALOON_ON;
	string BOW_CL_IDX;
	string MAX_LEVEL;
	string NEXT_ATTACK;
	string NEXT_CHARGE;
	int TALLY_ACTIVE;

	BowsOrion1()
	{
		const int MODEL_VIEW_IDX = 3;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const string MODEL_WEAR = "weapons/p_weapons2.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "longbow";
		const int BASE_LEVEL_REQ = 15;
		const int MODEL_BODY_OFS = 48;
		const string BOLT_SPRITE = "nhth1.spr";
		const int CUSTOM_ATTACK = 1;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 3, 0);
		const int MP_DRAIN = 4;
		const float CHARGE_RATE = 0.3;
		const int DMG_MULTI = 10;
		const int NOT_WEARABLE = 1;
	}

	void game_precache()
	{
		Precache("items/proj_mana2");
	}

	void bow_spawn()
	{
		SetName("Orion Bow");
		SetDescription("This enchanted bow fires spheres of pure mana");
		SetWeight(30);
		SetSize(1);
		SetValue(1000);
		SetHUDSprite("trade", 108);
		BALL_SIZE = 0;
		custom_register();
	}

	void custom_register()
	{
		string reg.attack.type = "charge-throw-projectile";
		string reg.attack.keys = "+attack1";
		string reg.attack.hold_min&max = "0.1;0.1";
		string reg.attack.dmg.type = "magic";
		int reg.attack.range = 200;
		int reg.attack.energydrain = 1;
		string reg.attack.stat = "archery";
		int reg.attack.COF = 0;
		string reg.attack.projectile = "none";
		int reg.attack.priority = 0;
		int reg.attack.delay.strike = 0;
		int reg.attack.delay.end = 0;
		string reg.attack.ofs.startpos = RANGED_STARTPOS;
		string reg.attack.ofs.aimang = RANGED_AIMANGLE;
		int reg.attack.ammodrain = 0;
		string reg.attack.callback = "ranged";
		int reg.attack.noise = 1000;
		string reg.attack.reqskill = BASE_LEVEL_REQ;
	}

	void OnDeploy() override
	{
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 1.0;
	}

	void game_attack1_down()
	{
		if (!(GetGameTime() > NEXT_ATTACK)) return;
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 0.75;
		if (!(AM_CHARGING))
		{
			if (GetEntityMP(GetOwner()) > MP_DRAIN)
			{
				PlayViewAnim(ANIM_FIRE);
				if ((CanAttack(GetOwner())))
				{
				}
				AM_CHARGING = 1;
				if ((true))
				{
				}
				BALL_SIZE = 0;
				BALL_DMG = 0;
				PlayOwnerAnim("critical", "bow_pull");
				if (!(TALLY_ACTIVE))
				{
					TALLY_ACTIVE = 1;
					tally_stretch();
				}
			}
			else
			{
				SendColoredMessage(GetOwner(), "You lack the mana to start charging a mana ball.");
				CancelAttack();
			}
		}
	}

	void tally_stretch()
	{
		if (!(TALLY_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "tally_stretch");
		if (!(AM_CHARGING)) return;
		if (!(GetGameTime() > NEXT_CHARGE)) return;
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += CHARGE_RATE;
		BALL_DMG = BALL_SIZE;
		BALL_DMG *= DMG_MULTI;
		if ((MAX_LEVEL)) return;
		BALL_SIZE += 1;
		if (!(BALOON_ON))
		{
			if (BALL_SIZE > 0)
			{
			}
			BALOON_ON = 1;
			ClientEvent("new", "all", "items/bows_orion1_cl", GetEntityIndex(GetOwner()));
			BOW_CL_IDX = "game.script.last_sent_id";
		}
		else
		{
			ClientEvent("update", "all", BOW_CL_IDX, "add_charge");
		}
		// TODO: splayviewanim ent_me 2
		if (GetEntityMP(GetOwner()) <= MP_DRAIN)
		{
			MAX_LEVEL = 1;
			SendColoredMessage(GetOwner(), "Orion Bow: Insufficient Mana");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (BALL_SIZE >= 10)
		{
			BALL_SIZE = 10;
			MAX_LEVEL = 1;
		}
		if ((MAX_LEVEL))
		{
			SendPlayerMessage("Manaball", "has reached maximum charge");
		}
		GiveMP(/* TODO: $neg */ $neg(MP_DRAIN));
		CallExternal(GetOwner(), "mana_drain");
		// svplaysound: svplaysound 1 3 ambience/alien_humongo.wav
		EmitSound(1, 3, "ambience/alien_humongo.wav");
		BALL_DMG = BALL_SIZE;
		BALL_DMG *= DMG_MULTI;
		if (GetSkillLevel(GetOwner(), "archery.proficiency") < BASE_LEVEL_REQ)
		{
			MAX_LEVEL = 1;
			BALL_DMG = 0.05;
		}
	}

	void game__attack1()
	{
		PlayViewAnim(0);
		if (!(AM_CHARGING)) return;
		NEXT_ATTACK = GetGameTime();
		NEXT_ATTACK += 0.2;
		if ((true))
		{
			string L_VEL = /* TODO: $relvel */ $relvel(GetEntityProperty(GetOwner(), "viewangles"), 0, ",", 200, ",", 0);
			SpawnNPC("items/proj_mana2", GetEntityProperty(GetOwner(), "eyepos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_VEL, BALL_SIZE, BALL_DMG, "archery"
		}
		reset_atk();
	}

	void game_fall()
	{
		reset_atk();
	}

	void reset_atk()
	{
		ClientEvent("update", "all", BOW_CL_IDX, "charge_release");
		BALOON_ON = 0;
		AM_CHARGING = 0;
		BALL_SIZE = 0;
		BALL_DMG = 0;
		MAX_LEVEL = 0;
		TALLY_ACTIVE = 0;
	}

	void game_putinpack()
	{
		cancel_attack();
	}

	void cancel_attack()
	{
		if (!(AM_CHARGING)) return;
		ClientEvent("update", "all", BOW_CL_IDX, "charge_release");
		reset_atk();
	}

}

}
