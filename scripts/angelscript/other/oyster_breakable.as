#pragma context server

#include "monsters/debug.as"

namespace MS
{

class OysterBreakable : CGameScript
{
	int DAMAGE_THRESHOLD;
	string INC_DAMAGE_TYPE;
	string MAP_TRIGGER;
	string NEXT_IMMUNE_WARN;
	string OBJECT_NAME;
	int PLAYING_DEAD;
	string SOUND_BREAK;
	string SOUND_RESIST1;
	string SOUND_RESIST2;
	string SOUND_RESIST3;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int VALID_DAMAGE;
	string VALID_DAMAGE_TYPES;

	OysterBreakable()
	{
		VALID_DAMAGE_TYPES = "blunt;fire";
		OBJECT_NAME = "web";
		MAP_TRIGGER = "break_web1";
		DAMAGE_THRESHOLD = 100;
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_STRUCK3 = "debris/flesh3.wav";
		SOUND_RESIST1 = "weapons/bullet_hit1.wav";
		SOUND_RESIST2 = "weapons/bullet_hit2.wav";
		SOUND_RESIST3 = "weapons/ric1.wav";
		SOUND_BREAK = "debris/bustflesh1.wav";
	}

	void OnSpawn() override
	{
		SetHealth(99999);
		SetName(OBJECT_NAME);
		PLAYING_DEAD = 1;
	}

	void OnDamage(int damage) override
	{
		if ((AM_BROKE)) return;
		VALID_DAMAGE = 0;
		INC_DAMAGE_TYPE = param3;
		for (int i = 0; i < GetTokenCount(VALID_DAMAGE_TYPES, ";"); i++)
		{
			check_type();
		}
		if (!(VALID_DAMAGE))
		{
			if (GetGameTime() > NEXT_IMMUNE_WARN)
			{
			}
			NEXT_IMMUNE_WARN = GetGameTime();
			NEXT_IMMUNE_WARN += 5.0;
			SendColoredMessage(param1, "The " + GetEntityName(GetOwner()) + " seems resistant to this weapon.");
			// PlayRandomSound from: SOUND_RESIST1, SOUND_RESIST2, SOUND_RESIST3
			array<string> sounds = {SOUND_RESIST1, SOUND_RESIST2, SOUND_RESIST3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((VALID_DAMAGE))
		{
			if (param2 >= DAMAGE_THRESHOLD)
			{
				EmitSound(GetOwner(), 0, SOUND_BREAK, 10);
				UseTrigger(MAP_TRIGGER);
				SetInvincible(true);
				AM_BROKE = 1;
				ScheduleDelayedEvent(0.1, "remove_me");
			}
			else
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				SendColoredMessage(param1, "The " + GetEntityName(GetOwner()) + " budges , but it seems it must be struck with more force. int(param2) of DAMAGE_THRESHOLD");
				SetDamage("dmg");
				SetHealth(9999);
			}
		}
	}

	void check_type()
	{
		string CUR_TYPE = GetToken(VALID_DAMAGE_TYPES, i, ";");
		if (!((INC_DAMAGE_TYPE).findFirst(CUR_TYPE) == 0)) return;
		VALID_DAMAGE = 1;
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
		RemoveScript();
	}

}

}
