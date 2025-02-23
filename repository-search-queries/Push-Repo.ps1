param(
    $Source,
    $Key
)

Get-ChildItem *.nupkg | ForEach-Object {
    choco push $_.fullname --source $source --key $key --force
}
