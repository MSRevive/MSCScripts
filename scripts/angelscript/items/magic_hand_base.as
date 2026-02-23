#pragma context server

#include "items/base_item.as"

namespace MS
{

class MagicHandBase : CGameScript
{
	int IS_MAGIC_HAND;
	string WEAPON_PRIMARY_SKILL;
	int baseitem.canidle;
	string spell.prepscript.id;

	MagicHandBase()
	{
		IS_MAGIC_HAND = 1;
		const int ANIM_LIFT1 = 7;
		const int ANIM_PREPARE = 9;
		const int ANIM_PREPARE_IDLE = 11;
		const int ANIM_CAST = 12;
		const string ANIM_IDLE1 = ANIM_PREPARE_IDLE;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_IDLE_DELAY_LOW = 0;
		const int ANIM_IDLE_DELAY_HIGH = 0;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "none";
		const string SOUND_CHARGE = "none";
		const string SOUND_SHOOT = "magic/cast.wav";
		const int SPELL_NOISE = 650;
		const int SPELL_ENERGYDRAIN = 0;
		const float SPELL_PREPARE_TIME = 5.5;
		const string RANGED_TYPE = "charge-throw-projectile";
		const float RANGED_DMG_DELAY = 0.4;
		const string RANGED_HOLD_MINMAX = "2;2";
		const string RANGED_COF = "0;0";
		const string MELEE_TYPE = "target";
		const string MELEE_DMG_DELAY = RANGED_DMG_DELAY;
		const int MELEE_DMG = 0;
		const int MELEE_DMG_RANGE = 0;
		const int MELEE_NOAUTOAIM = 0;
		const string PLAYERANIM_AIM = "fireball";
		const string PLAYERANIM_PREPARE = "prepare_fireball";
		const string PLAYERANIM_CAST = "throw_fireball";
		const string SCRIPT_SFX_PREP = "items/magic_hand_base_cl";
	}

	void game_precache()
	{
		Precache(SCRIPT_SFX_PREP);
	}

	void OnSpawn() override
	{
		SetWeight(0);
		SetSize(0);
		SetAnimExt(PLAYERANIM_AIM);
		SetHand("both");
		SetHUDSprite("hand", "bow");
		SetHUDSprite("trade", "firemagic");
		spell_spawn();
		setup_attack();
		setup_spell();
	}

	void OnDeploy() override
	{
		ClientEvent("new", "all", SCRIPT_SFX_PREP, GetEntityIndex(GetOwner()), SPELL_PREPARE_TIME);
		spell.prepscript.id = "game.script.last_sent_id";
		SetViewModel(MODEL_VIEW);
		PlayOwnerAnim("once", PLAYERANIM_PREPARE);
		PlayViewAnim(ANIM_PREPARE);
		baseitem.canidle = 0;
		spell_deploy();
	}

	void game_switchhands()
	{
		item_switchhands();
	}

	void OnPickup(CBaseEntity@ player) override
	{
		item_switchhands();
	}

	void game_removefromowner()
	{
		ClientEvent("remove", "all", spell.prepscript.id);
	}

	void setup_attack()
	{
		if (MELEE_RANGE != "MELEE_RANGE")
		{
			string reg.attack.type = MELEE_TYPE;
			string reg.attack.range = MELEE_RANGE;
			string reg.attack.dmg = MELEE_DMG;
			string reg.attack.dmg.range = MELEE_DMG_RANGE;
			string reg.attack.dmg.type = SPELL_DAMAGE_TYPE;
			string reg.attack.hitchance = MELEE_HITCHANCE;
			int reg.attack.priority = 1;
			string reg.attack.delay.strike = MELEE_DMG_DELAY;
			string reg.attack.delay.end = MELEE_ATK_DURATION;
			string reg.attack.ofs.startpos = MELEE_STARTPOS;
			string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		}
		else
		{
			string reg.attack.type = "charge-throw-projectile";
			string reg.attack.hold_min&max = RANGED_HOLD_MINMAX;
			string reg.attack.dmg.type = SPELL_DAMAGE_TYPE;
			string reg.attack.range = RANGED_FORCE;
			string reg.attack.COF = RANGED_COF;
			string reg.attack.projectile = RANGED_PROJECTILE;
			int reg.attack.priority = 0;
			string reg.attack.delay.strike = RANGED_DMG_DELAY;
			string reg.attack.delay.end = RANGED_ATK_DURATION;
			string reg.attack.ofs.startpos = RANGED_STARTPOS;
			string reg.attack.ofs.aimang = RANGED_AIMANGLE;
			int reg.attack.ammodrain = 0;
		}
		string reg.attack.keys = "+attack1";
		string reg.attack.noise = SPELL_NOISE;
		string reg.attack.energydrain = SPELL_ENERGYDRAIN;
		string reg.attack.mpdrain = SPELL_MPDRAIN;
		string reg.attack.stat = SPELL_STAT;
		string reg.attack.callback = "cast";
		string reg.attack.noautoaim = MELEE_NOAUTOAIM;
		WEAPON_PRIMARY_SKILL = reg.attack.stat;
		if (!(NO_REGISTER))
		{
			RegisterAttack();
		}
	}

	void setup_spell()
	{
		string reg.spell.reqskill = SPELL_SKILL_REQUIRED;
		int reg.spell.fizzletime = 9999999;
		int reg.spell.castsuccess = 100;
		string reg.spell.preparetime = SPELL_PREPARE_TIME;
		// TODO: registerspell
	}

	void game_prepare_success()
	{
		SPELL_PREPARE_TIME("prepare_success_done");
	}

	void prepare_success_done()
	{
		baseitem.canidle = 1;
		spell_prepare_success();
	}

	void spell_prepare_success()
	{
	}

	void cast_start()
	{
		PlayViewAnim(ANIM_CAST);
		PlayOwnerAnim("critical", PLAYERANIM_PREPARE);
		// svplaysound: svplaysound	game.sound.item game.sound.maxvol SOUND_CHARGE
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_CHARGE);
	}

	void cast_strike()
	{
		spell_casted(param1, param2, param3);
	}

	void cast_toss()
	{
		spell_casted();
		PlayOwnerAnim("critical", PLAYERANIM_CAST);
	}

	void cast_end()
	{
	}

	void spell_end()
	{
		if (!(CUST_MESSAGE))
		{
			SendPlayerMessage(GetOwner(), "The spell's duration ends.");
		}
		bweapon_effect_remove();
		DeleteEntity(GetOwner());
	}

	void spell_casted()
	{
		CallExternal(GetOwner(), "mana_drain");
	}

	void game_fall()
	{
		DeleteEntity(GetOwner());
	}

}

}
