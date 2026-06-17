[CmdletBinding()]
param(
    [switch]$InstallModules,
    [switch]$ReplaceProfile
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$configDir = Join-Path $HOME ".config\oh-my-posh"
$themeSource = Join-Path $repoRoot "mojada.omp.json"
$themeTarget = Join-Path $configDir "mojada.omp.json"
$profileTemplate = Join-Path $repoRoot "mojada-config.ps1"

New-Item -ItemType Directory -Path $configDir -Force | Out-Null
Copy-Item -LiteralPath $themeSource -Destination $themeTarget -Force

if ($InstallModules) {
    winget install JanDeDobbeleer.OhMyPosh --accept-package-agreements --accept-source-agreements
    Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
    Install-Module -Name PSReadLine -Scope CurrentUser -Force
    Install-Module -Name posh-git -Scope CurrentUser -Force
}

$profileDir = Split-Path -Parent $PROFILE
New-Item -ItemType Directory -Path $profileDir -Force | Out-Null

if (Test-Path -LiteralPath $PROFILE) {
    Copy-Item -LiteralPath $PROFILE -Destination ($PROFILE + ".bak-" + (Get-Date -Format "yyyyMMdd-HHmmss")) -Force
    $profileContent = Get-Content -Raw -LiteralPath $PROFILE
} else {
    $profileContent = ""
}

$initLine = 'oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\mojada.omp.json" | Invoke-Expression'

if ($ReplaceProfile) {
    Copy-Item -LiteralPath $profileTemplate -Destination $PROFILE -Force
} elseif ($profileContent -match '(?m)^\s*oh-my-posh\s+.*Invoke-Expression\s*$') {
    $profileContent = [regex]::Replace(
        $profileContent,
        '(?m)^\s*oh-my-posh\s+.*Invoke-Expression\s*$',
        $initLine,
        1
    )
    Set-Content -LiteralPath $PROFILE -Value $profileContent -Encoding UTF8
} else {
    Add-Content -LiteralPath $PROFILE -Value ""
    Add-Content -LiteralPath $PROFILE -Value "# Oh My Posh - mojada"
    Add-Content -LiteralPath $PROFILE -Value $initLine
}

Write-Host "Installed mojada theme to $themeTarget" -ForegroundColor Green
Write-Host "Restart PowerShell or run: . `$PROFILE" -ForegroundColor Cyan
