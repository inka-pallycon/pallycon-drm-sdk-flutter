import 'package:flutter_test/flutter_test.dart';
import 'package:pallycon_drm_sdk/pallycon_drm_sdk.dart';
import 'package:pallycon_drm_sdk_interface/pallycon_drm_sdk_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPallyConDrmSdkPlatform
    with MockPlatformInterfaceMixin
    implements PallyConDrmSdkPlatform {

  @override
  void addStartDownload(PallyConContentConfiguration config) {
    // TODO: implement addStartDownload
  }

  @override
  void cancleDownload(PallyConContentConfiguration config) {
    // TODO: implement cancleDownload
  }

  @override
  Future<String> getObjectForContent(PallyConContentConfiguration config) {
    // TODO: implement getObjectForContent
    throw UnimplementedError();
  }

  @override
  Future<void> initialize(String siteId) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<bool> isDownloadContent(PallyConContentConfiguration config) {
    // TODO: implement isDownloadContent
    throw UnimplementedError();
  }

  @override
  // TODO: implement onDownloadChanged
  Stream<PallyConDownload> get onDownloadChanged => throw UnimplementedError();

  @override
  // TODO: implement onDrmMessage
  Stream<String> get onDrmMessage => throw UnimplementedError();

  @override
  void pauseDownloads() {
    // TODO: implement pauseDownloads
  }

  @override
  void removeAllDownloads() {
    // TODO: implement removeAllDownloads
  }

  @override
  void removeDownload(PallyConContentConfiguration config) {
    // TODO: implement removeDownload
  }

  @override
  void resumeDownloads() {
    // TODO: implement resumeDownloads
  }

  @override
  void cancelDownloads() {
    // TODO: implement cancelDownloads
  }

  @override
  Future<PallyConDownloadState> getDownloadState(PallyConContentConfiguration config) {
    // TODO: implement getDownloadState
    throw UnimplementedError();
  }

  @override
  Future<String> getLicenseInformation(PallyConContentConfiguration config) {
    // TODO: implement getLicenseInformation
    throw UnimplementedError();
  }

  @override
  // TODO: implement onDownloadProgress
  Stream<PallyConDownload> get onDownloadProgress => throw UnimplementedError();

  @override
  // TODO: implement onPallyConEvent
  Stream<PallyConEvent> get onPallyConEvent => throw UnimplementedError();

  @override
  void release() {
    // TODO: implement release
  }

  @override
  void removeLicense(PallyConContentConfiguration config) {
    // TODO: implement removeLicense
  }

  @override
  void cancelDownloadTask(PallyConContentConfiguration config) {
    // TODO: implement cancelDownloadTask
  }

  @override
  void resumeDownloadTask(PallyConContentConfiguration config) {
    // TODO: implement resumeDownloadTask
  }

  @override
  Future<bool> migrateDatabase(PallyConContentConfiguration config) {
    // TODO: implement migrateDatabase
    throw UnimplementedError();
  }

  @override
  Future<bool> needsMigrateDatabase(PallyConContentConfiguration config) {
    // TODO: implement needsMigrateDatabase
    throw UnimplementedError();
  }

  @override
  Future<bool> reDownloadCertification(PallyConContentConfiguration config) {
    // TODO: implement reDownloadCertification
    throw UnimplementedError();
  }

  @override
  Future<bool> updateSecureTime() {
    // TODO: implement updateSecureTime
    throw UnimplementedError();
  }
}

void main() {
  final PallyConDrmSdkPlatform initialPlatform = PallyConDrmSdkPlatform.instance;

  test('getPlatformVersion', () async {
  });
}
