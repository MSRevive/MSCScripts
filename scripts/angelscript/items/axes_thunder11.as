#pragma context server

#include "items/axes_battleaxe.as"

namespace MS
{

class AxesThunder11 : CGameScript
{
	int AXE_RESTORED;
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_SWIPE;
	int THROWING_AXE;

	AxesThunder11()
	{
		BASE_LEVEL_REQ = 15;
		MELEE_DMG = 260;
		MODEL_VIEW = "viewmodels/v_2haxes.mdl";
		MODEL_VIEW_IDX = 3;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		SOUND_SWIPE = "weapons/swingsmall.wav";
		MODEL_BODY_OFS = 121;
	}

	void weapon_spawn()
	{
		SetName("Thunderaxe");
		SetDescription("An axe enchanted with lightning magics");
		SetWeight(80);
		SetSize(15);
		SetValue(800);
		SetHUDSprite("hand", 121);
		SetHUDSprite("trade", 121);
	}

	void OnSpawn() override
	{
		string reg.attack.type = "strike-land";
		int reg.attack.noautoaim = 1;
		string reg.attack.keys = "-attack1";
		int reg.attack.range = 4096;
		int reg.attack.dmg = 0;
		int reg.attack.dmg.range = 0;
		string reg.attack.dmg.type = "slash";
		int reg.attack.energydrain = 2;
		string reg.attack.stat = "axehandling";
		float reg.attack.hitchance = 1.0;
		int reg.attack.priority = 3;
		float reg.attack.delay.strike = 0.2;
		float reg.attack.delay.end = 0.9;
		string reg.attack.ofs.startpos = MELEE_STARTPOS;
		string reg.attack.ofs.aimang = MELEE_AIMANGLE;
		string reg.attack.callback = "axethrow";
		string reg.attack.noise = MELEE_NOISE;
		float reg.attack.chargeamt = 3.0;
		int reg.attack.reqskill = 19;
		RegisterAttack();
	}

	void special_02()
	{
		LogDebug("**************** special_02");
	}

	void axethrow_start()
	{
		AXE_RESTORED = 0;
		SetHand("undroppable");
		SetModel("none");
		SetWorldModel("none");
		SetViewModel("viewmodels/v_martialarts.mdl");
		PlayViewAnim(4);
		if ((false))
		{
		}
		else
		{
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") 0
			// svplaysound: svplaysound 0 8  $get(ent_owner,scriptvar,'PLR_SOUND_JAB2')
			EmitSound(0, 8, GetEntityProperty(GetOwner(), "scriptvar"));
		}
	}

	void axethrow_strike()
	{
		PlayOwnerAnim("critical", "bow_release");
		if (!(true)) return;
		string END_TARGET = param2;
		string MY_VIEW = GetEntityProperty(GetOwner(), "viewangles");
		END_TARGET += /* TODO: $relpos */ $relpos(MY_VIEW, Vector3(0, 128, 0));
		if ((IsEntityAlive(param3)))
		{
			if ((IsValidPlayer(param3)))
			{
				if ("game.pvp" < 1)
				{
				}
				int NO_EFFECT = 1;
			}
			if (!(NO_EFFECT))
			{
			}
			LogDebug("applying shock");
			string L_BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
			L_BURN_DAMAGE /= 2;
			L_BURN_DAMAGE += Random(1, 3);
			if (L_BURN_DAMAGE < 5)
			{
				int L_BURN_DAMAGE = 5;
			}
			ApplyEffect(param3, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), L_BURN_DAMAGE, "axehandling");
		}
		string DMG_AXE = GetSkillLevel(GetOwner(), "axehandling");
		SpawnNPC("monsters/summon/sorc_axe", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), END_TARGET, DMG_AXE, GetEntityIndex(GetOwner()), "axehandling"
		ApplyEffect(GetOwner(), "effects/effect_templock");
	}

	void restore_axe_cl()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		if ((AXE_RESTORED)) return;
		PlayViewAnim(ANIM_LIFT1);
	}

	void catch_axe()
	{
		LogDebug("Caught Axe");
		if ((true))
		{
			CallClientItemEvent(GetOwner(), "restore_axe_cl");
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
		}
		if ((true))
		{
			// TODO: setviewmodelprop ent_me submodel GetEntityProperty(GetOwner(), "scriptvar") MODEL_VIEW_IDX
		}
		CallExternal(GetOwner(), "ext_end_templock");
		THROWING_AXE = 0;
		SetHand("both");
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		string L_BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		L_BURN_DAMAGE /= 2;
		L_BURN_DAMAGE += Random(1, 3);
		if (L_BURN_DAMAGE < 5)
		{
			int L_BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), L_BURN_DAMAGE, "axehandling");
	}

	void melee_start()
	{
		SetViewModel(MODEL_VIEW);
		SetModel(MODEL_WORLD);
		SetWorldModel(MODEL_WORLD);
		AXE_RESTORED = 1;
	}

}

}
