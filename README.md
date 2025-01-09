# Flutter OTA Update Project

This Flutter project demonstrates how to implement OTA (Over-the-Air) updates by downloading and installing APK files dynamically.

---

## Features
- Download APK files from a remote server.
- Show progress of APK downloads.
- Install APK files programmatically.

---

## Requirements
- **Flutter SDK**: Version 3.x or higher.
- **Android Studio**: For building and debugging Android apps.
- **Minimum SDK Version**: 21.
- **Compile SDK Version**: 34.

---

## Set-Up Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Anhltn1609/demo_apk.git
cd demo_apk
```

### 2. Install Dependencies
Run the following command to install the required dependencies:
```bash
flutter pub get
```

### 3. Configure Android Build
Update the `android/build.gradle` file as follows:

```gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.0.0' // Or version 7.3.0 and above
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.0" // Update Kotlin version if needed
    }
}

subprojects {
    afterEvaluate { project ->
        if (project.hasProperty('android')) {
            project.android {
                if (namespace == null) {
                    namespace project.group
                }

                compileOptions {
                    sourceCompatibility JavaVersion.VERSION_17
                    targetCompatibility JavaVersion.VERSION_17
                }
                tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile).configureEach {
                    kotlinOptions {
                        jvmTarget = "17"
                    }
                }
                java {
                    toolchain {
                        languageVersion = JavaLanguageVersion.of(17)
                    }
                }

            }
        }
    }
}

android {
    compileSdkVersion 34
    defaultConfig {
        minSdkVersion 21
    }
}
```

### 4. Update Permissions
In the `AndroidManifest.xml` file, add the following permissions:

```xml
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### 5. Run the Application
To start the application:
```bash
flutter run
```

---

## Troubleshooting

### Error: Namespace Issue
If the application does not build due to a namespace error (e.g., "install_plugins"), ensure you update the `android/build.gradle` file as mentioned in the **Set-Up Instructions** section.

### APK Installation Errors
- **PathExistsException**: Ensure the file path for downloading APKs is unique. Use external directories like:
  ```dart
  final savePath = '/storage/emulated/0/Download/app-latest.apk';
  ```

---

## Contributing
Feel free to open issues or submit pull requests to improve this project.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact
For any inquiries, reach out to the repository owner on [GitHub](https://github.com/Anhltn1609).
