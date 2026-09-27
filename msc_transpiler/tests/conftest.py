"""Test fixtures for the MSCScript transpiler."""

import pytest
from pathlib import Path

from msc_transpiler.errors import ErrorCollector
from msc_transpiler.pipeline.preprocessor import preprocess
from msc_transpiler.pipeline.lexer import lex_file
from msc_transpiler.pipeline.parser import parse_script
from msc_transpiler.pipeline.analyzer import analyze
from msc_transpiler.pipeline.codegen import generate


@pytest.fixture
def errors():
    return ErrorCollector()


def transpile_source(source: str, filename: str = "test.script") -> tuple[str, ErrorCollector]:
    """Helper to transpile a source string and return (output, errors)."""
    errors = ErrorCollector()
    preprocessed = preprocess(source, filename)
    lexed = lex_file(preprocessed)
    ast = parse_script(lexed, preprocessed, errors)
    ast = analyze(ast, errors)
    output = generate(ast, errors)
    return output, errors
