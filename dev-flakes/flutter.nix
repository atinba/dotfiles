{
  description = "Flutter";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };

      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = ["35.0.0" "34.0.0" "33.0.1" "30.0.3"];
        platformVersions = ["35" "34" "33" "32" "31"];
        abiVersions = ["arm64-v8a" "x86_64"];
        includeNDK = true;
        ndkVersions = ["25.1.8937393" "26.1.10909125"];
        cmakeVersions = ["3.22.1"];
        includeSystemImages = true;
        systemImageTypes = ["google_apis"]; # "google_apis_playstore"];
        includeEmulator = true;
        useGoogleAPIs = true;
        extraLicenses = [
          "android-googletv-license"
          "android-sdk-arm-dbt-license"
          "android-sdk-license"
          "android-sdk-preview-license"
          "google-gdk-license"
          "intel-android-extra-license"
          "intel-android-sysimage-license"
          "mips-android-sysimage-license"
        ];
      };

      androidSdk = androidComposition.androidsdk;
    in {
      devShell = with pkgs;
        mkShell rec {
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          JAVA_HOME = jdk17.home;
          FLUTTER_ROOT = flutter;
          DART_ROOT = "${flutter}/bin/cache/dart-sdk";
          GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/34.0.0/aapt2";
          QT_QPA_PLATFORM = "wayland;xcb";
          ANDROID_AVD_HOME = "/home/ab/.config/.android/avd";

          buildInputs = [
            flutter
            androidSdk
            android-studio
            qemu_kvm
            gradle
            jdk17

            # https://github.com/NixOS/nixpkgs/issues/341147
            gtk3
            pkg-config
          ];

          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [vulkan-loader libGL]}";
          # Globally installed packages, which are installed through `dart pub global activate package_name`,
          # are located in the `$PUB_CACHE/bin` directory.
          shellHook = ''
            export __NV_PRIME_RENDER_OFFLOAD=1
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
            export QT_QPA_PLATFORM="wayland;xcb"
            if [ -z "$PUB_CACHE" ]; then
              export PATH="$PATH:$HOME/.pub-cache/bin"
            else
              export PATH="$PATH:$PUB_CACHE/bin"
            fi
          '';
        };
    });
}
