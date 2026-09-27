"""Preprocessor: strips comments, extracts #include/#scope directives."""

from __future__ import annotations

import re
from dataclasses import dataclass, field

from ..ast_nodes import IncludeDirective, ScopeDirective


@dataclass
class PreprocessedLine:
    """A source line after preprocessing."""
    text: str
    original: str
    line_number: int


@dataclass
class PreprocessedFile:
    """Result of preprocessing a .script file."""
    filename: str
    lines: list[PreprocessedLine] = field(default_factory=list)
    includes: list[IncludeDirective] = field(default_factory=list)
    scope_directive: ScopeDirective | None = None


_INCLUDE_RE = re.compile(
    r"^#include\s+(?:\[(\w+)\]\s+)?(.+)$", re.IGNORECASE
)
_SCOPE_RE = re.compile(r"^#scope\s+(\w+)$", re.IGNORECASE)


def preprocess(source: str, filename: str = "<unknown>") -> PreprocessedFile:
    """Preprocess MSCScript source: strip comments, extract directives."""
    result = PreprocessedFile(filename=filename)
    raw_lines = source.replace("\r\n", "\n").replace("\r", "\n").split("\n")

    for i, raw in enumerate(raw_lines, start=1):
        original = raw
        # Strip inline comments (// not inside quotes)
        line = _strip_comment(raw)
        stripped = line.strip()

        if not stripped:
            continue

        # Check for #scope directive
        m = _SCOPE_RE.match(stripped)
        if m:
            result.scope_directive = ScopeDirective(scope=m.group(1).lower(), line=i)
            continue

        # Check for #include directive
        m = _INCLUDE_RE.match(stripped)
        if m:
            scope = m.group(1) or ""
            path = m.group(2).strip()
            result.includes.append(
                IncludeDirective(path=path, scope=scope.lower(), line=i)
            )
            continue

        result.lines.append(PreprocessedLine(text=stripped, original=original, line_number=i))

    return result


def _strip_comment(line: str) -> str:
    """Strip // comments, but not inside quoted strings."""
    in_quote = False
    quote_char = None
    i = 0
    while i < len(line):
        ch = line[i]
        if in_quote:
            if ch == quote_char:
                in_quote = False
        else:
            if ch in ('"', "'", '`'):
                in_quote = True
                quote_char = ch
            elif ch == '/' and i + 1 < len(line) and line[i + 1] == '/':
                return line[:i]
        i += 1
    return line
