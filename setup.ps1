winget install JanDeDobbeleer.OhMyPosh
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module -Name PSReadLine -RequiredVersion 2.2.0-beta1 -AllowPrerelease
Install-Module z -AllowClobber
Install-Module -Name PowerShellGet -Force
Install-Module PSReadLine -AllowPrerelease -Force
cp .\mojada.omp.json ~\mojada.omp.json

Get-Content mojada-config.ps1 > $PROFILE

. $PROFILE



