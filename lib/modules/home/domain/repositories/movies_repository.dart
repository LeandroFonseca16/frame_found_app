import '../../../../shared/core/result.dart';
import '../entities/movie_entity.dart';

abstract class MoviesRepository {
  Future<Result<List<MovieEntity>, String>> searchMovies({required String query});
}
