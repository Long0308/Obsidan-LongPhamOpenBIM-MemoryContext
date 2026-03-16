# Hệ thống kiểm tra Context Window (từ đầu conversation)

## Mục tiêu

Ước lượng **số token đã dùng** từ khi bắt đầu một conversation, để:
- Biết còn bao nhiêu “chỗ” trong context window.
- Quyết định có nên bắt đầu chat mới hay tiếp tục.
- So sánh giữa các session (file lớn, @ nhiều, tool nhiều → tốn hơn).

## Cách tính context “từ đầu conversation”

Mọi thứ gửi trong **một request** đều được tính:

| Thành phần | Ghi chú |
|------------|--------|
| System prompt + rules | Cursor/IDE inject mỗi request |
| Toàn bộ lịch sử chat | User + Assistant + Tool results (từ turn 1 đến hiện tại) |
| Tin nhắn hiện tại | Nội dung bạn vừa gửi |
| File được inject | Open files, @ file/folder, recent files |
| Kết quả tool | read_file, grep, run_terminal_cmd, v.v. |

**“Từ đầu conversation”** = tổng token của (system + toàn bộ history + current message + injected context + tool outputs) tại thời điểm đó.

## Hạn chế

- Cursor không expose API token count cho workspace.
- Chỉ có thể **ước lượng** từ nội dung có được (ví dụ transcript, paste text, hoặc log độ dài từng message).

## Công cụ trong repo

- **Script**: `.agent/scripts/context_estimator.py`
  - Ước lượng token từ text (heuristic: ~4 ký tự/token tiếng Anh, ~3 cho mixed/code).
  - Input: file JSONL (transcript), hoặc text từ stdin / file .txt.
  - Output: tổng token ước lượng + % so với context limit (mặc định 128k, có thể chỉnh).

### Cách dùng nhanh

```bash
# Ước lượng từ transcript (mỗi dòng 1 JSON có "content" hoặc "text")
python .agent/scripts/context_estimator.py --transcript path/to/chat.jsonl

# Ước lượng từ một file text (ví dụ export chat)
python .agent/scripts/context_estimator.py --file exported_chat.txt

# Chỉ định context limit (mặc định 128000)
python .agent/scripts/context_estimator.py --transcript chat.jsonl --limit 200000
```

### Format transcript JSONL gợi ý

Mỗi dòng một JSON object, có ít nhất một trong các key: `content`, `text`, `message` (string). Script sẽ cộng tất cả lại.

```jsonl
{"role":"user","content":"Hello"}
{"role":"assistant","content":"Hi there..."}
{"role":"user","content":"Explain context window"}
```

## Quy ước ước lượng token

- **Tiếng Anh / code**: ~1 token ≈ 4 ký tự.
- **Tiếng Việt / mixed**: ~1 token ≈ 3 ký tự (conservative).
- Script dùng **chars / 3** mặc định để ước lượng an toàn (không vượt thật quá nhiều).

## Checklist “đã check context từ đầu conversation”

- [ ] Chạy `context_estimator.py` với transcript hoặc export của conversation.
- [ ] So sánh % với limit (128k / 200k tùy model).
- [ ] Nếu > ~70–80%, cân nhắc tóm tắt hoặc bắt đầu chat mới để tránh cắt context.
