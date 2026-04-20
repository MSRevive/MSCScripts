#pragma context server

namespace MS
{

class LightningDisc : CGameScript
{
	string FX_DMG;
	string FX_OWNER;
	string FX_SKILL;
	string FX_VELOCITY;
	float FX_WOBBLE_MULT;
	string FX_WOBBLE_SEQ;
	string MY_LIGHT_SCRIPT;
	int SEQ_IDX;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.2);
		XDoDamage(GetEntityOrigin(GetOwner()), 120, FX_DMG, 0, FX_OWNER, GetOwner(), FX_SKILL, "lightning_effect", "dmgevent:*disc");
	}

	void OnSpawn() override
	{
		SetName("laserdisc");
		SetModel("weapons/magic/seals.mdl");
		SetModelBody(0, 31);
		SetProp(GetOwner(), "movetype", 11);
		SetProp(GetOwner(), "friction", 0.1);
		SetProp(GetOwner(), "scale", 10);
		SetProp(GetOwner(), "solid", 0);
		SetWidth(5);
		SetHeight(1);
		SetInvincible(true);
		SetRace("beloved");
		ScheduleDelayedEvent(10.0, "fx_die");
		ClientEvent("persist", "all", "monsters/lighted_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 40), 96);
		MY_LIGHT_SCRIPT = "game.script.last_sent_id";
		SetMonsterClip(0);
	}

	void game_dynamically_created()
	{
		FX_OWNER = param1;
		FX_VELOCITY = param2;
		FX_DMG = param3;
		FX_SKILL = param4;
		FX_WOBBLE_SEQ = "0;1;2;3;2;1;0;-1;-2;-3;-2;-1";
		SEQ_IDX = 0;
		FX_WOBBLE_MULT = 0.07;
		ScheduleDelayedEvent(0.05, "wobble");
		SetVelocity(GetOwner(), FX_VELOCITY);
		// svplaysound: svplaysound 3 4 ambient/alien_frantic.wav
		EmitSound(3, 4, "ambient/alien_frantic.wav");
	}

	void disc_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_lightning", 5, FX_OWNER, GetSkillLevel(FX_OWNER, "spellcasting.lightning"), "spellcasting.lightning");
	}

	void wobble()
	{
		string L_IDX = GetToken(FX_WOBBLE_SEQ, SEQ_IDX, ";");
		SEQ_IDX += 1;
		if (SEQ_IDX >= GetTokenCount(FX_WOBBLE_SEQ, ";"))
		{
			SEQ_IDX = 0;
		}
		string L_ANG = GetEntityAngles(GetOwner());
		L_ANG += Vector3((L_IDX * FX_WOBBLE_MULT), 7, 0);
		SetAngles("face");
		FX_WOBBLE_MULT += 0.03;
		ScheduleDelayedEvent(0.05, "wobble");
	}

	void fx_die()
	{
		ClientEvent("new", "all", "effects/sfx_prism_blast", GetEntityOrigin(GetOwner()), 100, "lightning");
		// svplaysound: svplaysound 3 10 magic/bolt_end.wav
		EmitSound(3, 10, "magic/bolt_end.wav");
		SetModel("none");
		DeleteEntity(GetOwner());
		ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		ClientEvent("update", "all", MY_LIGHT_SCRIPT, "remove_me");
	}

}

}
