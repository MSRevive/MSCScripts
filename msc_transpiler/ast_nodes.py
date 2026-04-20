"""AST node definitions for the MSCScript transpiler."""

from __future__ import annotations
from dataclasses import dataclass, field
from typing import Optional, Union


# ── Expressions ──────────────────────────────────────────────

@dataclass
class Literal:
    """A literal value: int, float, string, or unquoted token."""
    value: str
    line: int = 0

    def __repr__(self):
        return f"Literal({self.value!r})"


@dataclass
class VectorLiteral:
    """A vector literal like (1,2,3)."""
    x: str
    y: str
    z: str
    line: int = 0

    def __repr__(self):
        return f"Vector({self.x},{self.y},{self.z})"


@dataclass
class DollarFunc:
    """A $function call like $rand(1,10) or $get(ent_me,hp)."""
    name: str
    args: list[Expression]
    line: int = 0

    def __repr__(self):
        return f"${self.name}({', '.join(repr(a) for a in self.args)})"


@dataclass
class VariableRef:
    """A reference to a variable (PARAM1, ent_me, MY_VAR, game.time, etc.)."""
    name: str
    line: int = 0

    def __repr__(self):
        return f"Var({self.name})"


@dataclass
class Concatenation:
    """Implicit string concatenation of multiple expressions."""
    parts: list[Expression]
    line: int = 0


# Union of all expression types
Expression = Union[Literal, VectorLiteral, DollarFunc, VariableRef, Concatenation]


# ── Conditions ───────────────────────────────────────────────

@dataclass
class Condition:
    """A condition expression like 'X equals Y' or 'X > Y'."""
    left: Expression
    operator: str  # equals, isnot, <, >, <=, >=, ==, !=, contains, startswith
    right: Expression
    negated: bool = False
    line: int = 0


@dataclass
class CompoundCondition:
    """Multiple conditions combined with && or ||."""
    conditions: list[Union[Condition, "CompoundCondition"]]
    operator: str = "&&"  # && or ||
    line: int = 0


# ── Statements ───────────────────────────────────────────────

@dataclass
class Command:
    """A single command statement like 'hp 50' or 'setmodel monsters/orc.mdl'."""
    name: str
    args: list[Expression]
    line: int = 0
    raw_line: str = ""  # Original source line for fallback


@dataclass
class IfBlock:
    """An if/else block.

    guard_style: True if this is a bare 'if X equals Y' without braces
    (means: if NOT condition, skip rest of event)
    """
    condition: Union[Condition, CompoundCondition]
    body: list[Statement]
    else_body: list[Statement] = field(default_factory=list)
    guard_style: bool = False
    line: int = 0


@dataclass
class Comment:
    """A comment line."""
    text: str
    line: int = 0


@dataclass
class RawLine:
    """An unconverted raw line (fallback)."""
    text: str
    line: int = 0


# Union of all statement types
Statement = Union[Command, IfBlock, Comment, RawLine]


# ── Top-Level Structures ────────────────────────────────────

@dataclass
class EventBlock:
    """An event block like { game_spawn ... }."""
    name: str  # e.g. "game_spawn", "npc_struck", "" for unnamed init blocks
    scope: str = ""  # "server", "client", "shared", or ""
    body: list[Statement] = field(default_factory=list)
    line: int = 0
    is_init: bool = False  # True for unnamed initialization blocks


@dataclass
class IncludeDirective:
    """A #include directive."""
    path: str
    scope: str = ""  # Optional scope tag like [server]
    line: int = 0


@dataclass
class ScopeDirective:
    """A #scope directive."""
    scope: str  # "server", "client", "shared"
    line: int = 0


@dataclass
class ScriptFile:
    """Root AST node representing an entire .script file."""
    filename: str
    scope_directive: Optional[ScopeDirective] = None
    includes: list[IncludeDirective] = field(default_factory=list)
    events: list[EventBlock] = field(default_factory=list)

    @property
    def init_blocks(self) -> list[EventBlock]:
        return [e for e in self.events if e.is_init]

    @property
    def named_events(self) -> list[EventBlock]:
        return [e for e in self.events if not e.is_init]
