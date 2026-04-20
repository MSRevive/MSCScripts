#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandLightningDisc : CGameScript
{
	int ANIM_CAST;
	int ANIM_PREPARE;
	string SOUND_CHARGE;
	string SOUND_SHOOT;
	string SPELL_BASE_DMG;
	int SPELL_BASE_SPEED;
	string SPELL_DAMAGE_TYPE;
	float SPELL_DMG_ADJ;
	int SPELL_MPDRAIN;
	int SPELL_NOISE;
	float SPELL_PREPARE_TIME;
	int SPELL_SPEED_ADJ;
	string SPELL_STAT;

	MagicHandLightningDisc()
	{
		ANIM_PREPARE = 7;
		ANIM_CAST = 17;
		SOUND_CHARGE = "none";
		SOUND_SHOOT = "magic/ice_strike.wav";
		SPELL_NOISE = 500;
		SPELL_PREPARE_TIME = 1.5;
		SPELL_DAMAGE_TYPE = "lightning";
		SPELL_MPDRAIN = 20;
		SPELL_STAT = "spellcasting.lightning";
		SPELL_BASE_SPEED = 600;
		SPELL_SPEED_ADJ = 450;
		SPELL_BASE_DMG = (1.5 * GetSkillLevel(GetOwner(), "spellcasting.lightning"));
		SPELL_DMG_ADJ = 0.5;
	}

	void spell_spawn()
	{
		SetName("Lightning Disc");
		SetDescription("Concentrated lightning that will slice through anything.");
	}

	void spell_casted()
	{
		string L_SPEED = SPELL_BASE_SPEED;
		L_SPEED += (CHARGE_MULT * SPELL_SPEED_ADJ);
		string L_MULT = (CHARGE_MULT * SPELL_DMG_ADJ);
		L_MULT += 1;
		string L_DMG = (SPELL_BASE_DMG * L_MULT);
		string L_VEL = /* TODO: $relvel */ $relvel(GetEntityProperty(GetOwner(), "viewangles"), Vector3(0, L_SPEED, 0));
		string L_POS = GetEntityProperty(GetOwner(), "eyepos");
		L_POS += Vector3(0, 0, -2);
		SpawnNPC("effects/lightning_disc", L_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), L_VEL, L_DMG, "spellcasting.lightning"
		// svplaysound: svplaysound game.sound.item game.sound.maxvol SOUND_SHOOT
		EmitSound("game.sound.item", "game.sound.maxvol", SOUND_SHOOT);
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 SOUND_SHOOT
		EmitSound(0, 0, SOUND_SHOOT);
		// svplaysound: svplaysound 0 0 ambient/alien_frantic.wav
		EmitSound(0, 0, "ambient/alien_frantic.wav");
		// svplaysound: svplaysound 0 0 magic/bolt_end.wav
		EmitSound(0, 0, "magic/bolt_end.wav");
	}

}

}
