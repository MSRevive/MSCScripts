#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandLightningDisc : CGameScript
{
	MagicHandLightningDisc()
	{
		const int ANIM_PREPARE = 7;
		const int ANIM_CAST = 17;
		const string SOUND_CHARGE = "none";
		const string SOUND_SHOOT = "magic/ice_strike.wav";
		const int SPELL_NOISE = 500;
		const float SPELL_PREPARE_TIME = 1.5;
		const string SPELL_DAMAGE_TYPE = "lightning";
		const int SPELL_MPDRAIN = 20;
		const string SPELL_STAT = "spellcasting.lightning";
		const int SPELL_BASE_SPEED = 600;
		const int SPELL_SPEED_ADJ = 450;
		const string SPELL_BASE_DMG = /* TODO: $math(multiply) */ 1.5;
		const float SPELL_DMG_ADJ = 0.5;
	}

	void spell_spawn()
	{
		SetName("Lightning Disc");
		SetDescription("Concentrated lightning that will slice through anything.");
	}

	void spell_casted()
	{
		string L_SPEED = SPELL_BASE_SPEED;
		L_SPEED += /* TODO: $math(multiply) */ CHARGE_MULT;
		string L_MULT = /* TODO: $math(multiply) */ CHARGE_MULT;
		L_MULT += 1;
		string L_DMG = /* TODO: $math(multiply) */ SPELL_BASE_DMG;
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
