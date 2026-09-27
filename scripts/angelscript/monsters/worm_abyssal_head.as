#pragma context server

namespace MS
{

class WormAbyssalHead : CGameScript
{
	int IS_ACTIVE;
	string MY_OWNER;
	int NPC_NO_HEALTH_BAR;

	WormAbyssalHead()
	{
		NPC_NO_HEALTH_BAR = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		SetRace(GetEntityRace(MY_OWNER));
		IS_ACTIVE = 1;
		snap_loop();
	}

	void OnSpawn() override
	{
		SetName("Abyssal Worm");
		SetModel("monsters/abyssal_worm_hitbox.mdl");
		SetWidth(128);
		SetHeight(150);
		SetFly(true);
		SetGravity(0);
		SetHealth(999999);
	}

	void debug_model()
	{
		SetModelBody(0, 1);
	}

	void snap_loop()
	{
		if (!(IS_ACTIVE)) return;
		string L_POS = GetEntityProperty(MY_OWNER, "attachpos");
		L_POS += "z";
		SetEntityOrigin(GetOwner(), L_POS);
		if ((G_DEVELOPER_MODE))
		{
			string L_BOX_MIN = GetEntityProperty(GetOwner(), "absmin");
			string L_BOX_MAX = GetEntityProperty(GetOwner(), "absmax");
			string L_BOX_EDGE1A = L_BOX_MIN;
			Vector3 L_BOX_EDGE1B = Vector3((L_BOX_MIN).x, (L_BOX_MIN).y, (L_BOX_MAX).z);
			string L_BOX_EDGE2A = L_BOX_MIN;
			Vector3 L_BOX_EDGE2B = Vector3((L_BOX_MAX).x, (L_BOX_MIN).y, (L_BOX_MIN).z);
			string L_BOX_EDGE3A = L_BOX_MIN;
			Vector3 L_BOX_EDGE3B = Vector3((L_BOX_MIN).x, (L_BOX_MAX).y, (L_BOX_MIN).z);
			Effect("beam", "point", "lgtning.spr", 3, L_BOX_EDGE1A, L_BOX_EDGE1B, Vector3(255, 0, 255), 200, 0, 0.1);
			Effect("beam", "point", "lgtning.spr", 3, L_BOX_EDGE2A, L_BOX_EDGE2B, Vector3(255, 0, 255), 200, 0, 0.1);
			Effect("beam", "point", "lgtning.spr", 3, L_BOX_EDGE3A, L_BOX_EDGE3B, Vector3(255, 0, 255), 200, 0, 0.1);
		}
		if (!(IsEntityAlive(MY_OWNER)))
		{
			IS_ACTIVE = 0;
			DeleteEntity(GetOwner());
		}
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "snap_loop");
	}

	void OnDamage(int damage) override
	{
		if (!(GetRelationship(param1) == "enemy")) return;
		Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
		string L_HIT_CHANCE = param4;
		if ((GetEntityProperty(param6, "itemname")).findFirst("proj") == 0)
		{
			float L_HIT_CHANCE = 1.0;
		}
		XDoDamage(MY_OWNER, "direct", param2, L_HIT_CHANCE, param1, param1, "none", param3);
		SetDamage("dmg");
		SetDamage("hit");
		ReturnData(0);
	}

	void game_applyeffect()
	{
		LogDebug("game_applyeffect got PARAM1 PARAM2 PARAM3 PARAM4 PARAM5 PARAM6 PARAM7 PARAM8 PARAM9");
		LogDebug("test game.event.params");
		string L_RETURN = "redirect";
		if (L_RETURN.length() > 0) L_RETURN += ";";
		L_RETURN += MY_OWNER;
		ReturnData(L_RETURN);
	}

	void ext_playsound()
	{
		LogDebug("ext_playsound [ game.event.params ] PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		if ("game.event.params" < 4)
		{
			EmitSound(GetOwner(), param1, param3, param2);
		}
		else
		{
			EmitSound(GetOwner(), param1, param3, param2);
		}
	}

}

}
