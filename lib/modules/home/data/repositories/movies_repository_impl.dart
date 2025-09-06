import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../shared/core/result.dart';
import '../../domain/repositories/movies_repository.dart';
import '../services/remote/movies_service.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieService movieService;

  MoviesRepositoryImpl({required this.movieService});

  @override
  Future<Result<List<MovieEntity>, String>> searchMovies({required String query}) async {
    try {
      if (query.isEmpty) {
        return Failure('Termo de busca não pode ser vazio');
      }

      final movies = await movieService.searchMovies(query: query);
      return movies;
    } catch (e) {
      return Failure('Erro ao buscar filmes: ${e.toString()}');
    }
  }
}
