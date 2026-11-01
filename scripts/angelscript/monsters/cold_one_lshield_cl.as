#pragma context client

#include "effects/sfx_lightning_shield.as"

namespace MS
{

class ColdOneLshieldCl : CGameScript
{
	string SHIELD_COLOR;

	ColdOneLshieldCl()
	{
		SHIELD_COLOR = Vector3(1.5, 1.5, 2.0);
	}

}

}
