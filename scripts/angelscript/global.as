#pragma context shared

#include "races.as"
#include "titles.as"
#include "effects.as"
#include "global/sv_globals.as"
#include "global/server/treasure.as"

namespace MS
{

class Global : CGameScript
{
	Global()
	{
		SetGlobalVar("G_MAX_SKILL_LEVEL", 45);
		SetGlobalVar("G_MAX_ITEMS", 100);
		SetGlobalVar("CHAN_AUTO", 0);
		SetGlobalVar("CHAN_WEAPON", 1);
		SetGlobalVar("CHAN_VOICE", 2);
		SetGlobalVar("CHAN_ITEM", 3);
		SetGlobalVar("CHAN_BODY", 4);
		string reg.newchar.weaponlist = "swords_rsword;bows_treebow;smallarms_rknife;axes_rsmallaxe;blunt_hammer1;magic_hand_lightning_weak;polearms_qs";
		string reg.newchar.freeitems = "sheath_belt_holster;sheath_back;sheath_dagger;pack_sack";
		int reg.newchar.gold = 10;
		string reg.hud.spawnbox = "models/hud/spawnbox.mdl";
		string reg.hud.quickslot.select = "ui/buttonrollover.wav";
		string reg.hud.quickslot.confirm = "ui/buttonclick.wav";
		string reg.hud.quickslot.assign = "ui/buttonrollover.wav";
		string reg.hud.char.active_weapon = "idle";
		string reg.hud.char.active_noweap = "attention";
		string reg.hud.char.figet = "stretch";
		string reg.hud.char.highlight = "jump";
		string reg.hud.char.upload = "run";
		string reg.hud.char.inactive = "sitdown";
		float reg.hud.desctext.x = 0.012;
		float reg.hud.desctext.y = 0.72;
		// TODO: registerdefaults
	}

}

}
