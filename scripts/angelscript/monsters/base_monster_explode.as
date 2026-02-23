#pragma context server

namespace MS
{

class BaseMonsterExplode : CGameScript
{
	BaseMonsterExplode()
	{
		const int EXPLOSION_DISTANCE = 120;
		const int EXPLOSION_DAMAGE = 300;
		const float EXPLOSION_DAMAGE_FALLOFF = 0.2;
		const int EXPLOSION_FORCE = 300;
		const string EXPLOSION_TYPE = "blunt_effect";
	}

	void do_explode()
	{
		if ((EXPLOSION_DAMAGE))
		{
			XDoDamage(GetEntityOrigin(GetOwner()), EXPLOSION_DISTANCE, EXPLOSION_DAMAGE, EXPLOSION_DAMAGE_FALLOFF, GetOwner(), GetOwner(), "none", EXPLOSION_TYPE, "dmgevent:beam");
		}
	}

	void beam_dodamage()
	{
		if ((param1))
		{
			string L_TARGET = param2;
			if (GetRelationship(L_TARGET) == "enemy")
			{
				if (EXPLOSION_FORCE != 0)
				{
					string L_YAW = /* TODO: $angles */ $angles(GetEntityOrigin(GetOwner()), GetEntityOrigin(L_TARGET));
					AddVelocity(L_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, L_YAW, 0), Vector3(0, EXPLOSION_FORCE, /* TODO: $math(divide) */ EXPLOSION_FORCE)));
				}
			}
		}
	}

}

}
