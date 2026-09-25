#pragma context server

namespace MS
{

class FirstParty : CGameScript
{
	void game_party_join()
	{
		string TEXT = "You have joined ";
		TEXT += param1;
		TEXT += ".|You will no longer injure those grouped in the party with you.";
		TEXT += "|The console command 'joinparty <name>' allows you to create";
		TEXT += "|or join a party with a custom name.";
		TEXT += "|NOTE: Currently parties can cause issues with servers.";
		TEXT += "|So their usage is recommended against on non-PvP servers.";
		ShowHelpTip(GetOwner(), "help_party_join", "Party", TEXT);
	}

}

}
