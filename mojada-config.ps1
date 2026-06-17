# 1. Oh My Posh - prompt theme
$ompTheme = Join-Path $HOME ".config\oh-my-posh\mojada.omp.json"
oh-my-posh init pwsh --config $ompTheme | Invoke-Expression

# 2. PSReadLine - history search and completion
Import-Module PSReadLine -ErrorAction SilentlyContinue
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# 3. Prediction suggestions, only when the host supports them
try {
    Set-PSReadLineOption -PredictionSource History -ErrorAction Stop
    Set-PSReadLineOption -PredictionViewStyle ListView -ErrorAction Stop
} catch {
    # Some redirected or embedded terminals do not support VT output.
}

# 4. Terminal icons and Git helpers
Import-Module Terminal-Icons -ErrorAction SilentlyContinue
Import-Module posh-git -ErrorAction SilentlyContinue

# 5. Small daily aliases
Set-Alias ll Get-ChildItem
Set-Alias which Get-Command
Set-Alias grep Select-String

Write-Host "PowerShell beautified environment loaded!" -ForegroundColor Green
