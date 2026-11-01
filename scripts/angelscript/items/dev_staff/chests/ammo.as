#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Ammo : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "proj_arrow_blunt", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_bluntwooden", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_broadhead", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_fire", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_frost", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_gholy", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_gpoison", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_holy", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_jagged", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_lightning", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_poison", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_silvertipped", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_arrow_wooden", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_fire", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_iron", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_poison", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_silver", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_steel", 9999, 0, 0, 250);
		AddStoreItem(STORENAME, "proj_bolt_wooden", 9999, 0, 0, 250);
	}

}

}
