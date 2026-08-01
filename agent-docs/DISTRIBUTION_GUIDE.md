# Distribution Guide — All-in-One SMK (Windows)

SMK is distributed as **one self-contained package**. End users install or unzip once and run `SMK.exe`. They never install Python, ffmpeg, pip, or other tools.

## What is bundled

| Component | Purpose |
|-----------|---------|
| Python runtime | App execution (inside PyInstaller build) |
| PyQt5 + Qt WebEngine | GUI + in-app GPS map |
| ffmpeg + ffprobe | Video overlays, repair, GPS read |
| Pillow, mutagen, exif | Metadata embed |
| folium + assets | Map HTML generation |

## Build (release maintainer only)

```powershell
powershell -ExecutionPolicy Bypass -File .\build_smk.ps1
```

This script:

1. Creates/uses `.venv` (developers only — not shipped)
2. Downloads ffmpeg into `tools/ffmpeg/` if missing
3. Runs `pyinstaller smd.spec`
4. Copies ffmpeg beside `dist/smd/SMK.exe`

**Output:** `dist/smd/` — zip this folder or compile `smd_installer.iss` with Inno Setup.

## Release checklist

- [ ] `dist/smd/SMK.exe` launches without console window
- [ ] About dialog shows ffmpeg: **Bundled**
- [ ] Bundled export: merge + metadata on sample ZIP
- [ ] GPS map tab loads (WebEngine)
- [ ] No prompts to install external software
- [ ] Publish SHA-256 for installer/ZIP
- [ ] Include FFmpeg LGPL notice in release notes (ffmpeg.org/legal.html)

## User messaging

- **Not affiliated with Snap Inc.**
- **All-in-one:** no extra installs
- **Bundled exports (2026+):** works fully offline
- **Link-only exports (legacy JSON with URLs):** not supported - request a new export with media in the ZIP
- **My Eyes Only** not included in Memories export

## Preferred trust path: Microsoft Store

**Decision (2026-08):** ship the trusted Windows install via the **Microsoft Store**
(individual developer account is free with ID verification). GitHub Releases stay
available for portable ZIP / advanced users; Store is what we point most people at
once the listing is live.

### You (Las) — account & listing

1. Open a free Individual account at https://storedeveloper.microsoft.com  
   (use your real government ID; other Partner Center entry points may still show the old paid flow).
2. In Partner Center, reserve the app name (e.g. **Snapchat Memories Keeper**).
3. Prepare Store assets: icon, screenshots, short/long description, privacy policy URL
   (can be a simple page on las-hs.com or a `PRIVACY.md` in the repo), age rating questionnaire.
4. Submit the MSIX package for certification; fix any policy feedback.

### Repo — packaging (next engineering work)

1. Keep building the all-in-one folder with `build_smk.ps1` (`dist/smd/SMK.exe` + ffmpeg + WebEngine).
2. Wrap that folder as **MSIX** (Desktop Bridge / `makeappx` or Visual Studio Packaging Project).
3. Declare needed capabilities (filesystem access for user-chosen export ZIPs / output folders).
4. Test install from a sideloaded MSIX, then upload to Partner Center.

Until the Store listing is public: GitHub downloads remain unsigned → SmartScreen note in README.

## Code signing (Authenticode) — optional later

Not required for Store distribution (Store uses its own trust model).  
Still useful if we keep a signed GitHub installer for people who refuse the Store.

When you have a CA certificate: sign `SMK.exe` + Inno setup, then publish a new GitHub release with new hashes.
