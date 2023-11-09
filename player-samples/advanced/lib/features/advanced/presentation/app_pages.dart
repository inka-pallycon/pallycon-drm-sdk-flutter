import 'package:advanced/features/advanced/presentation/controllers/drm_movie_binding.dart';
import 'package:advanced/features/advanced/presentation/pages/drm_content_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.drmMovies,
      page: () => DrmContentPage(),
      binding: DrmMovieBinding(),
    ),
  ];
}
