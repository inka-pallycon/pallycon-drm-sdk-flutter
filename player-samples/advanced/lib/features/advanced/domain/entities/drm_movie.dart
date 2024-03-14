import 'package:equatable/equatable.dart';
import 'download_status.dart';

class DrmMovie extends Equatable {
  final String url;
  final String contentType;
  final String streamFormat;
  final String mediaType;
  final String title;
  final String contentId;
  final String videoCodec;
  final String videoProfile;
  final String maximumResolution;
  final String frameRate;
  final String containerFormat;
  final String audioCodec;
  final String audioLanguage;
  final String? licenseServerUrl;
  final String? licenseCipherPath;
  final String? licenseCertUrl;
  String? token;
  DownloadStatus? downloadStatus;

  DrmMovie(
      {required this.url,
      required this.contentType,
      required this.streamFormat,
      required this.mediaType,
      required this.title,
      required this.contentId,
      required this.videoCodec,
      required this.videoProfile,
      required this.maximumResolution,
      required this.frameRate,
      required this.containerFormat,
      required this.audioCodec,
      required this.audioLanguage,
      this.token,
      this.licenseServerUrl,
      this.licenseCipherPath,
      this.licenseCertUrl,
      this.downloadStatus});

  @override
  List<Object> get props => [
        url,
        contentType,
        streamFormat,
        mediaType,
        title,
        contentId,
        videoCodec,
        videoProfile,
        maximumResolution,
        frameRate,
        containerFormat,
        audioCodec,
        audioLanguage,
        licenseServerUrl ?? "https://license-global.pallycon.com/ri/licenseManager.do/",
        licenseCipherPath ?? "",
        licenseCertUrl ?? "",
        token ?? "",
        downloadStatus ?? DownloadStatus.pending
      ];
}
