# Export Setup

This project ships export presets for `WindowsDesktop`, `Web`, and `Android`.

## Quick commands

From the repository root:

- Check environment and installed templates:
  - `pwsh -File .\tools\check_export_prereqs.ps1`
- Export one platform (debug):
  - `pwsh -File .\tools\export.ps1 -Preset WindowsDesktop`
  - `pwsh -File .\tools\export.ps1 -Preset Web`
  - `pwsh -File .\tools\export.ps1 -Preset Android`
- Export all presets (debug):
  - `pwsh -File .\tools\export.ps1 -All`
- Release export (single preset):
  - `pwsh -File .\tools\export.ps1 -Preset WindowsDesktop -Release`

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

- `tools/export.ps1` runs prerequisite checks by default.
- Use `-SkipPrereqCheck` only for local experiments.
- If `-All` is used, the script continues through presets and returns non-zero if any platform failed.
