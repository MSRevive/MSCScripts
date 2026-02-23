#pragma context server

namespace MS
{

class MeteorDeployer : CGameScript
{
	string AUTO_DESTRUCT;
	string GAME_PVP;
	string MY_OWNER;
	string OWNER_WEAPON;
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("Meteor Deployer");
		LogDebug("game_spawn");
		SetModel("weapons/projectiles.mdl");
		SetModelBody(0, 22);
		SetWidth(2);
		SetHeight(2);
		SetSolid("none");
		SetGravity(0);
		SetRace("beloved");
		SetInvincible(true);
		SetNoPush(true);
		PLAYING_DEAD = 1;
		GAME_PVP = "game.pvp";
		ScheduleDelayedEvent(0.1, "nuke_it");
		ScheduleDelayedEvent(3.0, "remove_me");
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_WEAPON = param2;
		AUTO_DESTRUCT = GetGameTime();
		AUTO_DESTRUCT += 10.0;
		LogDebug("game_dynamically_created GetEntityName(MY_OWNER)");
	}

	void nuke_it()
	{
		LogDebug("nuke_it");
		string MY_DEST = GetEntityOrigin(GetOwner());
		MY_DEST = "z";
		SetMoveDest(MY_DEST);
		TossProjectile("proj_staff_fire_bomb", /* TODO: $relpos */ $relpos(0, 0, -17), "none", 300, 0, 0, "none");
		ClientEvent("new", "all", "effects/sfx_seal", MY_DEST, 256, 2, 2.0);
		ClientEvent("new", "all", "effects/sfx_sprite_in", GetEntityOrigin(GetOwner()), "xflare1.spr", 20, 4.0);
	}

	void ext_fire_bomb()
	{
		LogDebug("ext_fire_bomb");
		if ((IsValidPlayer(MY_OWNER)))
		{
			string L_DMG = GetSkillLevel(MY_OWNER, "spellcasting.fire");
			L_DMG *= 4.5;
			float FALL_OFF = 0.1;
		}
		else
		{
			string L_DMG = GetEntityProperty(MY_OWNER, "scriptvar");
			float FALL_OFF = 0.2;
		}
		if ((IsValidPlayer(MY_OWNER)))
		{
			XDoDamage(param1, 350, L_DMG, FALL_OFF, MY_OWNER, OWNER_WEAPON, "spellcasting.fire", "fire_effect");
		}
		else
		{
			XDoDamage(param1, 350, L_DMG, FALL_OFF, MY_OWNER, MY_OWNER, "none", "fire_effect");
		}
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void game_dodamage()
	{
		LogDebug("game_dodamage PARAM1 GetEntityName(param2)");
		if ((GetEntityProperty(param2, "haseffect"))) return;
		if (!(GAME_PVP))
		{
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((IsValidPlayer(MY_OWNER)))
		{
			string DOT_FIRE = GetSkillLevel(MY_OWNER, "spellcasting.fire");
			DOT_FIRE *= 0.75;
		}
		else
		{
			string DOT_FIRE = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		ApplyEffect(param2, "effects/dot_fire", 5.0, MY_OWNER, DOT_FIRE);
	}

}

}
