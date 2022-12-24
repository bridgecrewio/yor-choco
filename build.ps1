$outfile="yor.zip"
$version=(Invoke-RestMethod https://api.github.com/repos/bridgecrewio/yor/releases/latest).name

Write-Host "$(get-date) - downloading release $version"
Invoke-WebRequest -uri "https://github.com/bridgecrewio/yor/releases/download/$($version)/yor_$($version)_windows_amd64.zip" -OutFile $outfile
tar -xvf $outfile -C .\tools\

Write-Host "$(get-date) - packing"
choco pack --version $version

Get-ChildItem *.nupkg
Write-Host "$(get-date) - Pushing to Chocolatey Feed"
choco push $package.Name -s https://push.chocolatey.org/ --api-key=$env:CHOCOPUSHKEY
