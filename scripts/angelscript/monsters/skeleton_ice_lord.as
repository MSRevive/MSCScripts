#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SkeletonIceLord : CGameScript
{
	string ALT_ATTACK;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SLASH;
	string ANIM_SMASH;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	string ATTACK_MODE;
	string ATTACK_RANGE;
	int CANT_TURN;
	int CAN_ATTACK;
	int CAN_FLINCH;
	int CAN_HUNT;
	string DID_WARCRY;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_HEALTH;
	string HIT_RECENT;
	int IGNORE_ENEMY;
	int IS_FLEEING;
	int I_AM_TURNABLE;
	int MONSTER_WIDTH;
	string MOVE_RANGE;
	int MOVE_RANGE1;
	int MOVE_RANGE2;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_MOVE_TARGET;
	int PLAYING_DEAD;
	int PURE_FLEE;
	int SEE_ENEMY;
	string SPEC_ATK_FREQUENCY;
	int STEP_COUNTER;
	float STUCK_CHECK_FREQUENCY;
	int STUCK_COUNT;
	string WAS_SNOWING;

	SkeletonIceLord()
	{
		const int NPC_NO_RAMP = 1;
		const int NPC_BOSS_REGEN_RATE = 0;
		const int NPC_BOSS_RESTORATION = 0;
		if (StringToLower(GetMapName()) == "ms_snow")
		{
			NPC_GIVE_EXP = 4000;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 1000;
		}
		const string SOUND_INTRO1 = "npc/ice_queen_live_beating2.wav";
		const string SOUND_INTRO2 = "npc/ice_queen_put_that_on_ice2.wav";
		const string SOUND_STAGETWO1 = "npc/ice_queen_cant_pronounce_loreldians2.wav";
		const string SOUND_STAGETWO2 = "npc/ice_queen_game2.wav";
		const string SOUND_FINAL1 = "npc/ice_queen_powah2.wav";
		const string SOUND_FINAL2 = "npc/ice_queen_die2.wav";
		const string SOUND_STRUCK1 = "controller/con_pain2.wav";
		const string SOUND_STRUCK2 = "controller/con_pain3.wav";
		const string SOUND_ATTACK1 = "zombie/claw_strike1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_strike2.wav";
		const string SOUND_ATTACK3 = "zombie/claw_strike3.wav";
		const string SOUND_FLINCH1 = "npc/ice_queen_pain2.wav";
		const string SOUND_FLINCH2 = "garg/gar_pain2.wav";
		const string SOUND_PUSH1 = "npc/ice_queen_throw2.wav";
		const string SOUND_PUSH2 = "npc/ice_queen_throw3.wav";
		const string SOUND_FALL = "weapons/mortarhit.wav";
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		const string ANIM_BASERUN = "walk";
		const string ANIM_BASEIDLE = "idle1";
		const string ANIM_BASEWALK = "walk";
		ANIM_SLASH = "attack1";
		ANIM_SMASH = "attack2";
		ANIM_ATTACK = ANIM_SMASH;
		const int ATTACK1_RANGE = 160;
		const int ATTACK2_RANGE = 160;
		ATTACK_RANGE = ATTACK1_RANGE;
		MOVE_RANGE1 = 80;
		MOVE_RANGE2 = 80;
		MOVE_RANGE = MOVE_RANGE1;
		ATTACK_HITRANGE = 300;
		SEE_ENEMY = 0;
		IGNORE_ENEMY = 0;
		CAN_FLINCH = 0;
		FLINCH_ANIM = "bigflinch";
		FLINCH_CHANCE = 10;
		FLINCH_DELAY = 1;
		CAN_HUNT = 1;
		CAN_ATTACK = 1;
		NPC_MOVE_TARGET = "enemy";
		FLINCH_HEALTH = 1000;
		const int MAX_HP = 3000;
		const int ATTACK_CLUB_RANGE = 200;
		ATTACK_MODE = "normal";
		const string ANIM_THROW = "throw_scientist";
		const string SOUND_STEP1 = "debris/glass1.wav";
		const string SOUND_STEP2 = "debris/glass2.wav";
		const string SOUND_STEP3 = "debris/glass3.wav";
		STEP_COUNTER = 0;
		const string SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		const string SOUND_FAKEDEATH1 = "garg/gar_die2.wav";
		const string SOUND_FAKEDEATH2 = "garg/gar_die1.wav";
		const string SOUND_DEATH = "npc/undamael2.wav";
		const string SOUND_FINAL = "gonarch/gon_die1.wav";
		const string SOUND_WHACK = "zombie/claw_strike1.wav";
		const string SOUND_REGEN = "x/x_laugh2.wav";
		const string SOUND_POWERUP = "ambience/particle_suck2.wav";
		const string ANIM_FAKEDEATH = "dieforward";
		ANIM_DEATH = "dieforward";
		const string ANIM_DEAD = "dead_on_stomach";
		const string ANIM_ALTTHROW = "bigflinch";
		ANIM_FLINCH = "flinch";
		const float TAUNT_DELAY = 2.0;
		const float GETUP_DELAY = 8.0;
		const float SPECATK_FREQ_CIRCLE = 20.0;
		const float SPECATK_FREQ_FREEZE = 20.0;
		STUCK_CHECK_FREQUENCY = 3.5;
		MONSTER_WIDTH = 40;
		const int FEIGN_THRESHOLD = 500;
		const string DAMAGE_NORM1 = Random(40.0, 55.0);
		const string DAMAGE_NORM2 = Random(30.0, 40.0);
		const string DAMAGE_BALL1 = Random(50.0, 55.0);
		const string DAMAGE_BALL2 = Random(60.0, 80.0);
		const string DAMAGE_CLUBS1 = Random(60.0, 85.0);
		const int DAMAGE_CLUBS2 = 200;
		const string CIRCLE_SCRIPT = "monsters/summon/circle_of_ice_greater";
		const string XSEAL_MODEL = "weapons/magic/seals.mdl";
		const string SOUND_MANIFEST = "magic/spawn_loud.wav";
		const string XSOUND_PULSE = "magic/frost_forward.wav";
		const string XSOUND_FADE = "magic/frost_reverse.wav";
		const string XSEAL_MODEL = "weapons/magic/seal_fire_large.mdl";
		const string XFX_SPRITE = "firemagic.spr";
		Precache(XSEAL_MODEL);
		Precache(SOUND_MANIFEST);
		Precache(XSOUND_PULSE);
		Precache(XSOUND_FADE);
		Precache(XFX_SPRITE);
		const string ICE_BLAST_SCRIPT = "monsters/summon/ice_blast";
		const string SOUND_FREEZE = "magic/freeze.wav";
		const string XSOUND_HOVERLOOP = "ambience/alienwind1.wav";
		const string XSOUND_HITWALL = "ambience/alienlaser1.wav";
		const string XLIGHTNING_SPRITE = "lgtning.spr";
		const string SOUND_ICEBLAST = "magic/temple.wav";
		Precache(XBLAST_MODEL);
		Precache(XSOUND_FREEZE);
		Precache(XSOUND_HOVERLOOP);
		Precache(XSOUND_HITWALL);
		Precache(XLIGHTNING_SPRITE);
		Precache("monsters/skeleton_icel.mdl");
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetHealth(MAX_HP);
		SetGold(RandomInt(100, 300));
		SetWidth(40);
		SetHeight(120);
		SetRace("undead");
		string PICK_NAME = RandomInt(1, 2);
		if (PICK_NAME == 1)
		{
			SetName("Ice Bone Lord");
		}
		if (PICK_NAME == 2)
		{
			SetName("Ice Queen");
		}
		SetRoam(false);
		SetHearingSensitivity(6);
		Precache("monsters/skeleton_icel.mdl");
		SetModel("monsters/skeleton_icel.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
		SetActionAnim(ANIM_ATTACK);
		SetDamageResistance("all", 0.6);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("slash", 0.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("lightning", 0.4);
		SetDamageResistance("holy", 1.25);
		if (G_CURRENT_WEATHER == "snow")
		{
			WAS_SNOWING = 1;
		}
		SPEC_ATK_FREQUENCY = SPECATK_FREQ_CIRCLE;
		SPEC_ATK_FREQUENCY("spec_attack");
		EmitSound(GetOwner(), 0, SOUND_FREEZE, 10);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 512, 5, 5);
		ScheduleDelayedEvent(0.1, "finish_manifest");
	}

	void finish_manifest()
	{
		EmitSound(GetOwner(), 0, SOUND_ICEBLAST, 10);
	}

	void attack_1()
	{
		if (ATTACK_MODE == "normal")
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
				npcatk_dodamage(m_hAttackTarget, "direct", DAMAGE_NORM1, 0.75, GetEntityIndex(GetOwner()), "slash");
			}
			if (RandomInt(1, 3) == 1)
			{
				ANIM_ATTACK = ANIM_SMASH;
			}
		}
		if (ATTACK_MODE == "freeze_ball")
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
				npcatk_dodamage(m_hAttackTarget, "direct", DAMAGE_BALL1, 0.8, GetEntityIndex(GetOwner()), "slash");
			}
			if (RandomInt(1, 10) == 1)
			{
				ANIM_ATTACK = ANIM_SMASH;
			}
		}
		if (ATTACK_MODE == "final")
		{
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
				npcatk_dodamage(m_hAttackTarget, "direct", DAMAGE_CLUBS1, 0.85, GetEntityIndex(GetOwner()), "blunt");
				if (RandomInt(1, 10) == 1)
				{
					ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 2, GetEntityIndex(GetOwner()));
				}
			}
			ALT_ATTACK += 1;
			if (ALT_ATTACK >= 16)
			{
			}
			ANIM_ATTACK = ANIM_SMASH;
			ALT_ATTACK = 0;
		}
	}

	void attack_2()
	{
		if (ATTACK_MODE == "normal")
		{
			ANIM_ATTACK = ANIM_SLASH;
			if (GetEntityRange(m_hAttackTarget) < ATTACK2_RANGE)
			{
			}
			npcatk_dodamage(m_hAttackTarget, ATTACK2_RANGE, DAMAGE_NORM2, 1.0);
			ApplyEffect(m_hAttackTarget, "effects/effect_push", 1, /* TODO: $relvel */ $relvel(0, 200, 30), 0);
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK1, 10);
		}
		if (ATTACK_MODE == "freeze_ball")
		{
			ANIM_ATTACK = ANIM_SLASH;
			if (GetEntityRange(m_hAttackTarget) < ATTACK2_RANGE)
			{
			}
			npcatk_dodamage(m_hAttackTarget, ATTACK2_RANGE, DAMAGE_BALL2, 1.0);
			ApplyEffect(m_hAttackTarget, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), RandomInt(3, 5), "none");
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK1, 10);
		}
		if (ATTACK_MODE == "final")
		{
			ANIM_ATTACK = ANIM_SLASH;
			if (GetEntityRange(m_hAttackTarget) < ATTACK2_RANGE)
			{
			}
			npcatk_dodamage(m_hAttackTarget, ATTACK2_RANGE, DAMAGE_CLUBS2, 1.0);
			AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 300, 60));
			ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			EmitSound(GetOwner(), CHAN_VOICE, SOUND_ATTACK1, 10);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		string MY_HP = GetEntityHealth(GetOwner());
		string OUT_HP = MY_HP;
		OUT_HP -= param1;
		if (!(ATTACK_MODE != "final")) return;
		if (OUT_HP <= FEIGN_THRESHOLD)
		{
			fall_down();
		}
		if (GetEntityHealth(GetOwner()) < 1000)
		{
			CAN_FLINCH = 1;
		}
		SetVolume(5);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), CHAN_BODY, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnFlinch()
	{
		// PlayRandomSound from: SOUND_FLINCH1, SOUND_FLINCH2
		array<string> sounds = {SOUND_FLINCH1, SOUND_FLINCH2};
		EmitSound(GetOwner(), CHAN_BODY, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (ATTACK_MODE == "normal")
		{
			if (RandomInt(1, 20) == 1)
			{
				// PlayRandomSound from: SOUND_PUSH1, SOUND_PUSH2
				array<string> sounds = {SOUND_PUSH1, SOUND_PUSH2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				PlayAnim("once", ANIM_ALTTHROW);
				PASS_THIS_POS = param2;
				ScheduleDelayedEvent(0.2, "throw_chummer", GetEntityIndex(param2));
				int DOING_SECONDARY = 1;
			}
		}
		if (ATTACK_MODE == "freeze_ball")
		{
			if (RandomInt(1, 15) == 1)
			{
				// PlayRandomSound from: SOUND_PUSH1, SOUND_PUSH2
				array<string> sounds = {SOUND_PUSH1, SOUND_PUSH2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				PlayAnim("once", ANIM_ALTTHROW);
				PASS_THIS_POS = param2;
				ScheduleDelayedEvent(0.2, "throw_chummer", GetEntityIndex(param2));
				int DOING_SECONDARY = 1;
			}
		}
		if (ATTACK_MODE == "final")
		{
			if (RandomInt(1, 20) == 1)
			{
				// PlayRandomSound from: SOUND_PUSH1, SOUND_PUSH2
				array<string> sounds = {SOUND_PUSH1, SOUND_PUSH2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				PlayAnim("once", ANIM_ALTTHROW);
				PASS_THIS_POS = param2;
				ScheduleDelayedEvent(0.2, "throw_chummer", GetEntityIndex(param2));
				int DOING_SECONDARY = 1;
			}
		}
		if ((DOING_SECONDARY)) return;
		if (ANIM_ATTACK == ANIM_SMASH)
		{
			EmitSound(GetOwner(), 0, SOUND_WHACK, 10);
		}
	}

	void throw_chummer()
	{
		string MY_NME_POS = GetEntityOrigin(m_hLastStruckByMe);
		string MY_ME_POS = GetEntityOrigin(GetOwner());
		string NME_DIST = Distance(MY_NME_POS, MY_ME_POS);
		if (!(NME_DIST < ATTACK2_RANGE)) return;
		ApplyEffect(PASS_THIS_POS, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 800, 800), 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(WAS_SNOWING))
		{
			CallExternal("players", "ext_weather_change", "clear");
		}
		if (!(G_CHRISTMAS_MODE))
		{
			EmitSound(GetOwner(), 0, "debris/bustglass3.wav", 10);
		}
		if ((G_CHRISTMAS_MODE))
		{
			EmitSound(GetOwner(), 0, "npc/happy_hogswatch.wav", 10);
		}
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 256), 1, 40, 10, 100, 30);
		SpawnNPC("monsters/summon/sfx_glassmaker", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		SetModel("none");
		SetSolid("none");
		UseTrigger("ice_lord_died");
		ScheduleDelayedEvent(0.1, "final_death");
	}

	void walk_step()
	{
		STEP_COUNTER += 1;
		if (STEP_COUNTER == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
		}
		if (STEP_COUNTER == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
		}
		if (STEP_COUNTER == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP3, 5);
			STEP_COUNTER = 0;
		}
	}

	void fall_down()
	{
		if (!(ATTACK_MODE != "final")) return;
		npcatk_suspend_ai();
		CANT_TURN = 1;
		SetMoveDest("none");
		CAN_FLINCH = 0;
		SetHealth(MAX_HP);
		SetInvincible(2);
		SetMoveDest("none");
		PlayAnim("critical", ANIM_FAKEDEATH);
		SetIdleAnim(ANIM_DEAD);
		SetMoveAnim(ANIM_DEAD);
		SetActionAnim(ANIM_DEAD);
		ANIM_ATTACK = ANIM_DEAD;
		ANIM_RUN = ANIM_DEAD;
		ANIM_IDLE = ANIM_DEAD;
		ANIM_WALK = ANIM_DEAD;
		IS_FLEEING = 1;
		PURE_FLEE = 1;
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(1.0, "stay_down_damnit");
		SetMoveSpeed(0.0);
		if (ATTACK_MODE == "freeze_ball")
		{
			ATTACK_MODE = "final";
			EmitSound(GetOwner(), 0, SOUND_FAKEDEATH2, 10);
			TAUNT_DELAY("taunt2");
			GETUP_DELAY("get_up");
		}
		if (ATTACK_MODE == "normal")
		{
			ATTACK_MODE = "freeze_ball";
			EmitSound(GetOwner(), 0, SOUND_FAKEDEATH1, 10);
			TAUNT_DELAY("taunt1");
			GETUP_DELAY("get_up");
		}
	}

	void npcatk_faceattacker()
	{
		if ((IS_FLEEING)) return;
		if ((PLAYING_DEAD)) return;
		SetMoveDest(GetEntityIndex(param1));
		LookAt(1024);
	}

	void stay_down_damnit()
	{
		if (!(PLAYING_DEAD)) return;
		SetIdleAnim(ANIM_DEAD);
		SetMoveAnim(ANIM_DEAD);
		SetActionAnim(ANIM_DEAD);
		// TODO: UNCONVERTED: setanim ANIM_DEAD
		ScheduleDelayedEvent(1.0, "stay_down_damnit");
	}

	void taunt1()
	{
		EmitSound(GetOwner(), 0, SOUND_STAGETWO1, 10);
		SetSayTextRange(2048);
		SayText("Hahaaa! I've not had this much fun since the Loreldians were here!");
	}

	void taunt2()
	{
		EmitSound(GetOwner(), 0, SOUND_FINAL1, 10);
		SetSayTextRange(2048);
		SayText("Good, good, maybe you are worthy of my full power...");
	}

	void get_up()
	{
		CANT_TURN = 0;
		if (ATTACK_MODE == "freeze_ball")
		{
			SetSayTextRange(2048);
			EmitSound(GetOwner(), 0, SOUND_STAGETWO2, 10);
			SayText("Shall we continue this little game?");
		}
		SetIdleAnim(ANIM_IDLE);
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 512, 3, 3);
		PlayAnim("critical", "getup");
	}

	void getup_done()
	{
		SetSolid("box");
		npcatk_resume_ai();
		ANIM_RUN = ANIM_BASERUN;
		ANIM_IDLE = ANIM_BASEIDLE;
		ANIM_WALK = ANIM_BASEWALK;
		ANIM_ATTACK = ANIM_SMASH;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		SetActionAnim(ANIM_SMASH);
		SetRoam(true);
		SetInvincible(false);
		IS_FLEEING = 0;
		PURE_FLEE = 0;
		PLAYING_DEAD = 0;
		if (ATTACK_MODE != "final")
		{
			SetMoveSpeed(1.0);
		}
		if (!(ATTACK_MODE == "final")) return;
		Effect("screenfade", "all", 3, 1, Vector3(255, 255, 255), 255, "fadein");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 190, 30, 3.0, 2048);
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 512, 5, 5);
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, SOUND_FINAL2, 10);
		SayText("NOW YOU WILL ALL DIE!!!");
		ScheduleDelayedEvent(1.0, "give_clubs");
	}

	void give_clubs()
	{
		STUCK_CHECK_FREQUENCY = 2.5;
		EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		SetModelBody(0, 1);
		SetMoveSpeed(3.0);
		// TODO: UNCONVERTED: animspeed 2.0
		SetProp(GetOwner(), "animtime", 3.0);
		Effect("screenfade", "all", 3, 1, Vector3(255, 255, 255), 128, "fadeout");
		ALT_ATTACK = 1;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(DID_WARCRY))
		{
			ScheduleDelayedEvent(1.0, "pre_taunt");
			ScheduleDelayedEvent(5.0, "taunt0");
			PlayAnim("once", ANIM_THROW);
			DID_WARCRY = 1;
		}
	}

	void pre_taunt()
	{
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, SOUND_INTRO1, 10);
		SayText("Ah , the warm fire of live beating heart...");
	}

	void taunt0()
	{
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, SOUND_INTRO2, 10);
		SayText("We'll just have to put that on ice.");
	}

	void spec_attack()
	{
		if (ATTACK_MODE == "normal")
		{
			if (!(PLAYING_DEAD))
			{
			}
			if ((false))
			{
				PlayAnim("critical", ANIM_THROW);
				STUCK_COUNT = 0;
				EmitSound(GetOwner(), 0, SOUND_MANIFEST, 10);
				Effect("glow", GetOwner(), Vector3(128, 128, 255), 80, 3, 0);
				ScheduleDelayedEvent(1.5, "circle_of_ice");
			}
			SPEC_ATK_FREQUENCY = SPECATK_FREQ_CIRCLE;
		}
		if (ATTACK_MODE == "freeze_ball")
		{
			if (!(PLAYING_DEAD))
			{
			}
			if ((false))
			{
				Effect("glow", GetOwner(), Vector3(128, 128, 255), 80, 3, 2);
				EmitSound(GetOwner(), 0, SOUND_MANIFEST, 10);
				ScheduleDelayedEvent(2.0, "toss_iceball");
				SPEC_ATK_FREQUENCY = SPECATK_FREQ_FREEZE;
			}
		}
		SPEC_ATK_FREQUENCY("spec_attack");
	}

	void circle_of_ice()
	{
		if ((PLAYING_DEAD)) return;
		STUCK_COUNT = 0;
		SpawnNPC(CIRCLE_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, 10.0
	}

	void toss_iceball()
	{
		if ((PLAYING_DEAD)) return;
		string BALL_DEST = /* TODO: $relpos */ $relpos(0, 2000, 0);
		EmitSound(GetOwner(), 0, SOUND_ICEBLAST, 10);
		SpawnNPC(ICE_BLAST_SCRIPT, /* TODO: $relpos */ $relpos(0, 64, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, BALL_DEST
	}

	void my_target_died()
	{
		if (!(ATTACK_MODE == "final")) return;
		if (!(HIT_RECENT == param1)) return;
		SetHealth(MAX_HP);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 255, 5, 5);
		EmitSound(GetOwner(), 0, SOUND_REGEN, 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(ATTACK_MODE == "final")) return;
		if (!(HIT_RECENT == 0)) return;
		HIT_RECENT = param1;
		ScheduleDelayedEvent(0.5, "hit_recent_reset");
	}

	void hit_recent_reset()
	{
		HIT_RECENT = 0;
	}

}

}
