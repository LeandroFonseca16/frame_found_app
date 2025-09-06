import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';

import '../../../../../shared/core/result.dart';

abstract class MovieDetailsService {
  Future<Result<MovieDetailsEntity, String>> getMovieDetails({
    required String imdbId,
  });
}
