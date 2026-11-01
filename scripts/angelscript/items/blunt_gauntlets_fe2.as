#pragma context server

#include "items/blunt_gauntlets_fe1.as"

namespace MS
{

class BluntGauntletsFe2 : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_ATTACK4;
	int ANIM_HANDS_DOWN;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LOWER;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int ANIM_SPEC_ATTACK;
	float AURA_DOT_RATIO;
	int AURA_RADIUS;
	string DELAY_NOVA;
	int DMG_NOVA;
	float GOUGE_LIFESTEAL_RATIO;
	int GOUGE_MPDRAIN;
	int GOUGE_MPSTEAL;
	string LAST_ERR;
	float MELEE_ACCURACY;
	int MELEE_AFFLICDMG_MIN;
	float MELEE_AFFLIC_RATIO;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
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
	float NOVA_ATKDELAY;
	int NOVA_MPDRAIN;
	string NOVA_SCRIPT;
	int NO_WORLD_MODEL;
	string PLAYERANIM_AIM;
	float RAND_GROWL;
	int REACH_MELEE_RANGE;
	string SOUND_DEPLOY;
	string SOUND_GAS_ON;
	string SOUND_GOUGE;
	string SOUND_GROWL1;
	string SOUND_GROWL2;
	string SOUND_GROWL3;
	string SOUND_GROWL4;
	string SOUND_GROWL5;
	string SOUND_GROWL6;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWING;
	string SOUND_SWIPE;

	BluntGauntletsFe2()
	{
		ANIM_HANDS_DOWN = 20;
		ANIM_LIFT1 = 12;
		ANIM_LOWER = 11;
		ANIM_IDLE1 = 11;
		ANIM_IDLE_TOTAL = 12;
		ANIM_ATTACK1 = 16;
		ANIM_ATTACK2 = 17;
		ANIM_ATTACK3 = 18;
		ANIM_ATTACK4 = 19;
		ANIM_SPEC_ATTACK = 14;
		ANIM_SHEATH = 16;
		MODEL_VIEW = "viewmodels/v_martialarts_claws.mdl";
		MODEL_VIEW_IDX = 1;
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 60;
		MELEE_DMG = 250;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "acid";
		MELEE_ACCURACY = 0.85;
		MELEE_AFFLIC_RATIO = 0.8;
		MELEE_AFFLICDMG_MIN = 20;
		GOUGE_MPDRAIN = 40;
		GOUGE_MPSTEAL = 30;
		GOUGE_LIFESTEAL_RATIO = 0.17;
		AURA_DOT_RATIO = 0.6;
		AURA_RADIUS = 100;
		SOUND_SWIPE = "zombie/claw_miss1.wav";
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		SOUND_SWING = "zombie/claw_miss2.wav";
		SOUND_DEPLOY = "monsters/skeleton/calrain3.wav";
		SOUND_GOUGE = "monsters/gonome/gonome_jumpattack.wav";
		RAND_GROWL = Random(5.5, 8.5);
		SOUND_GROWL1 = "monsters/zombie1/zo_pain1.wav";
		SOUND_GROWL2 = "monsters/zombie1/zo_pain3.wav";
		SOUND_GROWL3 = "monsters/gonome/gonome_pain1.wav";
		SOUND_GROWL4 = "monsters/gonome/gonome_pain2.wav";
		SOUND_GROWL5 = "monsters/gonome/gonome_pain3.wav";
		SOUND_GROWL6 = "monsters/gonome/gonome_pain4.wav";
		NOVA_SCRIPT = "monsters/summon/poison_burst";
		DMG_NOVA = 50;
		NOVA_MPDRAIN = 60;
		NOVA_ATKDELAY = 8.0;
		ANIM_PREFIX = "gauntlets";
		NO_WORLD_MODEL = 1;
		MELEE_RANGE = 50;
		REACH_MELEE_RANGE = 100;
		MELEE_ENERGY = 1;
		MELEE_STAT = "spellcasting.affliction";
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.05;
		PLAYERANIM_AIM = "axe_onehand";
		SOUND_GAS_ON = "ambience/steamburst1.wav";
	}

	void game_precache()
	{
		Precache("poison_cloud.spr");
		Precache(NOVA_SCRIPT);
	}

	void weapon_spawn()
	{
		SetName("Greater Venom Claws");
		SetDescription("Vicious claws have burst from your hands!");
		ScheduleDelayedEvent(0.1, "growl_noises");
	}

	void do_special_damage()
	{
		string LIFE_STOLEN = MELEE_DAMAGE;
		LIFE_STOLEN *= /* TODO: $get_takedmg */ $get_takedmg(param1, "acid");
		LIFE_STOLEN *= 0.01;
		try_vampire_target(GetEntityIndex(GetOwner()), GetEntityIndex(param1), LIFE_STOLEN);
	}

	void growl_noises()
	{
		RAND_GROWL("growl_noises");
		// PlayRandomSound from: SOUND_GROWL1, SOUND_GROWL2, SOUND_GROWL3, SOUND_GROWL4, SOUND_GROWL5, SOUND_GROWL6
		array<string> sounds = {SOUND_GROWL1, SOUND_GROWL2, SOUND_GROWL3, SOUND_GROWL4, SOUND_GROWL5, SOUND_GROWL6};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 256, 1.9, 1.9);
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		if (GetGameTime() < DELAY_NOVA)
		{
			int EXIT_SUB = 1;
			if (GetGameTime() > LAST_ERR)
			{
			}
			SendColoredMessage(GetOwner(), "Too soon to use Poison Burst again!");
			LAST_ERR = GetGameTime();
			LAST_ERR += 2.0;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityMP(GetOwner()) < NOVA_MPDRAIN)
		{
			SendColoredMessage(GetOwner(), "Greater Flesheater Gauntlets: Insufficient mana for Poison Burst.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		DELAY_NOVA = GetGameTime();
		DELAY_NOVA += NOVA_ATKDELAY;
		string DOT_POISON = GetSkillLevel(GetOwner(), "spellcasting.affliction");
		DOT_POISON *= 0.5;
		SpawnNPC(NOVA_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 86, 1, DMG_NOVA, DOT_POISON
		GiveMP(GetOwner());
		CallExternal(GetOwner(), "mana_drain");
		LAST_ERR = GetGameTime();
		LAST_ERR += 2.0;
	}

}

}
