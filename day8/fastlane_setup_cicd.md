# 🚀 Fastlane + Flutter — Complete CI/CD Setup Guide

> Covers local practice setup, GitHub Actions integration, and real store deployment (Android & iOS).

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Flutter App Setup](#flutter-app-setup)
4. [Android Setup](#android-setup)
   - Appfile
   - Fastfile
   - Gemfile
5. [iOS Setup](#ios-setup)
   - Appfile
   - Fastfile
   - Gemfile
6. [GitHub Actions CI/CD](#github-actions-cicd)
7. [Running Lanes Locally](#running-lanes-locally)
8. [Real Deployment (When You Have Credentials)](#real-deployment)
   - Android → Play Store
   - iOS → App Store / TestFlight
   - Fastlane Match (iOS Certificates)
9. [Environment Variables & Secrets](#environment-variables--secrets)
10. [Troubleshooting](#troubleshooting)
11. [Quick Reference Cheatsheet](#quick-reference-cheatsheet)

---

## Prerequisites

Install the following before starting:

```bash
# Ruby (Fastlane requires 2.5+)
ruby --version

# Fastlane
gem install fastlane

# Bundler (recommended)
gem install bundler

# Flutter SDK
flutter --version

# FVM - Flutter Version Manager (optional but recommended)
dart pub global activate fvm
fvm install stable
fvm use stable

# Java JDK 11+ (for Android)
java --version

# Xcode (for iOS — Mac only)
xcode-select --version
```

---

## Project Structure

```
my_flutter_app/
├── android/
│   ├── fastlane/
│   │   ├── Appfile          ← App identifier & credentials
│   │   └── Fastfile         ← Automation lanes
│   ├── Gemfile              ← Ruby dependencies
│   └── Gemfile.lock
├── ios/
│   ├── fastlane/
│   │   ├── Appfile
│   │   └── Fastfile
│   ├── Gemfile
│   └── Gemfile.lock
├── .github/
│   └── workflows/
│       ├── android_ci.yml
│       └── ios_ci.yml
├── lib/
│   └── main.dart
└── pubspec.yaml
```

---

## Flutter App Setup

```bash
# Create a new Flutter app
flutter create my_flutter_app
cd my_flutter_app

# Verify everything works
flutter pub get
flutter test
flutter build apk --debug
```

---

## Android Setup

### Step 1 — Initialize Fastlane

```bash
cd android
fastlane init
# Press Enter for all prompts (or type dummy values for practice)
```

---

### `android/fastlane/Appfile`

```ruby
# For practice — leave json_key_file empty
json_key_file("")
package_name("com.example.myflutterapp")

# For real deployment, use:
# json_key_file("fastlane/google-play-key.json")
# package_name("com.yourcompany.yourapp")
```

---

### `android/fastlane/Fastfile`

```ruby
# android/fastlane/Fastfile

# ─── Flutter Discovery Helper ────────────────────────────────────────────────
# Finds Flutter SDK: checks FVM first, then PATH, then common install locations
def find_flutter
  # 1. Check if FVM is available
  fvm_path = `which fvm`.strip
  return "fvm flutter" unless fvm_path.empty?

  # 2. Check for Flutter in PATH
  flutter_path = `which flutter`.strip
  return flutter_path unless flutter_path.empty?

  # 3. Check common installation locations
  common_paths = [
    ENV['FLUTTER_HOME'],
    '/usr/local/flutter/bin/flutter',
    '/opt/homebrew/bin/flutter',
    "/Users/#{ENV['HOME']}/development/flutter/bin/flutter",
    "/Users/#{ENV['HOME']}/fvm/default/bin/flutter"
  ].compact

  common_paths.each do |path|
    resolved = path.gsub('$HOME', ENV['HOME'] || '~')
    return resolved if File.exist?(resolved)
  end

  nil
end

# Add common Flutter install paths to PATH for all lanes
ENV['PATH'] = "/usr/local/bin:/opt/homebrew/bin:/usr/local/flutter/bin:#{ENV['PATH']}"

default_platform(:android)

platform :android do

  # ─── Test ────────────────────────────────────────────────────────────────
  desc "Run Flutter unit tests"
  lane :test do
    flutter_cmd = find_flutter
    if flutter_cmd.nil?
      puts "⚠️  Flutter not found. Please install Flutter or FVM"
      puts "   FVM: https://fvm.app"
      raise "Flutter not found"
    end

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} test")
    end
  end

  # ─── Build Debug APK ─────────────────────────────────────────────────────
  desc "Build a debug APK"
  lane :build_debug do
    flutter_cmd = find_flutter
    raise "Flutter not found" if flutter_cmd.nil?

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} build apk --debug")
    end
    puts "✅ Debug APK → build/app/outputs/flutter-apk/app-debug.apk"
  end

  # ─── Build Release APK ───────────────────────────────────────────────────
  desc "Build a release APK"
  lane :build_release do
    flutter_cmd = find_flutter
    raise "Flutter not found" if flutter_cmd.nil?

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} build apk --release")
    end
    puts "✅ Release APK built!"
  end

  # ─── Build Release AAB (for Play Store) ──────────────────────────────────
  desc "Build a release App Bundle (.aab)"
  lane :build_aab do
    flutter_cmd = find_flutter
    raise "Flutter not found" if flutter_cmd.nil?

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} build appbundle --release")
    end
    puts "✅ AAB built → build/app/outputs/bundle/release/app-release.aab"
  end

  # ─── CI Pipeline ─────────────────────────────────────────────────────────
  desc "Full CI: run tests + build debug APK"
  lane :ci do
    test
    build_debug
  end

  # ─── Simulated Deploy (Practice) ─────────────────────────────────────────
  desc "Simulate deploy to Play Store (no real upload)"
  lane :deploy do
    build_release
    puts "🚀 [SIMULATED] Would upload to Play Store here"
    puts "   In real setup: use the deploy_internal or deploy_production lane"
  end

  # ─── Real Deploy: Internal Track ─────────────────────────────────────────
  # Uncomment and use when you have real credentials
  # desc "Build AAB and upload to Play Store internal track"
  # lane :deploy_internal do
  #   build_aab
  #   upload_to_play_store(
  #     track: 'internal',
  #     aab: '../../build/app/outputs/bundle/release/app-release.aab',
  #     skip_upload_apk: true,
  #     release_status: 'draft'
  #   )
  #   puts "✅ Uploaded to Play Store Internal Track"
  # end

  # ─── Real Deploy: Production ─────────────────────────────────────────────
  # desc "Build AAB and upload to Play Store production"
  # lane :deploy_production do
  #   build_aab
  #   upload_to_play_store(
  #     track: 'production',
  #     aab: '../../build/app/outputs/bundle/release/app-release.aab',
  #     skip_upload_apk: true
  #   )
  # end

end
```

---

### `android/Gemfile`

```ruby
source "https://rubygems.org"

gem "fastlane"
```

```bash
# Install dependencies
cd android
bundle install

# Run lanes via Bundler (recommended)
bundle exec fastlane test
bundle exec fastlane ci
```

---

## iOS Setup

> ⚠️ iOS builds require **macOS + Xcode**. On Windows/Linux the build lane will fail — that's expected.

### Step 1 — Initialize Fastlane

```bash
cd ios
fastlane init
# Choose option 4 (Manual setup) when prompted
```

---

### `ios/fastlane/Appfile`

```ruby
# For practice — dummy values are fine
app_identifier("com.example.myflutterapp")
apple_id("dummy@example.com")
team_id("XXXXXXXXXX")

# For real deployment, use actual credentials:
# app_identifier("com.yourcompany.yourapp")
# apple_id("your@apple.id")
# team_id("YOUR_TEAM_ID")          # Found in Apple Developer portal
# itc_team_id("YOUR_ITC_TEAM_ID") # App Store Connect team ID (if different)
```

---

### `ios/fastlane/Fastfile`

```ruby
# ios/fastlane/Fastfile

# ─── Flutter Discovery Helper ────────────────────────────────────────────────
# Finds Flutter SDK: checks FVM first, then PATH, then common install locations
def find_flutter
  # 1. Check if FVM is available
  fvm_path = `which fvm`.strip
  return "fvm flutter" unless fvm_path.empty?

  # 2. Check for Flutter in PATH
  flutter_path = `which flutter`.strip
  return flutter_path unless flutter_path.empty?

  # 3. Check common installation locations
  common_paths = [
    ENV['FLUTTER_HOME'],
    '/usr/local/flutter/bin/flutter',
    '/opt/homebrew/bin/flutter',
    "/Users/#{ENV['HOME']}/development/flutter/bin/flutter",
    "/Users/#{ENV['HOME']}/fvm/default/bin/flutter"
  ].compact

  common_paths.each do |path|
    resolved = path.gsub('$HOME', ENV['HOME'] || '~')
    return resolved if File.exist?(resolved)
  end

  nil
end

# Add common Flutter install paths to PATH for all lanes
ENV['PATH'] = "/usr/local/bin:/opt/homebrew/bin:/usr/local/flutter/bin:#{ENV['PATH']}"

default_platform(:ios)

platform :ios do

  # ─── Test ────────────────────────────────────────────────────────────────
  desc "Run Flutter unit tests"
  lane :test do
    flutter_cmd = find_flutter
    if flutter_cmd.nil?
      puts "⚠️  Flutter not found. Please install Flutter or FVM"
      puts "   FVM: https://fvm.app"
      raise "Flutter not found"
    end

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} test")
    end
  end

  # ─── Build iOS (no code signing — practice) ──────────────────────────────
  desc "Build iOS without code signing (practice / CI)"
  lane :build do
    flutter_cmd = find_flutter
    if flutter_cmd.nil?
      puts "⚠️  Flutter not found. Please install Flutter or FVM"
      puts "   FVM: https://fvm.app"
      raise "Flutter not found"
    end

    puts "🔍 Using Flutter: #{flutter_cmd}"

    Dir.chdir("../../") do
      sh("#{flutter_cmd} build ios --release --no-codesign")
    end
    puts "✅ iOS build complete (no code signing)"
  end

  # ─── Build IPA (with signing — real deployment) ───────────────────────────
  desc "Build a signed IPA for distribution"
  lane :build_ipa do
    flutter_cmd = find_flutter
    raise "Flutter not found" if flutter_cmd.nil?

    puts "🔍 Using Flutter: #{flutter_cmd}"

    # Build the Flutter iOS app first
    Dir.chdir("../../") do
      sh("#{flutter_cmd} build ios --release")
    end

    # Then use gym (aka build_app) to create the IPA
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      configuration: "Release",
      output_directory: "./build",
      output_name: "Runner.ipa",
      export_method: "app-store"  # or "ad-hoc" for internal testing
    )
    puts "✅ IPA built → ios/build/Runner.ipa"
  end

  # ─── CI Pipeline ─────────────────────────────────────────────────────────
  desc "Full CI: run tests + build (no signing)"
  lane :ci do
    test
    build
  end

  # ─── Simulated Deploy (Practice) ─────────────────────────────────────────
  desc "Simulate deploy to App Store (no real upload)"
  lane :deploy do
    build
    puts "🚀 [SIMULATED] Would upload to TestFlight/App Store here"
    puts "   In real setup: use the deploy_testflight or deploy_appstore lane"
  end

  # ─── Real Deploy: TestFlight ──────────────────────────────────────────────
  # Uncomment and use when you have real credentials + Match set up
  # desc "Build IPA and upload to TestFlight"
  # lane :deploy_testflight do
  #   sync_code_signing(type: "appstore")   # Fastlane Match
  #   build_ipa
  #   upload_to_testflight(
  #     ipa: "./build/Runner.ipa",
  #     skip_waiting_for_build_processing: true
  #   )
  #   puts "✅ Uploaded to TestFlight"
  # end

  # ─── Real Deploy: App Store ───────────────────────────────────────────────
  # desc "Build IPA and submit to App Store review"
  # lane :deploy_appstore do
  #   sync_code_signing(type: "appstore")
  #   build_ipa
  #   upload_to_app_store(
  #     ipa: "./build/Runner.ipa",
  #     force: true,                          # Skip HTML preview
  #     skip_screenshots: true,
  #     skip_metadata: true,
  #     submit_for_review: false              # Set true to auto-submit
  #   )
  # end

end
```

---

### `ios/Gemfile`

```ruby
source "https://rubygems.org"

gem "fastlane"
```

```bash
cd ios
bundle install
bundle exec fastlane test
bundle exec fastlane ci
```

---

## GitHub Actions CI/CD

### `.github/workflows/android_ci.yml`

```yaml
name: Android CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  android-build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: android

      - name: Flutter dependencies
        run: flutter pub get

      - name: Run Fastlane CI
        working-directory: android
        run: bundle exec fastlane ci

      - name: Upload APK artifact
        uses: actions/upload-artifact@v4
        with:
          name: debug-apk
          path: build/app/outputs/flutter-apk/app-debug.apk
          retention-days: 7
```

---

### `.github/workflows/ios_ci.yml`

```yaml
name: iOS CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  ios-build:
    runs-on: macos-latest   # ← Must be macOS for iOS builds

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
          bundler-cache: true
          working-directory: ios

      - name: Flutter dependencies
        run: flutter pub get

      - name: Run Fastlane CI
        working-directory: ios
        run: bundle exec fastlane ci
```

---

## Running Lanes Locally

```bash
# ── Android (from android/ folder) ──────────────────────────
cd android

bundle exec fastlane test          # Run Flutter tests
bundle exec fastlane build_debug   # Build debug APK
bundle exec fastlane build_release # Build release APK
bundle exec fastlane build_aab     # Build release AAB
bundle exec fastlane ci            # Test + build (full pipeline)
bundle exec fastlane deploy        # Simulated deploy
bundle exec fastlane lanes         # List all available lanes

# ── iOS (from ios/ folder — Mac only) ────────────────────────
cd ios

bundle exec fastlane test          # Run Flutter tests
bundle exec fastlane build         # Build iOS (no signing)
bundle exec fastlane ci            # Test + build
bundle exec fastlane deploy        # Simulated deploy
```

---

## Real Deployment

> Follow these steps when you have actual store credentials.

---

### Android → Google Play Store

#### Step 1 — Create a Google Play API Service Account

1. Go to [Google Play Console](https://play.google.com/console) → Setup → API access
2. Link to a Google Cloud project
3. Create a **Service Account** with role: `Release Manager`
4. Download the **JSON key file** → save as `android/fastlane/google-play-key.json`

#### Step 2 — Create a Keystore for Signing

```bash
keytool -genkey -v \
  -keystore android/app/release.keystore \
  -alias my-key-alias \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

#### Step 3 — Configure `android/key.properties`

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=my-key-alias
storeFile=release.keystore
```

#### Step 4 — Update `android/app/build.gradle`

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

#### Step 5 — Update `Appfile` and uncomment deploy lanes

```ruby
# android/fastlane/Appfile
json_key_file("fastlane/google-play-key.json")
package_name("com.yourcompany.yourapp")
```

Then uncomment `deploy_internal` / `deploy_production` lanes in your Fastfile.

```bash
bundle exec fastlane deploy_internal    # Upload to internal testing
bundle exec fastlane deploy_production  # Upload to production
```

---

### iOS → App Store / TestFlight

#### Step 1 — Apple Developer Account

- Enroll at [developer.apple.com](https://developer.apple.com) ($99/year)
- Create an **App ID** in the portal matching your bundle identifier

#### Step 2 — App Store Connect API Key (recommended over password)

1. Go to [App Store Connect](https://appstoreconnect.apple.com) → Users & Access → Keys
2. Generate an API key → download the `.p8` file
3. Note the **Key ID** and **Issuer ID**

Set these as environment variables or in CI secrets:

```bash
export APP_STORE_CONNECT_API_KEY_ID="XXXXXXXXXX"
export APP_STORE_CONNECT_ISSUER_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
export APP_STORE_CONNECT_API_KEY_PATH="/path/to/AuthKey_XXXXXXXXXX.p8"
```

#### Step 3 — Setup Fastlane Match (Certificate Management)

Fastlane Match stores your certificates and provisioning profiles in a private Git repo, making them shareable across machines and CI.

```bash
# Create a private Git repo (e.g., on GitHub) for storing certs
# Then from ios/ folder:
bundle exec fastlane match init
# Enter your private Git repo URL when prompted
```

```bash
# Generate and store certificates
bundle exec fastlane match appstore    # For App Store distribution
bundle exec fastlane match development # For local development
```

This creates and stores:
- Distribution certificate (`.cer` + `.p12`)
- App Store provisioning profile (`.mobileprovision`)

#### Step 4 — Update `Appfile`

```ruby
# ios/fastlane/Appfile
app_identifier("com.yourcompany.yourapp")
apple_id("your@apple.id")
team_id("YOUR_TEAM_ID")
itc_team_id("YOUR_ITC_TEAM_ID")
```

#### Step 5 — Uncomment deploy lanes in Fastfile

```bash
bundle exec fastlane deploy_testflight  # Upload to TestFlight
bundle exec fastlane deploy_appstore    # Submit to App Store
```

---

### Fastlane Match — `ios/fastlane/Matchfile`

```ruby
# ios/fastlane/Matchfile

git_url("https://github.com/yourorg/certs-repo.git")  # Private repo
storage_mode("git")

type("appstore")    # Default match type

app_identifier(["com.yourcompany.yourapp"])
username("your@apple.id")

# For CI — use readonly mode to avoid modifying certificates
# readonly(true)
```

---

## Environment Variables & Secrets

### Local Development — `.env` file

Create `android/fastlane/.env` (never commit this):

```bash
GOOGLE_PLAY_JSON_KEY=fastlane/google-play-key.json
KEYSTORE_PASSWORD=your_password
KEY_PASSWORD=your_key_password
```

Add to `.gitignore`:

```
# Fastlane secrets
android/fastlane/.env
android/fastlane/google-play-key.json
android/app/release.keystore
android/key.properties
ios/fastlane/*.p8
ios/fastlane/*.p12
```

---

### GitHub Actions Secrets

Go to your repo → Settings → Secrets and variables → Actions → New repository secret

| Secret Name | Value |
|---|---|
| `GOOGLE_PLAY_JSON_KEY` | Contents of your Google Play JSON key |
| `KEYSTORE_BASE64` | Base64 encoded keystore file |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_PASSWORD` | Key password |
| `KEY_ALIAS` | Key alias |
| `MATCH_PASSWORD` | Fastlane Match encryption password |
| `APP_STORE_CONNECT_API_KEY` | Contents of your `.p8` file |
| `APP_STORE_CONNECT_KEY_ID` | API Key ID |
| `APP_STORE_CONNECT_ISSUER_ID` | API Issuer ID |

### Using Secrets in GitHub Actions (Android)

```yaml
- name: Setup signing
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 --decode > android/app/release.keystore
    echo "${{ secrets.GOOGLE_PLAY_JSON_KEY }}" > android/fastlane/google-play-key.json

- name: Run Fastlane deploy
  working-directory: android
  env:
    KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
    KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
    KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
  run: bundle exec fastlane deploy_internal
```

---

## Troubleshooting

| Problem | Cause | Fix |
|---|---|---|
| `Flutter not found` | Flutter not in PATH | Install FVM or set `FLUTTER_HOME` env var |
| `bundle: command not found` | Bundler not installed | Run `gem install bundler` |
| `Gradle build failed` | Java version mismatch | Use JDK 17; set `JAVA_HOME` |
| `iOS build: Xcode not found` | Running on Linux/Windows | iOS builds require macOS |
| `No provisioning profile` | Missing Match setup | Run `fastlane match appstore` |
| `Google Play upload failed` | Wrong JSON key or permissions | Ensure service account has Release Manager role |
| `Code signing error` | Certificate expired or mismatch | Run `fastlane match nuke` then `fastlane match appstore` to regenerate |
| `sh: flutter: not found` in CI | Flutter not installed in runner | Add `subosito/flutter-action` step before Fastlane |

---

## Quick Reference Cheatsheet

```bash
# ── Setup ─────────────────────────────────────────────
gem install fastlane bundler
cd android && fastlane init
cd ios && fastlane init

# ── Daily Use (Android) ───────────────────────────────
bundle exec fastlane test           # Run tests
bundle exec fastlane build_debug    # Debug APK
bundle exec fastlane build_release  # Release APK
bundle exec fastlane build_aab      # Release AAB (Play Store)
bundle exec fastlane ci             # Test + debug build
bundle exec fastlane deploy         # Simulated deploy

# ── Daily Use (iOS) ───────────────────────────────────
bundle exec fastlane test           # Run tests
bundle exec fastlane build          # Build (no signing)
bundle exec fastlane ci             # Test + build
bundle exec fastlane deploy         # Simulated deploy

# ── Real Deployment ───────────────────────────────────
bundle exec fastlane deploy_internal     # Android → Play Internal
bundle exec fastlane deploy_production   # Android → Play Production
bundle exec fastlane deploy_testflight   # iOS → TestFlight
bundle exec fastlane deploy_appstore     # iOS → App Store

# ── Match (iOS Certs) ─────────────────────────────────
bundle exec fastlane match appstore      # Sync App Store certs
bundle exec fastlane match development   # Sync Dev certs
bundle exec fastlane match nuke appstore # ⚠️ Delete & regenerate certs

# ── Utility ───────────────────────────────────────────
fastlane lanes                      # List all lanes
fastlane env                        # Show environment info
fastlane --help                     # Help
```

---

> 💡 **Tip:** Always use `bundle exec fastlane` instead of `fastlane` directly.
> This ensures the exact Fastlane version in your `Gemfile.lock` is used,
> keeping builds reproducible across machines and CI.