#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjArrowBase : CGameScript
{
	string ANIM_DEPLOY;
	string ANIM_DROPPED;
	int BARROW_HIT_NPC;

	ProjArrowBase()
	{
		const string MODEL_HANDS = "weapons/bows/arrows.mdl";
		const string MODEL_WORLD = "weapons/bows/arrows.mdl";
		const string BASE_MODEL_WORLD = "weapons/bows/arrows.mdl";
		const string SOUND_HITWALL1 = "weapons/bow/arrowhit1.wav";
		const string SOUND_HITWALL2 = "weapons/bow/arrowhit2.wav";
		const string SPRITE_ARROW_TRADE = "woodenarrow";
		const string SPRITE_ARROW_HAND = "arrows";
		const int HITWALL_VOL = 5;
		const int ARROW_EXPIRE_DELAY = 10;
		const string PROJ_DAMAGE_TYPE = "pierce";
		const int PROJ_COLLIDEHITBOX = 1;
	}

	void projectile_spawn()
	{
		if (PROJ_ANIM_IDLE == "PROJ_ANIM_IDLE")
		{
			if (MODEL_WORLD == BASE_MODEL_WORLD)
			{
				ANIM_DEPLOY = "idle2";
				ANIM_DROPPED = "idle1";
			}
			else
			{
				ANIM_DEPLOY = "idle_standard";
				ANIM_DROPPED = "idle_standard";
			}
		}
		else
		{
			ANIM_DEPLOY = PROJ_ANIM_IDLE;
			ANIM_DROPPED = PROJ_ANIM_IDLE;
		}
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
		if (ANIM_DEPLOY != "none")
		{
			PlayAnim("once", ANIM_DEPLOY);
		}
		string MB_TEMP = "game.item.hand_index";
		MB_TEMP += 1;
		MB_TEMP += ARROW_BODY_OFS;
		SetModelBody(0, MB_TEMP);
		arrow_deploy();
		SetGravity(1.0);
	}

	void game_tossprojectile()
	{
		if ((CLFX_ARROW)) return;
		SetModelBody(0, ARROW_BODY_OFS);
		if (ANIM_DROPPED != "none")
		{
			PlayAnim("once", ANIM_DROPPED);
		}
	}

	void game_fall()
	{
		if (!(CLFX_ARROW))
		{
			SetModelBody(0, ARROW_BODY_OFS);
		}
		if (ANIM_DROPPED != "none")
		{
			PlayAnim("once", ANIM_DROPPED);
		}
	}

	void game_projectile_hitwall()
	{
		// PlayRandomSound from: HITWALL_VOL, SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {HITWALL_VOL, SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 4, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_projectile_hitnpc()
	{
		BARROW_HIT_NPC = 1;
		if ((PROJ_STICK_ON_NPC)) return;
		if ((PROJ_IGNORENPC)) return;
		remove_projectile("barrow_hitnpc");
	}

	void projectile_landed()
	{
		if ((BARROW_HIT_NPC)) return;
		if ((PROJ_STICK_ON_WALL_NEW)) return;
		ARROW_EXPIRE_DELAY("remove_projectile", "barrow_landed");
	}

}

}
