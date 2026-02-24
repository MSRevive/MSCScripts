#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class DemonBlood : CGameScript
{
	int DEMON_BLOOD;
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;
	string FX_DURATION;
	string FX_INTENSITY;
	int MAKE_NOISE;

	DemonBlood()
	{
		EFFECT_SCRIPT = currentscript;
		EFFECT_ID = "demon_blood";
		EFFECT_FLAGS = "nostack";
	}

	void game_activate()
	{
		FX_DURATION = param1;
		FX_INTENSITY = param2;
		FX_DURATION("end_demon_blood");
		Effect("screenfade", GetOwner(), 0.5, 3, Vector3(255, 0, 0), 255, "fadeout");
		SendColoredMessage(GetOwner(), "The demonic soul fills your heart with rage!");
		EmitSound(GetOwner(), 0, "monsters/troll/trollidle2.wav", 10);
		MAKE_NOISE = 2;
		DEMON_BLOOD = 1;
		ScheduleDelayedEvent(1.0, "demon_blood_loop");
	}

	void demon_blood_loop()
	{
		if (!(DEMON_BLOOD)) return;
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 256, 1.9, 1.9);
		ScheduleDelayedEvent(2.0, "demon_blood_loop");
		MAKE_NOISE += 1;
		if (MAKE_NOISE > 5)
		{
			// PlayRandomSound from: "monsters/troll/trollidle2.wav", "monsters/troll/trollidle.wav"
			array<string> sounds = {"monsters/troll/trollidle2.wav", "monsters/troll/trollidle.wav"};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			MAKE_NOISE = 0;
		}
		HealEntity(GetOwner(), FX_INTENSITY);
		Effect("screenfade", GetOwner(), 0.5, 1, Vector3(255, 0, 0), 150, "fadeout");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 32, 10, 1, 32);
		if (MAKE_NOISE > 0)
		{
			EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
		}
		if (GetEntityHealth(GetOwner()) <= 0)
		{
			KillEntity(GetOwner());
		}
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if ((DEMON_BLOOD))
		{
			if ((IsEntityAlive(param1)))
			{
			}
			if (GetRelationship(param1) == "enemy")
			{
			}
			string DEMON_BLOOD_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting");
			DEMON_BLOOD_DAMAGE *= (2 * /* TODO: $neg */ $neg(FX_INTENSITY));
			if (RandomInt(1, 3) == 1)
			{
			}
			XDoDamage(param1, "direct", DEMON_BLOOD_DAMAGE, 100, GetOwner(), GetOwner(), "none", "magic_effect");
			EmitSound(GetOwner(), 0, "weather/Storm_exclamation.wav", 10);
			// PlayRandomSound from: "monsters/troll/trollpain.wav", "monsters/troll/trollattack.wav"
			array<string> sounds = {"monsters/troll/trollpain.wav", "monsters/troll/trollattack.wav"};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void end_demon_blood()
	{
		DEMON_BLOOD = 0;
		SendColoredMessage(GetOwner(), "The demon blood fades.");
		RemoveScript();
	}

}

}
