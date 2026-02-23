#pragma context server

#include "items/proj_arrow_base.as"
#include "items/proj_base.as"

namespace MS
{

class ProjServerArrow : CGameScript
{
	ProjServerArrow()
	{
		const int ARROW_BODY_OFS = 0;
		const string SPRITE_ARROW_TRADE = "woodenarrow";
		const string PROJ_DAMAGE = RandomInt(30, 60);
		const int ARROW_STICK_DURATION = 10;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 0.2;
		const int PROJ_MOTIONBLUR = 1;
		const string MODEL_HANDS = "weapons/bows/arrows.mdl";
		const string MODEL_WORLD = "weapons/bows/arrows.mdl";
		const string SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		const string SOUND_HITWALL2 = "weapons/bow/arrowhit1.wav";
		const string SPRITE_ARROW_TRADE = "woodenarrow";
		const string SPRITE_ARROW_HAND = "arrows";
		const string ANIM_DEPLOY = "idle2";
		const string ANIM_DROPPED = "idle1";
		const int ARROW_EXPIRE_DELAY = 10;
		const string PROJ_DAMAGETYPE = "pierce";
		const int PROJ_COLLIDEHITBOX = 1;
	}

	void OnSpawn() override
	{
		// TODO: movetype projectile
		SetWorldModel(MODEL_WORLD);
		projectile_spawn();
		string reg.proj.dmg = PROJ_DAMAGE;
		string reg.proj.dmgtype = PROJ_DAMAGE_TYPE;
		string reg.proj.aoe.range = PROJ_AOE_RANGE;
		string reg.proj.aoe.falloff = PROJ_AOE_FALLOFF;
		string reg.proj.stick.duration = PROJ_STICK_DURATION;
		string reg.proj.collidehitbox = PROJ_COLLIDEHITBOX;
		RegisterProjectile();
	}

	void game_tossprojectile()
	{
		SetUseable(0);
		if ((PROJ_MOTIONBLUR))
		{
			ClientEvent("new", "all_in_sight", "effects/sfx_motionblur", GetEntityIndex(GetOwner()));
		}
		game_fall();
	}

	void game_projectile_landed()
	{
		// TODO: movetype none
		SetExpireTime(0);
		projectile_landed();
	}

	void arrow_spawn()
	{
		SetName("Server Arrow");
		SetDescription("For testing server side projectiles");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.75);
	}

	void projectile_spawn()
	{
		SetGroupable(25);
		SetWorldModel(MODEL_WORLD);
		SetHUDSprite("hand", SPRITE_ARROW_HAND);
		SetHUDSprite("trade", SPRITE_ARROW_TRADE);
		SetHand("left");
		arrow_spawn();
	}

	void OnDeploy() override
	{
		SetModel(MODEL_HANDS);
		PlayAnim("once", ANIM_DEPLOY);
		string MB_TEMP = "game.item.hand_index";
		MB_TEMP += 1;
		MB_TEMP += ARROW_BODY_OFS;
		SetModelBody(0, MB_TEMP);
		arrow_deploy();
	}

	void game_tossprojectile()
	{
		game_fall();
	}

	void game_fall()
	{
		SetModelBody(0, ARROW_BODY_OFS);
		PlayAnim("once", ANIM_DROPPED);
	}

	void game_projectile_hitwall()
	{
		// PlayRandomSound from: SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 4, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void game_projectile_hitnpc()
	{
		if (ARROW_STICK_DURATION > 0)
		{
			SetFollow(m_hLastStruckByMe);
			SetExpireTime(ARROW_STICK_DURATION);
			ARROW_STICK_DURATION("arrow_unstick");
		}
		SetExpireTime(0);
	}

	void arrow_unstick()
	{
		SetFollow("none");
	}

	void projectile_landed()
	{
		SetExpireTime(ARROW_EXPIRE_DELAY);
	}

	void arrow_breakchance()
	{
		if (!(RandomInt(0, 99) < ARROW_BREAK_CHANCE)) return;
		projectile_broke();
	}

}

}
