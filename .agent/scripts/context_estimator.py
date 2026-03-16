#!/usr/bin/env python3
"""
Context Window Estimator - từ đầu conversation
===============================================

Ước lượng số token đã dùng từ khi bắt đầu một conversation.
Input: transcript JSONL, file text, hoặc stdin.

Usage:
    python context_estimator.py --transcript path/to/chat.jsonl
    python context_estimator.py --file exported.txt [--limit 200000]
    echo "some text" | python context_estimator.py
"""

import argparse
import json
import sys
from pathlib import Path

# ~1 token ≈ 4 chars (English); dùng 3 để conservative (mixed/code/Vietnamese)
CHARS_PER_TOKEN = 3
DEFAULT_CONTEXT_LIMIT = 128_000


def estimate_tokens(text: str, chars_per_token: int = CHARS_PER_TOKEN) -> int:
    """Ước lượng token từ chuỗi (heuristic)."""
    if not text or not text.strip():
        return 0
    return max(0, len(text) // chars_per_token)


def extract_text_from_jsonl_line(line: str) -> str:
    """Lấy nội dung text từ một dòng JSONL (content / text / message)."""
    line = line.strip()
    if not line:
        return ""
    try:
        obj = json.loads(line)
        if isinstance(obj, dict):
            for key in ("content", "text", "message", "body"):
                if key in obj and isinstance(obj[key], str):
                    return obj[key]
            # Nếu không có key quen thuộc, nối mọi string value
            return " ".join(str(v) for v in obj.values() if isinstance(v, str))
        if isinstance(obj, str):
            return obj
    except json.JSONDecodeError:
        pass
    return line  # fallback: coi cả dòng là text


def read_transcript(path: Path) -> str:
    """Đọc file JSONL, trích toàn bộ text và nối lại."""
    parts = []
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        for line in f:
            parts.append(extract_text_from_jsonl_line(line))
    return "\n".join(parts)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Ước lượng context (token) từ đầu conversation."
    )
    parser.add_argument(
        "--transcript",
        type=Path,
        help="Đường dẫn file transcript JSONL (mỗi dòng 1 JSON có content/text/message)",
    )
    parser.add_argument(
        "--file",
        type=Path,
        help="Đường dẫn file text thuần (một khối nội dung)",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=DEFAULT_CONTEXT_LIMIT,
        help=f"Context window size (token). Mặc định: {DEFAULT_CONTEXT_LIMIT}",
    )
    parser.add_argument(
        "--chars-per-token",
        type=int,
        default=CHARS_PER_TOKEN,
        help=f"Số ký tự coi là 1 token (mặc định {CHARS_PER_TOKEN})",
    )
    args = parser.parse_args()
    cpt = args.chars_per_token

    if args.transcript:
        if not args.transcript.exists():
            print(f"File không tồn tại: {args.transcript}", file=sys.stderr)
            return 1
        text = read_transcript(args.transcript)
        source = str(args.transcript)
    elif args.file:
        if not args.file.exists():
            print(f"File không tồn tại: {args.file}", file=sys.stderr)
            return 1
        text = args.file.read_text(encoding="utf-8", errors="replace")
        source = str(args.file)
    else:
        text = sys.stdin.read()
        source = "stdin"

    total_tokens = estimate_tokens(text, cpt)
    limit = args.limit
    pct = (100.0 * total_tokens / limit) if limit else 0

    print(f"Source: {source}")
    print(f"Estimated tokens: {total_tokens:,}")
    print(f"Context limit:     {limit:,}")
    print(f"Usage:            {pct:.1f}%")

    # Simple bar
    bar_len = 40
    filled = min(bar_len, int(bar_len * total_tokens / limit)) if limit else 0
    bar = "█" * filled + "░" * (bar_len - filled)
    print(f"[{bar}]")

    if pct >= 80:
        print("⚠️  Gần đầy context — cân nhắc bắt đầu conversation mới hoặc rút gọn.")
    elif pct >= 50:
        print("ℹ️  Đã dùng khoảng nửa context.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
