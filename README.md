# omp-mojada-theme-main

Personal Windows Terminal + PowerShell 7 beautification files based on Oh My Posh.

The current theme is a customized `jandedobbeleer` style prompt. It keeps the colorful prompt layout and updates the Python segment so active conda or virtualenv environments are visible, even from the home directory.

## Files

| File | Purpose |
| --- | --- |
| `mojada.omp.json` | Oh My Posh theme. Includes a Python segment configured for conda/venv display. |
| `mojada-config.ps1` | PowerShell profile template with Oh My Posh, PSReadLine, Terminal-Icons, posh-git, and aliases. |
| `setup.ps1` | Installer that copies the theme and updates `$PROFILE` safely. |
| `settings.json` | Windows Terminal settings reference. Review before replacing your local settings. |

## Requirements

- Windows 10 or later
- PowerShell 7
- Windows Terminal
- A Nerd Font, for example `CaskaydiaCove Nerd Font` or `MesloLGM Nerd Font`
- Oh My Posh

Optional modules:

- `Terminal-Icons`
- `PSReadLine`
- `posh-git`

## PSReadLine Shortcuts

The profile template enables prefix-based history search:

```powershell
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
```

Type the beginning of a command, then press `UpArrow` or `DownArrow` to search matching history entries. For example, type `conda` and press `UpArrow` to cycle through previous `conda ...` commands.

## Install

Run PowerShell from this repository:

```powershell
.\setup.ps1
```

To install or update the optional modules as well:

```powershell
.\setup.ps1 -InstallModules
```

The installer copies the theme to:

```text
%USERPROFILE%\.config\oh-my-posh\mojada.omp.json
```

It also backs up the existing PowerShell profile before changing it:

```text
%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1.bak-YYYYMMDD-HHMMSS
```

Restart PowerShell, or reload the profile:

```powershell
. $PROFILE
```

## Conda Environment Display

This theme shows the active conda or virtualenv name through the Oh My Posh Python segment.

Recommended conda setting:

```powershell
conda config --set changeps1 False
```

Then activate an environment:

```powershell
conda activate yolo26
```

You should see the environment name in the yellow Python prompt segment.

To verify conda is actually active:

```powershell
$env:CONDA_DEFAULT_ENV
```

## Manual Profile Line

If you prefer editing `$PROFILE` yourself, add this line:

```powershell
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\mojada.omp.json" | Invoke-Expression
```

## Windows Terminal Settings

`settings.json` is included as a reference from the original setup. Do not overwrite your current Windows Terminal settings blindly. Compare it with your local settings first, especially font face, color scheme, and profile GUIDs.
