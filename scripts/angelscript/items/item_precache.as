#pragma context server

namespace MS
{

class ItemPrecache : CGameScript
{
	ItemPrecache()
	{
		Precache("weapons/projectiles2.mdl");
		Precache("poison_cloud.spr");
		Precache("laserbeam.spr");
		Precache("weapons/magic/seals.mdl");
		Precache("3dmflaora.spr");
		Precache("lgtning.spr");
		Precache("fire1_fixed.spr");
		Precache("null.mdl");
		Precache("xsmoke3.spr");
		Precache("weapons/p_weapons1.mdl");
		Precache("weapons/p_weapons2.mdl");
		Precache("weapons/p_weapons3.mdl");
		Precache("weapons/p_weapons4.mdl");
		Precache("glassgibs.mdl");
		Precache("weapons/p_weapons1.mdl");
		Precache("weapons/p_weapons2.mdl");
		Precache("weapons/p_weapons3.mdl");
		Precache("weapons/projectiles.mdl");
		Precache("bigsmoke.spr");
		Precache("null.wav");
		Precache("misc/gold.wav");
		Precache("ambience/alienflyby1.wav");
		Precache("chests/base_treasurechest");
		Precache("monsters/skeleton");
		Precache("monsters/summon/bear1");
		Precache("fire1_fixed2.spr");
		Precache("fire1_fixed.spr");
		Precache("monsters/summon/lesser_wraith");
		Precache("monsters/wraith_cl");
		Precache("monsters/companion/pet_wolf");
		Precache("monsters/companion/pet_wolf_ice");
		Precache("monsters/companion/pet_wolf_shadow");
	}

	void fake_caches()
	{
	}

}

}
