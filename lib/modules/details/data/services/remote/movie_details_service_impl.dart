import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';

import '../../../../../shared/core/result.dart';
import '../../../../../shared/http/http_client.dart';
import '../../dtos/movie_details_dto.dart';
import 'movie_details_service.dart';

class MovieDetailsServiceImpl extends MovieDetailsService {
  @override
  Future<Result<MovieDetailsEntity, String>> getMovieDetails({required String imdbId}) async {
    final response = await HttpClient.instance.get(
      queryParameters: {
        'i': imdbId,
        'plot': 'full',
      },
    );

    if (response.data['Error'] != null) {
      return Failure(response.data['Error'] ?? 'Erro ao buscar detalhes do filme');
    }

    return Success(MovieDetailsDto.fromMap(response.data));
  }
}
