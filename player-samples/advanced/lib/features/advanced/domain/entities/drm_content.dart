import 'drm_movie.dart';

class DrmContent {
  DrmContent({
    required this.totalResults,
    required this.contents,
  });

  int totalResults;
  List<DrmMovie> contents;
}
