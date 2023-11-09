import 'package:pallycon_drm_sdk_interface/pallycon_drm_sdk_interface.dart';

import 'package:pallycon_drm_sdk_android/pallycon_drm_sdk_android.dart';
import 'package:pallycon_drm_sdk_ios/pallycon_drm_sdk_ios.dart';

export 'package:pallycon_drm_sdk_android/pallycon_drm_sdk_android.dart';
export 'package:pallycon_drm_sdk_ios/pallycon_drm_sdk_ios.dart';
export 'package:pallycon_drm_sdk_interface/pallycon_drm_sdk_interface.dart';

/// PallyCon SDK for using Multi-DRM.
class PallyConDrmSdk {
  /// Notifications of events occurring in the SDK.
  static Stream<PallyConEvent> get onPallyConEvent =>
      PallyConDrmSdkPlatform.instance.onPallyConEvent;

  /// Notification that informs the percentage of content currently being downloaded.
  static Stream<PallyConDownload> get onDownloadProgress =>
      PallyConDrmSdkPlatform.instance.onDownloadProgress;

  /// Initialize the [PallyConDrmSdk]
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<void> initialize(String siteId) async {
    PallyConDrmSdkPlatform.instance.initialize(siteId);
  }

  /// Release the [PallyConDrmSdk]
  /// The [PallyConDrmSdk] must not be used after calling this method.
  static void release() {
    PallyConDrmSdkPlatform.instance.release();
  }

  /// function that creates the objects needed to play the player.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  /// Throws a [PermissionRequiredException] when there is no permission in the android project
  static Future<String> getObjectForContent(PallyConContentConfiguration config) async {
    return PallyConDrmSdkPlatform.instance.getObjectForContent(config);
  }

  /// Get a [PallyConDownloadState]
  ///
  /// A [PallyConDownloadState] is state of download for content
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<PallyConDownloadState> getDownloadState(PallyConContentConfiguration config) =>
      PallyConDrmSdkPlatform.instance.getDownloadState(config);

  /// Starts the service if not started already and adds a new download.
  /// If an error occurs during DRM download, [PallyConEventType.downloadError] called.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void addStartDownload(PallyConContentConfiguration config) {
    PallyConDrmSdkPlatform.instance.addStartDownload(config);
  }

  /// Starts the service if not started already and resumes all downloads.
  static void resumeDownloads() {
    PallyConDrmSdkPlatform.instance.resumeDownloads();
  }

  /// Starts the service in not started already and cancels all downloads.
  static void cancelDownloads() {
    PallyConDrmSdkPlatform.instance.cancelDownloads();
  }

  /// Starts the service in not started already and pauses all downloads.
  static void pauseDownloads() {
    PallyConDrmSdkPlatform.instance.pauseDownloads();
  }

  /// Remove the content already downloaded.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void removeDownload(PallyConContentConfiguration config) {
    PallyConDrmSdkPlatform.instance.removeDownload(config);
  }

  /// Remove offline licenses already downloaded.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static void removeLicense(PallyConContentConfiguration config) {
    PallyConDrmSdkPlatform.instance.removeLicense(config);
  }

  /// As each patch progresses, you can check to see if you need to migrate.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> needsMigrateDatabase(PallyConContentConfiguration config) async {
    return PallyConDrmSdkPlatform.instance.needsMigrateDatabase(config);
  }

  /// Migrate past downloaded content
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> migrateDatabase(PallyConContentConfiguration config) async {
    return PallyConDrmSdkPlatform.instance.migrateDatabase(config);
  }

  /// for android
  /// Try when all Widevine DRM(Android) content suddenly fails to play on the device and there is an error like the one below.
  ///  Failed to restore keys: General DRM error (-2000)
  ///  This error can occur when there is a problem with provisioning and can be reset.
  ///  You must be connected to the network when using the function.
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> reDownloadCertification(PallyConContentConfiguration config) {
    return PallyConDrmSdkPlatform.instance.reDownloadCertification(config);
  }

  /// for android
  /// Called for playback when 'detectedDeviceTimeModifiedError' in android
  ///
  /// Throws a [IllegalArgumentException] when the input parameters are null or incorrect
  static Future<bool> updateSecureTime() {
    return PallyConDrmSdkPlatform.instance.updateSecureTime();
  }
}
