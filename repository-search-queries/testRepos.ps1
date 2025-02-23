param($dockerHost)
function test-repo {
  param(
    $src,
    $repo,
    $groupType,
    $Destination
  )
  try {
    Push-Location $Destination
    $queryType = if ($src -match 'index\.json') {
      'v3'
    }
    else {
      'v2'
    }

    $OutputFile = "$repo-$groupType-queriedas-$queryType.txt"
    "$src`n`n" > $OutputFile
    choco search -s $src --ignore-http-cache >> $OutputFile
    "Exit: $LASTEXITCODE`n$('='*25)`n" >> $OutputFile
    nuget search -source $src -Take 1000 >> $OutputFile
    "Exit: $LASTEXITCODE`n$('='*25)" >> $OutputFile
  }
  finally {
    Pop-Location
  }
}

$dest = (Get-Date -Format 'yyyy-MM-dd-HH-mm')
mkdir $dest

# Hosted repos
test-repo -src "http://${dockerHost}:9000/repository/nuget-hosted/" -repo nexus-hosted -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-hosted/index.json" -repo nexus-hosted -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-v2-hosted/" -repo nexus-hosted -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-v2-hosted/index.json" -repo nexus-hosted -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget-hosted/" -repo artifactory-hosted -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget-hosted/index.json" -repo artifactory-hosted -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget-v2-hosted/" -repo artifactory-hosted -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget-v2-hosted/index.json" -repo artifactory-hosted -groupType v2 -Destination $dest

# Proxy repos
test-repo -src "http://${dockerHost}:9000/repository/nuget.org-proxy/" -repo nexus-proxy -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget.org-proxy/index.json" -repo nexus-proxy -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget.org-v2-proxy/" -repo nexus-proxy -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget.org-v2-proxy/index.json" -repo nexus-proxy -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget.org-proxy/" -repo artifactory-proxy -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget.org-proxy/index.json" -repo artifactory-proxy -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget.org-v2-proxy/" -repo artifactory-proxy -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget.org-v2-proxy/index.json" -repo artifactory-proxy -groupType v2 -Destination $dest

# Grouped repos
test-repo -src "http://${dockerHost}:9000/repository/nuget-group/" -repo nexus-group -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-group/index.json" -repo nexus-group -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-v2-group/" -repo nexus-group -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:9000/repository/nuget-v2-group/index.json" -repo nexus-group -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget-group/" -repo artifactory-group -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget-group/index.json" -repo artifactory-group -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/nuget-v2-group/" -repo artifactory-group -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:8082/artifactory/api/nuget/v3/nuget-v2-group/index.json" -repo artifactory-group -groupType v2 -Destination $dest

# ProGet only has grouped repositories
test-repo -src "http://${dockerHost}:9003/nuget/nuget-group/" -repo proget -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9003/nuget/nuget-group/v3/index.json" -repo proget -groupType v3 -Destination $dest
test-repo -src "http://${dockerHost}:9003/nuget/nuget-v2-group/" -repo proget -groupType v2 -Destination $dest
test-repo -src "http://${dockerHost}:9003/nuget/nuget-v2-group/v3/index.json" -repo proget -groupType v2 -Destination $dest
