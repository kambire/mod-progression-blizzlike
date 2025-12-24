# Local release script: commits and tags locally (no push)
# Usage: Run from repository root in PowerShell

param(
    [string]$Message = "Add progression advanced configs (disabled) and arena vendor restrictions",
    [string]$TagPrefix = "prod/progression-configs-",
    [switch]$NoVerify
)

function Check-Git {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error "Git is not available in this environment. Install Git or run these commands on your machine."
        exit 1
    }
}

Check-Git

# Show status
git status --porcelain

# Stage the config file
git add "conf/progression_system.conf.dist"

# Commit
$commitCmd = "git commit -m '$Message'"
if ($NoVerify) { $commitCmd += " --no-verify" }
Invoke-Expression $commitCmd

# Create timestamped tag
$ts = Get-Date -Format yyyyMMddHHmmss
$tag = "$TagPrefix$ts"
git tag -a $tag -m "Local release: $Message"

Write-Host "Local commit and tag created: $tag"
Write-Host "To push later, run:`n git push origin HEAD`n git push origin --tags"
