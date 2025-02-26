param(
  $TotalPackages = 100
)

# Create a base package for depencdencies
(Get-Content "$PSScriptRoot/template.nuspec" -raw) -replace '\[\[ID\]\]', "dep1" | Out-File "dep1.nuspec" -Encoding utf8
choco pack "dep1.nuspec" --version 1.0.0
foreach ($number in (2..$TotalPackages)) {
  $packageId = "dep$number"
  (Get-Content "$PSScriptRoot/dependencies.nuspec" -raw) -replace '\[\[ID\]\]', $packageId -replace '\[\[DEP\]\]', "dep$($number - 1)" | Out-File "$packageId.nuspec" -Encoding utf8
  choco pack "$packageId.nuspec" --version 1.0.0
}
