#pragma context server

#include "items/blunt_base_twohanded.as"

namespace MS
{

class BluntNorthmaul972 : CGameScript
{
	int ANIM_BLIZZARD;
	int ANIM_GROUND_SMASH_NORM;
	int ANIM_GROUND_SMASH_PIERCE;
	int ANIM_PIERCE_IDLE;
	int ANIM_PIERCE_SWING1;
	int ANIM_PIERCE_SWING2;
	string ANIM_PREFIX;
	int ANIM_SWITCH;
	string ATTACK_MODE;
	int BASE_LEVEL_REQ;
	int BLIZZARD_MPDRAIN;
	int CUSTOM_REGISTER_BLUNT;
	int ICEWAVE_MPDRAIN;
	int IN_PACK;
	string LAST_SWIVEL;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_COLD_HITWALL1;
	string SOUND_COLD_HITWALL2;
	string SOUND_PIERCE_HITWALL1;
	string SOUND_PIERCE_HITWALL2;
	float SWIVEL_DELAY;
	float SWIVEL_TIME;

	BluntNorthmaul972()
	{
		CUSTOM_REGISTER_BLUNT = 1;
		BASE_LEVEL_REQ = 20;
		ICEWAVE_MPDRAIN = 60;
		BLIZZARD_MPDRAIN = 30;
		MODEL_VIEW = "viewmodels/v_2hblunts.mdl";
		MODEL_VIEW_IDX = 5;
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_BODY_OFS = 7;
		ANIM_PREFIX = "standard";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.5;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 2;
		MELEE_DMG = 400;
		MELEE_DMG_RANGE = 20;
		MELEE_ACCURACY = 0.65;
		MELEE_PARRY_AUGMENT = 0.1;
		ANIM_SWITCH = 11;
		ANIM_PIERCE_IDLE = 12;
		ANIM_PIERCE_SWING1 = 4;
		ANIM_PIERCE_SWING2 = 5;
		ANIM_GROUND_SMASH_NORM = 10;
		ANIM_GROUND_SMASH_PIERCE = 13;
		ANIM_BLIZZARD = 14;
		SWIVEL_DELAY = 3.0;
		SWIVEL_TIME = 1.0;
		SOUND_COLD_HITWALL1 = "debris/glass1.wav";
		SOUND_COLD_HITWALL2 = "debris/glass2.wav";
		SOUND_PIERCE_HITWALL1 = "weapons/axemetal1.wav";
		SOUND_PIERCE_HITWALL2 = "weapons/axemetal2.wav";
		MELEE_DMG_TYPE = "cold";
	}

	void weapon_spawn()
	{
		SetName("North Maul");
		SetDescription("A gigantic hammer of solid elemental ice");
		SetWeight(80);
		SetSize(10);
		SetValue(3750);
		SetHUDSprite("hand", 125);
		SetHUDSprite("trade", 125);
	}

	void OnDeploy() override
	{
		ATTACK_MODE = "cold";
		IN_PACK = 0;
	}

	void game_+attack2()
	{
		if (!(true)) return;
		if (!(CanAttack(GetOwner()))) return;
		float TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_SWIVEL;
		if (!(TIME_DIFF > SWIVEL_DELAY)) return;
		LAST_SWIVEL = GetGameTime();
		if (ATTACK_MODE == "cold")
		{
			// TODO: splayviewanim ent_me ANIM_SWITCH
			ATTACK_MODE = "pierce";
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
		}
		else
		{
			// TODO: splayviewanim ent_me ANIM_LIFT1
			ATTACK_MODE = "cold";
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 1);
		}
		ApplyEffect(GetOwner(), "effects/effect_templock");
		SWIVEL_TIME("remove_lock");
	}

	void remove_lock()
	{
		CallExternal(GetOwner(), "ext_end_templock");
	}

	void register_charge1()
	{
		register_charge2();
	}

	void register_charge2()
	{
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		string reg.attack.range = MELEE_RANGE;
		string reg.attack.dmg = SECONDARY_DMG;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = MELEE_DMG_TYPE;
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = MELEE_STAT;
		string reg.attack.hitchance = MELEE_ACCURACY;
		reg.attack.hitchance += 0.1;
		int reg.attack.priority = 2;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "special_02";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 2.0;
		int reg.attack.reqskill = 4;
		if (BASE_LEVEL_REQ > reg.attack.reqskill)
		{
			reg.attack.reqskill += BASE_LEVEL_REQ;
		}
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 0;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "target";
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = "spellcasting.ice";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 1.5;
		float reg.attack.delay.end = 2.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "blizzard";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 3.0;
		string reg.attack.mpdrain = BLIZZARD_MPDRAIN;
		int reg.attack.reqskill = 15;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 80;
		string reg.attack.dmg = MELEE_DMG;
		reg.attack.dmg *= 4;
		string reg.attack.dmg.range = MELEE_DMG_RANGE;
		string reg.attack.dmg.type = "pierce";
		string reg.attack.energydrain = MELEE_ENERGY;
		reg.attack.energydrain *= 2;
		string reg.attack.stat = "bluntarms";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 4;
		float reg.attack.delay.strike = 0.75;
		float reg.attack.delay.end = 1.0;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "stomp";
		int reg.attack.noise = 1000;
		float reg.attack.chargeamt = 4.0;
		string reg.attack.mpdrain = ICEWAVE_MPDRAIN;
		int reg.attack.reqskill = 27;
		RegisterAttack();
	}

