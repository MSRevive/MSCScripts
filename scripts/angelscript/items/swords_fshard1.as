#pragma context server

#include "items/swords_base_twohanded.as"

namespace MS
{

class SwordsFshard1 : CGameScript
{
	string ALLOW_MODE_SWITCH;
	string HOLY_MODE;
	string NEXT_ALLOWED_PARRY;
	string NEXT_WARN_MSG;
	int REGEN_LOOP;
	int SHARD_SHIELD_ON;

	SwordsFshard1()
	{
		const string SOUND_MODE_SWITCH = "magic/energy1_loud.wav";
		const int CUSTOM_REGISTER_CHARGE1 = 1;
		const int MP_HOLY_WAVE = 30;
		const int BASE_LEVEL_REQ = 30;
		const int ANIM_LIFT = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 2;
		const int ANIM_ATTACK3 = 2;
		const int ATTACK_ANIMS = 1;
		const int ANIM_LUNGE = 3;
		const int ANIM_PARRY1 = 4;
		const int ANIM_PARRY1_RETRACT = 5;
		const int ANIM_UNSHEATH = 6;
		const int ANIM_SHEATH = 7;
		const string MODEL_VIEW = "viewmodels/v_2hswords.mdl";
		const int MODEL_VIEW_IDX = 8;
		const int HOLY_VIEW_IDX = 9;
		const string MODEL_HANDS = "weapons/p_weapons4.mdl";
		const string MODEL_WORLD = "weapons/p_weapons4.mdl";
		const int MODEL_BODY_OFS = 51;
		const int MODEL_HOLY_OFS = 53;
		const int PMODEL_IDX_FLOOR = 52;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_DRAW = "weapons/swords/sworddraw.wav";
		const string SOUND_SHOUT = GetEntityProperty(GetOwner(), "scriptvar");
		const string ANIM_PREFIX = "standard";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.1;
		const int MELEE_ENERGY = 1;
		const int MELEE_DMG = 450;
		const int MELEE_DMG_RANGE = 80;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.75;
		const string MELEE_STAT = "swordsmanship";
		const int MELEE_ALIGN_BASE = 3;
		const int MELEE_ALIGN_TIP = 0;
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.3;
		const int MELEE_NEW_PARRY_CHANCE = 30;
		const string PLAYERANIM_AIM = "sword_double_idle";
		const string PLAYERANIM_SWING = "sword_double_swing";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((REGEN_LOOP))
		{
		}
		if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
		{
		}
		if (!(HOLY_MODE))
		{
			HealEntity(GetOwner(), 1);
		}
		else
		{
			HealEntity(GetOwner(), 2);
		}
	}

	void weapon_spawn()
	{
		SetName("Felewyn Shard I");
		SetDescription("A shard of the legendary Felewyn Blade");
		SetWeight(100);
		SetSize(10);
		SetValue(5000);
		SetHUDSprite("trade", 132);
		SetHand("both");
	}

	void OnDeploy() override
	{
		if (!(true)) return;
		ScheduleDelayedEvent(0.1, "render_props");
	}

	void render_props()
	{
		if (!(HOLY_MODE))
		{
			SetModelBody(0, MODEL_BODY_OFS);
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
		}
		else
		{
			SetModelBody(0, MODEL_HOLY_OFS);
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") HOLY_VIEW_IDX
		}
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = MELEE_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		string reg.attack.delay.strike = MELEE_DMG_DELAY;
		reg.attack.delay.strike += 0.5;
		string reg.attack.delay.end = MELEE_ATK_DURATION;
		reg.attack.delay.end += 0.5;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.noise = MELEE_NOISE;
		int reg.attack.priority = 1;
		string reg.attack.keys = "-attack1";
		string reg.attack.callback = "special_01";
		reg.attack.dmg *= 2;
		float reg.attack.chargeamt = 1.0;
		int reg.attack.reqskill = 32;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 0;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "slash";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "swordsmanship";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 0.1;
		float reg.attack.delay.end = 0.2;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "shield";
		string reg.attack.noise = MELEE_NOISE;
		string reg.attack.mpdrain = SHIELD_MP;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 34;
		RegisterAttack();
	}

