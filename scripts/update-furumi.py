"""Set the Furumi formula version and hash from a verified release archive."""

import argparse
import hashlib
import re
from pathlib import Path

STABLE = r"(?:0|[1-9][0-9]*)(?:\.(?:0|[1-9][0-9]*)){2}"


def update_formula(tag: str, downloads: Path, formula: Path) -> None:
    if not re.fullmatch(f"v{STABLE}", tag):
        raise ValueError("expected a stable vMAJOR.MINOR.PATCH release")
    version = tag[1:]
    original = formula.read_text()
    version_pattern = rf'^(  VERSION = ")({STABLE})(")$'
    checksum_pattern = r'^(  SHA256 = ")([0-9a-f]{64})(")$'
    current = re.findall(version_pattern, original, re.MULTILINE)
    if len(current) != 1 or len(re.findall(checksum_pattern, original, re.MULTILINE)) != 1:
        raise ValueError("expected one VERSION and one SHA256 constant in the formula")
    if tuple(map(int, version.split("."))) < tuple(map(int, current[0][1].split("."))):
        print(f"Skipping older Furumi release {tag}")
        return

    filename = f"furumi-macos-aarch64-{version}.tar.gz"
    pattern = rf"([0-9a-fA-F]{{64}}) [ *]{re.escape(filename)}"
    checksums = [
        match[1].lower()
        for line in (downloads / "SHA256SUMS").read_text().splitlines()
        if (match := re.fullmatch(pattern, line))
    ]
    if len(checksums) != 1:
        raise ValueError(f"expected one SHA256SUMS entry for {filename}")
    sha256 = hashlib.sha256()
    with (downloads / filename).open("rb") as archive:
        for chunk in iter(lambda: archive.read(1024 * 1024), b""):
            sha256.update(chunk)
    if sha256.hexdigest() != checksums[0]:
        raise ValueError(f"SHA-256 mismatch for {filename}")

    updated = re.sub(version_pattern, rf"\g<1>{version}\g<3>", original, flags=re.MULTILINE)
    updated = re.sub(checksum_pattern, rf"\g<1>{checksums[0]}\g<3>", updated, flags=re.MULTILINE)
    if updated != original:
        formula.write_text(updated)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("tag")
    parser.add_argument("downloads", type=Path)
    parser.add_argument("formula", type=Path)
    args = parser.parse_args()
    try:
        update_formula(args.tag, args.downloads, args.formula)
    except (OSError, ValueError) as error:
        parser.exit(1, f"{error}\n")


if __name__ == "__main__":
    main()
