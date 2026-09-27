"""File output with directory mirroring."""

from __future__ import annotations

from pathlib import Path


def write_output(content: str, output_path: Path, dry_run: bool = False) -> bool:
    """Write transpiled content to output path, creating directories as needed."""
    if dry_run:
        return True

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content, encoding="utf-8")
    return True


def mirror_path(input_file: Path, input_dir: Path, output_dir: Path) -> Path:
    """Compute output path that mirrors the input directory structure."""
    try:
        rel = input_file.relative_to(input_dir)
    except ValueError:
        rel = Path(input_file.name)

    return output_dir / rel.with_suffix(".as")
