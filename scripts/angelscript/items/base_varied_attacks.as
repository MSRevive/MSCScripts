#pragma context server

namespace MS
{

class BaseVariedAttacks : CGameScript
{
	int BV_EXTRA_ANIM_STAB;
	int BV_EXTRA_ANIM_SWIPE;
	int BV_REGULAR_ATTACK_ANIM;
	string CUR_ATTACK_ANIM;

	BaseVariedAttacks()
	{
		BV_EXTRA_ANIM_STAB = 6;
		BV_EXTRA_ANIM_SWIPE = 5;
		BV_REGULAR_ATTACK_ANIM = 2;
	}

	void check_attack_anim()
	{
		if ((BITEM_UNDERSKILLED)) return;
		if ((IsKeyDown(GetOwner(), "moveleft")))
		{
			int L_SWIPE = 1;
		}
		if ((IsKeyDown(GetOwner(), "moveright")))
		{
			int L_SWIPE = 1;
		}
		if ((IsKeyDown(GetOwner(), "forward")))
		{
			int L_STAB = 1;
		}
		if ((IsKeyDown(GetOwner(), "back")))
		{
			int L_STAB = 1;
		}
		if ((L_STAB))
		{
			CUR_ATTACK_ANIM = BV_EXTRA_ANIM_STAB;
			string CUR_DMG = MELEE_DMG;
			string CUR_ACC = MELEE_ACCURACY;
			CUR_DMG *= 1.5;
			CUR_ACC *= 0.75;
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((L_SWIPE))
		{
			CUR_ATTACK_ANIM = BV_EXTRA_ANIM_SWIPE;
			string CUR_DMG = MELEE_DMG;
			string CUR_ACC = MELEE_ACCURACY;
			CUR_DMG *= 0.75;
			CUR_ACC *= 1.5;
			SetAttackProp("ent_me", 0);
			SetAttackProp("ent_me", 0);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CUR_ATTACK_ANIM = BV_REGULAR_ATTACK_ANIM;
		string CUR_DMG = MELEE_DMG;
		string CUR_ACC = MELEE_ACCURACY;
		SetAttackProp("ent_me", 0);
		SetAttackProp("ent_me", 0);
	}

}

}
