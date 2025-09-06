import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';

import '../../../../shared/core/result.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../services/remote/movie_details_service.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsService movieDetailsService;

  MovieDetailsRepositoryImpl({required this.movieDetailsService});

  @override
  Future<Result<MovieDetailsEntity, String>> getMovieDetails({required String imdbId}) async {
    try {
      if (imdbId.isEmpty) {
        return Failure('ID do filme não pode ser vazio');
      }

      return await movieDetailsService.getMovieDetails(imdbId: imdbId);
    } catch (e) {
      return Failure('Erro ao buscar detalhes do filme: ${e.toString()}');
    }
  }
}
