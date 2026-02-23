#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandTrollcano : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandTrollcano()
	{
		const string SOUND_SHOOT = "magic/cast.wav";
		const int MELEE_RANGE = 600;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 1;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "fire";
		const int SPELL_ENERGYDRAIN = 200;
		const int SPELL_MPDRAIN = 1;
		const string SPELL_STAT = "spellcasting.fire";
		const int EFFECT_MAXDURATION = 30;
		const int EFFECT_MINDURATION = 8;
		const int EFFECT_DURATION_STAT = 1;
		const int EFFECT_DURATION = 20;
		const int EFFECT_MAX_DMG = 10;
		const int EFFECT_MIN_DMG = 3;
		const string EFFECT_SCRIPT = "monsters/summon/volcano_troll";
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
