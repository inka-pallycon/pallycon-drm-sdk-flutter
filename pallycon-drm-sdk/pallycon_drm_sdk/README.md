# **PallyCon DRM SDK** for Flutter Development Guide


[![pub package](https://img.shields.io/badge/puv-1.2.0-orange)](https://pub.dartlang.org/packages/)

A Flutter **`pallycon_drm_sdk`** plugin which provides easy to apply [PallyCon Multi-DRM SDK][1] (Android: Widevine, iOS: FairPlay) when developing media service apps for Android and iOS. 

This document describes the usage and API of **`pallycon_drm_sdk`**.
The example of **`pallycon_drm_sdk`** is available on [player-sample][2].


## **SDK usage**

This section describes the `pallycon_drm_sdk` API provided by flutter.

`PallyConDrmSdk` is the main class of pallycon_drm_sdk.
This class is a wrapper of PallyCon Multi-DRM SDK(Widevine, FairPlay).

> To add **`pallycon_drm_sdk`** to your Flutter app, read the [Flutter Documentation][3] instructions. 


### **Initialize**

- Initialization is performed through the `initialize` method of the `PallyConDrmSdk` class.
  > To develop using the SDK, you must first sign up for the [PallyCon Site][4] and obtain a **`Site ID`**.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  // Initialize the SDK
  PallyConDrmSdk.initialize(siteId);
  ```

### **PallyCon DRM SDK Event**

- **PallyConDrmSdk.onPallyConEvent**
  - Events occurring within the SDK can be received through `PallyConDrmSdk.onPallyConEvent`.
    ```dart
    // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
    // PallyConDrmSdk.onPallyConEvent
    PallyConDrmSdk.onPallyConEvent.listen((event) {
        // PallyConEventType
        var pallyconEventType = event.eventType;
        switch (pallyconEventType) {
          case PallyConEventType.prepare:
            break;
          ...
        }
    });
    ```

- **PallyConDrmSdk.PallyConEventType**
  - The event types occurring in PallyConDrmSdk are defined in `PallyConDrmSdk.PallyConEventType`.
    ```dart
    /// Event type of PallyCon SDK Event
    enum PallyConEventType {
      prepare,          /// Download preparation completed
      complete,         /// The download completed
      pause,            /// The download paused
      remove,           /// The download is removed
      stop,             /// The download is stop
      download,         /// The download is start
      contentDataError, /// Error when the content information to be downloaded is incorrect
      drmError,         /// License error
      licenseServerError, /// Server error when issuing license
      downloadError,      /// Error during download
      networkConnectedError, /// Error when there is no network connection
      detectedDeviceTimeModifiedError, /// Error that occurs when the time is forcibly manipulated on an Android device
      migrationError,     /// Error that occurs when migrating from SDK
      licenseCipherError, /// Error that occurs when a license cipher from SDK
      unknown             /// Unknown error type
    }
    ```

### **Content Download**

- When downloading, register a listener to know the size of the currently downloaded data.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  PallyConDrmSdk.onDownloadProgress.listen((event) {
      // event.url is url
      // event.percent is downloaded percent
  });
  ```

#### **Get content download status**

- Get the current download status of the content.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  PallyConDownloadState downloadState = await PallyConDrmSdk.getDownloadState(PallyConContentConfiguration);
      switch (downloadState) {
        case PallyConDownloadState.DOWNLOADING:
          break;
        case PallyConDownloadState.PAUSED:
          break;
        case PallyConDownloadState.COMPLETED:
          break;
        default:
          break;
      }
  ```

#### **Download API**

- Describes the API required for the content download process.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  // start download
  PallyConDrmSdk.addStartDownload(PallyConContentConfiguration);

  // cancel downloads
  PallyConDrmSdk.cancelDownloads();

  // pause downloads
  PallyConDrmSdk.pauseDownloads();

  // resume downloads
  PallyConDrmSdk.resumeDownloads();
  ```

### **Remove License or Contents**

- Remove the downloaded license and content.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  // remove downloaded content
  PallyConDrmSdk.removeDownload(PallyConContentConfiguration);

  // remove license for content
  PallyConDrmSdk.removeLicense(PallyConContentConfiguration);
  ```


### **Release**

- Called when you end using the SDK.

  ```dart
  // player-samples/advanced/lib/features/advanced/presentation/controllers/drm_movie_controller.dart
  PallyConDrmSdk.release();
  ```


[1]: https://pallycon.com/sdk/
[2]: ../../player-samples
[3]: https://docs.flutter.dev/
[4]: https://login.pallycon.com/