# macos-fetch

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS-blue.svg)](https://www.apple.com/macos/)
[![Shell](https://img.shields.io/badge/shell-zsh-green.svg)](https://www.zsh.org/)
[![Stars](https://img.shields.io/github/stars/tyffan1/macos-fetch?style=social)](https://github.com/tyffan1/macos-fetch)

> A `macos` command for zsh: Apple logo + system info, just like neofetch.

```
                    'c.         john@MacBook-Pro----------------
                 ,xNMM.         OS: macOS 14.4 (23E224)
               .OMMMMo          Host: MacBook Pro (Mac16,7)
               OMMM0,           Kernel: Darwin 24.3.0
     .;loddo:' loolloddol;.     Uptime: 3 days, 14 hours, 52 mins
   cKMMMMMMMMMMNWMMMMMMMMMM0:   Shell: zsh 5.9
 .KMMMMMMMMMMMMMMMMMMMMMMMWd.   Resolution: 3456 x 2234 Retina
 XMMMMMMMMMMMMMMMMMMMMMMMX.     DE: Aqua
;MMMMMMMMMMMMMMMMMMMMMMMM:      Terminal: Apple_Terminal 453
:MMMMMMMMMMMMMMMMMMMMMMMM:      CPU: Apple M3 Pro (5P + 6E, 11 cores)
.MMMMMMMMMMMMMMMMMMMMMMMMX.     GPU: Apple M3 Pro
 kMMMMMMMMMMMMMMMMMMMMMMMMWd.   Memory: 11.42GiB / 18.00GiB (63%)
 'XMMMMMMMMMMMMMMMMMMMMMMMMMMk  Disk: 342.19GiB / 994.41GiB (34%)
  'XMMMMMMMMMMMMMMMMMMMMMMMMK.
    kMMMMMMMMMMMMMMMMMMMMMMd
     ;KMMMMMMMWXXWMMMMMMMk.
       "cooc*"    "*coo'"
```

Under the info block there is a 16-color palette, like in the original
neofetch. The title, the field labels and the separator are colored, the
logo is white.

## Features

- Apple logo + system info in one view
- 16-color palette bar (like neofetch)
- Auto-detects terminal width — stacks logo/info on narrow terminals
- Colors auto-disable when piped or when `NO_COLOR=1` is set
- Custom logo color support
- Lightweight — pure zsh, no dependencies
- Fast — ~0.4s runtime

## Installation

```zsh
git clone https://github.com/tyffan1/macos-fetch.git
cd macos-fetch
./install.sh
source ~/.zshrc
macos
```

`install.sh` creates the symlink `~/.local/bin/macos` and adds
`export PATH="$HOME/.local/bin:$PATH"` to `~/.zshrc` (only if it is not
there yet). Both steps are idempotent — running it twice is harmless.

## Usage

```zsh
macos
```

### Environment variables

| Variable | Description |
|---|---|
| `MACOS_LOGO_COLOR` | Custom logo color (ANSI escape) |
| `MACOS_DEBUG=1` | Print layout debug info (`cols`, `w`, `info_w`) |
| `NO_COLOR=1` | Disable all colors |

### Examples

```zsh
# Custom logo color (cyan)
MACOS_LOGO_COLOR=$'\033[1;36m' macos

# Debug layout
MACOS_DEBUG=1 macos

# No colors
NO_COLOR=1 macos
```

## What it collects

| Field | Source |
|---|---|
| OS | `sw_vers` |
| Host | `system_profiler SPHardwareDataType` (model + identifier) |
| Kernel | `uname -sr` |
| Uptime | `sysctl kern.boottime` |
| Shell | `$ZSH_VERSION` |
| Resolution / GPU | `system_profiler SPDisplaysDataType` |
| CPU | `sysctl machdep.cpu.brand_string` + core split (P/E) |
| Memory | `sysctl hw.memsize` + `vm_stat` |
| Disk | `df -Pk /System/Volumes/Data` |
| Terminal | `$TERM_PROGRAM` + version |

Nothing is sent anywhere — the script only reads local system data.

## Uninstall

```zsh
rm ~/.local/bin/macos
```

Then remove the `export PATH=...` line from `~/.zshrc` if you do not use
`~/.local/bin` for anything else.

## Files

| File | Purpose |
|---|---|
| `macos` | the script itself (zsh) |
| `install.sh` | installs the symlink + PATH |
| `README.md` | this page |

## License

[MIT](LICENSE) © 2026 tyffan1
