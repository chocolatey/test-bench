param(
  $TotalPackages = 10
)
foreach ($number in (1..$TotalPackages)) {
  $packageId = "test$number"
  (Get-Content "$PSScriptRoot/template.nuspec" -raw) -replace '\[\[ID\]\]', $packageId | Out-File "$packageId.nuspec" -Encoding utf8
  choco pack "$packageId.nuspec" --version 1.0.0
  choco pack "$packageId.nuspec" --version 1.0.1
  choco pack "$packageId.nuspec" --version 1.0.2-pre
  choco pack "$packageId.nuspec" --version 1.0.0-alpha
}
