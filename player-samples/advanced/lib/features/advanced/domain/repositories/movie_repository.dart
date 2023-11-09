import 'package:advanced/core/error/failures.dart';
import 'package:advanced/features/advanced/domain/entities/drm_content.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, DrmContent>> getDrmContent();
}
