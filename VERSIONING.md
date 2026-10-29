# LieVPN Versioning Policy & Release Guidelines

> **IMPORTANT FOR ALL AI AGENTS & DEVELOPERS:**
> Always read this document before updating versions or building releases.

## Current Baseline Version
- **v1.1.8**

## Version Increment Rules
1. **Regular Updates & Bugfixes**:
   - Increment the **patch** component sequentially:
     - `1.1.9`, `1.1.10`, `1.1.11` ... up to `1.1.20`+
   - Examples: minor UI polishes, fixes for TUN/VPN, proxy list adjustments, localization tweaks.

2. **Colossal & Major Feature Updates**:
   - Increment the **minor** component immediately to `1.2.0` (or `1.3.0`, etc.):
     - Examples: massive redesigns, completely new major subsystems, fundamental protocol additions.

3. **Where to update version when releasing**:
   - `pubspec.yaml`: update `version: X.Y.Z+buildNumber`
   - Repository manifest `version.json` (served via GitHub):
     ```json
     {
       "version": "X.Y.Z",
       "apkUrl": "https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.apk",
       "windowsUrl": "https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.exe",
       "linuxUrl": "https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.AppImage"
     }
     ```
   - Commit and push to GitHub `main` branch.
   - Build assets (Android APK, Windows EXE, Linux AppImage) and upload directly to GitHub Releases under tag `vX.Y.Z`.
   - All client updates and downloads are distributed 100% through GitHub Releases.
