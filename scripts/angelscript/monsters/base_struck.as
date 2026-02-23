#pragma context server

namespace MS
{

class BaseStruck : CGameScript
{
	string BS_SOUND_STRUCK1;
	string BS_SOUND_STRUCK2;
	string BS_SOUND_STRUCK3;
	string NPC_BS_HALF_HEALTH;
	string NPC_CUR_MATERIAL_TYPE;
	string NPC_NEXT_IDLE;
	string NPC_NEXT_PAIN;
	string NPC_PAIN_LEVEL;

	BaseStruck()
	{
		const string NPC_MATERIAL_TYPE = "default";
		const int NPC_STRUCK_VOL = 10;
		const int NPC_STRUCK_CHANNEL = 2;
		const int NPC_PITCH_STRUCK = 100;
		const float NPC_ATN_STRUCK = 0.8;
		const int NPC_STRUCK_SOUND_EVENT = 0;
		const int NPC_USE_PAIN = 0;
		const string NPC_FREQ_PAIN = Random(5.0, 10.0);
		const int NPC_PITCH_PAIN = 100;
		const float NPC_ATN_PAIN = 0.8;
		const int NPC_FLINCH_ALLOW_SUSPEND_AI = 0;
		const int NPC_FLINCH_ALLOW_SUSPEND_MOVEMENT = 0;
		const int NPC_USE_FLINCH = 0;
		const float NPC_FREQ_FLINCH = 30.0;
		const float NPC_FLINCH_THRESH = 0.1;
		const float NPC_FLINCH_TIME = 1.5;
		const int NPC_PITCH_FLINCH = 100;
		const float NPC_ATN_FLINCH = 0.8;
		const int NPC_USE_IDLE = 0;
		const string NPC_FREQ_IDLE = Random(10.0, 20.0);
		const int NPC_PITCH_IDLE = 100;
		const float NPC_ATN_IDLE = 0.8;
		BS_SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		BS_SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		BS_SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.5, "set_material");
	}

