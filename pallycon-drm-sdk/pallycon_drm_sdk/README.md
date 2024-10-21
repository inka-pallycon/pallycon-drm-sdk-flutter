## **PallyCon DRM SDK** for Flutter Development Guide


[![pub package](https://img.shields.io/badge/puv-1.0.0-orange)](https://pub.dartlang.org/packages/)

A Flutter pallycon_drm_sdk plugin which provides easy to apply PallyConMulti-DRM SDK(Android: Widevine, iOS: FairPlay) when developing media service apps for Android and iOS. Please refer to the links below for detailed information. 

## **support environment**

- Android 6.0 (API 23)) & Android targetSdkVersion 34 or higher
- iOS 14.0 higher
- This SDK supports ExoPlayer version 2.18.1 on Android.

## **Important**

- To develop using the SDK, you must first sign up for the PallyCon Admin Site and obtain a Site ID.

## **SDK usage**

To add PallyConDrmSdk to your Flutter app, read the [Installation](https://pub.dev/packages/) instructions. Below are the Android and iOS properties required for PallyConDrmSdk to work properly.

<details>
<summary>Android</summary>

**compileSdkVersion**

Make sure you set `compileSdkVersion` in "android/app/build.gradle".

```
android {
  compileSdkVersion 31

  ...
}
```

**Permissions**

Inside the SDK, the following 4 items are used in relation to user permission.

``` xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
```

</details>

<details>
<summary>iOS</summary>

`PallyCon DRM SDK Flutter` uses `PallyConFPSSDK`. `PallyConFPSSDK` is supposed to be downloaded as `cocoapods`.


</details>

### **Initialize**

```dart
PallyConDrmSdk.initialize(siteId);
```

### **Set Event**

Register events that occur inside the SDK.

```dart
PallyConDrmSdk.onPallyConEvent.listen((event) {
    var downloadState = DownloadStatus.pending;
    switch (event.eventType) {
        case PallyConEventType.prepare:
          // 
          break;
        case PallyConEventType.complete:
          // Called when download is complete
          break;
        case PallyConEventType.pause:
          // Called when downloading is stopped during download
          break;
        case PallyConEventType.download:
          // Called when download starts
          break;
        case PallyConEventType.contentDataError:
          // Called when an error occurs in the parameters passed to the sdk
          break;
        case PallyConEventType.drmError:
          // Called when a license error occurs
          break;
        case PallyConEventType.licenseServerError:
          // Called when an error comes down from the license server
          break;
        case PallyConEventType.downloadError:
          // Called when an error occurs during download
          break;
        case PallyConEventType.networkConnectedError:
          // Called in case of network error
          break;
        case PallyConEventType.detectedDeviceTimeModifiedError:
          // Called when device time is forcibly manipulated
          break;
        case PallyConEventType.migrationError:
          // Called when sdk migration fails
          break;
        case PallyConEventType.unknown:
          // Internally called when an unknown error occurs
          break;
  }
  // content state
}).onError((error) {
  // 
});
```

When downloading, register a listener to know the size of the currently downloaded data.

```dart
PallyConDrmSdk.onDownloadProgress.listen((event) {
    // event.url is url
    // event.percent is downloaded percent
});
```

### **Get content download status**

Get the current download status of the content.

```dart
PallyConDownloadState downloadState =
        await PallyConDrmSdk.getDownloadState(PallyConContentConfiguration);
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

### **Download**

Describes the API required for the content download process.

```dart
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

Remove the downloaded license and content.

```dart
// remove downloaded content
PallyConDrmSdk.removeDownload(PallyConContentConfiguration);

// remove license for content
PallyConDrmSdk.removeLicense(PallyConContentConfiguration);
```


### **Release**

Called when you end using the SDK.

```dart
PallyConDrmSdk.release();
```


