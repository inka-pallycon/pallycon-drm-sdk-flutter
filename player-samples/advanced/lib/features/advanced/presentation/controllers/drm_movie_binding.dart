import 'package:advanced/features/advanced/data/datasources/pallycon_content_local_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/pallycon_content_remote_data_source.dart';
import 'package:advanced/features/advanced/data/datasources/pallycon_content_user_data_source.dart';
import 'package:advanced/features/advanced/data/repositories/movie_repository_impl.dart';
import 'package:advanced/features/advanced/domain/usecases/get_drm_content_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'drm_movie_controller.dart';

class DrmMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Dio(BaseOptions(
        baseUrl: 'https://testtokyo.pallycon.com/demo-app/api')));
    Get.lazyPut(() => PallyConContentRemoteDataSourceImpl(
        dio: Get.find()));
    Get.lazyPut(() => PallyConContentLocalDataSourceImpl());
    Get.lazyPut(() => PallyConContentUserDataSourceImpl());
    Get.lazyPut(() => MovieRepositoryImpl(
        remoteDataSource: Get.find<PallyConContentRemoteDataSourceImpl>(),
        localDataSource: Get.find<PallyConContentLocalDataSourceImpl>(),
        userDataSource: Get.find<PallyConContentUserDataSourceImpl>()
    ));
    Get.lazyPut(() => GetDrmContentUseCase(Get.find<MovieRepositoryImpl>()));
    Get.lazyPut(() => DrmMovieController(Get.find()));
  }
}
