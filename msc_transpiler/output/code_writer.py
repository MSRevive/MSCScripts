"""Indentation-aware code emitter for AngelScript output."""

from __future__ import annotations


class CodeWriter:
    """Builds AngelScript source with proper indentation."""

    def __init__(self, indent_str: str = "\t"):
        self._lines: list[str] = []
        self._indent: int = 0
        self._indent_str: str = indent_str

    def line(self, text: str = ""):
        """Write a line at current indentation."""
        if text:
            self._lines.append(f"{self._indent_str * self._indent}{text}")
        else:
            self._lines.append("")

    def raw_line(self, text: str):
        """Write a line with no indentation adjustment."""
        self._lines.append(text)

    def indent(self):
        """Increase indent level."""
        self._indent += 1

    def dedent(self):
        """Decrease indent level."""
        self._indent = max(0, self._indent - 1)

    def open_brace(self, prefix: str = ""):
        """Write 'prefix {' and indent."""
        if prefix:
            self.line(f"{prefix}")
            self.line("{")
        else:
            self.line("{")
        self.indent()

    def close_brace(self, suffix: str = ""):
        """Dedent and write '}'."""
        self.dedent()
        self.line(f"}}{suffix}")

    def blank(self):
        """Write a blank line."""
        self._lines.append("")

    def comment(self, text: str):
        """Write a comment line."""
        self.line(f"// {text}")

    def todo(self, text: str):
        """Write a TODO comment."""
        self.line(f"// TODO: {text}")

    def build(self) -> str:
        """Return the complete source string."""
        return "\n".join(self._lines) + "\n"
