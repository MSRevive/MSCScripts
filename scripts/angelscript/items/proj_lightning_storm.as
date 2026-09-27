#pragma context server

namespace MS
{

class ProjLightningStorm : CGameScript
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
	string SOUND_BURN;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;

	ProjLightningStorm()
	{
	}

	void OnSpawn() override
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "none";
		SOUND_HITWALL1 = "weapons/electro4.wav";
		SOUND_HITWALL2 = "weapons/electro4.wav";
		SOUND_BURN = "debris/beamstart15.wav";
		ITEM_NAME = "watermana";
		PROJ_DAMAGE_TYPE = "lightning";
		PROJ_DAMAGESTAT = "spellcasting.lightning";
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 256;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_COLLIDEHITBOX = 32;
		Precache(MODEL_WORLD);
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
		SetName("Lightning Storm Spawner");
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
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string pos = GetEntityOrigin(GetOwner());
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
		string EFFECT_DURATION_STAT = GetStat(MY_OWNER, "concentration.ratio");
		int EFFECT_MAXDURATION = 15;
		int EFFECT_MINDURATION = 15;
		string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		string EFFECT_SCRIPT = "monsters/summon/summon_lightning_storm";
		SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: MY_OWNER, GetEntityProperty(GetOwner(), "angles.y"), EFFECT_DMG, EFFECT_DURATION, "spellcasting.lightning"
		string LAST_ENT = GetEntityIndex(m_hLastCreated);
	}

	void game_hitnpc()
	{
		string MY_OWNER = GetEntityIndex("ent_expowner");
		string EFFECT_DMG = GetSkillLevel(MY_OWNER, "spellcasting.lightning");
		EFFECT_DMG /= 2;
		int EFFECT_MAXDURATION = 15;
		int EFFECT_MINDURATION = 10;
		string EFFECT_DURATION = /* TODO: $get_skill_ratio */ $get_skill_ratio(EFFECT_DURATION_STAT, EFFECT_MINDURATION, EFFECT_MAXDURATION);
		ApplyEffect(m_hLastStruckByMe, "effects/dot_lightning", EFFECT_DURATION, MY_OWNER, EFFECT_DMG, "spellcasting.lightning");
	}

}

}
