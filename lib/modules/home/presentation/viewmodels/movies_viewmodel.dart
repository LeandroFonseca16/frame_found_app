import 'package:flutter/widgets.dart';
import 'package:frame_found_app/shared/core/command.dart';

import '../../../../shared/core/result.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movies_repository.dart';

class MoviesViewModel extends ChangeNotifier {
  final MoviesRepository moviesRepository;
  late final Command1<String, List<MovieEntity>, String> searchMoviesCommand;

  MoviesViewModel({required this.moviesRepository}) {
    searchMoviesCommand = Command1(_searchMovies);
  }

  Future<Result<List<MovieEntity>, String>> _searchMovies(String query) async {
    final result = await moviesRepository.searchMovies(query: query);

    result.fold((success) {
      debugPrint('success');
      debugPrint(success.length.toString());
    }, (error) {
      debugPrint('Erro ao buscar filmes: $error');
    });

    notifyListeners();
    return result;
  }
}
