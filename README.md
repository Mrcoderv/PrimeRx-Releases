# PrimeRx Releases

This repository contains official release binaries for PrimeRx Pharmacy Management System.

## 📋 About

PrimeRx is a comprehensive pharmacy billing and management software developed by **Prime LogicTech**. This repository stores only compiled release binaries - source code is maintained in a separate private repository.

## 🏢 About Prime LogicTech

**Prime LogicTech** is a technology company specializing in pharmacy management solutions.

- **Website**: [Prime LogicTech](https://www.facebook.com/PrimeLogictech)
- **Facebook**: [Follow us on Facebook](https://www.facebook.com/PrimeLogictech)
- **Specialization**: Pharmacy billing, inventory management, and business automation

## 🚀 Latest Release

### Version 1.0.0
- **Release Date**: June 23, 2026
- **Platform**: Windows x64
- **File**: `PrimeRx-win-x64-v1.0.0.zip`
- **Size**: ~82 MB

### Quick Download
Download the latest release from the [Releases Page](https://github.com/Mrcoderv/PrimeRx-Releases/releases/latest)

## 📦 Installation

### System Requirements
- **OS**: Windows 10 or later (64-bit)
- **RAM**: 4 GB minimum (8 GB recommended)
- **Disk Space**: 500 MB free space
- **.NET**: No external dependencies required (self-contained)

### Installation Steps

1. **Download**: Download the latest `PrimeRx-win-x64-vX.Y.Z.zip` from releases
2. **Extract**: Extract the zip file to your desired location
3. **Run**: Double-click `PrimeRx.exe` to launch the application
4. **Setup**: Follow the on-screen setup wizard

### Default Structure
```
PrimeRx/
├── PrimeRx.exe              # Main application
├── PrimeRxUpdater.exe       # Auto-update tool
├── Data/
│   └── primerx.db          # Database (created on first run)
├── Backups/                 # Automatic database backups
├── wwwroot/                # Web interface files
└── *.dll                   # Application dependencies
```

## 🔄 Auto-Updates

PrimeRx includes an automatic update system:

- **Automatic Check**: Checks for updates on startup
- **Manual Check**: Admin → Settings → Updates tab
- **One-Click Updates**: Download and install updates with a single click
- **Database Safety**: Automatic backup before updates
- **Rollback**: Database backups retained for recovery

### Update Process
1. PrimeRx checks GitHub for new releases
2. If an update is available, you'll be notified
3. Click "Update Now" in Settings
4. Database is automatically backed up
5. Update files are downloaded and installed
6. PrimeRx restarts automatically

## 🛡️ Database Protection

Your pharmacy data is safe:

- **Automatic Backups**: Created before every update
- **Retention**: Last 10 backups maintained
- **Location**: `Backups/primerx_YYYYMMDDHHmmss.db`
- **Manual Backup**: You can manually copy `Data/primerx.db`

## 📝 Version History

See the [Releases Page](https://github.com/Mrcoderv/PrimeRx-Releases/releases) for detailed release notes and version history.

## 🔧 Troubleshooting

### Update Issues
- **Not detecting updates**: Check internet connection
- **Download fails**: Ensure disk space and file permissions
- **Update stuck**: Close PrimeRx, run manually

### Database Issues
- **Corrupted database**: Restore from `Backups/` folder
- **Missing database**: Check `Data/primerx.db`
- **Backup restore**: Copy backup file to `Data/primerx.db`

### Installation Issues
- **Antivirus blocking**: Add exception for PrimeRx folder
- **Port conflicts**: Default port 5000 must be available
- **Permissions**: Run as administrator if needed

## 📞 Support

For issues, feature requests, or support:
- **Company**: [Prime LogicTech](https://www.facebook.com/PrimeLogictech)
- **Phone**: 986-7788298
- **Email**: primelogictech3@gmail.com
- **Facebook**: [Contact us on Facebook](https://www.facebook.com/PrimeLogictech)
- **Documentation**: See [PrimeRx Wiki](https://github.com/Mrcoderv/PrimeRx/wiki)
- **Issues**: Report bugs via [GitHub Issues](https://github.com/Mrcoderv/PrimeRx/issues)

## 🔐 Security

- **Source Code**: Maintained in private repository
- **Releases Only**: This repository contains only compiled binaries
- **Verified Builds**: All releases are officially signed builds
- **Update Security**: Updates downloaded from official GitHub releases

## 📄 License

PrimeRx is proprietary software. See your license agreement for terms of use.

## 🔄 Release Process

For developers releasing new versions, see [RELEASE_GUIDE.md](RELEASE_GUIDE.md)

---

**Note**: This repository is read-only for end users. All updates are delivered through the built-in auto-update system.
