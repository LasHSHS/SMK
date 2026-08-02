# Contributing to Snapchat Memories Keeper (SMK)

Thanks for wanting to help. SMK is maintained as a **Windows-first** app, and we are **actively open to contributors**.

## High-value areas

1. **macOS / Linux** — official support is Windows only. Experimental scripts:
   `build_smk_unix.sh`, `scripts/fetch_ffmpeg.sh`, and the
   `Beta unix builds (untested)` GitHub Action. Maintainer has **not**
   verified these. Real-device testing and packaging fixes are the highest-value help.
2. **Bugs and reliability** — crashes, edge-case exports, matching/metadata mistakes.
3. **Performance** — faster processing, smoother UI, less disk thrash.
4. **Docs / UX** — clearer wording, accessibility, beginner-friendly flows.

**Not in scope soon:** iOS / iPadOS / Android native apps (desktop PyQt only).

## Before a large port

Open a GitHub issue first to agree on packaging (e.g. `.dmg` / AppImage / Flatpak), signing, and how ffmpeg is bundled. That avoids wasted work.

## Day-to-day workflow

1. Fork and branch from `master`.
2. Use a venv; install `requirements.txt` / `requirements-dev.txt`.
3. Run tests: `pytest` (see `tests/README.md`).
4. Keep PRs focused; match existing style and safety rules (especially anything that deletes or overwrites user media).
5. Update `agent-docs/ARCHITECTURE.md` / `DECISIONS.md` when behavior or structure changes.

## Local Windows build (reference)

```powershell
powershell -ExecutionPolicy Bypass -File .\build_smk.ps1
```

See `agent-docs/ALL_IN_ONE_PACKAGING.md` and `agent-docs/DISTRIBUTION_GUIDE.md`.

## Conduct

Be respectful. This project is not affiliated with Snap Inc. Do not commit personal Snapchat exports or secrets.
