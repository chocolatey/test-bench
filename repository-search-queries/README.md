# Test Package Creation

The files in this directory are aimed at helping reproduce and test the findings of Chocolatey's investigation into repository managers. See our [blog post](https://blog.chocolatey.org/2025/02/repository-search-queries/) for more information.

## Key Files

- `Vagrantfile` - A vagrant environment to ease the creation of new packages and pushing to the repositories.
- `New-Dependencies.ps1`/`New-Packages.ps1` - Scripts used to generate hundreds of packages with multiple versions as well as multiple packages with dependencies.
- `Push-Repo.ps1` - A script to ease the pushing of packages to the repositories. Will push every `nupkg` it finds to the source specified.
- `compose.yaml` - Docker compose file to bring up the repository managers at the versions specified in `.env`
- `.env` - Variables for the Docker Compose file to specify the version of each product to use. Used to ensure versions stay consistent between tests.
- `testRepos.ps1` - Script used to test all of the repositories when configured as outlined in the document.
