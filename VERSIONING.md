# LieVPN Versioning Policy & Release Guidelines

> **IMPORTANT FOR ALL AI AGENTS & DEVELOPERS:**
> Always read this document before updating versions or building releases.

## Current Baseline Version
- **v1.0.0** (First Official Release - 25 September 2026)

## Version Increment Rules
1. **Regular Updates & Bugfixes**:
   - Increment the **patch** component sequentially:
     - `1.0.1`, `1.0.2`, `1.0.3` ... up to `1.0.20`+
   - Examples: minor UI polishes, fixes for TUN/VPN, proxy list adjustments, localization tweaks.

2. **Colossal & Major Feature Updates**:
   - Increment the **minor** component immediately to `1.1.0` (or `1.2.0`, etc.):
     - Examples: massive redesigns, completely new major subsystems, fundamental protocol additions.

3. **Where to update version when releasing**:
   - `pubspec.yaml`: update `version: X.Y.Z+buildNumber`
   - Remote version manifest on server `/var/www/files/version.json` (served at `https://clck.lie2srvv.com/files/version.json`):
     ```json
     {
       "version": "1.0.0",
       "apkUrl": "https://clck.lie2srvv.com/files/lievpn.apk",
       "windowsUrl": "https://clck.lie2srvv.com/files/LieVPN-Windows.zip",
       "changelog": "Description of changes in this release"
     }
     ```
   - Build and deploy Android APK to:
     `root@31.76.80.10:/var/www/files/lievpn.apk` (and ensure `/var/www/files/LieVPN.apk` is symlinked).
   - Push git commit to trigger GitHub Actions Windows build.
