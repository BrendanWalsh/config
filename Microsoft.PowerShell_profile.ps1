# Brendan
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardKillWord

Import-Module posh-git
$GitPromptSettings.AfterText += "`n "
$GitPromptSettings.DefaultPromptPrefix = '`n$(Get-Date -f "MM-dd HH:mm") '
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultForegroundColor = [ConsoleColor]::Green

New-Alias mk minikube
New-Alias kk kubectl
New-Alias g git
New-Alias dk docker
New-Alias grep findstr
New-Alias cl Clear-Print

function scratch {
    cd C:\dev\scratch
}

function b64d {
    param(
        [Parameter(Mandatory=$true)][string]$str
    )
    [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($str))
}

function b64e {
    param(
        [Parameter(Mandatory=$true)][string]$str
    )
    [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($str))
}

function dkpkgversion {
    param(
        [Parameter(Mandatory=$true)][string]$image,
        [Parameter(Mandatory=$true)][string]$package
    )
    docker run --rm --entrypoint="apt-cache" $image show $package
}

function dkinspect {
    param(
        [Parameter(Mandatory=$true)][string]$image
    )
    docker run -v C:\dev\scratch:/scratch --rm -it --entrypoint /bin/bash $image
}

function Find-Contents {
    param(
        [Parameter(Mandatory=$true)][string]$Pattern,
        [Parameter(Mandatory=$false)][string]$FilePattern
    )
    Get-ChildItem -recurse -Filter $FilePattern | Select-String -pattern "$Pattern" | group path | select name
}

function Stop-Containers {
    dk rm -f $(dk ps -aq)
}

function Free-Port {
    param([Parameter(Mandatory=$true)][int]$port)
    $process_id = (Get-NetTCPConnection -LocalPort $port).OwningProcess
    if ($process_id)
    {
      $process = Get-Process -ID $process_id
      Write-Host "Killing process '$($process.Name)' with ID '$process_id'"
      Stop-Process -Id $process_id
    }
}

function Check-Port {
    param([Parameter(Mandatory=$true)][int]$port)
    $process_id = (Get-NetTCPConnection -LocalPort $port).OwningProcess
    if ($process_id)
    {
      $process = Get-Process -ID $process_id
      Write-Host "Port in use by process '$($process.Name)' with ID '$process_id'"
    }
}

function bashrc {
    code $profile
}

function profile {
    code $profile
}

function dev {
    cd C:\dev
}

function docker-clean-all {
  docker stop -f $(docker ps -aq)
  docker rm -f $(docker ps -aq)
  docker rmi -f $(docker images -aq)
}

function gitl {
    clear
    git log
}

function glog {
    clear
    git log
}

function gf {
    clear
    git fetch
    git status
}

function gs {
    clear
    dir
    Write-Host ""
    git status
}

function gd {
    clear
    git diff
}

function gbl {
    clear
    git branch -l
}

function guorigin {
    clear
    git branch -u origin/master
	git status
}

function gorigin {
    git checkout origin/master
    clear
	git status
}

function gmaster {
    git checkout origin/master
    clear
	git status
}

function gborigin {
    param([Parameter(Mandatory=$true)][string]$name)
	
	clear
	git checkout -b $name origin/master
	git status
}

function gco {
    param([Parameter(Mandatory=$true)][string]$branch)
	
	clear
	git checkout $branch
}

function dkrma {
    docker rm -f $(docker ps -aq)
    docker rmi $(docker images -q)
}

function dksa {
    docker rm -f $(docker ps -aq)
}

function dks {
    docker images
}

function dki {
    docker images
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
