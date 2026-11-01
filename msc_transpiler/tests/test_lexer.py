"""Tests for the lexer stage."""

from msc_transpiler.pipeline.preprocessor import preprocess
from msc_transpiler.pipeline.lexer import lex_file, TokenType


def lex(source: str):
    pp = preprocess(source, "test.script")
    return lex_file(pp)


def test_empty():
    result = lex("")
    assert len(result.lines) == 0


def test_simple_command():
    result = lex("hp 50")
    assert len(result.lines) == 1
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[0].type == TokenType.IDENTIFIER
    assert tokens[0].value == "hp"
    assert tokens[1].type == TokenType.NUMBER
    assert tokens[1].value == "50"


def test_hp_literal():
    result = lex("hp 50/50")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[1].type == TokenType.HP_LITERAL
    assert tokens[1].value == "50/50"


def test_percentage():
    result = lex("const CHANCE 75%")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[2].type == TokenType.PERCENTAGE
    assert tokens[2].value == "75%"


def test_dollar_func():
    result = lex("local X $rand(1,10)")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[2].type == TokenType.DOLLAR_FUNC
    assert tokens[2].value == "rand"


def test_scope_tag():
    result = lex("[server]")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[0].type == TokenType.SCOPE_TAG
    assert tokens[0].value == "server"


def test_if_keyword():
    result = lex("if X equals Y")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[0].type == TokenType.IF_KW


def test_braces():
    result = lex("{ game_spawn")
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[0].type == TokenType.OPEN_BRACE
    assert tokens[1].type == TokenType.IDENTIFIER
    assert tokens[1].value == "game_spawn"


def test_quoted_string():
    result = lex('name "Skeleton Warrior"')
    tokens = [t for t in result.lines[0].tokens if t.type != TokenType.NEWLINE]
    assert tokens[1].type == TokenType.STRING
    assert tokens[1].value == "Skeleton Warrior"


def test_comment_stripping():
    pp = preprocess("hp 50 // comment here", "test.script")
    assert pp.lines[0].text == "hp 50"


def test_include_extraction():
    pp = preprocess("#include monsters/base_monster", "test.script")
    assert len(pp.includes) == 1
    assert pp.includes[0].path == "monsters/base_monster"
    assert len(pp.lines) == 0


def test_scope_directive():
    pp = preprocess("#scope server", "test.script")
    assert pp.scope_directive is not None
    assert pp.scope_directive.scope == "server"
