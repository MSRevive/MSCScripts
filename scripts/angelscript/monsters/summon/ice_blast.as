#pragma context server

#include "monsters/base_noclip.as"

namespace MS
{

class IceBlast : CGameScript
{
	int ATTACK_RADIUS;
	int BALL_SPEED;
	string BLAST_MODEL;
	string FINAL_DEST;
	string FREEZE_DURATION;
	int FREEZING;
	int FWD_SPEED;
	float HUM_LENGTH;
	string ICE_OLD_POS;
	string IGNORE_TARGET;
	string LIGHTNING_SPRITE;
	int MODEL_BODY_OFS;
	string MY_OWNER;
	string NPC_NOCLIP_DEST;
	string OWNER_ANGLES;
	string PLAYER_SPAWNED;
	string PROJ_ANIM_IDLE;
	string SOUND_HUM;
	string SOUND_ZAP1;
	string SOUND_ZAP2;
	string SOUND_ZAP3;
	float STUCKCHECK_FREQ;

	IceBlast()
	{
		SOUND_HUM = "magic/pulsemachine_noloop.wav";
		HUM_LENGTH = 1.7;
		STUCKCHECK_FREQ = 0.5;
		BLAST_MODEL = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 1;
		PROJ_ANIM_IDLE = "idle_iceball";
		SOUND_ZAP1 = "debris/beamstart14.wav";
		SOUND_ZAP2 = "debris/beamstart14.wav";
		SOUND_ZAP3 = "debris/zap1.wav";
		BALL_SPEED = 100;
		LIGHTNING_SPRITE = "lgtning.spr";
		ATTACK_RADIUS = 196;
		FWD_SPEED = 10;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		FREEZE_DURATION = param2;
		PLAYER_SPAWNED = IsValidPlayer(param1);
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetProp(GetOwner(), "solid", 0);
		OWNER_ANGLES = GetEntityAngles(MY_OWNER);
		SetAngles("face");
		FINAL_DEST = /* TODO: $relpos */ $relpos(0, 20000, 0);
		if (param3 != "PARAM3")
		{
			FINAL_DEST = param3;
		}
		NPC_NOCLIP_DEST = FINAL_DEST;
	}

	void OnSpawn() override
	{
		SetName("Freezing Sphere");
		SetHealth(1);
		SetInvincible(true);
		SetFly(true);
		SetGravity(0.0);
		SetFOV(359);
		SetRace("beloved");
		SetWidth(1);
		SetHeight(1);
		SetMonsterClip(0);
		SetModel(BLAST_MODEL);
		SetModelBody(0, MODEL_BODY_OFS);
		SetSolid("not");
		SetIdleAnim(PROJ_ANIM_IDLE);
		SetMoveAnim(PROJ_ANIM_IDLE);
		SetAnimFrameRate(2);
		PlayAnim("once", "idle");
		FREEZING = 1;
		ICE_OLD_POS = GetEntityOrigin(GetOwner());
		ScheduleDelayedEvent(0.1, "freeze_loop");
		ScheduleDelayedEvent(0.5, "hum_loop");
		SetProp(GetOwner(), "movetype", "const.movetype.noclip");
		SetProp(GetOwner(), "solid", 0);
		ScheduleDelayedEvent(10.0, "remove_me");
	}

	void hum_loop()
	{
		if (!(FREEZING)) return;
		HUM_LENGTH("hum_loop");
		EmitSound(GetOwner(), CHAN_BODY, SOUND_HUM, 10);
	}

	void freeze_loop()
	{
		if (!(FREEZING)) return;
		ScheduleDelayedEvent(0.1, "freeze_loop");
		if (!(false)) return;
		if (!(GetEntityIndex(m_hLastSeen) != IGNORE_TARGET)) return;
		if (!(GetRelationship(MY_OWNER) == "enemy")) return;
		if (!(GetEntityRange(m_hLastSeen) < ATTACK_RADIUS)) return;
		string TARGET_ORG = GetEntityOrigin(m_hLastSeen);
		Effect("beam", "point", LIGHTNING_SPRITE, 60, /* TODO: $relpos */ $relpos(0, 0, 0), TARGET_ORG, Vector3(200, 200, 255), 150, 50, 1.0);
		// PlayRandomSound from: SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3
		array<string> sounds = {SOUND_ZAP1, SOUND_ZAP2, SOUND_ZAP3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (GetEntityHealth(m_hLastSeen) <= 1500)
		{
			ApplyEffect(m_hLastSeen, "effects/dot_cold_freeze", FREEZE_DURATION, MY_OWNER);
		}
		if (GetEntityHealth(m_hLastSeen) >= 1500)
		{
			if ((PLAYER_SPAWNED))
			{
			}
			string TARG_NAME = GetEntityName(m_hLastSeen);
			SendPlayerMessage(MY_OWNER, TARG_NAME + " is too strong to be affected.");
		}
		IGNORE_TARGET = GetEntityIndex(m_hLastSeen);
	}

	void remove_me()
	{
		FREEZING = 0;
		DeleteEntity(GetOwner());
	}

}

}
