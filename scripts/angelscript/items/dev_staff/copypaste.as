#pragma context server

namespace MS
{

class Copypaste : CGameScript
{
	string CLIPBOARD_ADDPARAMS;
	int CLIPBOARD_ADD_DIST;
	int CLIPBOARD_DMGMULTI;
	int CLIPBOARD_HPMULTI;
	int CLIPBOARD_KEEP_DIST;
	string CLIPBOARD_NAME;
	string NPC_CLIPBOARD;

	Copypaste()
	{
		NPC_CLIPBOARD = "none";
		CLIPBOARD_NAME = "none";
		CLIPBOARD_DMGMULTI = 1;
		CLIPBOARD_HPMULTI = 1;
		CLIPBOARD_ADDPARAMS = "none";
		CLIPBOARD_KEEP_DIST = 500;
		CLIPBOARD_ADD_DIST = 0;
	}

	void copy_target()
	{
		find_beam_target();
		if (BEAM_TARGET == "none")
		{
			int L_NOTARG = 1;
		}
		if ((IsValidPlayer(BEAM_TARGET)))
		{
			int L_NOTARG = 1;
		}
		if ((L_NOTARG))
		{
			if (NPC_CLIPBOARD != "none")
			{
				SendColoredMessage(GetOwner(), "Clipboard cleared.");
			}
			NPC_CLIPBOARD = "none";
			return;
		}
		NPC_CLIPBOARD = GetScriptName(BEAM_TARGET);
		CLIPBOARD_NAME = GetEntityProperty(BEAM_TARGET, "scriptvar");
		CLIPBOARD_DMGMULTI = GetEntityProperty(BEAM_TARGET, "scriptvar");
		CLIPBOARD_HPMULTI = GetEntityProperty(BEAM_TARGET, "scriptvar");
		CLIPBOARD_ADDPARAMS = GetEntityProperty(BEAM_TARGET, "scriptvar");
		CLIPBOARD_ADD_DIST = (GetEntityWidth(BEAM_TARGET) / 2);
		SendColoredMessage(GetOwner(), "Copied " + GetEntityName(BEAM_TARGET) + GetScriptName(BEAM_TARGET));
	}

	void paste_target()
	{
		if (!(NPC_CLIPBOARD != "none")) return;
		string L_KEEP_DIST = CLIPBOARD_KEEP_DIST;
		L_KEEP_DIST += CLIPBOARD_ADD_DIST;
		string L_POS = /* TODO: $relpos */ $relpos(GetEntityProperty(GetOwner(), "viewangles"), Vector3(0, L_KEEP_DIST, 0));
		L_POS += GetEntityProperty(GetOwner(), "eyepos");
		string L_SPAWN_POINT = TraceLine(GetEntityProperty(GetOwner(), "eyepos"), L_POS);
		SpawnNPC(NPC_CLIPBOARD, L_SPAWN_POINT, ScriptMode::Legacy);
		CallExternal(GetEntityIndex(m_hLastCreated), "game_postspawn", CLIPBOARD_NAME, CLIPBOARD_DMGMULTI, CLIPBOARD_HPMULTI, CLIPBOARD_ADDPARAMS);
	}

}

}
