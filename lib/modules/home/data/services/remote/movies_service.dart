import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

abstract class MovieService {
  Future<List<MovieEntity>> searchMovies({
    required String query,
  });
}
