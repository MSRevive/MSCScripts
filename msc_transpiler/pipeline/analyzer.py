"""Analyzer: type inference, scope resolution, validation.

Phase 1 implementation is minimal — just validates the AST structure.
More sophisticated analysis will be added in later phases.
"""

from __future__ import annotations

from ..ast_nodes import ScriptFile, EventBlock, IfBlock, Command, Statement
from ..errors import ErrorCollector


def analyze(script: ScriptFile, errors: ErrorCollector) -> ScriptFile:
    """Analyze and validate a parsed script AST. Returns the (possibly modified) AST."""
    _validate_events(script, errors)
    _resolve_guard_ifs(script, errors)
    return script


def _validate_events(script: ScriptFile, errors: ErrorCollector):
    """Check for common issues in event blocks."""
    event_names = set()
    for event in script.named_events:
        if event.name in event_names:
            errors.warning(
                f"Duplicate event name '{event.name}'",
                script.filename, event.line,
            )
        event_names.add(event.name)

        if not event.body:
            errors.info(
                f"Empty event block '{event.name}'",
                script.filename, event.line,
            )


def _resolve_guard_ifs(script: ScriptFile, errors: ErrorCollector):
    """Resolve guard-style if blocks by collecting subsequent statements into the guard body.

    A guard-style `if` in MSCScript means: if the condition is FALSE, skip
    the rest of the statements until the next guard or end of block.

    We convert this to: `if (!condition) return;` and leave subsequent
    statements outside the if block.
    """
    for event in script.events:
        event.body = _process_guards(event.body)


def _process_guards(stmts: list[Statement]) -> list[Statement]:
    """Process guard-style if blocks in a statement list.

    Guard-style ifs with empty bodies just become guard checks.
    The code generator handles emitting them as `if (!cond) return;`.
    """
    result: list[Statement] = []

    for stmt in stmts:
        if isinstance(stmt, IfBlock) and not stmt.guard_style:
            # Recurse into block-style if bodies
            stmt.body = _process_guards(stmt.body)
            stmt.else_body = _process_guards(stmt.else_body)
        result.append(stmt)

    return result
