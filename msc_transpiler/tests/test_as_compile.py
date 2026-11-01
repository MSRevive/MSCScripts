"""AngelScript compilation tests — end-to-end transpile + compile.

These tests take MSCScript source, run it through the full transpiler
pipeline, then compile the resulting AngelScript through the real AS
engine (via as_linter.exe) to catch type mismatches, bad signatures,
and other issues the text-level tests cannot see.

Requires: as_linter.exe built at as_linter/build/Release/as_linter.exe
          (or set AS_LINTER_EXE environment variable)
"""

import pytest

from msc_transpiler.linter import compile_source, linter_available
from .conftest import transpile_source


# Skip the entire module if the linter executable isn't available
pytestmark = pytest.mark.skipif(
    not linter_available(),
    reason="as_linter.exe not found — build it or set AS_LINTER_EXE",
)


def _transpile_and_compile(mscscript: str, filename: str = "test.script") -> tuple:
    """Transpile MSCScript source, then compile the result through AS engine.

    Returns (as_source, compile_result, transpiler_errors).
    """
    as_source, transpiler_errors = transpile_source(mscscript, filename)
    compile_result = compile_source(as_source)
    return as_source, compile_result, transpiler_errors


# =========================================================================
# Basic structure tests — ensure the transpiler's output compiles at all
# =========================================================================

class TestBasicCompilation:
    """Verify that fundamental transpiler output structures compile."""

    def test_empty_script(self):
        """A minimal script with just an init block should compile."""
        src, result, _ = _transpile_and_compile("{\nconst MY_VAL 42\n}")
        assert result.success, f"Empty script failed:\n{result.error_summary()}\n\nSource:\n{src}"

    @pytest.mark.xfail(reason="SetHealth/SetMaxHealth/SetName not yet methods on CGameScript")
    def test_spawn_event(self):
        """A simple spawn event with hp/name should compile."""
        msc = """\
{
eventname spawn
hp 50/50
name TestMonster
}"""
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"Spawn event failed:\n{result.error_summary()}\n\nSource:\n{src}"

    @pytest.mark.xfail(reason="SetHealth not yet a method on CGameScript")
    def test_namespace_and_class(self):
        """Output should have namespace MS and class inheriting CGameScript."""
        msc = "{ game_spawn\nhp 50\n}"
        src, result, _ = _transpile_and_compile(msc, "test_monster.script")
        assert result.success, f"Namespace/class failed:\n{result.error_summary()}\n\nSource:\n{src}"
        assert "namespace MS" in src
        assert "CGameScript" in src


# =========================================================================
# Variable system tests
# =========================================================================

class TestVariables:
    """Verify that variable declarations and usage compile correctly."""

    def test_const_int(self):
        msc = "{\nconst DAMAGE 10\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"const int failed:\n{result.error_summary()}\n\nSource:\n{src}"

    def test_const_string(self):
        msc = '{\nconst SOUND monsters/hit.wav\n}'
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"const string failed:\n{result.error_summary()}\n\nSource:\n{src}"

    def test_setvard(self):
        msc = "{\nsetvard MY_VAR 42\nsetvard MY_STR hello\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"setvard failed:\n{result.error_summary()}\n\nSource:\n{src}"

    def test_local_variable(self):
        msc = "{ game_spawn\nlocal MY_LOCAL 42\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"local var failed:\n{result.error_summary()}\n\nSource:\n{src}"


# =========================================================================
# Control flow tests
# =========================================================================

class TestControlFlow:
    """Verify if/else and other control flow compiles."""

    @pytest.mark.xfail(reason="HEALTH/SetHealth symbols not on CGameScript yet")
    def test_if_else(self):
        msc = """\
{ test_event
if ( HEALTH equals 0 )
{
hp 50
}
else
{
hp 100
}
}"""
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"if/else failed:\n{result.error_summary()}\n\nSource:\n{src}"


# =========================================================================
# Math and expressions
# =========================================================================

class TestExpressions:
    """Verify math operations and dollar functions compile."""

    def test_math_ops(self):
        msc = """\
{ game_spawn
setvard X 10
add X 5
subtract X 2
multiply X 3
}"""
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"Math ops failed:\n{result.error_summary()}\n\nSource:\n{src}"

    def test_dollar_rand(self):
        msc = "{\nsetvard MY_VAR $rand(1,10)\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"$rand failed:\n{result.error_summary()}\n\nSource:\n{src}"


# =========================================================================
# Game API usage tests
# =========================================================================

