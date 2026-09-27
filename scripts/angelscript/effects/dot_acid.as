#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotAcid : CGameScript
{
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DotAcid()
	{
		EFFECT_ID = "DOT_acid";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "acid_effect";
		DOT_IM_AFFECTED = "You have been acid burned!";
		DOT_IM_RESIST = "You resist the acid attack.";
		DOT_HE_IMMUNE = "is immune to acid!";
	}

	void dot_start()
	{
		string DUR_RATIO = GetEntityProperty(DOT_ATTACKER, "scriptvar");
		if (DUR_RATIO != 0)
		{
			EFFECT_DURATION *= DUR_RATIO;
		}
		if ((IsValidPlayer(GetOwner())))
		{
			// svplaysound: if ( $get(ent_me,isplayer) ) svplaysound game.sound.body game.sound.maxvol $get(ent_me,scriptvar,'PLR_SOUND_STOMACHHIT1')
			EmitSound("game.sound.body", "game.sound.maxvol", GetEntityProperty(GetOwner(), "scriptvar"));
		}
		Effect("glow", GetOwner(), Vector3(75, 215, 0), 72, EFFECT_DURATION, EFFECT_DURATION);
		ApplyEffect(GetOwner(), "effects/debuff_acid", EFFECT_DURATION);
		// TODO: hud.addstatusicon ent_me hud/status/alpha_dot_poison EFFECT_ID EFFECT_DURATION
	}

	void dot_effect()
	{
		Effect("screenfade", GetOwner(), 0.2, 0, Vector3(75, 215, 0), 30, "fadein");
	}

	void effect_die()
	{
		if (!(DOT_RESISTED))
		{
			SendPlayerMessage(GetOwner(), "The acid burns out.");
		}
	}

}

}
