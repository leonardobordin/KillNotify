plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.killnotify.killnotify"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.killnotify.killnotify"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    val signingPropertyNames = listOf(
        "killnotifyReleaseKeystore",
        "killnotifyReleaseStorePassword",
        "killnotifyReleaseKeyAlias",
        "killnotifyReleaseKeyPassword",
    )
    val hasReleaseSigning = signingPropertyNames.all { providers.gradleProperty(it).isPresent }

    signingConfigs {
        if (hasReleaseSigning) {
            create("killnotifyRelease") {
                storeFile = file(providers.gradleProperty("killnotifyReleaseKeystore").get())
                storePassword = providers.gradleProperty("killnotifyReleaseStorePassword").get()
                keyAlias = providers.gradleProperty("killnotifyReleaseKeyAlias").get()
                keyPassword = providers.gradleProperty("killnotifyReleaseKeyPassword").get()
            }
        }
    }

    buildTypes {
        release {
            // The fallback is only for local build verification; never upload it.
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("killnotifyRelease")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

dependencies {
    testImplementation("junit:junit:4.13.2")
}
