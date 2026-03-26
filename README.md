# Stepless Volume

> Fine-grained volume control for Android — customize your volume step count.

![KernelSU](https://img.shields.io/badge/KernelSU-Module-green?style=flat-square)
![Magisk](https://img.shields.io/badge/Magisk-Compatible-blue?style=flat-square)
![APatch](https://img.shields.io/badge/APatch-Compatible-purple?style=flat-square)
![Android](https://img.shields.io/badge/Android-12%2B-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)

---

## The Problem

Android's default 15 volume steps (~6.7% each) are too coarse. It's either too loud or too quiet, with nothing in between.

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

<details>
<summary><b>Settings</b></summary>

### Volume Stream

Choose whether to apply the step count to media volume only, or media + voice calls.

### Safety

**Disable safe media volume warning** — removes the "volume above safe level" popup. With more steps, this warning can trigger at low actual volume since it's based on step number. Sets `audio.safemedia.bypass=true`.

### Debug Menu

Enable in Settings > Advanced. Shows active system properties, config files, and module status. Also writes a log file accessible via ADB:

```
adb shell "su -c 'cat /data/adb/modules/stepless-volume/debug.log'"
```

</details>

<details>
<summary><b>Bluetooth Limitation</b></summary>

This module changes Android's internal volume steps. For **phone speakers and wired headphones**, this works perfectly — you get the exact number of steps you set.

For **Bluetooth devices**, volume is controlled via the AVRCP protocol. Your Bluetooth speaker/soundbar has its own fixed number of volume levels (typically 15-20). Android maps its steps to the device's levels, so you may still experience larger jumps over Bluetooth regardless of the step count you set.

This is a firmware limitation of the Bluetooth device, not something Android can change. The device's own remote may support finer control because it communicates directly with the hardware, bypassing Bluetooth.

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

<details>
<summary><b>How It Works</b></summary>

Android's `AudioService` reads `ro.config.media_vol_steps` once at boot. This module sets that property via `system.prop` at the `post-fs-data` stage — before AudioService initializes. Requires a reboot to apply changes.

### Data Files

| File | Purpose |
|------|---------|
| `/data/adb/volsteps_config` | Saved step count (persists across updates) |
| `/data/adb/volsteps_settings` | Stream mode, safe volume bypass, debug toggle |
| `system.prop` | Generated at boot from config |

</details>

---

## License

MIT
