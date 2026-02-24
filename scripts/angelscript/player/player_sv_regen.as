#pragma context server

namespace MS
{

class PlayerSvRegen : CGameScript
{
	int BASE_REGEN_HP;
	int BASE_REGEN_MP;
	float BASE_REGEN_RATE;
	float BLOODSTONE_BONUS_RATE;
	int BLOODSTONE_EQUIPPED;
	string FINAL_REGEN_HP;
	string FINAL_REGEN_MP;
	string FINAL_REGEN_RATE_HP;
	string FINAL_REGEN_RATE_MP;
	float MANARING_BONUS_RATE;
	int MANARING_EQUIPPED;

	PlayerSvRegen()
	{
		BASE_REGEN_RATE = 12.0;
		BASE_REGEN_HP = 1;
		BASE_REGEN_MP = 1;
		BLOODSTONE_EQUIPPED = 0;
		BLOODSTONE_BONUS_RATE = 6.0;
		MANARING_EQUIPPED = 0;
		MANARING_BONUS_RATE = 6.0;
		calculate_new_regen();
	}

	void calculate_new_regen()
	{
		FINAL_REGEN_RATE_HP = BASE_REGEN_RATE;
		FINAL_REGEN_HP = BASE_REGEN_HP;
		FINAL_REGEN_RATE_MP = BASE_REGEN_RATE;
		FINAL_REGEN_MP = BASE_REGEN_MP;
		if ((BLOODSTONE_EQUIPPED))
		{
			calculate_bloodstone_bonus();
		}
		if ((MANARING_EQUIPPED))
		{
			calculate_manaring_bonus();
		}
	}

	void calculate_manaring_bonus()
	{
		string L_MANARING_BONUS_MP = (GetEntityProperty(GetOwner(), "maxmp") / 100);
		FINAL_REGEN_RATE_MP -= MANARING_BONUS_RATE;
		FINAL_REGEN_MP += L_MANARING_BONUS_MP;
	}

	void calculate_bloodstone_bonus()
	{
		string L_BLOODSTONE_BONUS_HP = (GetEntityMaxHealth(GetOwner()) / 100);
		FINAL_REGEN_RATE_HP -= BLOODSTONE_BONUS_RATE;
		FINAL_REGEN_HP += L_BLOODSTONE_BONUS_HP;
	}

	void player_regen_hp()
	{
		SetRepeatDelay(FINAL_REGEN_RATE_HP);
		HealEntity(GetOwner(), FINAL_REGEN_HP);
	}

	void player_regen_mp()
	{
		SetRepeatDelay(FINAL_REGEN_RATE_MP);
		GiveMP(GetOwner());
	}

	void bloodstone_toggle()
	{
		BLOODSTONE_EQUIPPED = param1;
		calculate_new_regen();
	}

	void manaring_toggle()
	{
		MANARING_EQUIPPED = param1;
		calculate_new_regen();
	}

}

}
