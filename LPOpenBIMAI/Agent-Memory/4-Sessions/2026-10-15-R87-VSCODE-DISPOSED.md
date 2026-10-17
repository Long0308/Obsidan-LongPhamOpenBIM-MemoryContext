# R87 VS Code disposed transport research · 15 October 2026

Workspace D:/61.SetupAgent; root01a0ff9a-8a57-7eb3-8920-bd775cdea9de;
Hindsight bank may-agent-memory. Canonical incident remains
error-db/2026-10-15-codex-mock-gateway-and-vscode-reload.md, R87 section.

[MEASURED] Installed VSCode1.141.2 commit
16507d91be0dc1ce4f94c04d4d0430210b8685d9 recognizes connectionDisposed,
but _handleClientOperationFailure starts recovery ONLY for connectionClosed.
Current official copilotAgent.ts has the same guard. This explains persistent
failures against a dead SDK transport; the initial disposal trigger is unproven.
First client-not-connected11:11:35.800, first disposed11:17:36.686 BEFORE the
11:17:38 abort. No UriError in inspected host/renderer logs.

[MEASURED] Supported Developer: Restart Local Agent Host executed after explicit
user resumption11:32:56, host58144->54044. Original pinned chat
Check auto-restart for page4400, AgentHostd53f39bc-d0e4-43e6-8a4f-f93135c94395,
SDK79040487-3fea-4868-95f0-e224c02f330a, attached disposed=false11:33:44.
Configured AntiGemini answered R86_VSCODE_RECONNECTED_20261015 at11:36:30,
then seven user-driven tool completions succeeded11:41:09-11:42:12. No disposed
entries after11:32:57 through11:45:08.221. Upstream model identity not attested;
bounded successful observation is not a permanent fix guarantee.

[RESEARCH] microsoft/vscode#340758 reports exact same error on RemoteSSH with
UriError; this local machine lacks that preceding signature. #332085/#338099
describe separate BYOK model-not-registered failures. No confirmed release fixing
this disposed path was found. Reddit recurring Agents hangs are corroboration,
not diagnosis. Evidence and frozen sources/hashes:
.runtime/architecture-audit-20261008/r87-disposed-research/receipt.json.

[PRESERVE] Chats, pins, unsaved work, SecretStorage and native DB. Do not restart
healthy Docker, overwrite credentials, disable sandbox/antivirus, delete history,
patch installed VSCode bundles, or restart progressing concurrent work.

[PENDING] The second physical Escape stopped UI automation; do not resume UI
without user resumption. Original /compact draft has not been restored/submitted.
DeepSeek native VSCode UAT and long-duration stability remain pending. Project
editor opened at D:/61.SetupAgent; old workspaceless chats were not rebound.
Architecture original count remains40/63 completed23open. Cognee recall timed out
8.027s this turn; new checkpoint graph ingestion/readback remains unverified.
