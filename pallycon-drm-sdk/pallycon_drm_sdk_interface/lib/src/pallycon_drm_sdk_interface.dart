import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'implementations/pallycon_drm_sdk_method_channel.dart';
import 'enums/pallycon_download_state.dart';
import 'models/models.dart';

abstract class PallyConDrmSdkPlatform extends PlatformInterface {
  /// Constructs a PallyConDrmSdkPlatform.
  PallyConDrmSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static PallyConDrmSdkPlatform _instance = MethodChannelPallyConDrmSdk();

  /// The default instance of [PallyConDrmSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelPallyConDrmSdk].
  static PallyConDrmSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PallyConDrmSdkPlatform] when
  /// they register themselves.
  static set instance(PallyConDrmSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // Delegate
  Stream<PallyConEvent> get onPallyConEvent {
    throw UnimplementedError('onPallyConEvent() has not been implemented.');
  }

  Stream<PallyConDownload> get onDownloadProgress {
    throw UnimplementedError('onDownloadProgress() has not been implemented.');
  }

  Future<void> initialize(String siteId) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  void release() {
    throw UnimplementedError('release() has not been implemented.');
  }

  Future<String> getObjectForContent(PallyConContentConfiguration config) {
    throw UnimplementedError('getObjectForContent() has not been implemented.');
  }

  Future<PallyConDownloadState> getDownloadState(PallyConContentConfiguration config) {
    throw UnimplementedError('getDownloadState() has not been implemented.');
  }

  Future<String> getLicenseInformation(PallyConContentConfiguration config) {
    throw UnimplementedError('getLicenseInformation() has not been implemented.');
  }

  // Download
  void addStartDownload(PallyConContentConfiguration config) {
    throw UnimplementedError('addStartDownload() has not been implemented.');
  }

  void resumeDownloads() {
    throw UnimplementedError('resumeDownloads() has not been implemented.');
  }

  void cancelDownloads() {
    throw UnimplementedError('cancelDownload() has not been implemented.');
  }

  void pauseDownloads() {
    throw UnimplementedError('pauseDownloads() has not been implemented.');
  }

  void removeDownload(PallyConContentConfiguration config) {
    throw UnimplementedError('removeDownload() has not been implemented.');
  }

  void removeLicense(PallyConContentConfiguration config) {
    throw UnimplementedError('removeLicense() has not been implemented.');
  }

  Future<bool> needsMigrateDatabase(PallyConContentConfiguration config) {
    throw UnimplementedError('needsMigrateDatabase() has not been implemented.');
  }

  Future<bool> migrateDatabase(PallyConContentConfiguration config) {
    throw UnimplementedError('migrateDatabase() has not been implemented.');
  }

  Future<bool> reDownloadCertification(PallyConContentConfiguration config) {
    throw UnimplementedError('reDownloadCertification() has not been implemented.');
  }

  Future<bool> updateSecureTime() {
    throw UnimplementedError('updateSecureTime() has not been implemented.');
  }
}
