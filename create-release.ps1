param(
    [Parameter(Mandatory=$true)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$SourceRepo = "D:\PrimeRx",
    
    [Parameter(Mandatory=$false)]
    [string]$ReleaseRepo = "D:\rgxprimerx\PrimeRx-Releases",
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipBuild,
    
    [Parameter(Mandatory=$false)]
    [switch]$AutoCreateGitHubRelease
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PrimeRx Release Creator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor Yellow
Write-Host ""

# Validate version format
if ($Version -notmatch '^\d+\.\d+\.\d+$') {
    Write-Host "Error: Version must be in format X.Y.Z (e.g., 1.0.1)" -ForegroundColor Red
    exit 1
}

# Step 1: Update version in source files
Write-Host "Step 1: Updating version numbers..." -ForegroundColor Yellow

$primeRxCsproj = "$SourceRepo\PrimeRx\PrimeRx.csproj"
$updaterCsproj = "$SourceRepo\PrimeRxUpdater\PrimeRxUpdater.csproj"
$buildScript = "$SourceRepo\build-update.ps1"

if (-not (Test-Path $primeRxCsproj)) {
    Write-Host "Error: PrimeRx.csproj not found at $primeRxCsproj" -ForegroundColor Red
    exit 1
}

# Update PrimeRx.csproj
$primeRxContent = Get-Content $primeRxCsproj -Raw
$primeRxContent = $primeRxContent -replace '<Version>.*</Version>', "<Version>$Version</Version>"
$primeRxContent | Set-Content $primeRxCsproj -NoNewline
Write-Host "Updated: PrimeRx.csproj" -ForegroundColor Green

# Update PrimeRxUpdater.csproj
$updaterContent = Get-Content $updaterCsproj -Raw
$updaterContent = $updaterContent -replace '<Version>.*</Version>', "<Version>$Version</Version>"
$updaterContent | Set-Content $updaterCsproj -NoNewline
Write-Host "Updated: PrimeRxUpdater.csproj" -ForegroundColor Green

# Update build script
$buildContent = Get-Content $buildScript -Raw
$buildContent = $buildContent -replace '\$Version = ".*"', "`$Version = `"$Version`""
$buildContent | Set-Content $buildScript -NoNewline
Write-Host "Updated: build-update.ps1" -ForegroundColor Green

Write-Host ""

# Step 2: Build the release
if (-not $SkipBuild) {
    Write-Host "Step 2: Building release..." -ForegroundColor Yellow
    
    cd $SourceRepo
    & .\build-update.ps1
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Build failed" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Build completed successfully" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "Step 2: Skipping build (as requested)" -ForegroundColor Yellow
    Write-Host ""
}

# Step 3: Copy to release repository
Write-Host "Step 3: Copying to release repository..." -ForegroundColor Yellow

$zipFile = "PrimeRx-win-x64-v$Version.zip"
$sourceZip = "$SourceRepo\publish\$zipFile"
$destZip = "$ReleaseRepo\Release\$zipFile"

if (-not (Test-Path $sourceZip)) {
    Write-Host "Error: Built zip file not found at $sourceZip" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "$ReleaseRepo\Release")) {
    New-Item -ItemType Directory -Path "$ReleaseRepo\Release" -Force | Out-Null
}

Copy-Item $sourceZip $destZip -Force
Write-Host "Copied: $zipFile" -ForegroundColor Green
Write-Host ""

# Step 4: Commit to release repository
Write-Host "Step 4: Committing to release repository..." -ForegroundColor Yellow

cd $ReleaseRepo
git add "Release\$zipFile"

$commitMessage = "Add PrimeRx v$Version release"
git commit -m $commitMessage

Write-Host "Committed: $commitMessage" -ForegroundColor Green
Write-Host ""

# Step 5: Push to remote
Write-Host "Step 5: Pushing to remote repository..." -ForegroundColor Yellow

git push

Write-Host "Pushed successfully" -ForegroundColor Green
Write-Host ""

# Step 6: Create GitHub release (optional)
if ($AutoCreateGitHubRelease) {
    Write-Host "Step 6: Creating GitHub release..." -ForegroundColor Yellow
    Write-Host "Note: This requires GitHub CLI (gh) to be installed and authenticated" -ForegroundColor Yellow
    
    try {
        $releaseNotes = "## PrimeRx v$Version`n`n**Developed by Prime LogicTech**`n📞 986-7788298 | 📧 primelogictech3@gmail.com`n🌐 https://www.facebook.com/PrimeLogictech`n`n### What's New`n- Add your release notes here`n`n### Installation`nDownload and extract the zip file. Run PrimeRx.exe to start.`n`n### Upgrade`nIf you have a previous version, the auto-update system will handle the upgrade automatically."
        
        gh release create "v$Version" "Release\$zipFile" --notes $releaseNotes --title "PrimeRx v$Version"
        
        Write-Host "GitHub release created: v$Version" -ForegroundColor Green
    } catch {
        Write-Host "Warning: Could not create GitHub release automatically" -ForegroundColor Yellow
        Write-Host "Please create it manually at: https://github.com/Mrcoderv/PrimeRx-Releases/releases/new" -ForegroundColor Yellow
    }
    
    Write-Host ""
}

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Release Created Successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Version: $Version" -ForegroundColor White
Write-Host "Location: $destZip" -ForegroundColor White
Write-Host "Commit: Added to release repository" -ForegroundColor White
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Test the release locally" -ForegroundColor White
Write-Host "2. Create GitHub release (if not auto-created)" -ForegroundColor White
Write-Host "3. Notify users of the update" -ForegroundColor White
Write-Host ""
Write-Host "GitHub release URL: https://github.com/Mrcoderv/PrimeRx-Releases/releases/new" -ForegroundColor Cyan
Write-Host ""
