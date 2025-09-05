import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../../shared/http/http_client.dart';
import '../../dtos/movie_dto.dart';
import 'movies_service.dart';

class MoviesServiceImpl extends MovieService {
  @override
  Future<List<MovieEntity>> searchMovies({required String query}) async {
    final response = await HttpClient.instance.get(
      queryParameters: {
        's': query,
      },
    );

    return MovieDto.fromList(response.data['Search']);
  }
}
