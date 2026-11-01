#pragma context server

namespace MS
{

class ShadowFormBossFx : CGameScript
{
	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		PlayAnim("once", "rot");
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 2, Vector3(200, 0, 200), 100, 200, 10.0);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, GetOwner(), 3, Vector3(200, 0, 200), 100, 200, 10.0);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 3, GetOwner(), 4, Vector3(200, 0, 200), 100, 200, 10.0);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 1, GetOwner(), 1, Vector3(200, 0, 200), 100, 200, 10.0);
	}

	void OnSpawn() override
	{
		SetNoPush(true);
		SetInvincible(true);
		SetFly(true);
		SetGravity(0);
		SetModel("monsters/shadowform_beams.mdl");
		SetIdleAnim("rot");
		SetMoveAnim("rot");
		SetSolid("none");
		PlayAnim("once", "rot");
	}

	void remove_beams()
	{
		DeleteEntity(GetOwner());
	}

}

}
