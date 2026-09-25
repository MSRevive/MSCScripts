"""CLI configuration and argument parsing."""

import argparse
from dataclasses import dataclass, field
from pathlib import Path
from typing import Optional


@dataclass
class TranspilerConfig:
    input_dir: Path = field(default_factory=lambda: Path("."))
    output_dir: Path = field(default_factory=lambda: Path("./angelscript"))
    verbose: bool = False
    dry_run: bool = False
    filter_pattern: Optional[str] = None
    single_file: Optional[Path] = None
    log_file: Path = field(default_factory=lambda: Path("transpiler_errors.log"))


def parse_args(argv: list[str] | None = None) -> TranspilerConfig:
    parser = argparse.ArgumentParser(
        prog="msc_transpiler",
        description="Transpile MSCScript .script files to AngelScript .as files",
    )
    parser.add_argument(
        "input_dir",
        nargs="?",
        default=".",
        help="Input directory containing .script files",
    )
    parser.add_argument(
        "output_dir",
        nargs="?",
        default=None,
        help="Output directory for .as files (default: <input_dir>/angelscript)",
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose logging")
    parser.add_argument(
        "--dry-run", action="store_true", help="Analyze without writing files"
    )
    parser.add_argument(
        "--filter", dest="filter_pattern", help="Only process files matching pattern"
    )
    parser.add_argument(
        "-f", "--file", dest="single_file", help="Transpile a single file"
    )
    parser.add_argument(
        "--log-file",
        default="transpiler_errors.log",
        help="Error log file path",
    )

    args = parser.parse_args(argv)
    input_dir = Path(args.input_dir)
    output_dir = Path(args.output_dir) if args.output_dir else input_dir / "angelscript"

    return TranspilerConfig(
        input_dir=input_dir,
        output_dir=output_dir,
        verbose=args.verbose,
        dry_run=args.dry_run,
        filter_pattern=args.filter_pattern,
        single_file=Path(args.single_file) if args.single_file else None,
        log_file=Path(args.log_file),
    )
