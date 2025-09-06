import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../../shared/core/result.dart';

abstract class MovieService {
  Future<Result<List<MovieEntity>, String>> searchMovies({
    required String query,
  });
}
