import 'dart:convert';

import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';

import 'drm_movie_model.dart';

class DrmContentModel extends DrmContent {
  DrmContentModel({
    required this.totalResults,
    required this.contents,
  }) : super(contents: contents, totalResults: totalResults);

  final int totalResults;
  final List<DrmMovie> contents;

  @override
  factory DrmContentModel.fromJson(Map<String, dynamic> json) {
    final jsonData = json["data"];
    if (jsonData.runtimeType == String) {
      List<DrmMovieModel> list = List.from(jsonDecode(jsonData).map((x) => DrmMovieModel.fromJson(x)));
      return DrmContentModel(
          totalResults: list.length,
          contents: list
      );
    } else {
      List<DrmMovieModel> list = List.from(jsonData.map((x) => DrmMovieModel.fromJson(x)));
      return DrmContentModel(
          totalResults: list.length,
          contents: list
      );
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "data": jsonEncode(contents)
    };
  }
}
