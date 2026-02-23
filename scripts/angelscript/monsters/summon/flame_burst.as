#pragma context server

namespace MS
{

class FlameBurst : CGameScript
{
	string ACTIVE_SKILL;
	string BURST_SCRIPT_IDX;
	string MY_BASE_DAMAGE;
	string MY_OWNER;
	string ONE_SHOT;
	string OWNER_ISPLAYER;

	FlameBurst()
	{
		const int SCAN_RANGE = 256;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		OWNER_ISPLAYER = IsValidPlayer(param1);
		MY_BASE_DAMAGE = param2;
		if (param3 != "PARAM3")
		{
			ONE_SHOT = param3;
		}
		ACTIVE_SKILL = param4;
		if (ACTIVE_SKILL == "PARAM4")
		{
			ACTIVE_SKILL = "spellcasting.fire";
		}
		ClientEvent("new", "all_in_sight", "monsters/summon/flame_burst_cl", GetEntityIndex(MY_OWNER));
		BURST_SCRIPT_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.25, "big_boom");
		ScheduleDelayedEvent(3.0, "effect_die");
	}

	void effect_die()
	{
		// TODO: UNCONVERTED: clienteffect remove all BURST_SCRIPT_IDX
		DeleteEntity(GetOwner());
	}

	void big_boom()
	{
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, -32), SCAN_RANGE, 0.0, 1.0, 0);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((OWNER_ISPLAYER))
		{
			if (!("game.pvp"))
			{
			}
			if ((IsValidPlayer(param2)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(ONE_SHOT))
		{
			if (!(GetEntityProperty(param2, "haseffect")))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5, MY_OWNER, MY_BASE_DAMAGE, ACTIVE_SKILL);
		}
		if ((ONE_SHOT))
		{
			XDoDamage(GetEntityIndex(param2), "direct", MY_BASE_DAMAGE, 1.0, MY_OWNER, MY_OWNER, ACTIVE_SKILL, "fire");
		}
	}

}

}
