#pragma context server

namespace MS
{

class BaseBanker : CGameScript
{
	int CHECK_REASON;
	int STORAGE_ACCOUNT_COST;
	string STORAGE_DISPLAYNAME;
	float STORAGE_FEERATIO;
	string STORAGE_NAME;

	BaseBanker()
	{
		STORAGE_DISPLAYNAME = "Edana Bank";
		STORAGE_NAME = "edanastorage";
		STORAGE_FEERATIO = 0.10;
		STORAGE_ACCOUNT_COST = 20;
		DeleteEntity(GetOwner());
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		CHECK_REASON = 0;
		Storage("checkaccount", STORAGE_NAME, m_hLastUsed, "used_checkaccount");
	}

	void used_checkaccount_success()
	{
		bank_trade(m_hLastUsed);
	}

	void used_checkaccount_failed()
	{
		SayText("Sorry , you don t have an account with us");
		OpenMenu(m_hLastUsed);
		ScheduleDelayedEvent(1, "speech_makeaccount");
	}

	void speech_makeaccount()
	{
		SayText("You can create an account with this bank for " + STORAGE_ACCOUNT_COST + " gold");
	}

	void game_recvoffer_gold()
	{
		Storage("checkaccount", STORAGE_NAME, m_hLastUsed, "offer_checkacct");
	}

	void offer_checkacct_success()
	{
		ReceiveOffer("reject");
		SayText("You already have an account with us.");
	}

	void offer_checkacct_failed()
	{
		if ("game.offer.gold" >= STORAGE_ACCOUNT_COST)
		{
			ReceiveOffer("accept");
			bank_openaccount("ent_lastgave");
		}
		else
		{
			ReceiveOffer("reject");
			bank_openaccount_failed("ent_lastgave");
		}
	}

	void game_menu_getoptions()
	{
		Storage("checkaccount", STORAGE_NAME, param1, "menuitem_checkacct");
	}

	void menuitem_checkacct_failed()
	{
		string reg.mitem.id = "payment";
		string reg.mitem.title = "Open Account";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:";
		string reg.mitem.callback = "bank_openaccount";
		string reg.mitem.cb_failed = "menu_recv_payment_failed";
	}

	void menuitem_checkacct_succes()
	{
		string reg.mitem.id = "bank";
		string reg.mitem.title = "Bank";
		string reg.mitem.type = "callback";
		string reg.mitem.data = "gold:";
		string reg.mitem.callback = "bank_trade";
		string reg.mitem.cb_failed = "";
	}

	void bank_trade()
	{
		Storage("trade", STORAGE_NAME, param1, STORAGE_FEERATIO, STORAGE_DISPLAYNAME);
	}

	void bank_openaccount()
	{
		Storage("openaccount", STORAGE_NAME, param1);
		SayText("Thank you! Your new account with " + STORAGE_DISPLAYNAME + " is open!");
		PlayAnim("once", "yes");
	}

	void bank_openaccount_failed()
	{
		SayText(I + " m sorry, we have a business to run.  An Account costs STORAGE_ACCOUNT_COST gold.");
		PlayAnim("once", "no");
	}

}

}
