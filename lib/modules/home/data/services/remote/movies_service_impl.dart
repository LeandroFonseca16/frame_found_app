import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../../shared/core/result.dart';
import '../../../../../shared/http/http_client.dart';
import '../../dtos/movie_dto.dart';
import 'movies_service.dart';

class MoviesServiceImpl extends MovieService {
  @override
  Future<Result<List<MovieEntity>, String>> searchMovies({required String query}) async {
    final response = await HttpClient.instance.get(
      queryParameters: {
        's': query,
      },
    );

    if (response.data['Search'] == null || response.data['Error'] != null) {
      return Failure(response.data['Error'] ?? 'Erro ao buscar filmes: $query');
    }

    return Success(MovieDto.fromList(response.data['Search']));
  }
}
