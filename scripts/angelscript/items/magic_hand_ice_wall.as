#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceWall : CGameScript
{
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

	MagicHandIceWall()
	{
		SOUND_SHOOT = "magic/ice_strike.wav";
		MELEE_RANGE = 600;
		MELEE_HITCHANCE = 1.0;
		MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 4;
		SPELL_PREPARE_TIME = 2;
		SPELL_DAMAGE_TYPE = "cold";
		SPELL_ENERGYDRAIN = 75;
		SPELL_MPDRAIN = 25;
		SPELL_STAT = "spellcasting.ice";
		EFFECT_SCRIPT = "monsters/summon/summon_ice_wall";
		Precache(EFFECT_SCRIPT);
	}

	void spell_spawn()
	{
		SetName("Ice Wall");
		SetDescription("Ice Wall - Impede your opponents progress");
	}

	void spell_casted()
	{
		string pos = param2;
		string temp = /* TODO: $get_ground_height */ $get_ground_height(pos);
		string x = (pos).x;
		string y = (pos).y;
		Vector3 pos = Vector3(x, y, temp);
		ICE_WALLS += 1;
		if (ICE_WALLS >= MAX_ICE_WALLS)
		{
			SendPlayerMessage("Too", "many ice walls present , cannot create more");
		}
		if (!(ICE_WALLS < MAX_ICE_WALLS)) return;
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.ice");
		SpawnNPC(EFFECT_SCRIPT, pos, ScriptMode::Legacy); // params: GetEntityProperty(GetOwner(), "angles.yaw"), "firstcast", OWNER_SKILL
	}

}

}
