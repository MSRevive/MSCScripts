"""Condition operator translation."""

from __future__ import annotations


# Map MSCScript condition operators to AngelScript
OPERATOR_MAP = {
    "equals": "==",
    "==": "==",
    "isnot": "!=",
    "!=": "!=",
    "<": "<",
    ">": ">",
    "<=": "<=",
    ">=": ">=",
    "less": "<",
    "greater": ">",
}


def translate_condition_op(op: str, left: str, right: str, negated: bool = False) -> str:
    """Translate a condition to AngelScript expression string."""
    op_lower = op.lower()

    # Truthy check: if VAR or if !VAR
    if op_lower == "truthy":
        if negated:
            return f"!({left})"
        # Check for uninitialized variable pattern: VAR equals 'VAR'
        return f"({left})"

    # Special operators
    if op_lower == "contains":
        expr = f'({left}).findFirst({right}) >= 0'
        return f"!({expr})" if negated else expr

    if op_lower == "startswith":
        expr = f'({left}).findFirst({right}) == 0'
        return f"!({expr})" if negated else expr

    if op_lower == "endswith":
        expr = f'EndsWith({left}, {right})'
        return f"!({expr})" if negated else expr

    # Check for uninitialized variable pattern: VAR equals 'VAR'
    # In MSCScript, if a variable hasn't been set, its value is the variable name itself
    if op_lower in ("equals", "==") and right.startswith("'") and right.endswith("'"):
        var_name = right[1:-1]
        if var_name == left:
            # This means "if variable is uninitialized"
            expr = f'!HasVar("{left}")'
            return f"!({expr})" if negated else expr

    # Standard operators
    as_op = OPERATOR_MAP.get(op_lower, op)
    expr = f"{left} {as_op} {right}"
    return f"!({expr})" if negated else expr
