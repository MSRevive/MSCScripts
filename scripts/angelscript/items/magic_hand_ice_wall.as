#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandIceWall : CGameScript
{
	int SPELL_SKILL_REQUIRED;

	MagicHandIceWall()
	{
		const string SOUND_SHOOT = "magic/ice_strike.wav";
		const int MELEE_RANGE = 600;
		const float MELEE_HITCHANCE = 1.0;
		const int MELEE_ATK_DURATION = 1;
		SPELL_SKILL_REQUIRED = 4;
		const int SPELL_PREPARE_TIME = 2;
		const string SPELL_DAMAGE_TYPE = "cold";
		const int SPELL_ENERGYDRAIN = 75;
		const int SPELL_MPDRAIN = 25;
		const string SPELL_STAT = "spellcasting.ice";
		const string EFFECT_SCRIPT = "monsters/summon/summon_ice_wall";
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
