import 'package:advanced/core/error/failures.dart';
import 'package:advanced/core/usecases/usecase.dart';
import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';
import 'package:advanced/features/advanced/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetDrmContentUseCase implements UseCase<DrmContent, NoParams> {
  late final MovieRepository repository;

  GetDrmContentUseCase(this.repository);

  @override
  Future<Either<Failure, DrmContent>> call(NoParams params) async {
    return await repository.getDrmContent();
  }
}
