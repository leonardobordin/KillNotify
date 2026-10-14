plugins {
    id("com.android.application")
}

android {
    namespace = "dev.killnotify.probe"
    compileSdk = 36

    defaultConfig {
        applicationId = "dev.killnotify.probe"
        minSdk = 26
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }
}
