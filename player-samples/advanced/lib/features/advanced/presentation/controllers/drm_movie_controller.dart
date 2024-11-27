import 'dart:convert';

import 'package:advanced/core/error/failures.dart';
import 'package:advanced/core/usecases/usecase.dart';
import 'package:advanced/features/advanced/domain/entities/download_status.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';
import 'package:advanced/features/advanced/domain/usecases/get_drm_content_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:path/path.dart' as p;
import 'package:pallycon_drm_sdk/pallycon_drm_sdk.dart';

class DrmMovieController extends SuperController<List<DrmMovie>> {
  DrmMovieController(this._getDrmContentUseCaseUseCase);

  final GetDrmContentUseCase _getDrmContentUseCaseUseCase;

  static const inkaLicenseUrl =
      "https://license-global.pallycon.com/ri/licenseManager.do";
  static const certUrl =
      "https://license-global.pallycon.com/ri/fpsKeyManager.do";
  static const siteId = "DEMO";

  // var movies = RxList<DrmMovie>([]);
  var pallyConContentConfigs = RxList<PallyConContentConfiguration>([]);
  var downloadPercent = <Tuple2<String, double>>[].obs;
  String checkExtension = ".mpd";

  final Rx<String?> errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    if (Platform.isIOS) {
      checkExtension = ".m3u8";
    }

