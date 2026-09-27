#pragma context server

namespace MS
{

class ProjPoisonCloud : CGameScript
{
	string ITEM_NAME;
	string MODEL_HANDS;
	string MODEL_WORLD;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_COLLIDEHITBOX;
	int PROJ_DAMAGE;
	string PROJ_DAMAGESTAT;
	string PROJ_DAMAGE_TYPE;
	int PROJ_STICK_DURATION;
	string SCRIPT_1_ID;
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjPoisonCloud()
	{
		Precache("monsters/summon/poison_cloud2");
	}

	void OnSpawn() override
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "none";
		SOUND_HITWALL1 = "ambience/steamburst1.wav";
		SOUND_HITWALL2 = "ambience/steamburst1.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "poison";
		PROJ_DAMAGESTAT = "spellcasting.affliction";
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 256;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
		// TODO: movetype projectile
		SetWorldModel(MODEL_WORLD);
		projectile_spawn();
		string reg.proj.dmg = PROJ_DAMAGE;
		string reg.proj.dmgtype = PROJ_DAMAGE_TYPE;
		string reg.proj.aoe.range = PROJ_AOE_RANGE;
		string reg.proj.aoe.falloff = PROJ_AOE_FALLOFF;
		string reg.proj.stick.duration = PROJ_STICK_DURATION;
		string reg.proj.collidehitbox = PROJ_COLLIDEHITBOX;
		const string SCRIPT_1 = "items/proj_poison_cloud_cl";
		const string POISON_SPRITE = "poison_cloud.spr";
		Precache(POISON_SPRITE);
		RegisterProjectile();
	}

	void game_tossprojectile()
	{
		ClientEvent("new", "all_in_sight", SCRIPT_1, GetEntityIndex(GetOwner()));
		SCRIPT_1_ID = "game.script.last_sent_id";
		SetUseable(0);
		game_fall();
	}

	void game_projectile_landed()
	{
		// TODO: movetype none
		SetExpireTime(0);
		projectile_landed();
	}

	void projectile_spawn()
	{
		SetName("Poison Cloud Spawner");
		SetWeight(500);
		SetSize(1);
		SetValue(5);
		SetGravity(0.7);
		SetGroupable(25);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void projectile_landed()
	{
		Effect("tempent", "trail", POISON_SPRITE, /* TODO: $relpos */ $relpos(0, 0, 0), /* TODO: $relpos */ $relpos(0, 0, 10), 10, 2, 5, 10, 20);
		ClientEvent("remove", "all", SCRIPT_1_ID);
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string pos = GetEntityOrigin(GetOwner());
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		EFFECT_DMG *= 0.6;
		string EFFECT_DURATION = GetStat(MY_OWNER, "concentration");
		EFFECT_DURATION /= 2;
		EFFECT_DURATION += EFFECT_DMG;
		SpawnNPC("monsters/summon/poison_cloud2", pos, ScriptMode::Legacy); // params: MY_OWNER, PROJ_AOE_RANGE, EFFECT_DMG, EFFECT_DURATION, "spellcasting.affliction"
		string LAST_ENT = GetEntityIndex(m_hLastCreated);
	}

	void game_hitnpc()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {"game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((GetEntityProperty(m_hLastStruckByMe, "haseffect"))) return;
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string EFFECT_DURATION_STAT = GetStat(MY_OWNER, "concentration.ratio");
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.affliction");
		int EFFECT_MAXDURATION = 15;
		int EFFECT_MINDURATION = 10;
		string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", EFFECT_DURATION, MY_OWNER, EFFECT_DMG, "spellcasting.affliction");
	}

	void hitwall()
	{
		// PlayRandomSound from: "game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2
		array<string> sounds = {"game.sound.maxvol", SOUND_HITWALL1, SOUND_HITWALL2};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