	void set_material()
	{
		NPC_BS_HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		NPC_BS_HALF_HEALTH *= 0.5;
		NPC_PAIN_LEVEL = "";
		if ((param1).findFirst(PARAM) == 0)
		{
			NPC_CUR_MATERIAL_TYPE = NPC_MATERIAL_TYPE;
		}
		else
		{
			NPC_CUR_MATERIAL_TYPE = param1;
		}
		if (SOUND_STRUCK1 != "SOUND_STRUCK1")
		{
			BS_SOUND_STRUCK1 = SOUND_STRUCK1;
			BS_SOUND_STRUCK2 = SOUND_STRUCK2;
			BS_SOUND_STRUCK3 = SOUND_STRUCK3;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (NPC_CUR_MATERIAL_TYPE == "default")
		{
			BS_SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
			BS_SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
			BS_SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		}
		else
		{
			if (NPC_CUR_MATERIAL_TYPE == "flesh")
			{
				BS_SOUND_STRUCK1 = "body/flesh1.wav";
				BS_SOUND_STRUCK2 = "body/flesh2.wav";
				BS_SOUND_STRUCK3 = "body/flesh3.wav";
			}
			else
			{
				if (NPC_CUR_MATERIAL_TYPE == "stone")
				{
					BS_SOUND_STRUCK1 = "weapons/axemetal1.wav";
					BS_SOUND_STRUCK2 = "weapons/axemetal2.wav";
					BS_SOUND_STRUCK3 = "debris/concrete1.wav";
				}
				else
				{
					if (NPC_CUR_MATERIAL_TYPE == "metal")
					{
						BS_SOUND_STRUCK1 = "doors/doorstop5.wav";
						BS_SOUND_STRUCK2 = "weapons/axemetal2.wav";
						BS_SOUND_STRUCK3 = "weapons/axemetal1.wav";
					}
					else
					{
						if (NPC_CUR_MATERIAL_TYPE == "glass")
						{
							const string SOUND_STRUCK = "debris/glass1.wav";
							const string SOUND_PAIN = "debris/glass2.wav";
							const string SOUND_PAIN2 = "debris/glass3.wav";
						}
						else
						{
							if (NPC_CUR_MATERIAL_TYPE == "bloat")
							{
								BS_SOUND_STRUCK1 = "debris/flesh2.wav";
								BS_SOUND_STRUCK2 = "debris/flesh5.wav";
								BS_SOUND_STRUCK3 = "debris/flesh7.wav";
							}
							else
							{
								if (NPC_CUR_MATERIAL_TYPE == "plant")
								{
									BS_SOUND_STRUCK1 = "weapons/xbow_hitbod1.wav";
									BS_SOUND_STRUCK2 = "weapons/xbow_hitbod2.wav";
									BS_SOUND_STRUCK3 = "weapons/bustflesh2.wav";
								}
								else
								{
									if (NPC_CUR_MATERIAL_TYPE == "bullet")
									{
										BS_SOUND_STRUCK1 = "weapons/ric1.wav";
										BS_SOUND_STRUCK2 = "weapons/ric2.wav";
										BS_SOUND_STRUCK3 = "weapons/ric3.wav";
									}
									else
									{
										if (NPC_CUR_MATERIAL_TYPE == "carapace")
										{
											BS_SOUND_STRUCK1 = "weapons/bustflesh1.wav";
											BS_SOUND_STRUCK2 = "weapons/bullet_hit2.wav";
											BS_SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
										}
										else
										{
											if (NPC_CUR_MATERIAL_TYPE == "wood")
											{
												BS_SOUND_STRUCK1 = "debris/wood2.wav";
												BS_SOUND_STRUCK2 = "debris/wood3.wav";
												BS_SOUND_STRUCK3 = "debris/wood1.wav";
											}
											else
											{
												if (NPC_CUR_MATERIAL_TYPE == "electric")
												{
													BS_SOUND_STRUCK1 = "debris/zap1.wav";
													BS_SOUND_STRUCK2 = "debris/zap3.wav";
													BS_SOUND_STRUCK3 = "debris/zap8.wav";
												}
												else
												{
													if (NPC_CUR_MATERIAL_TYPE == "bone")
													{
														BS_SOUND_STRUCK1 = "monsters/undeadz/c_skeleton_hit1.wav";
														BS_SOUND_STRUCK2 = "monsters/undeadz/c_skeleton_hit2.wav";
														BS_SOUND_STRUCK3 = "monsters/undeadz/c_hookhorr_hit1.wav";
													}
													else
													{
														if (NPC_CUR_MATERIAL_TYPE == "bone_large")
														{
															BS_SOUND_STRUCK1 = "monsters/undeadz/c_golmbone_hit1.wav";
															BS_SOUND_STRUCK2 = "monsters/undeadz/c_golmbone_slct.wav";
															BS_SOUND_STRUCK3 = "monsters/undeadz/c_shadow_hit1.wav";
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	void OnDamage(int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		string MY_HP = GetEntityHealth(GetOwner());
		MY_HP -= param2;
		if (!(MY_HP > 0)) return;
		LogDebug("$currentscript uf NPC_USE_FLINCH thr NPC_FLINCH_THRESH");
		if ((NPC_USE_FLINCH))
		{
			if (!(NPC_FLINCH_DISABLE))
			{
			}
			if (GetGameTime() > NPC_NEXT_FLINCH)
			{
			}
			string L_MIN_DMG = GetEntityHealth(GetOwner());
			L_MIN_DMG *= NPC_FLINCH_THRESH;
			if (param2 > L_MIN_DMG)
			{
				int L_CAN_FLINCH = 1;
			}
			if (/* TODO: $get_takedmg */ $get_takedmg(GetOwner(), param3) >= 2)
			{
				int L_CAN_FLINCH = 1;
			}
			if ((SUSPEND_AI))
			{
				if (!(NPC_FLINCH_ALLOW_SUSPEND_AI))
				{
				}
				int L_CAN_FLINCH = 0;
			}
			if ((NPC_MOVEMENT_SUSPENDED))
			{
				if (!(NPC_FLINCH_ALLOW_SUSPEND_MOVEMENT))
				{
				}
				int L_CAN_FLINCH = 0;
			}
			LogDebug("$currentscript flinch_check result L_CAN_FLINCH");
			if ((L_CAN_FLINCH))
			{
			}
			npc_flinch();
			if (!(NPC_FLINCH_DISABLE_ONCE))
			{
				PlayAnim("critical", ANIM_FLINCH);
				string L_RND_SOUND = RandomInt(1, 3);
				if (NPC_STRUCK_SOUND_EVENT == 0)
				{
					if (L_RND_SOUND == 1)
					{
						EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_FLINCH1, NPC_STRUCK_VOL);
					}
					else
					{
						if (L_RND_SOUND == 2)
						{
							EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_FLINCH2, NPC_STRUCK_VOL);
						}
						else
						{
							if (L_RND_SOUND == 3)
							{
								EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_FLINCH3, NPC_STRUCK_VOL);
							}
						}
					}
				}
				else
				{
					if (L_RND_SOUND == 1)
					{
						NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_FLINCH1, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
					}
					else
					{
						if (L_RND_SOUND == 2)
						{
							NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_FLINCH2, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
						}
						else
						{
							if (L_RND_SOUND == 3)
							{
								NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_FLINCH3, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
							}
						}
					}
				}
				NPC_NEXT_FLINCH = GetGameTime();
				NPC_NEXT_FLINCH += NPC_FREQ_FLINCH;
				if (NPC_FLINCH_TIME > 0)
				{
					npcatk_suspend_ai(NPC_FLINCH_TIME);
				}
				int EXIT_SUB = 1;
			}
			else
			{
				NPC_FLINCH_DISABLE_ONCE = 0;
			}
		}
		if ((EXIT_SUB)) return;
		npc_bs_struck(GetEntityIndex(param1));
		if ((NPC_USE_PAIN))
		{
			if (!(NPC_PAIN_DISABLE))
			{
			}
			LogDebug("$currentscript use pain if GetEntityHealth(GetOwner()) < NPC_BS_HALF_HEALTH");
			if (GetEntityHealth(GetOwner()) < NPC_BS_HALF_HEALTH)
			{
			}
			if (GetGameTime() > NPC_NEXT_PAIN)
			{
				int L_CAN_PAIN = 1;
			}
			if (/* TODO: $get_takedmg */ $get_takedmg(GetOwner(), param3) >= 3)
			{
				int L_CAN_PAIN = 1;
			}
			if ((L_CAN_PAIN))
			{
			}
			NPC_NEXT_PAIN = GetGameTime();
			NPC_NEXT_PAIN += NPC_FREQ_PAIN;
			string L_RND_SOUND = RandomInt(1, 3);
			if (NPC_STRUCK_SOUND_EVENT == 0)
			{
				if (L_RND_SOUND == 1)
				{
					EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_PAIN1, NPC_STRUCK_VOL);
				}
				else
				{
					if (L_RND_SOUND == 2)
					{
						EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_PAIN2, NPC_STRUCK_VOL);
					}
					else
					{
						if (L_RND_SOUND == 3)
						{
							EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_PAIN3, NPC_STRUCK_VOL);
						}
					}
				}
			}
			else
			{
				if (L_RND_SOUND == 1)
				{
					NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_PAIN1, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
				}
				else
				{
					if (L_RND_SOUND == 2)
					{
						NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_PAIN2, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
					}
					else
					{
						if (L_RND_SOUND == 3)
						{
							NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, SOUND_PAIN3, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
						}
					}
				}
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_RND_SOUND = RandomInt(1, 3);
		if (NPC_STRUCK_SOUND_EVENT == 0)
		{
			if (L_RND_SOUND == 1)
			{
				EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, BS_SOUND_STRUCK1, NPC_STRUCK_VOL);
			}
			else
			{
				if (L_RND_SOUND == 2)
				{
					EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, BS_SOUND_STRUCK2, NPC_STRUCK_VOL);
				}
				else
				{
					if (L_RND_SOUND == 3)
					{
						EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, BS_SOUND_STRUCK3, NPC_STRUCK_VOL);
					}
				}
			}
		}
		else
		{
			if (L_RND_SOUND == 1)
			{
				NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, BS_SOUND_STRUCK1, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
			}
			else
			{
				if (L_RND_SOUND == 2)
				{
					NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, BS_SOUND_STRUCK2, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
				}
				else
				{
					if (L_RND_SOUND == 3)
					{
						NPC_STRUCK_SOUND_EVENT(NPC_STRUCK_CHANNEL, NPC_STRUCK_VOL, BS_SOUND_STRUCK3, NPC_ATN_STRUCK, NPC_PITCH_STRUCK);
					}
				}
			}
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(NPC_USE_IDLE)) return;
		if ((NPC_IDLE_DISABLE)) return;
		if (!(m_hAttackTarget == "unset")) return;
		if (!(GetGameTime() > NPC_NEXT_IDLE)) return;
		NPC_NEXT_IDLE = GetGameTime();
		NPC_NEXT_IDLE += NPC_FREQ_IDLE;
		string L_RND_SOUND = RandomInt(1, 3);
		if (L_RND_SOUND == 1)
		{
			EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_IDLE1, 10);
		}
		if (L_RND_SOUND == 2)
		{
			EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_IDLE2, 10);
		}
		if (L_RND_SOUND == 3)
		{
			EmitSound(GetOwner(), NPC_STRUCK_CHANNEL, SOUND_IDLE3, 10);
		}
	}

}

}
