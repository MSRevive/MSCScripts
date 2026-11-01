#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandTrollcano : CGameScript
{
	int EFFECT_DURATION;
	int EFFECT_DURATION_STAT;
	int EFFECT_MAXDURATION;
	int EFFECT_MAX_DMG;
	int EFFECT_MINDURATION;
	int EFFECT_MIN_DMG;
	string EFFECT_SCRIPT;
	int MELEE_ATK_DURATION;
	float MELEE_HITCHANCE;
	int MELEE_RANGE;
	string SOUND_SHOOT;
	string SPELL_DAMAGE_TYPE;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;

	MagicHandTrollcano()
	{
		SOUND_SHOOT = "magic/cast.wav";
		MELEE_RANGE = 600;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 1;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "fire";
		SPELL_ENERGYDRAIN = 200;
		SPELL_MPDRAIN = 1;
		SPELL_STAT = "spellcasting.fire";
		EFFECT_MAXDURATION = 30;
		EFFECT_MINDURATION = 8;
		EFFECT_DURATION_STAT = 1;
		EFFECT_DURATION = 20;
		EFFECT_MAX_DMG = 10;
		EFFECT_MIN_DMG = 3;
		EFFECT_SCRIPT = "monsters/summon/volcano_troll";
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Trollcano");
		SetDescription("Trollllololol");
	}

	void spell_casted()
	{
		string pos = param2;
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		DeleteEntity(GetOwner());
	}

}

}
