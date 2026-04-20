# CivPlagueRush Vertical Slice

Fast strategy prototype mixing macro-expansion decisions with crisis propagation pressure.

## Core Loop
- 8-12 minute runs (`24` turns in config)
- 3-4 high-impact decisions per turn
- Win by region control while keeping crisis contained
- Lose on collapse (low stability or extreme crisis)

## Run Flow
1. `MainMenu` starts the run.
2. `RunScene` executes turn decisions and resolves outcome.
3. `MetaHub` grants permanent credits and allows unlocks.
4. Player starts another run with upgrades applied.

## Data-Driven Content
- `data/run_config.json`: pacing, win/loss, rewards
- `data/events.json`: event cards and effects
- `data/techs.json`: permanent upgrade tree
- `data/campaign_ch1.json`: chapter lore and objective

## Metrics
Run telemetry is written to `user://metrics_runs.jsonl` with:
- run duration
- outcome
- turn count
- chapter objective completion
- credits gained

## Platform Scaling
- `project.godot` configured with mobile renderer and stretch mode.
- `scripts/systems/platform_profile.gd` adapts control sizing by platform feature flags.
- `export_presets.cfg` includes baseline Web, Windows, and Android export presets.

## Build and Export
- One-time install of Godot export templates: `powershell -ExecutionPolicy Bypass -File .\tools\install_export_templates.ps1`
- Check environment: `powershell -ExecutionPolicy Bypass -File .\tools\check_export_prereqs.ps1 -Preset Web`
- Export Windows debug: `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset WindowsDesktop`
- Export Web debug: `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -Preset Web`
- Export all platforms: `powershell -ExecutionPolicy Bypass -File .\tools\export.ps1 -All`
- Serve the Web build locally: `powershell -ExecutionPolicy Bypass -File .\tools\serve_web.ps1 -Open`
- Full setup and troubleshooting: `docs/EXPORT_SETUP.md`
- CI builds (Windows + Web) run automatically via GitHub Actions.
