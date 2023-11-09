import 'package:flutter/services.dart';

import 'package:pallycon_drm_sdk_interface/pallycon_drm_sdk_interface.dart';

class PallyConDrmSdkAndroid extends PallyConDrmSdkPlatform {
  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('com.pallycon.drmsdk/android');

  static const _pallyConEventChannel =
      EventChannel('com.pallycon.drmsdk/pallycon_event');

  static const _downloadProgressChannel =
      EventChannel('com.pallycon.drmsdk/download_progress');

  static void registerWith() {
    PallyConDrmSdkPlatform.instance =
        PallyConDrmSdkAndroid._privateConstructor();
  }

  PallyConDrmSdkAndroid._privateConstructor();

  static final PallyConDrmSdkAndroid shared =
      PallyConDrmSdkAndroid._privateConstructor();

  Stream<PallyConEvent>? _pallyConEventStream;
  Stream<PallyConDownload>? _downloadProgressStream;

  @override
  Future<void> initialize(String siteId) async {
    try {
      await _methodChannel.invokeMethod('initialize', {'siteId': siteId});
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void release() {
    try {
      _methodChannel.invokeMethod('release');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<String> getObjectForContent(
      PallyConContentConfiguration config) async {
    try {
      return await _methodChannel
          .invokeMethod('getObjectForContent', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<PallyConDownloadState> getDownloadState(
      PallyConContentConfiguration config) async {
    try {
      final String state = await _methodChannel
          .invokeMethod('getDownloadState', _configToDynamicList(config));

      var pallyConDownloadState = PallyConDownloadState.NOT;
      switch (state) {
        case "DOWNLOADING":
          {
            pallyConDownloadState = PallyConDownloadState.DOWNLOADING;
          }
          break;
        case "COMPLETED":
          {
            pallyConDownloadState = PallyConDownloadState.COMPLETED;
          }
          break;
        case "PAUSED":
          {
            pallyConDownloadState = PallyConDownloadState.PAUSED;
          }
          break;
        default:
          {
            pallyConDownloadState = PallyConDownloadState.NOT;
          }
          break;
      }

      return pallyConDownloadState;
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  // Delegate
  @override
  Stream<PallyConEvent> get onPallyConEvent {
    if (_pallyConEventStream != null) {
      return _pallyConEventStream!;
    }
    var pallyConEventStream = _pallyConEventChannel.receiveBroadcastStream();

    _pallyConEventStream = pallyConEventStream
        .where((pallyConEvent) => pallyConEvent != null)
        .map((dynamic element) =>
            PallyConEvent.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _pallyConEventStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _pallyConEventStream!;
  }

  @override
  Stream<PallyConDownload> get onDownloadProgress {
    if (_downloadProgressStream != null) {
      return _downloadProgressStream!;
    }

    var downloadProgressStream =
        _downloadProgressChannel.receiveBroadcastStream();

    _downloadProgressStream = downloadProgressStream
        .where((pallyConDownload) => pallyConDownload != null)
        .map((dynamic element) =>
            PallyConDownload.fromMap(element.cast<String, dynamic>()))
        .handleError((error) {
      _downloadProgressStream = null;
      if (error is PlatformException) {
        error = _handlePlatformException(error);
      }
      throw error;
    });

    return _downloadProgressStream!;
  }

  // Download
  @override
  void addStartDownload(PallyConContentConfiguration config) {
    try {
      _methodChannel.invokeMethod(
          'addStartDownload', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void resumeDownloads() {
    try {
      _methodChannel.invokeMethod('resumeDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void cancelDownloads() {
    try {
      _methodChannel.invokeMethod('cancelDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void pauseDownloads() {
    try {
      _methodChannel.invokeMethod('pauseDownloads');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void removeDownload(PallyConContentConfiguration config) {
    try {
      _methodChannel.invokeMethod(
          'removeDownload', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  void removeLicense(PallyConContentConfiguration config) {
    try {
      _methodChannel.invokeMethod(
          'removeLicense', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> needsMigrateDatabase(PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'needsMigrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> migrateDatabase(PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'migrateDatabase', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> reDownloadCertification(
      PallyConContentConfiguration config) async {
    try {
      return await _methodChannel.invokeMethod(
          'reDownloadCertification', _configToDynamicList(config));
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  @override
  Future<bool> updateSecureTime() async {
    try {
      return await _methodChannel.invokeMethod('updateSecureTime');
    } on PlatformException catch (e) {
      final error = _handlePlatformException(e);
      throw error;
    }
  }

  dynamic _configToDynamicList(
      PallyConContentConfiguration config) {
    return {
      'url': config.contentUrl,
      'contentId': config.contentId,
      'drmType': config.drmType,
      'token': config.token,
      'customData': config.customData,
      'contentCookie': config.contentCookie,
      'contentHttpHeaders': config.contentHttpHeaders,
      'licenseCookie': config.licenseCookie,
      'licenseHttpHeaders': config.licenseHttpHeaders,
      'licenseUrl': config.licenseUrl,
      'certificateUrl': config.certificateUrl,
      'licenseCipherTablePath': config.licenseCipherTablePath
    };
  }

  Exception _handlePlatformException(PlatformException exception) {
    switch (exception.code) {
      case 'PERMISSIONS_REQUIRED':
        return PermissionRequiredException(exception.message);
      case 'ILLEGAL_ARGUMENT':
        return IllegalArgumentException(exception.message);
      case 'UNINITIALIZED':
        return UninitializedException(exception.message);
      default:
        return exception;
    }
  }
}