class TestGameAPI:
    """Verify that generated calls to registered game APIs compile."""

    @pytest.mark.xfail(reason="GetOwner() not a method on CGameScript yet")
    def test_vector_literal(self):
        msc = "{ game_spawn\nsetorigin ent_me (100,200,300)\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"Vector literal failed:\n{result.error_summary()}\n\nSource:\n{src}"

    @pytest.mark.xfail(reason="callevent generates call to undefined method")
    def test_callevent(self):
        msc = "{ game_spawn\ncallevent my_custom_event\n}"
        src, result, _ = _transpile_and_compile(msc)
        assert result.success, f"callevent failed:\n{result.error_summary()}\n\nSource:\n{src}"


# =========================================================================
# Raw AngelScript compilation tests (no transpiler — test linter directly)
# =========================================================================

class TestRawAngelScript:
    """Compile hand-written AngelScript to verify the linter's bindings."""

    def test_minimal_script(self):
        """Bare minimum AS file should compile."""
        result = compile_source("void main() {}")
        assert result.success, f"Minimal script failed:\n{result.error_summary()}"

    def test_vector3_usage(self):
        """Vector3 type and methods should be available."""
        src = """\
void main() {
    Vector3 v(1.0f, 2.0f, 3.0f);
    float len = v.Length();
    Vector3 n = v.Normalize();
    Vector3 sum = v + n;
}
"""
        result = compile_source(src)
        assert result.success, f"Vector3 usage failed:\n{result.error_summary()}"

    def test_math_functions(self):
        """Math functions and constants should be available."""
        src = """\
void main() {
    float s = sin(PI / 2.0f);
    float c = cos(0.0f);
    float r = sqrt(4.0f);
    float a = abs(-5.0f);
    float lo = min(1.0f, 2.0f);
    float hi = max(1.0f, 2.0f);
}
"""
        result = compile_source(src)
        assert result.success, f"Math functions failed:\n{result.error_summary()}"

    def test_string_functions(self):
        """String type and utilities should work."""
        src = """\
void main() {
    string s = "hello world";
    int len = s.length();
    string upper = s;
}
"""
        result = compile_source(src)
        assert result.success, f"String functions failed:\n{result.error_summary()}"

    def test_game_api_types(self):
        """Core game types should be declared."""
        src = """\
void main() {
    float t = GetGameTime();
    string map = GetMapName();
    int pc = GetPlayerCount();
}
"""
        result = compile_source(src)
        assert result.success, f"Game API types failed:\n{result.error_summary()}"

    def test_entity_types_declared(self):
        """Entity type hierarchy should be available for declaration."""
        src = """\
void main() {
    CBaseEntity@ ent = null;
    CBasePlayer@ player = null;
    CBaseMonster@ monster = null;
    CMSMonster@ msmon = null;
    CBasePlayerItem@ item = null;
    CBasePlayerWeapon@ weapon = null;
}
"""
        result = compile_source(src)
        assert result.success, f"Entity types failed:\n{result.error_summary()}"

    def test_cgamescript_inheritance(self):
        """Scripts should be able to inherit from CGameScript."""
        src = """\
class MyScript : CGameScript {
    MyScript() {
        SetVar("test", "value");
    }

    void OnSpawn() override {
        string val = GetVar("test");
    }
}
"""
        result = compile_source(src)
        assert result.success, f"CGameScript inheritance failed:\n{result.error_summary()}"

    def test_enums_available(self):
        """Game enums should be available."""
        src = """\
void main() {
    MessageColor c = White;
    MonsterState s = MONSTERSTATE_IDLE;
    Gender g = GENDER_MALE;
    ScriptMode m = Legacy;
}
"""
        result = compile_source(src)
        assert result.success, f"Enums failed:\n{result.error_summary()}"

    def test_coroutine_functions(self):
        """Coroutine functions should be declared."""
        src = """\
void main() {
    int id = StartCoroutine("MyCoroutine");
    bool running = IsCoroutineRunning(id);
    StopCoroutine(id);
}
"""
        result = compile_source(src)
        assert result.success, f"Coroutine functions failed:\n{result.error_summary()}"

    def test_casting_functions(self):
        """Casting functions should be declared."""
        src = """\
void main() {
    CBaseEntity@ ent = null;
    CBasePlayer@ player = ToPlayer(ent);
    CBaseMonster@ monster = ToMonster(ent);
    CMSMonster@ msmon = ToMSMonster(ent);
    CBaseEntity@ back = ToEntity(player);
}
"""
        result = compile_source(src)
        assert result.success, f"Casting functions failed:\n{result.error_summary()}"

    def test_render_constants(self):
        """Render and damage constants should be available."""
        src = """\
void main() {
    int rm = kRenderNormal;
    int rt = kRenderTransTexture;
    int dn = DAMAGE_NO;
    int dy = DAMAGE_YES;
}
"""
        result = compile_source(src)
        assert result.success, f"Render constants failed:\n{result.error_summary()}"
