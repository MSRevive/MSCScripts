#pragma context server

#include "traps/fire_wall.as"

namespace MS
{

class OrcFireWall : CGameScript
{
	string FLAME_ID;
	int FLAMING;
	int MY_BASE_DMG;
	string MY_OWNER;
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		PLAYING_DEAD = 1;
		SetName("Fire Wall Trap");
		SetHealth(5);
		SetRace("orc");
		SetInvincible(true);
		SetRoam(false);
		SetSkillLevel(0);
		SetHearingSensitivity(0);
		SetModel("null.mdl");
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(0.1, "flames_start");
		MY_OWNER = GetEntityIndex(GetOwner());
		MY_BASE_DMG = 120;
		string REMOVE_TIME = FIRE_DURATION;
		REMOVE_TIME -= 0.5;
		REMOVE_TIME("remove_invul");
		FIRE_DURATION("firewall_death");
		SetAngles("face.y");
		ClientEvent("new", "all", currentscript, GetEntityOrigin(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"));
		FLAME_ID = "game.script.last_sent_id";
	}

	void game_dodamage()
	{
		if ((IsEntityAlive(param2)))
		{
			if (GetRelationship(GetOwner()) != "ally")
			{
				ApplyEffect(param2, "effects/dot_fire", 2, GetEntityIndex(GetOwner()), MY_BASE_DMG);
			}
		}
	}

	void firewall_death()
	{
		FLAMING = 0;
		firewall_end_cl();
		EmitSound(GetOwner(), CHAN_ITEM, "items/torch1.wav", "game.sound.silentvol");
		ClientEvent("remove", "all", FLAME_ID);
		RemoveScript();
		DeleteEntity(GetOwner());
	}

}

}
