# Stepless Volume

> Fine-grained volume control for Android — customize your volume step count.

![KernelSU](https://img.shields.io/badge/KernelSU-Module-green?style=flat-square)
![Magisk](https://img.shields.io/badge/Magisk-Compatible-blue?style=flat-square)
![APatch](https://img.shields.io/badge/APatch-Compatible-purple?style=flat-square)
![Android](https://img.shields.io/badge/Android-12%2B-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)

---

## The Problem

Android's default 15 volume steps (~6.7% each) are too coarse — especially over Bluetooth speakers and soundbars. It's either too loud or too quiet, with nothing in between.

## The Fix

This module lets you set any number of volume steps (5-150). More steps = finer control.

| Steps | % per step | Feel |
|-------|-----------|------|
| 15 | 6.7% | Stock — coarse jumps |
| 30 | 3.3% | Fine — good balance |
| 50 | 2.0% | Finer — precise control |
| 100 | 1.0% | Ultra — near-continuous |

---

## Quick Start

1. Download the latest `.zip` from [Releases](https://github.com/dracediax/stepless-volume/releases)
2. Flash via your module manager
3. Reboot — you now have 30 steps (default)
4. Open the **WebUI** to customize

---

## WebUI

- **Presets** — Stock (15), Fine (30), Finer (50), Ultra (100)
- **Slider** — drag to set any value from 5-150
- **Dual input** — type steps or %, the other auto-fills
- **Live preview** — shows current active step count vs your new setting
- **Save + Reboot** — one tap each

---

## Settings

<details>
<summary>Volume Stream</summary>

Choose whether to apply the step count to media volume only, or media + voice calls.

</details>

<details>
<summary>Bluetooth: Disable Absolute Volume</summary>

If your Bluetooth speaker/soundbar has large volume jumps or requires double-pressing the volume button, enable this.

**What it does:** Decouples Android's volume from the Bluetooth device's volume. Set your speaker to a comfortable level once, then use your phone's volume buttons for fine-grained control.

**Sets:** `persist.bluetooth.disableabsvol=true`

</details>

<details>
<summary>Debug Menu</summary>

Enable in Settings > Advanced. Shows:
- Active system properties (`ro.config.media_vol_steps`, `persist.bluetooth.disableabsvol`)
- Config file contents
- Module status
- Bluetooth connection info

Debug info is also written to a log file accessible via ADB:
```
adb shell "su -c 'cat /data/adb/modules/stepless-volume/debug.log'"
```

</details>

---

## Compatibility

| Manager | Works |
|---------|-------|
| KernelSU / KernelSU Next | Yes |
| Magisk | Yes |
| APatch | Yes |
| KsuWebUI (standalone) | Yes |

Any manager that supports `system.prop` works. WebUI requires a manager with WebUI support or [KsuWebUI](https://github.com/adivenxnataly/KsuWebUI).

---

## How It Works

Android's `AudioService` reads `ro.config.media_vol_steps` once at boot. This module sets that property via `system.prop` at the `post-fs-data` stage — before AudioService initializes.

| File | Purpose |
|------|---------|
| `/data/adb/volsteps_config` | Saved step count (persists across updates) |
| `/data/adb/volsteps_settings` | Stream mode, BT toggle, debug toggle |
| `system.prop` | Generated at boot from config |

---

## License

MIT
