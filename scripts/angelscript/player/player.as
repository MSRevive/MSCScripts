#pragma context server

#include "player/player_sound.as"
#include "player/player_animation.as"
#include "player/player_main.as"
#include "player/server/meta_perks.as"
#include "player/player_sv_menu.as"
#include "player/player_sv_regen.as"
#include "help/first_transition.as"
#include "help/first_party.as"
#include "help/first_skillgain.as"
#include "help/first_death.as"
#include "player/player_cl_main.as"
#include "player/player_cl_effects.as"
#include "player/player_cl_effects_world.as"
#include "player/player_cl_effects_water.as"
#include "player/client/halos.as"
#include "player/player_sh_stats.as"
#include "player/externals.as"

namespace MS
{

class Player : CGameScript
{
	void game_precache()
	{
		Precache("[full]");
		Precache("[full]");
		Precache("[full]");
		Precache("[full]");
		Precache("player/player_cl_effects");
		Precache("player/player_cl_effects_water");
		Precache("lgtning.spr");
	}

	void client_activate()
	{
		SetCallback("render", "enable");
	}

}

}
