"""Wrapper for the as_linter.exe AngelScript compilation checker.

Provides functions to compile AngelScript source strings or files through
the real AS engine with the game's type registrations, catching type errors
and bad signatures that the transpiler's text-level checks cannot see.
"""

from __future__ import annotations

import json
import os
import subprocess
import tempfile
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional

# Default linter executable location (sibling to the transpiler package)
_DEFAULT_LINTER = Path(__file__).resolve().parent.parent / "as_linter" / "build" / "Release" / "as_linter.exe"

# Environment variable override
_LINTER_EXE = os.environ.get("AS_LINTER_EXE", str(_DEFAULT_LINTER))


@dataclass
class CompileMessage:
    row: int = 0
    col: int = 0
    type: str = ""      # "ERROR", "WARN", "INFO"
    message: str = ""


@dataclass
class CompileResult:
    success: bool = False
    messages: list[CompileMessage] = field(default_factory=list)
    file_path: str = ""

    @property
    def errors(self) -> list[CompileMessage]:
        return [m for m in self.messages if m.type == "ERROR"]

    @property
    def warnings(self) -> list[CompileMessage]:
        return [m for m in self.messages if m.type == "WARN"]

    def error_summary(self) -> str:
        errs = self.errors
        if not errs:
            return "no errors"
        lines = []
        for e in errs[:5]:
            lines.append(f"  ({e.row},{e.col}): {e.message}")
        if len(errs) > 5:
            lines.append(f"  ... and {len(errs) - 5} more")
        return "\n".join(lines)


@dataclass
class LintReport:
    total: int = 0
    passed: int = 0
    failed: int = 0
    warnings: int = 0
    results: list[CompileResult] = field(default_factory=list)


def get_linter_path() -> Path:
    """Return the path to as_linter.exe, or raise if not found."""
    p = Path(_LINTER_EXE)
    if not p.exists():
        raise FileNotFoundError(
            f"as_linter.exe not found at {p}. "
            f"Build it with CMake or set AS_LINTER_EXE env var."
        )
    return p


def linter_available() -> bool:
    """Check if the linter executable exists."""
    return Path(_LINTER_EXE).exists()


def compile_source(source: str, include_paths: Optional[list[str]] = None) -> CompileResult:
    """Compile an AngelScript source string through the linter.

    Writes the source to a temp file, runs as_linter, parses JSON output.
    Returns a CompileResult with success/failure and any error messages.
    """
    linter = get_linter_path()

    with tempfile.NamedTemporaryFile(
        mode="w", suffix=".as", delete=False, encoding="utf-8"
    ) as f:
        f.write(source)
        tmp_path = f.name

    try:
        cmd = [str(linter), "-f", tmp_path, "--format", "json"]
        if include_paths:
            for p in include_paths:
                cmd.extend(["--include-path", p])

        proc = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=30,
        )

        return _parse_json_result(proc.stdout, tmp_path)
    except subprocess.TimeoutExpired:
        result = CompileResult(file_path=tmp_path, success=False)
        result.messages.append(CompileMessage(0, 0, "ERROR", "Linter timed out"))
        return result
    except Exception as e:
        result = CompileResult(file_path=tmp_path, success=False)
        result.messages.append(CompileMessage(0, 0, "ERROR", f"Linter error: {e}"))
        return result
    finally:
        try:
            os.unlink(tmp_path)
        except OSError:
            pass


def compile_file(file_path: str | Path, include_paths: Optional[list[str]] = None) -> CompileResult:
    """Compile a single .as file through the linter."""
    linter = get_linter_path()

    cmd = [str(linter), "-f", str(file_path), "--format", "json"]
    if include_paths:
        for p in include_paths:
            cmd.extend(["--include-path", p])

    proc = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
    return _parse_json_result(proc.stdout, str(file_path))


def compile_directory(
    dir_path: str | Path,
    include_paths: Optional[list[str]] = None,
) -> LintReport:
    """Compile all .as files in a directory through the linter."""
    linter = get_linter_path()

    cmd = [str(linter), "-d", str(dir_path), "--format", "json"]
    if include_paths:
        for p in include_paths:
            cmd.extend(["--include-path", p])

    proc = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    return _parse_json_report(proc.stdout)


def _parse_json_result(json_str: str, file_path: str) -> CompileResult:
    """Parse a single-file result from the linter's JSON output."""
    try:
        data = json.loads(json_str)
    except (json.JSONDecodeError, ValueError):
        result = CompileResult(file_path=file_path, success=False)
        result.messages.append(
            CompileMessage(0, 0, "ERROR", "Failed to parse linter JSON output")
        )
        return result

    if "results" in data and data["results"]:
        entry = data["results"][0]
        result = CompileResult(
            file_path=entry.get("file", file_path),
            success=entry.get("success", False),
        )
        for msg in entry.get("messages", []):
            result.messages.append(CompileMessage(
                row=msg.get("row", 0),
                col=msg.get("col", 0),
                type=msg.get("type", "ERROR"),
                message=msg.get("message", ""),
            ))
        return result

    # Fallback: top-level summary only
    result = CompileResult(file_path=file_path, success=data.get("passed", 0) > 0)
    return result


def _parse_json_report(json_str: str) -> LintReport:
    """Parse a full batch report from the linter's JSON output."""
    try:
        data = json.loads(json_str)
    except (json.JSONDecodeError, ValueError):
        return LintReport()

    report = LintReport(
        total=data.get("total", 0),
        passed=data.get("passed", 0),
        failed=data.get("failed", 0),
        warnings=data.get("warnings", 0),
    )

    for entry in data.get("results", []):
        cr = CompileResult(
            file_path=entry.get("file", ""),
            success=entry.get("success", False),
        )
        for msg in entry.get("messages", []):
            cr.messages.append(CompileMessage(
                row=msg.get("row", 0),
                col=msg.get("col", 0),
                type=msg.get("type", "ERROR"),
                message=msg.get("message", ""),
            ))
        report.results.append(cr)

    return report
