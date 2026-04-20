#pragma context server

namespace MS
{

class KhazModelTest : CGameScript
{
	void OnSpawn() override
	{
		SetModel("monsters/khaz.mdl");
		SetInvincible(true);
		SetRace("beloved");
		SetSolid("none");
		SetBBox(Vector3(0, 0, 0), Vector3(0, 0, 0));
	}

	void ext_anim()
	{
		PlayAnim("once", param1);
	}

	void npc_suicide()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

	void ext_faceme()
	{
		LogDebug("PARAM1 GetEntityName(param1)");
		SetMoveDest(param1);
	}

}

}
