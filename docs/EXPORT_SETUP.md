# Export Setup

This project ships export presets for `WindowsDesktop`, `Web`, and `Android`.

## Quick commands

From the repository root (works with Windows PowerShell 5.1 or PowerShell 7+):

- Install Godot export templates automatically (one-time, idempotent):
  - `powershell -ExecutionPolicy Bypass -File .\tools\install_export_templates.ps1`
  - Add `-Force` to reinstall; override version with `-GodotVersion 4.6.2 -GodotChannel stable`.
- Check environment for a given preset:
  - `powershell -ExecutionPolicy Bypass -File .\tools\check_export_prereqs.ps1 -Preset Web`
  - `powershell -ExecutionPolicy Bypass -File .\tools\check_export_prereqs.ps1 -Preset All`
- Export one platform (debug):
  - `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset WindowsDesktop`
  - `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset Web`
  - `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset Android`
- Export all presets (debug):
  - `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -All`
- Release export (single preset):
  - `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset WindowsDesktop -Release`
- Serve the Web build locally (Python 3 required):
  - `powershell -ExecutionPolicy Bypass -File .\tools\serve_web.ps1 -Open`

## Required prerequisites

### Godot CLI

Set one of:

- `GODOT_PATH` env var, or
- pass `-GodotPath` to scripts.

Expected binary (default fallback in scripts):

- `F:/Godot_v4.6.2-stable_win64.exe/Godot_v4.6.2-stable_win64_console.exe`

### Export templates (Godot 4.6.2)

Templates are expected under:

- `%APPDATA%\Godot\export_templates\4.6.2.stable`

Minimum files checked:

- Web: `web_nothreads_debug.zip`, `web_nothreads_release.zip`
- Android: `android_source.zip`

### Java + Android SDK (for Android preset)

Set environment variables:

- `JAVA_HOME`
- `ANDROID_SDK_ROOT` (or `ANDROID_HOME`)

Expected Android SDK content:

- `platform-tools\adb.exe`
- at least one folder under `build-tools\`

## Output paths

Preset outputs are aligned with `export_presets.cfg`:

- Windows: `build/windows/CivPlagueRush.exe`
- Web: `build/web/index.html`
- Android: `build/android/CivPlagueRush.apk`

## Notes

- `tools/export.ps1` runs prerequisite checks by default and is **preset-aware**: exporting `Web` does not require Java/Android SDK.
- Use `-SkipPrereqCheck` only for local experiments.
- If `-All` is used, the script continues through presets and returns non-zero if any platform failed.

## CI

GitHub Actions (`.github/workflows/build.yml`) builds Windows and Web on every push to `main` and on pull requests, uploading the artifacts. Android is intentionally skipped in CI until the Android SDK image is wired up.
