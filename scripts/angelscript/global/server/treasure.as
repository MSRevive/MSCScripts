#pragma context server

namespace MS
{

class Treasure : CGameScript
{
	string CUR_ITEM;
	string LOAD_ITEMS;

	Treasure()
	{
		SetGlobalVar("G_NOOB_ITEMS1", "smallarms_royaldagger;smallarms_stiletto;blunt_maul;blunt_mace;blunt_hammer1;blunt_hammer2;bows_treebow;bows_orcbow;smallarms_rknife;smallarms_knife;smallarms_dagger;bows_shortbow;shields_buckler;health_apple;");
		SetGlobalVar("G_NOOB_ITEMS2", "skin_boar;skin_boar_heavy;skin_ratpelt;skin_bear;drink_ale;drink_mead;swords_katana;drink_wine;blunt_warhammer;swords_rsword;swords_shortsword;smallarms_dirk;swords_longsword;swords_scimitar;");
		SetGlobalVar("G_NOOB_ITEMS3", "swords_bastardsword;item_galat_note_10;axes_rsmallaxe;axes_smallaxe;axes_axe;axes_battleaxe;axes_greataxe;axes_scythe;axes_2haxe;gold_pouch_5;gold_pouch_10;gold_pouch_25;sheath_holster_snakeskin;");
		SetGlobalVar("G_NOOB_ITEMS4", "sheath_belt_holster_snakeskin;blunt_gauntlets_leather;sheath_dagger_snakeskin;sheath_belt_snakeskin;sheath_belt_holster_snakeskin;sheath_axe_snakeskin;sheath_blunt_snakeskin;sheath_dagger;sheath_back;sheath_belt;");
		SetGlobalVar("G_NOOB_ITEMS5", "sheath_belt_holster;sheath_back_holster;sheath_belt_snakeskin;pack_bigsack;pack_xbowquiver;pack_quiver;armor_leather;armor_leather_torn;scroll_glow;swords_skullblade2;smallarms_craftedknife2;");
		SetGlobalVar("G_NOOB_ITEMS6", "polearms_qs;polearms_sp;");
		SetGlobalVar("G_NOOB_SETS", 6);
		SetGlobalVar("G_GOOD_ITEMS1", "smallarms_huggerdagger2;smallarms_craftedknife;swords_katana2;swords_skullblade;swords_skullblade3;scroll_fire_dart;scroll_lightning_weak;armor_leather_studded;shields_ironshield;pack_archersquiver;");
		SetGlobalVar("G_GOOD_ITEMS2", "item_crystal_return;swords_nkatana;armor_helm_bronze;gold_pouch_50;gold_pouch_100;item_light_crystal;scroll2_lightning_weak;bows_longbow;scroll2_glow;scroll_poison;sheath_spellbook;");
		SetGlobalVar("G_GOOD_ITEMS3", "sheath_back_snakeskin;blunt_greatmaul;pack_heavybackpack;armor_helm_plate;armor_helm_mongol;armor_plate;armor_mongol;polearms_ba;mana_lleadfoot;");
		SetGlobalVar("G_GOOD_SETS", 3);
		SetGlobalVar("G_GREAT_ITEMS1", "smallarms_huggerdagger;swords_katana3;bows_swiftbow;smallarms_craftedknife3;swords_skullblade4;scroll_summon_undead;armor_knight;armor_helm_knight;shields_lironshield;blunt_gauntlets;scroll2_rejuvenate;blunt_hammer3;");
		SetGlobalVar("G_GREAT_ITEMS2", "item_crystal_reloc;scroll2_fire_dart;scroll2_frost_xolt;scroll2_poison;armor_fireliz;armor_salamander;gold_pouch_200;scroll2_summon_rat;mana_leadfoot;mana_prot_spiders;swords_liceblade;swords_poison1;scroll_summon_rat;");
		SetGlobalVar("G_GREAT_ITEMS3", "armor_leather_gaz1;scroll2_summon_undead;axes_poison1;scroll_fire_ball;polearms_hal;mana_lleadfoot;");
		SetGlobalVar("G_GREAT_SETS", 3);
		SetGlobalVar("G_NOOB_ARROWS", "proj_arrow_blunt;proj_arrow_bluntwooden;proj_arrow_wooden;proj_arrow_broadhead;proj_arrow_silvertipped;proj_bolt_wooden;proj_bolt_wooden");
		SetGlobalVar("G_GOOD_ARROWS", "proj_arrow_blunt;proj_arrow_broadhead;proj_arrow_silvertipped;proj_arrow_jagged;proj_arrow_fire;proj_bolt_iron");
		SetGlobalVar("G_GREAT_ARROWS", "proj_arrow_blunt;proj_arrow_jagged;proj_arrow_poison;proj_arrow_frost;proj_arrow_holy;proj_bolt_steel");
		SetGlobalVar("G_EPIC_ARROWS", "proj_arrow_blunt;proj_arrow_poison;proj_arrow_frost;proj_arrow_holy;proj_arrow_gholy;proj_arrow_gpoison;proj_arrow_lightning;proj_bolt_fire;proj_bolt_fire;proj_bolt_steel;proj_bolt_steel;proj_bolt_silver");
		if (/* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_EPIC) == -1)
		{
			CreateGlobalArray("G_ARRAY_EPIC");
			LOAD_ITEMS = "smallarms_huggerdagger3;6;scroll_fire_wall;5;smallarms_huggerdagger4;10;scroll_rejuvenate;10;smallarms_craftedknife4;10;mana_demon_blood;1";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
			LOAD_ITEMS = "scroll2_lightning_chain;1;scroll_lightning_chain;1;item_galat_note_100;10;mana_regen;1;mana_vampire;1;swords_spiderblade;5;blunt_granitemace;5;swords_iceblade;2;gold_pouch_500;10";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
			LOAD_ITEMS = "scroll_volcano;1;scroll_ice_wall;1;smallarms_bone_blade;1;mana_forget;10;mana_speed;1;mana_gprotection;1;mana_protection;2;blunt_granitemaul;5;mana_resist_cold;10;scroll2_fire_ball;3";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
			LOAD_ITEMS = "mana_immune_fire;1;mana_immune_poison;1;scroll2_ice_wall;1;axes_thunder11;3;scroll2_turn_undead;5;scroll2_fire_wall;1";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
			LOAD_ITEMS = "blunt_gauntlets_serpant;1;armor_helm_gaz1;1;smallarms_flamelick;2;armor_helm_golden;3;mana_resist_fire;5;mana_immune_cold;1";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
			LOAD_ITEMS = "polearms_tri;5;polearms_nag;1;mana_lsb;1;mana_bravery;1;item_crystal_reloc;3;mana_lleadfoot;5;mana_st;5;armor_helm_alvo1;1";
			for (int i = 0; i < GetTokenCount(LOAD_ITEMS, ";"); i++)
			{
				add_epic_array();
			}
		}
		SetGlobalVar("G_NOOB_POTS", "health_apple;health_mpotion;health_lpotion;mana_mpotion;mana_resist_fire;mana_prot_spiders;mana_bravery;mana_fbrand;mana_faura;mana_paura;mana_st");
		SetGlobalVar("G_GOOD_POTS", "health_spotion;mana_forget;mana_resist_cold;mana_vampire;mana_prot_spiders;mana_bravery;mana_fbrand;mana_faura;mana_paura;mana_lsb;mana_lleadfoot;mana_st");
		SetGlobalVar("G_GREAT_POTS", "mana_forget;mana_protection;mana_resist_cold;mana_demon_blood;mana_regen;mana_immune_lightning;mana_bravery;mana_fbrand;mana_faura;mana_paura;mana_lsb;mana_lleadfoot");
		SetGlobalVar("G_EPIC_POTS", "mana_gprotection;mana_protection;mana_immune_cold;mana_immune_fire;mana_immune_poison;mana_demon_blood;mana_regen;mana_vampire;mana_leadfoot;mana_immune_lightning;mana_faura;mana_lsb;mana_sb;");
	}

	void add_epic_array()
	{
		string CUR_IDX = i;
		CUR_ITEM = GetToken(LOAD_ITEMS, CUR_IDX, ";");
		if ((CUR_ITEM).length() <= 3)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CUR_IDX += 1;
		string CUR_FREQ = GetToken(LOAD_ITEMS, CUR_IDX, ";");
		for (int i = 0; i < CUR_FREQ; i++)
		{
			add_epic_item();
		}
	}

	void add_epic_item()
	{
		GlobalArrayAdd("G_ARRAY_EPIC", CUR_ITEM);
	}

}

}
