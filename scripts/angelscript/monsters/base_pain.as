#pragma context server

namespace MS
{

class BasePain : CGameScript
{
	string BPAIN_CAN_FLINCH;
	string BPAIN_FLINCH_HP;
	string BPAIN_PAIN_HP;

	BasePain()
	{
		const int BPAIN_USE_PAIN = 1;
		const int BPAIN_USE_FLINCH = 1;
		const string BPAIN_FREQ_FLINCH = Random(10.0, 20.0);
		const float BPAIN_FLINCH_HEALTH = 0.75;
		const float BPAIN_PAIN_HEALTH = 0.5;
		const string BPAIN_FLINCH_TOKENS = "flinchsmall;flinch;bigflinch;laflinch;raflinch;llflinch;rlflinch";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN1 = "garg/gar_pain1.wav";
		const string SOUND_PAIN2 = "garg/gar_pain2.wav";
	}

	void OnSpawn() override
	{
		if ((BPAIN_USE_FLINCH))
		{
			BPAIN_CAN_FLINCH = 1;
		}
		ScheduleDelayedEvent(2.0, "bpain_finalize");
	}

	void bpain_finalize()
	{
		BPAIN_PAIN_HP = GetEntityMaxHealth(GetOwner());
		BPAIN_FLINCH_HP = BPAIN_PAIN_HP;
		BPAIN_PAIN_HP *= BPAIN_PAIN_HEALTH;
		BPAIN_FLINCH_HP *= BPAIN_FLINCH_HEALTH;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((BPAIN_USE_PAIN))
		{
			if ((BPAIN_USE_FLINCH))
			{
				if ((BPAIN_CAN_FLINCH))
				{
				}
				if (GetEntityHealth(GetOwner()) < BPAIN_FLINCH_HP)
				{
				}
				if (GetGameTime() > BPAIN_NEXT_FLINCH)
				{
				}
				BPAIN_NEXT_FLINCH = GetGameTime();
				BPAIN_NEXT_FLINCH += BPAIN_FREQ_FLINCH;
				npc_flinch();
				string L_NFLINCH_ANIMS = GetTokenCount(BPAIN_FLINCH_TOKENS, ";");
				L_NFLINCH_ANIMS -= 1;
				string L_RND_FLINCH = RandomInt(0, L_NFLINCH_ANIMS);
				PlayAnim("critical", GetToken(BPAIN_FLINCH_TOKENS, L_NFLINCH_ANIMS, ";"));
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (GetEntityHealth(GetOwner()) < BPAIN_PAIN_HP)
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void bflinch_suspend_flinch()
	{
		if (!(BPAIN_CAN_FLINCH)) return;
		BPAIN_CAN_FLINCH = 0;
		if (!((param1).findFirst(PARAM) == 0)) return;
		PARAM1("bflinch_restore_flinch");
	}

	void bflinch_restore_flinch()
	{
		if ((BPAIN_CAN_FLINCH)) return;
		BPAIN_CAN_FLINCH = 1;
	}

}

}
