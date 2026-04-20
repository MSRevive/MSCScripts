"""Tests for the parser stage."""

from msc_transpiler.errors import ErrorCollector
from msc_transpiler.pipeline.preprocessor import preprocess
from msc_transpiler.pipeline.lexer import lex_file
from msc_transpiler.pipeline.parser import parse_script
from msc_transpiler.ast_nodes import Command, IfBlock


def parse(source: str):
    errors = ErrorCollector()
    pp = preprocess(source, "test.script")
    lexed = lex_file(pp)
    return parse_script(lexed, pp, errors), errors


def test_simple_event_block():
    ast, errors = parse("{ game_spawn\nhp 50\n}")
    assert len(ast.events) == 1
    assert ast.events[0].name == "game_spawn"
    assert len(ast.events[0].body) == 1


def test_init_block():
    ast, errors = parse("{\nconst HP 50\nsetvard GOLD 10\n}")
    assert len(ast.events) == 1
    assert ast.events[0].is_init


def test_eventname_keyword():
    ast, errors = parse("{\neventname spawn\nhp 50\n}")
    assert ast.events[0].name == "spawn"


def test_include_preserved():
    ast, errors = parse("#include monsters/base\n{ game_spawn\n}")
    assert len(ast.includes) == 1
    assert ast.includes[0].path == "monsters/base"


def test_if_block_with_braces():
    source = """\
{ test_event
if ( X equals Y )
{
hp 50
}
}"""
    ast, errors = parse(source)
    assert len(ast.events) == 1
    body = ast.events[0].body
    assert len(body) >= 1
    assert isinstance(body[0], IfBlock)
    assert not body[0].guard_style


def test_if_else_block():
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
    ast, errors = parse(source)
    body = ast.events[0].body
    assert isinstance(body[0], IfBlock)
    assert len(body[0].body) >= 1
    assert len(body[0].else_body) >= 1


def test_guard_style_if():
    source = """\
{ test_event
if X equals Y
hp 50
}"""
    ast, errors = parse(source)
    body = ast.events[0].body
    assert isinstance(body[0], IfBlock)
    assert body[0].guard_style


def test_multiple_events():
    source = """\
{ game_spawn
hp 50
}
{ game_death
gold 10
}"""
    ast, errors = parse(source)
    assert len(ast.events) == 2
    assert ast.events[0].name == "game_spawn"
    assert ast.events[1].name == "game_death"


def test_scope_directive():
    ast, errors = parse("#scope server\n{ game_spawn\n}")
    assert ast.scope_directive is not None
    assert ast.scope_directive.scope == "server"
