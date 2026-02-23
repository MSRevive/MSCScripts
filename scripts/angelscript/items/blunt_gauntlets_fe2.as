#pragma context server

#include "items/blunt_gauntlets_fe1.as"

namespace MS
{

class BluntGauntletsFe2 : CGameScript
{
	string DELAY_NOVA;
	string LAST_ERR;

	BluntGauntletsFe2()
	{
		const int ANIM_HANDS_DOWN = 20;
		const int ANIM_LIFT1 = 12;
		const int ANIM_LOWER = 11;
		const int ANIM_IDLE1 = 11;
		const int ANIM_IDLE_TOTAL = 12;
		const int ANIM_ATTACK1 = 16;
		const int ANIM_ATTACK2 = 17;
		const int ANIM_ATTACK3 = 18;
		const int ANIM_ATTACK4 = 19;
		const int ANIM_SPEC_ATTACK = 14;
		const int ANIM_SHEATH = 16;
		const string MODEL_VIEW = "viewmodels/v_martialarts_claws.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const int MODEL_BODY_OFS = 60;
		const int MELEE_DMG = 250;
		const int MELEE_DMG_RANGE = 0;
		const string MELEE_DMG_TYPE = "acid";
		const float MELEE_ACCURACY = 0.85;
		const float MELEE_AFFLIC_RATIO = 0.8;
		const int MELEE_AFFLICDMG_MIN = 20;
		const int GOUGE_MPDRAIN = 40;
		const int GOUGE_MPSTEAL = 30;
		const float GOUGE_LIFESTEAL_RATIO = 0.17;
		const float AURA_DOT_RATIO = 0.6;
		const int AURA_RADIUS = 100;
		const string SOUND_SWIPE = "zombie/claw_miss1.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const string SOUND_SWING = "zombie/claw_miss2.wav";
		const string SOUND_DEPLOY = "monsters/skeleton/calrain3.wav";
		const string SOUND_GOUGE = "monsters/gonome/gonome_jumpattack.wav";
		const string RAND_GROWL = Random(5.5, 8.5);
		const string SOUND_GROWL1 = "monsters/zombie1/zo_pain1.wav";
		const string SOUND_GROWL2 = "monsters/zombie1/zo_pain3.wav";
		const string SOUND_GROWL3 = "monsters/gonome/gonome_pain1.wav";
		const string SOUND_GROWL4 = "monsters/gonome/gonome_pain2.wav";
		const string SOUND_GROWL5 = "monsters/gonome/gonome_pain3.wav";
		const string SOUND_GROWL6 = "monsters/gonome/gonome_pain4.wav";
		const string NOVA_SCRIPT = "monsters/summon/poison_burst";
		const int DMG_NOVA = 50;
		const int NOVA_MPDRAIN = 60;
		const float NOVA_ATKDELAY = 8.0;
		const string ANIM_PREFIX = "gauntlets";
		const int NO_WORLD_MODEL = 1;
		const int MELEE_RANGE = 50;
		const int REACH_MELEE_RANGE = 100;
		const int MELEE_ENERGY = 1;
		const string MELEE_STAT = "spellcasting.affliction";
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.05;
		const string PLAYERANIM_AIM = "axe_onehand";
		const string SOUND_GAS_ON = "ambience/steamburst1.wav";
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