	void special_01_start()
	{
		PlayViewAnim(ANIM_LUNGE);
		PlayOwnerAnim("once", "axe_twohand_swing");
		EmitSound(GetOwner(), "const.snd.weapon", SPECIAL01_SND, "const.snd.maxvol");
	}

	void shield_start()
	{
		LogDebug("shield_start IsKeyDown(GetOwner(), "use")");
		if (!(IsKeyDown(GetOwner(), "use")))
		{
			if (GetEntityMP(GetOwner()) < MP_HOLY_WAVE)
			{
				int L_FAIL = 1;
				SendColoredMessage(GetOwner(), "Felewyn Shard: Insufficient mana for Holy Wave 20");
				SendColoredMessage(GetOwner(), "Hold +Use to use Holy Shield instead.");
			}
			if (!(L_FAIL))
			{
			}
			do_holy_wave();
		}
		if ((PARRY_MODE)) return;
		if (!(IsKeyDown(GetOwner(), "use"))) return;
		if (GetGameTime() <= NEXT_ALLOWED_PARRY)
		{
			if (GetGameTime() > NEXT_WARN_MSG)
			{
			}
			NEXT_WARN_MSG = GetGameTime();
			NEXT_WARN_MSG += 1.0;
			SendColoredMessage(GetOwner(), "Felewyn Shard: Shield needs time to recharge");
		}
		if (!(GetGameTime() > NEXT_ALLOWED_PARRY)) return;
		NEXT_ALLOWED_PARRY = GetGameTime();
		NEXT_ALLOWED_PARRY += 20.0;
		// TODO: splayviewanim ent_me ANIM_PARRY1
		ApplyEffect(GetOwner(), "effects/effect_shardshield", 10.0, 0.1);
		SHARD_SHIELD_ON = 1;
		ScheduleDelayedEvent(10.0, "end_parry");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(SHARD_SHIELD_ON)) return;
		if (!(HOLY_MODE)) return;
		string MAX_HP_REPEL = GetEntityMaxHealth(GetOwner());
		MAX_HP_REPEL *= 2;
		if (!(GetEntityMaxHealth(param1) < MAX_HP_REPEL)) return;
		string REPEL_VEL = GetEntityProperty(param1, "angles.yaw");
		AddVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, REPEL_VEL, 0), Vector3(0, -400, 200)));
	}

	void end_parry()
	{
		SHARD_SHIELD_ON = 0;
		// TODO: splayviewanim ent_me ANIM_PARRY1_RETRACT
	}

	void bweapon_effect_activate()
	{
		REGEN_LOOP = 1;
	}

	void bweapon_effect_remove()
	{
		REGEN_LOOP = 0;
	}

	void game_+attack2()
	{
		if (!(GetGameTime() > ALLOW_MODE_SWITCH)) return;
		ALLOW_MODE_SWITCH = GetGameTime();
		ALLOW_MODE_SWITCH += 1.0;
		EmitSound(GetOwner(), 0, SOUND_MODE_SWITCH, 10);
		if ((HOLY_MODE))
		{
			HOLY_MODE = 0;
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
			SetModelBody(0, MODEL_BODY_OFS);
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
		}
		else
		{
			HOLY_MODE = 1;
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
			SetModelBody(0, MODEL_HOLY_OFS);
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") HOLY_VIEW_IDX
		}
	}

	void game_show()
	{
		render_props();
	}

	void ext_activate_items()
	{
		LogDebug("$currentscript ext_activate_items");
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		render_props();
	}

	void do_holy_wave()
	{
		GiveMP(GetOwner());
		// TODO: splayviewanim ent_me 3
		string L_OWNER_YAW = GetEntityProperty(GetOwner(), "viewangles");
		string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
		string L_PROJ_START = GetEntityOrigin(GetOwner());
		L_PROJ_START = "z";
		SpawnNPC("effects/sfx_wave", L_PROJ_START, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_OWNER_YAW, 20, "swordsmanship"
	}

	void game_fall()
	{
		SetModelBody(0, PMODEL_IDX_FLOOR);
	}

}

}
