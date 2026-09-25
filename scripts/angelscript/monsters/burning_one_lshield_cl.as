#pragma context client

#include "effects/sfx_lightning_shield.as"

namespace MS
{

class BurningOneLshieldCl : CGameScript
{
	string SHIELD_COLOR;

	BurningOneLshieldCl()
	{
		SHIELD_COLOR = Vector3(2.0, 0.5, 0.0);
	}

}

}
