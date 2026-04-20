#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjPoisonSpit2 : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SPRITE;

	ProjPoisonSpit2()
	{
		MODEL_HANDS = "weapons/projectiles.mdl";
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 6;
		SOUND_HITWALL1 = "debris/bustflesh2.wav";
		SOUND_HITWALL2 = "debris/bustflesh2.wav";
		MODEL_BODY_OFS = 6;
		SPRITE = "poison.spr";
		PROJ_DAMAGE = RandomInt(10, 40);
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_COLLIDEHITBOX = 32;
		ARROW_BREAK_CHANCE = 1.0;
		PROJ_ANIM_IDLE = "spore_spinning";
		PROJ_AOE_RANGE = 32;
		PROJ_AOE_FALLOFF = 1;
		PROJ_DAMAGE_TYPE = "poison";
		Precache(SPRITE);
	}

	void arrow_spawn()
	{
		SetName("Glob of Spit");
		SetDescription("A glob of spit");
		SetWeight(0);
		SetSize(1);
		SetValue(1);
		SetGravity(0.0001);
	}

	void game_fall()
	{
	}

	void hitwall()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {"game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		ApplyEffect(param2, "effects/dot_poison", RandomInt(3, 10), MY_OWNER, Random(10, 20), "spellcasting.affliction");
	}

	void game_projectile_landed()
	{
		Effect("tempent", "trail", SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 0), 3, 1, 1, 15, 0);
		SetExpireTime(0);
	}

}

}
