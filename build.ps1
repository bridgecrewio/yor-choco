$outfile="yor.zip"
$version="0.1.53"
write-host "$(get-date) - downloading release $version"
Invoke-WebRequest -uri "https://github.com/bridgecrewio/yor/releases/download/$($version)/yor-$($version)-windows-amd64.zip" -OutFile $outfile
tar -xvf $outfile -C .\tools\
write-host "$(get-date) - packing"
choco pack --version $version
gci *.nupkg
write-host "$(get-date) - Pushing to Chocolatey"
choco push $package.Name -s https://push.chocolatey.org/ --api-key=$env:CHOCOPUSHKEY
