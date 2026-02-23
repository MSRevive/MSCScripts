#pragma context server

namespace MS
{

class TestAngelscriptIntegration : CGameScript
{
	int AS_TEST_STAGE;

	void OnSpawn() override
	{
		AS_TEST_STAGE = 0;
		ScheduleDelayedEvent(1.0, "test_angelscript_init");
	}

	void OnSpawn() override
	{
		SetName("AS Integration Tester");
		SetHealth(1);
		SetRace("beloved");
		SetWidth(1);
		SetHeight(1);
		SetGravity(0);
		SetInvincible(true);
		SetInvisible(true);
		// TODO: UNCONVERTED: infomessage all "Testing AngelScript Integration..."
	}

	void test_angelscript_init()
	{
		AS_TEST_STAGE = 1;
		ServerCommand("echo === Testing AngelScript Module System ===");
		if (("game.script.angelscript_initialized"))
		{
			ServerCommand("echo [PASS] AngelScript engine is initialized");
			test_modules();
		}
		else
		{
			ServerCommand("echo [FAIL] AngelScript engine NOT initialized!");
			ServerCommand("echo Please ensure ASBindings::RegisterAll() was called during server startup");
		}
	}

	void test_modules()
	{
		AS_TEST_STAGE = 2;
		ServerCommand("echo === Testing AngelScript Modules ===");
		as_load_module("GameMaster.as");
		ScheduleDelayedEvent(0.5, "as_load_module", "PlayerManager.as");
		ScheduleDelayedEvent(1.0, "as_load_module", "MagicSystem.as");
		ScheduleDelayedEvent(1.5, "as_load_module", "WorldSystem.as");
		ScheduleDelayedEvent(3.0, "test_functions");
	}

	void as_load_module()
	{
		string L_MODULE_NAME = param1;
		ServerCommand("echo Testing module: L_MODULE_NAME");
		if (("game.script.module_exists" + L_MODULE_NAME))
		{
			ServerCommand("echo [PASS] Module found: L_MODULE_NAME");
		}
		else
		{
			ServerCommand("echo [FAIL] Module NOT found: L_MODULE_NAME");
		}
	}

	void test_functions()
	{
		AS_TEST_STAGE = 3;
		ServerCommand("echo === Testing AngelScript Functions ===");
		ServerCommand("echo Testing MS::InitializeGameMaster()...");
		as_call_function("MS::InitializeGameMaster");
		ServerCommand("echo Testing MS::GetMagicHandScripts()...");
		ScheduleDelayedEvent(0.5, "as_call_function", "MS::GetMagicHandScripts", 1);
		ScheduleDelayedEvent(2.0, "test_complete");
	}

	void as_call_function()
	{
		string L_FUNC_NAME = param1;
		string L_PARAM = param2;
		ServerCommand("echo Calling AngelScript function: L_FUNC_NAME");
		if ((L_FUNC_NAME).findFirst("Initialize") >= 0)
		{
			ServerCommand("echo [SIMULATED] Function would initialize system");
		}
		else
		{
			if ((L_FUNC_NAME).findFirst("GetMagic") >= 0)
			{
				ServerCommand("echo [SIMULATED] Function would return magic hand scripts");
			}
		}
	}

	void test_complete()
	{
		ServerCommand("echo === AngelScript Integration Test Complete ===");
		ServerCommand("echo Test stages completed: AS_TEST_STAGE / 3");
		// TODO: UNCONVERTED: infomessage all "AngelScript test complete - check server console for results"
		ScheduleDelayedEvent(2.0, "removeme");
	}

	void removeme()
	{
		DeleteEntity(GetOwner());
	}

}

}
