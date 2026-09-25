"""CLI entry point: python -m msc_transpiler <input_dir> <output_dir>"""

from __future__ import annotations

import sys
import time
from pathlib import Path

from .config import TranspilerConfig, parse_args
from .errors import ErrorCollector
from .output.file_writer import mirror_path, write_output
from .pipeline.preprocessor import preprocess
from .pipeline.lexer import lex_file
from .pipeline.parser import parse_script
from .pipeline.analyzer import analyze
from .pipeline.codegen import generate


def transpile_file(input_path: Path, errors: ErrorCollector) -> str:
    """Transpile a single .script file to AngelScript source."""
    source = input_path.read_text(encoding="utf-8", errors="replace")
    filename = str(input_path)

    # Pipeline: preprocess → lex → parse → analyze → codegen
    preprocessed = preprocess(source, filename)
    lexed = lex_file(preprocessed)
    ast = parse_script(lexed, preprocessed, errors)
    ast = analyze(ast, errors)
    output = generate(ast, errors)

    return output


def run(config: TranspilerConfig) -> int:
    """Run the transpiler with the given configuration."""
    errors = ErrorCollector()
    start_time = time.time()

    # Collect input files
    if config.single_file:
        input_files = [config.single_file]
    else:
        input_files = sorted(config.input_dir.rglob("*.script"))
        if config.filter_pattern:
            import fnmatch
            input_files = [
                f for f in input_files
                if fnmatch.fnmatch(str(f), f"*{config.filter_pattern}*")
            ]

    if not input_files:
        print(f"No .script files found in {config.input_dir}")
        return 1

    print(f"Found {len(input_files)} .script files")

    success_count = 0
    error_count = 0
    total_commands = 0
    unconverted_commands = 0

    for input_file in input_files:
        file_errors = ErrorCollector()
        try:
            output = transpile_file(input_file, file_errors)

            # Count TODO: UNCONVERTED lines
            for line in output.split("\n"):
                if "TODO: UNCONVERTED" in line:
                    unconverted_commands += 1
                elif line.strip() and not line.strip().startswith("//"):
                    total_commands += 1

            if not config.dry_run:
                output_path = mirror_path(input_file, config.input_dir, config.output_dir)
                write_output(output, output_path)

            if config.verbose:
                status = "OK" if not file_errors.has_errors else "WARN"
                print(f"  [{status}] {input_file.name} ({file_errors.summary()})")

            success_count += 1

        except Exception as e:
            error_count += 1
            errors.error(f"Failed to transpile: {e}", str(input_file))
            if config.verbose:
                print(f"  [ERR] {input_file.name}: {e}")

        # Merge file errors
        errors.messages.extend(file_errors.messages)

    elapsed = time.time() - start_time

    # Summary
    print(f"\n{'='*60}")
    print(f"Transpilation complete in {elapsed:.1f}s")
    print(f"  Files: {success_count}/{len(input_files)} succeeded, {error_count} failed")
    converted = total_commands
    total = total_commands + unconverted_commands
    if total > 0:
        pct = converted / total * 100
        print(f"  Commands: {converted}/{total} converted ({pct:.1f}%)")
    else:
        print(f"  Commands: 0 total")
    print(f"  {errors.summary()}")

    if not config.dry_run:
        print(f"  Output: {config.output_dir}")

    # Write error log
    if errors.messages:
        log_content = errors.dump()
        config.log_file.write_text(log_content, encoding="utf-8")
        print(f"  Error log: {config.log_file}")

    return 0 if not errors.has_errors else 1


def main():
    config = parse_args()
    sys.exit(run(config))


if __name__ == "__main__":
    main()
