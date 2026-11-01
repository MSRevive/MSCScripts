#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class BluntLrod11 : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	int MELEE_RANGE;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_CHARGE;
	string SOUND_SHOCK1;
	string SOUND_SHOCK2;
	string SOUND_SHOCK3;
	string SOUND_THUNDER;
	int SPEC_ATTACK;

	BluntLrod11()
	{
		BASE_LEVEL_REQ = 20;
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 5;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_BODY_OFS = 94;
		MELEE_ATK_DURATION = 1.1;
		MELEE_DMG_TYPE = "lightning";
		SOUND_CHARGE = "magic/lightning_powerup.wav";
		SOUND_THUNDER = "weather/Storm_exclamation.wav";
		SOUND_SHOCK1 = "debris/zap8.wav";
		SOUND_SHOCK2 = "debris/zap3.wav";
		SOUND_SHOCK3 = "debris/zap4.wav";
		MELEE_RANGE = 60;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.1;
		MELEE_ENERGY = 8;
		MELEE_DMG = 230;
		MELEE_DMG_RANGE = 140;
		MELEE_ACCURACY = 0.75;
		MELEE_STAT = "bluntarms";
		ANIM_PREFIX = "dagger";
	}

	void weapon_spawn()
	{
		SetName("Lightning Rod");
		SetDescription("A rare enchanted mace.");
		SetValue(3000);
		SetHUDSprite("hand", 112);
		SetHUDSprite("trade", 112);
		Precache(MODEL_VIEW);
	}

	void special_02_start()
	{
		SPEC_ATTACK = 1;
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(SPEC_ATTACK))
		{
			if (RandomInt(1, 5) != 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SPEC_ATTACK = 0;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		BURN_DAMAGE /= 2;
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE);
	}

	void register_charge1()
	{
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 4096;
		int reg.attack.dmg = 800;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "lightning";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "spellcasting.lightning";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "bolt";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 18;
		int reg.attack.mpdrain = 50;
		RegisterAttack();
		string reg.attack.type = "strike-land";
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 4096;
		int reg.attack.dmg = 1;
		int reg.attack.dmg.range = 1;
		string reg.attack.dmg.type = "target";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "spellcasting.lightning";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 4;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "repulse";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 4.0;
		int reg.attack.reqskill = 20;
		int reg.attack.mpdrain = 75;
		RegisterAttack();
	}

	void bolt_start()
	{
		PlayViewAnim(5);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
	}

	void bolt_strike()
	{
		PlayViewAnim(5);
		PlayOwnerAnim("critical", "bow_release");
		Effect("beam", "point", "lgtning.spr", 30, GetEntityOrigin(GetOwner()), param2, Vector3(200, 255, 50), 200, 30, 1.0);
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		BURN_DAMAGE *= 2;
		if ((IsEntityAlive(param3)))
		{
			if ((IsValidPlayer(param3)))
			{
				if ("game.pvp" < 1)
				{
				}
				int NO_EFFECT = 1;
			}
			if (!(NO_EFFECT))
			{
			}
			ApplyEffect(param3, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "spellcasting.lightning");
		}
	}

	void OnDeploy() override
	{
		EmitSound(GetOwner(), 0, SOUND_THUNDER, 10);
	}

	void repulse_start()
	{
		PlayViewAnim(5);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		PlayViewAnim(5);
		PlayOwnerAnim("critical", "bow_release");
		SpawnNPC("monsters/summon/lightning_repulse", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 512, 3.0, 0, "spellcasting.lightning"
	}

}

}