	void blizzard_start()
	{
		if (GetSkillLevel(GetOwner(), "bluntarms.proficiency") < 20)
		{
			SendColoredMessage(GetOwner(), "Northmaul: You do not have sufficient blunt arms skill to use Blizzard attack");
			int EXIT_SUB = 1;
		}
		if (GetEntityMP(GetOwner()) < BLIZZARD_MPDRAIN)
		{
			SendColoredMessage(GetOwner(), "Northmaul: Insufficient mana for Blizzard.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		// TODO: splayviewanim ent_me ANIM_BLIZZARD
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		ScheduleDelayedEvent(1.0, "summon_blizzard");
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void summon_blizzard()
	{
		string pos = GetEntityOrigin(GetOwner());
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		SpawnNPC("monsters/summon/summon_blizzard", pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), 15, 15, "spellcasting.ice"
	}

	void stomp_start()
	{
		if (GetSkillLevel(GetOwner(), "spellcasting.ice") < 15)
		{
			SendColoredMessage(GetOwner(), "Northmaul: You do not have sufficient ice magic skill to use Ice Wave attack");
			int EXIT_SUB = 1;
		}
		if (GetEntityMP(GetOwner()) < ICEWAVE_MPDRAIN)
		{
			SendColoredMessage(GetOwner(), "Northmaul: Insufficient mana for Ice Wave.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (ATTACK_MODE == "cold")
		{
			// TODO: splayviewanim ent_me ANIM_GROUND_SMASH_NORM
		}
		if (ATTACK_MODE == "pierce")
		{
			// TODO: splayviewanim ent_me ANIM_GROUND_SMASH_PIERCE
		}
		PlayOwnerAnim("once", PLAYERANIM_SWING);
		if (!(true)) return;
		// svplaysound: svplaysound 2 10 $get(ent_owner,scriptvar,'PLR_SOUND_SHOUT1')
		EmitSound(2, 10, GetEntityProperty(GetOwner(), "scriptvar"));
	}

	void stomp_strike()
	{
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
		SpawnNPC("monsters/summon/ice_wave_player", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10, 3
	}

	void melee_start()
	{
		if (!(true)) return;
		int RND_ANIM = RandomInt(1, 2);
		if (ATTACK_MODE == "cold")
		{
			if (RND_ANIM == 1)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK1
			}
			if (RND_ANIM == 2)
			{
				// TODO: splayviewanim ent_me ANIM_ATTACK2
			}
		}
		if (ATTACK_MODE == "pierce")
		{
			if (RND_ANIM == 1)
			{
				// TODO: splayviewanim ent_me ANIM_PIERCE_SWING1
			}
			if (RND_ANIM == 2)
			{
				// TODO: splayviewanim ent_me ANIM_PIERCE_SWING2
			}
		}
		if (PLAYERANIM_SWING != "PLAYERANIM_SWING")
		{
			PlayOwnerAnim("once", PLAYERANIM_SWING);
		}
		MELEE_SOUND_DELAY("melee_playsound");
	}

	void item_idle()
	{
		if (("game.item.attacking")) return;
		if (!(GetEntityProperty(GetOwner(), "inhand"))) return;
		if ((IN_PACK)) return;
		if (ATTACK_MODE == "cold")
		{
			// TODO: splayviewanim ent_me 1
		}
		if (ATTACK_MODE == "pierce")
		{
			// TODO: splayviewanim ent_me ANIM_PIERCE_IDLE
		}
	}

	void game_putinpack()
	{
		IN_PACK = 1;
	}

	void game_switchhands()
	{
	}

	void hitwall()
	{
		if (ATTACK_MODE == "cold")
		{
			// PlayRandomSound from: "game.sound.maxvol", SOUND_COLD_HITWALL1, SOUND_COLD_HITWALL2
			array<string> sounds = {"game.sound.maxvol", SOUND_COLD_HITWALL1, SOUND_COLD_HITWALL2};
			EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (ATTACK_MODE == "pierce")
		{
			// PlayRandomSound from: "game.sound.maxvol", SOUND_PIERCE_HITWALL1, SOUND_PIERCE_HITWALL2
			array<string> sounds = {"game.sound.maxvol", SOUND_PIERCE_HITWALL1, SOUND_PIERCE_HITWALL2};
			EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

}

}
