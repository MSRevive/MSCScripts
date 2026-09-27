"""Error and warning collection for the transpiler pipeline."""

from dataclasses import dataclass, field
from enum import Enum
from typing import Optional


class Severity(Enum):
    INFO = "info"
    WARNING = "warning"
    ERROR = "error"


@dataclass
class TranspilerMessage:
    severity: Severity
    message: str
    file: str = ""
    line: int = 0
    column: int = 0

    def __str__(self):
        loc = f"{self.file}:{self.line}" if self.file else f"line {self.line}"
        return f"[{self.severity.value.upper()}] {loc}: {self.message}"


class ErrorCollector:
    """Collects errors and warnings across the transpiler pipeline."""

    def __init__(self):
        self.messages: list[TranspilerMessage] = []

    def error(self, msg: str, file: str = "", line: int = 0):
        self.messages.append(TranspilerMessage(Severity.ERROR, msg, file, line))

    def warning(self, msg: str, file: str = "", line: int = 0):
        self.messages.append(TranspilerMessage(Severity.WARNING, msg, file, line))

    def info(self, msg: str, file: str = "", line: int = 0):
        self.messages.append(TranspilerMessage(Severity.INFO, msg, file, line))

    @property
    def errors(self) -> list[TranspilerMessage]:
        return [m for m in self.messages if m.severity == Severity.ERROR]

    @property
    def warnings(self) -> list[TranspilerMessage]:
        return [m for m in self.messages if m.severity == Severity.WARNING]

    @property
    def has_errors(self) -> bool:
        return any(m.severity == Severity.ERROR for m in self.messages)

    def summary(self) -> str:
        errs = len(self.errors)
        warns = len(self.warnings)
        return f"{errs} error(s), {warns} warning(s)"

    def dump(self) -> str:
        return "\n".join(str(m) for m in self.messages)
