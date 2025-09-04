import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../shared/core/result.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  @override
  Future<Result<List<MovieEntity>, String>> searchMovies({required String query}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (query.isEmpty) {
      return Failure('Erro ao buscar filmes');
    }
    return Success([]);
  }
}
