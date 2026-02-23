#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class DotPoison : CGameScript
{
	DotPoison()
	{
		const string EFFECT_ID = "DOT_poison";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "poison_effect";
		const string DOT_IM_AFFECTED = "You have been poisoned!";
		const string DOT_IM_RESIST = "You resist the poison.";
		const string DOT_HE_IMMUNE = "is immune to poison!";
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
			SendPlayerMessage(GetOwner(), "The poison subsides.");
		}
	}

}

}
