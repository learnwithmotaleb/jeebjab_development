# Google Maps API Key Setup

This document explains how the Google Maps API keys are securely loaded into the app without exposing them to source control (Git).

> [!IMPORTANT]
> The API keys are restricted to the bundle ID `com.titanumtech.jeebjab`. They will only work for the Maps SDK. If you need to use Places, Geocoding, or Directions, the key restrictions must be updated in the Google Cloud Console.

> [!WARNING]
> **Release Builds**: The current Android API key is pinned to the debug SHA-1. Before releasing to the Play Store, you MUST provide the Release SHA-1 and Play App Signing SHA-1 to the backend team to add to the Maps API key restrictions. Otherwise, maps will break in production.

## 🤖 Android Setup

We use `local.properties` (which is git-ignored) to store the API key, and inject it into the `AndroidManifest.xml` during the build process.

### 1. Configure local.properties
Add the following line to `android/local.properties`:
```properties
MAPS_API_KEY=AIzaSyBCYhLFH245ocR2fJj6GnSzSMfC9X90mv0
```

### 2. build.gradle.kts Injection
In `android/app/build.gradle.kts`, the key is read from `local.properties` and added to `manifestPlaceholders`:
```kotlin
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}
val mapsApiKey = localProperties.getProperty("MAPS_API_KEY") ?: ""

// ...
defaultConfig {
    manifestPlaceholders["mapsApiKey"] = mapsApiKey
}
```

### 3. AndroidManifest.xml
The placeholder is used in `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="${mapsApiKey}" />
```

## 🍎 iOS Setup

For iOS, we use an untracked `.xcconfig` file to inject the key into `Info.plist`.

### 1. Configure Config.xcconfig
Create a file at `ios/Flutter/Config.xcconfig` (this file is git-ignored) and add:
```text
MAPS_API_KEY=AIzaSyDdOxy5iL214K1sAqn7CoJ8jUXD6T_W6To
```

### 2. Include in Build Configurations
In both `ios/Flutter/Debug.xcconfig` and `ios/Flutter/Release.xcconfig`, we include our secret config:
```text
#include? "Config.xcconfig"
```

### 3. Info.plist
In `ios/Runner/Info.plist`, we read the variable into a key:
```xml
<key>GoogleMapsApiKey</key>
<string>$(MAPS_API_KEY)</string>
```

### 4. AppDelegate.swift
Finally, we load the key from the bundle in `ios/Runner/AppDelegate.swift`:
```swift
let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String ?? ""
GMSServices.provideAPIKey(mapsApiKey)
```
