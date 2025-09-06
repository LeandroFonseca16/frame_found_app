import '../modules/details/data/repositories/movie_details_repository_impl.dart';
import '../modules/details/data/services/remote/movie_details_service.dart';
import '../modules/details/data/services/remote/movie_details_service_impl.dart';
import '../modules/details/domain/repositories/movie_details_repository.dart';
import '../modules/home/data/repositories/movies_repository_impl.dart';
import '../modules/home/data/services/remote/movies_service.dart';
import 'package:provider/provider.dart';

import '../modules/home/data/services/remote/movies_service_impl.dart';
import '../modules/home/domain/repositories/movies_repository.dart';

class Dependencies {
  static final list = [
    Provider<MovieService>(
      create: (_) => MoviesServiceImpl(),
    ),
    Provider<MoviesRepository>(
      create: (context) => MoviesRepositoryImpl(
        movieService: context.read<MovieService>(),
      ),
    ),
    Provider<MovieDetailsService>(
      create: (_) => MovieDetailsServiceImpl(),
    ),
    Provider<MovieDetailsRepository>(
      create: (context) => MovieDetailsRepositoryImpl(
        movieDetailsService: context.read<MovieDetailsService>(),
      ),
    ),
  ];
}
