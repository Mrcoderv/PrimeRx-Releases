# PrimeRx Release Guide

This guide is for developers who need to create new releases of PrimeRx.

**PrimeRx is developed by Prime LogicTech**  
📞 986-7788298 | 📧 primelogictech3@gmail.com  
🌐 [https://www.facebook.com/PrimeLogictech](https://www.facebook.com/PrimeLogictech)

## 📋 Prerequisites

- Access to the private source repository: `Mrcoderv/PrimeRx`
- Access to the public releases repository: `Mrcoderv/PrimeRx-Releases`
- .NET 10.0 SDK installed
- Git configured with proper credentials
- PowerShell (for Windows builds)

## 🚀 Quick Release Process

### Step 1: Update Version Numbers

1. **Update PrimeRx.csproj**:
   ```xml
   <PropertyGroup>
       <Version>1.0.1</Version>  <!-- Increment this -->
   </PropertyGroup>
   ```

2. **Update PrimeRxUpdater.csproj**:
   ```xml
   <PropertyGroup>
       <Version>1.0.1</Version>  <!-- Match PrimeRx version -->
   </PropertyGroup>
   ```

3. **Update build script** (if needed):
   ```powershell
   $Version = "1.0.1"  # In build-update.ps1
   ```

### Step 2: Build the Release

Navigate to the source repository and run:

```powershell
cd D:\PrimeRx
.\build-update.ps1
```

This will:
- Build PrimeRx for win-x64 (self-contained)
- Build PrimeRxUpdater for win-x64 (self-contained)
- Copy updater to PrimeRx directory
- Create release zip: `PrimeRx-win-x64-v1.0.1.zip`

### Step 3: Test the Build

Before releasing, test the build:

```powershell
# Extract to test location
Expand-Archive -Path publish\PrimeRx-win-x64-v1.0.1.zip -DestinationPath test-install

# Run the application
cd test-install
.\PrimeRx.exe
```

Verify:
- Application starts correctly
- Database can be created
- Update checker works
- No errors in console

### Step 4: Prepare Release Notes

Create release notes following this template:

```markdown
## PrimeRx v1.0.1

**Developed by Prime LogicTech**  
📞 986-7788298 | 📧 primelogictech3@gmail.com  
🌐 [https://www.facebook.com/PrimeLogictech](https://www.facebook.com/PrimeLogictech)

### What's New
- Feature 1 description
- Feature 2 description

### Bug Fixes
- Fixed issue with...
- Resolved problem with...

### Improvements
- Performance improvements
- UI enhancements

### Database Changes
- No database migration required
- OR: Database migration to version X required

### Known Issues
- List any known issues

### Upgrade Instructions
- Automatic update available
- OR: Manual update required due to...
```

### Step 5: Create GitHub Release

1. Go to: https://github.com/Mrcoderv/PrimeRx-Releases/releases/new
2. Fill in the form:
   - **Tag**: `v1.0.1` (must start with 'v')
   - **Release title**: `PrimeRx v1.0.1`
   - **Description**: Paste your release notes
3. **Attach the zip file**:
   - Click "Attach binaries"
   - Select: `D:\PrimeRx\publish\PrimeRx-win-x64-v1.0.1.zip`
4. **Publish release**

### Step 6: Copy to Release Repository (Optional)

If you maintain local copies:

```powershell
# Copy the built zip to the release repository
Copy-Item D:\PrimeRx\publish\PrimeRx-win-x64-v1.0.1.zip D:\rgxprimerx\PrimeRx-Releases\Release\

# Commit to release repository
cd D:\rgxprimerx\PrimeRx-Releases
git add Release\PrimeRx-win-x64-v1.0.1.zip
git commit -m "Add PrimeRx v1.0.1 release"
git push
```

## 📋 Version Numbering

Use semantic versioning: `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes, major features
- **MINOR**: New features, improvements
- **PATCH**: Bug fixes, small changes

Examples:
- `1.0.0` → `1.0.1` (Bug fix)
- `1.0.1` → `1.1.0` (New feature)
- `1.1.0` → `2.0.0` (Major update)

## 🔐 Pre-Release Checklist

Before publishing, ensure:

- [ ] Version numbers updated in both projects
- [ ] Build completes without errors
- [ ] Application launches successfully
- [ ] Database operations work correctly
- [ ] Update checker functions properly
- [ ] Release notes are comprehensive
- [ ] No critical bugs remain
- [ ] Tested on clean Windows installation
- [ ] Backup/restore functionality verified

## 🚨 Emergency Hotfix Process

For critical bug fixes:

1. Update version to PATCH increment (e.g., `1.0.0` → `1.0.1`)
2. Fix the bug in source
3. Build and test immediately
4. Create release with "Hotfix" in title
5. Notify users of critical update

## 📊 Release Automation (Optional)

### Automated Release Script

Create `create-release.ps1` in the release repository:

```powershell
param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

$SourceRepo = "D:\PrimeRx"
$ReleaseRepo = "D:\rgxprimerx\PrimeRx-Releases"

# Update version in source
$csproj = "$SourceRepo\PrimeRx\PrimeRx.csproj"
$content = Get-Content $csproj
$content = $content -replace '<Version>.*</Version>', "<Version>$Version</Version>"
$content | Set-Content $csproj

# Build
cd $SourceRepo
.\build-update.ps1

# Copy to release repo
$zipFile = "PrimeRx-win-x64-v$Version.zip"
Copy-Item "publish\$zipFile" "$ReleaseRepo\Release\"

# Commit
cd $ReleaseRepo
git add "Release\$zipFile"
git commit -m "Add PrimeRx v$Version release"
git push

Write-Host "Release $Version created and committed"
```

Usage:
```powershell
.\create-release.ps1 -Version "1.0.1"
```

## 📝 Post-Release Tasks

After releasing:

1. **Monitor**: Watch for user feedback and issues
2. **Document**: Update any documentation if needed
3. **Archive**: Archive old releases if keeping many
4. **Plan**: Start planning next release

## 🔧 Troubleshooting

### Build Fails
- Check .NET SDK version: `dotnet --version`
- Restore packages: `dotnet restore`
- Clean build: `dotnet clean && dotnet build`

### Upload Fails
- Check file size (GitHub limit: 2GB)
- Verify internet connection
- Check GitHub token permissions

### Version Conflicts
- Ensure both .csproj files have same version
- Check build script version variable
- Verify GitHub tag doesn't already exist

## 📞 Support

For release issues:
- Contact the development team
- Check build logs for errors
- Review GitHub Actions (if configured)

---

**Remember**: Always test thoroughly before releasing to production users!