    getMovies();
    sdkInit();
    super.onInit();
  }

  sdkInit() {
    try {
      PallyConDrmSdk.initialize(siteId);
    } on IllegalArgumentException catch (e) {
      print(e.message);
    } on PermissionRequiredException catch (e) {
      print(e.message);
    }

    setListener();
  }

  setListener() {
    PallyConDrmSdk.onPallyConEvent.listen((event) {
      var downloadState = DownloadStatus.pending;
      switch (event.eventType) {
        case PallyConEventType.prepare:
          break;
        case PallyConEventType.complete:
          downloadState = DownloadStatus.success;
          break;
        case PallyConEventType.pause:
          downloadState = DownloadStatus.pause;
          break;
        case PallyConEventType.remove:
          break;
        case PallyConEventType.stop:
          break;
        case PallyConEventType.download:
          downloadState = DownloadStatus.running;
          break;
        case PallyConEventType.contentDataError:
          break;
        case PallyConEventType.drmError:
        case PallyConEventType.licenseServerError:
        case PallyConEventType.downloadError:
        case PallyConEventType.networkConnectedError:
        case PallyConEventType.detectedDeviceTimeModifiedError:
        case PallyConEventType.migrationError:
          errorMessage.value = event.message;
          break;
        case PallyConEventType.licenseCipherError:
          break;
        case PallyConEventType.unknown:
          break;
      }
      if (state != null) {
        state![state!.indexWhere((p0) => p0.url == event.url)] =
            state![state!.indexWhere((p0) => p0.url == event.url)].copyWith(
          downloadStatus: downloadState,
        );
        update(null, true);
      }
    }).onError((error) {
      if (state != null) {
        change(null, status: RxStatus.error(error.toString()));
      }
    });

    PallyConDrmSdk.onDownloadProgress.listen((event) {
      if (state != null) {
        var index = state!.indexWhere((p0) => p0.url == event.url);
        if (index >= 0 &&
            state![index].downloadStatus != DownloadStatus.success) {
          state![index] = state![index].copyWith(
            downloadStatus: DownloadStatus.running,
          );
        }

        downloadPercent.removeWhere((element) => element.value1 == event.url);
        downloadPercent.add(Tuple2(event.url, event.percent));
        update(null, true);
      }
    });
  }

  getMovies() async {
    var failureOrDrmContent =
        await _getDrmContentUseCaseUseCase.call(NoParams());
    failureOrDrmContent.fold(
      (failure) {
        String msg = _mapFailureToMessage(failure);
        change(null, status: RxStatus.error(msg));
      },
      (drmContent) => setMovies(drmContent.contents),
    );
  }

  setMovies(List<DrmMovie> movieList) {
    final Set<String> uniqueContentIds = {};

    final filteredMovies = movieList.where((movie) {
      return p.extension(movie.url) == checkExtension &&
          uniqueContentIds.add(movie.contentId);
    }).toList();

    change(filteredMovies, status: RxStatus.success());

    if (state != null) {
      pallyConContentConfigs.clear();
      for (var i = 0; i < state!.length; i++) {
        var config = PallyConContentConfiguration(
          state![i].contentId,
          state![i].url,
          token: state![i].token,
          licenseUrl: state![i].licenseServerUrl ?? inkaLicenseUrl,
          licenseCipherTablePath: state![i].licenseCipherPath,
          certificateUrl: state![i].licenseCertUrl ?? certUrl,
        );
        pallyConContentConfigs.add(config);
        downloadStateCheck(i);
      }
    }
  }

  releaseSdks() {
    PallyConDrmSdk.release();
  }

  downloadContent(DrmMovie drmMovie) {
    final index = pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);

    if (index >= 0) {
      if (state![index].downloadStatus == DownloadStatus.pause) {
        PallyConDrmSdk.resumeDownloads();

        // if (Platform.isIOS) {
        //   PallyConDrmSdk.resumeDownloadTask(pallyConContentConfigs[index]);
        // }
      } else {
        try {
          PallyConDrmSdk.addStartDownload(pallyConContentConfigs[index]);
        } on IllegalArgumentException catch (e) {
          print(e.message);
        }
      }
    }

    // movies[movies.indexWhere((p0) => p0.url == drmMovie.url)].downloadStatus =
    //     DownloadStatus.running;
    //
    // downloadPercent.add(Tuple2(drmMovie.url, 0));
    // movies.refresh();
  }

  getDownloadPercent(DrmMovie drmMovie) {
    var index = downloadPercent.indexWhere((p0) => p0.value1 == drmMovie.url);
    if (index == -1) {
      state![state!.indexWhere((p0) => p0.url == drmMovie.url)] =
          state![state!.indexWhere((p0) => p0.url == drmMovie.url)]
              .copyWith(downloadStatus: DownloadStatus.pending);
      return 0;
    }

    return downloadPercent[index].value2;
  }

  pauseContent(DrmMovie drmMovie) {
    final index = pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);

    PallyConDrmSdk.stopDownload(pallyConContentConfigs[index]);
  }

  removeContent(DrmMovie drmMovie) {
    final index = pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);

    try {
      PallyConDrmSdk.removeDownload(pallyConContentConfigs[index]);
      downloadStateCheck(index);
    } on IllegalArgumentException catch (e) {
      print(e.message);
    }
  }

  removeLicense(DrmMovie drmMovie) {
    final index = pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);

    try {
      PallyConDrmSdk.removeLicense(pallyConContentConfigs[index]);
    } on IllegalArgumentException catch (e) {
      print(e.message);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server error";
      case CacheFailure:
        return "Cache error";
      case PlatformFailure:
        return "Platform error";
      default:
        return 'Unexpected error';
    }
  }

  downloadStateCheck(int index) async {
    if (state == null) {
      return;
    }

    try {
      var needsMigration = await PallyConDrmSdk.needsMigrateDatabase(
          pallyConContentConfigs[index]);
      if (needsMigration) {
        await PallyConDrmSdk.migrateDatabase(pallyConContentConfigs[index]);
      }

      PallyConDownloadState downloadState =
          await PallyConDrmSdk.getDownloadState(pallyConContentConfigs[index]);
      switch (downloadState) {
        case PallyConDownloadState.DOWNLOADING:
          state![index] =
              state![index].copyWith(downloadStatus: DownloadStatus.running);
          break;
        case PallyConDownloadState.PAUSED:
          state![index] =
              state![index].copyWith(downloadStatus: DownloadStatus.pause);
          break;
        case PallyConDownloadState.COMPLETED:
          state![index] =
              state![index].copyWith(downloadStatus: DownloadStatus.success);
          break;
        default:
          state![index] =
              state![index].copyWith(downloadStatus: DownloadStatus.pending);
          break;
      }
      update(null, true);
    } on IllegalArgumentException catch (e) {
      print(e.message);
    }
  }

  Future<String> getObjectForContent(int index) async {
    final config = pallyConContentConfigs[index];
    var contentData = await PallyConDrmSdk.getObjectForContent(config);

    if (contentData.isEmpty) {
      contentData = '{"drmConfig":{'
          '"drmLicenseUrl":"${config.licenseUrl}",'
          '"siteId":"$siteId",'
          '"contentId":"${config.contentId}",';

      if (config.token != null && config.token!.isNotEmpty) {
        contentData += '"token":"${config.token!}",';
      }

      if (config.customData != null && config.customData!.isNotEmpty) {
        contentData += '"customData":"${config.customData!}",';
      }

      if (config.contentCookie != null && config.contentCookie!.isNotEmpty) {
        contentData += '"contentCookie":"${config.contentCookie}",';
      }

      if (config.licenseHttpHeaders != null &&
          config.licenseHttpHeaders!.isNotEmpty) {
        contentData +=
            '"licenseHttpHeaders":"${json.encode(config.licenseHttpHeaders!)}",';
      }

      if (config.licenseCookie != null && config.licenseCookie!.isNotEmpty) {
        contentData += '"licenseCookie":"${config.licenseCookie}",';
      }

      contentData += '},';
      contentData += '"url":"${config.contentUrl}"';
      contentData += '}';
    }

    return contentData;
  }

  PallyConContentConfiguration getContentConfig(DrmMovie drmMovie) {
    final index = pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);
    return pallyConContentConfigs[index];
  }

  int getIndex(DrmMovie drmMovie) {
    return pallyConContentConfigs
        .indexWhere((p0) => p0.contentUrl == drmMovie.url);
  }

  @override
  void onDetached() {
    print("onDetached");
  }

  @override
  void onInactive() {
    print("onInactive");
  }

  @override
  void onPaused() {
    print("onPaused");
  }

  @override
  void onResumed() {
    sdkInit();
  }

  @override
  void onHidden() {
    print("onHidden");
  }
}
