import '../../../../shared/core/result.dart';
import '../entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<Result<MovieDetailsEntity, String>> getMovieDetails({required String imdbId});
}
