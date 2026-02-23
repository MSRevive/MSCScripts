#pragma context server

namespace MS
{

class FirstDeath : CGameScript
{
	void OnDeath(CBaseEntity@ attacker) override
	{
		string TEXT = "You have DIED! ";
		TEXT += "|When you die you lose 5% of your gold!";
		ShowHelpTip(GetOwner(), "help_death", "Death", TEXT);
		string OPPONENT_HP = GetEntityMaxHealth(m_hLastStruck);
		string MY_HP = GetEntityMaxHealth(GetOwner());
		string MY_HP_TEN = MY_HP;
		MY_HP_TEN *= 10;
		if (!(MY_HP < 700)) return;
		if (OPPONENT_HP > MY_HP_TEN)
		{
			SendInfoMsg(GetOwner(), "OVERPOWERED! Your opponent has more than TEN TIMES your HP! You should probably retreat!");
		}
		string REGEN_WARN = GetMonsterMaxHP();
		REGEN_WARN *= 2.0;
		REGEN_WARN += 1000;
	}

}

}
