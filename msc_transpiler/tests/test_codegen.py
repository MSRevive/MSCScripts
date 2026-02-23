"""Tests for the code generation stage."""

from .conftest import transpile_source


def test_simple_spawn():
    source = """\
{
eventname spawn
hp 50/50
name Bunny
race neutral
}"""
    output, errors = transpile_source(source)
    assert "void OnSpawn() override" in output
    assert "SetHealth(50)" in output
    assert "SetMaxHealth(50)" in output
    assert 'SetName("Bunny")' in output
    assert 'SetRace("neutral")' in output
    assert not errors.has_errors


def test_member_variables():
    source = """\
{
setvard MY_VAR 42
setvard MY_STR hello
}
{ game_spawn
hp MY_VAR
}"""
    output, errors = transpile_source(source)
    assert "int MY_VAR;" in output
    assert "string MY_STR;" in output


def test_const_declaration():
    source = """\
{
const DAMAGE 10
const SOUND monsters/hit.wav
}"""
    output, errors = transpile_source(source)
    assert "const int DAMAGE = 10;" in output
    assert 'const string SOUND = "monsters/hit.wav";' in output


def test_local_variable():
    source = """\
{ game_spawn
local MY_LOCAL 42
}"""
    output, errors = transpile_source(source)
    assert "int MY_LOCAL = 42;" in output


def test_if_else_codegen():
    source = """\
{ test_event
if ( X equals Y )
{
hp 50
}
else
{
hp 100
}
}"""
    output, errors = transpile_source(source)
    assert "if (" in output
    assert "else" in output


def test_dollar_rand():
    source = """\
{
setvard MY_VAR $rand(1,10)
}"""
    output, errors = transpile_source(source)
    assert "RandomInt(1, 10)" in output


def test_include_output():
    source = """\
#include monsters/base_monster
{ game_spawn
hp 50
}"""
    output, errors = transpile_source(source)
    assert '#include "monsters/base_monster.as"' in output


def test_namespace_and_class():
    output, errors = transpile_source("{ game_spawn\nhp 50\n}", "bunny.script")
    assert "namespace MS" in output
    assert "class Bunny : CGameScript" in output


def test_callevent():
    source = """\
{ game_spawn
callevent my_custom_event
}"""
    output, errors = transpile_source(source)
    assert "my_custom_event();" in output


def test_callevent_with_delay():
    source = """\
{ game_spawn
callevent 2.0 my_event
}"""
    output, errors = transpile_source(source)
    assert 'ScheduleDelayedEvent(2.0, "my_event")' in output


def test_math_operations():
    source = """\
{ game_spawn
add MY_VAR 5
subtract MY_VAR 2
multiply MY_VAR 3
}"""
    output, errors = transpile_source(source)
    assert "MY_VAR += 5;" in output
    assert "MY_VAR -= 2;" in output
    assert "MY_VAR *= 3;" in output


def test_entity_references():
    source = """\
{ game_spawn
deleteent ent_me
}"""
    output, errors = transpile_source(source)
    assert "GetOwner()" in output


def test_repeatdelay_timer():
    source = """\
{
repeatdelay 4
playanim once hop
}"""
    output, errors = transpile_source(source)
    assert "OnRepeatTimer" in output
    assert "SetRepeatDelay(4)" in output


def test_vec_literal():
    source = """\
{ game_spawn
setorigin ent_me (100,200,300)
}"""
    output, errors = transpile_source(source)
    assert "Vector3(100, 200, 300)" in output
