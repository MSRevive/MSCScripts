#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesSp : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	string AXE_DEPLOYED;
	string AXE_IDLE_COUNT;
	int BASE_LEVEL_REQ;
	int MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	int MP_CIRCLE_OF_WEBS;
	string NEXT_CIRCLE;
	string NEXT_IDLE;
	string NEXT_WEB;
	int RANGED_MP;
	string SOUND_SWIPE;
	float THROW_ATTACK_DELAY;

	AxesSp()
	{
		BASE_LEVEL_REQ = 25;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 9;
		MODEL_HANDS = "weapons/p_weapons4.mdl";
		MODEL_WORLD = "weapons/p_weapons4.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 57;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 3;
		MELEE_DMG = 375;
		MELEE_DMG_RANGE = 150;
		MELEE_DMG_TYPE = "slash";
		MELEE_ACCURACY = 65;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 25;
		RANGED_MP = 5;
		THROW_ATTACK_DELAY = 0.5;
		MP_CIRCLE_OF_WEBS = 90;
	}

	void weapon_spawn()
	{
		SetName("Spider Axe");
		if (RandomInt(1, 3) == 1)
		{
			SetDescription("How do I shot web?");
		}
		else
		{
			SetDescription("This red amber axe debilitates spiders and ensnares other enemies");
		}
		SetWeight(90);
		SetSize(25);
		SetValue(1200);
		SetHUDSprite("hand", 197);
		SetHUDSprite("trade", 197);
	}

	void OnSpawn() override
	{
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 0;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "none";
		int reg.attack.energydrain = 0;
		string reg.attack.stat = "axehandling";
		int reg.attack.hitchance = 100;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "makewebs";
		int reg.attack.noise = 1000;
		int reg.attack.chargeamt = 200;
		int reg.attack.reqskill = 27;
		string reg.attack.mpdrain = MP_CIRCLE_OF_WEBS;
		RegisterAttack();
	}

	void OnDeploy() override
	{
		if (!(false)) return;
		if (!(AXE_DEPLOYED))
		{
			AXE_DEPLOYED = 1;
			AXE_IDLE_COUNT = 0;
			ScheduleDelayedEvent(1.0, "spec_idle_loop");
		}
	}

	void spec_idle_loop()
	{
		if (!(AXE_DEPLOYED)) return;
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (!(GetGameTime() > NEXT_IDLE)) return;
		if (("game.item.attacking"))
		{
			NEXT_IDLE = GetGameTime();
			NEXT_IDLE += 3.0;
			ScheduleDelayedEvent(4.0, "spec_idle_loop");
		}
		else
		{
			AXE_IDLE_COUNT += 1;
			if (AXE_IDLE_COUNT == 1)
			{
				PlayViewAnim(1);
				ScheduleDelayedEvent(20.0, "spec_idle_loop");
			}
			else
			{
				PlayViewAnim(4);
				ScheduleDelayedEvent(5.0, "spec_idle_loop");
				AXE_IDLE_COUNT = 0;
			}
		}
	}

	void melee_start()
	{
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += 4.0;
	}

	void special_01_start()
	{
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += 4.0;
	}

	void melee_damaged_other()
	{
		if (!((GetEntityProperty(param1, "itemname")).findFirst("spid") >= 0)) return;
		SetDamage("dmg");
		return;
		spider_defile(GetEntityIndex(param1));
	}

	void special_01_damaged_other()
	{
		if (!((GetEntityProperty(param1, "itemname")).findFirst("spid") >= 0)) return;
		SetDamage("dmg");
		return;
		spider_defile(GetEntityIndex(param1));
	}

	void spider_defile()
	{
		string L_DOT = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		ApplyEffect(param1, "effects/dot_dark", 30.0, GetEntityIndex(GetOwner()), L_DOT, "axehandling");
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (("game.item.attacking")) return;
		if (!(CanAttack(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_WEB)) return;
		NEXT_WEB = GetGameTime();
		NEXT_WEB += 1.2;
		if (GetSkillLevel(GetOwner(), "axehandling.proficiency") < 25)
		{
			return;
		}
		if (GetEntityMP(GetOwner()) < RANGED_MP)
		{
			SendColoredMessage(GetOwner(), "Spider Axe: Not enough mana for web projectile 5");
			return;
		}
		GiveMP(GetOwner());
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += 4.0;
		// TODO: splayviewanim ent_me 8
		THROW_ATTACK_DELAY("do_web");
	}

	void do_web()
	{
		EmitSound(GetOwner(), 0, "bullchicken/bc_attack2.wav", 10);
		CallExternal(GetOwner(), "ext_tossprojectile", "proj_web", "view", "none", 700, Random(50, 60), 0, "axehandling");
	}

	void makewebs_start()
	{
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += 4.0;
		if (!(true)) return;
		if (!(GetEntityMP(GetOwner()) > MP_CIRCLE_OF_WEBS)) return;
		int L_REQS_MET = 1;
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") < 5)
		{
			SendColoredMessage(GetOwner(), "Spider Axe: Insufficient affliction talent for web projectile 5");
			int L_REQS_MET = 0;
		}
		if (GetGameTime() < NEXT_CIRCLE)
		{
			SendPlayerMessage("Spider", "axe can only maintain one web trap at a time.");
			int L_REQS_MET = 0;
		}
		if (!(L_REQS_MET))
		{
			CancelAttack();
			return;
		}
		// TODO: splayviewanim ent_me 9
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		EmitSound(GetOwner(), "game.sound.item", "magic/temple.wav", 10);
	}

	void makewebs_strike()
	{
		if (!(true)) return;
		SpawnNPC("monsters/summon/circle_of_lolth", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 5.0
		NEXT_CIRCLE = GetGameTime();
		NEXT_CIRCLE += 5.0;
	}

	void bweapon_effect_remove()
	{
		LogDebug("$currentscript bweapon_effect_remove PARAM1");
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(GetOwner(), "spideraxe", "name_exists"))) return;
		SendPlayerMessage("You", "are no longer resistant to spiders.");
		SetScriptFlags(GetOwner(), "remove", "spideraxe");
	}

	void bweapon_effect_activate()
	{
		if (!(GetEntityProperty(GetOwner(), "scriptvar"))) return;
		SendPlayerMessage("You", "are now immune to web effects and take half damage from spiders.");
		SetScriptFlags(GetOwner(), "add", "spideraxe", "spider_resist", 0.5, -1);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (GetEntityRace(param1) == "spider")
		{
			int L_REDUCE_DMG = 1;
		}
		if (GetEntityRace(param2) == "spider")
		{
			int L_REDUCE_DMG = 1;
		}
		string L_NAME = GetEntityName(param1);
		string L_NAME = StringToLower(L_NAME);
		if ((L_NAME).findFirst("spider") >= 0)
		{
			int L_REDUCE_DMG = 1;
		}
		if ((GetEntityProperty(param1, "itemname")).findFirst("spid") >= 0)
		{
			int L_REDUCE_DMG = 1;
		}
		if ((GetEntityProperty(param2, "itemname")).findFirst("spid") >= 0)
		{
			int L_REDUCE_DMG = 1;
		}
		if (!(L_REDUCE_DMG)) return;
		string L_DMG = (param3 * 0.5);
		SetDamage("hit");
		SetDamage("dmg");
		return;
	}

}

}
