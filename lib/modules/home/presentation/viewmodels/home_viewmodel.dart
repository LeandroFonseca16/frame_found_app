import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frame_found_app/modules/home/presentation/states/loading_state.dart';
import 'package:frame_found_app/modules/home/presentation/states/search_error_state.dart';
import 'package:frame_found_app/shared/core/command.dart';

import '../../../../shared/core/result.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movies_repository.dart';
import '../states/home_state.dart';
import '../states/initial_state.dart';
import '../states/search_success_state.dart';

class HomeViewModel extends Cubit<HomeState> {
  final MoviesRepository moviesRepository;
  late final Command1<String, List<MovieEntity>, String> searchMoviesCommand;

  HomeViewModel({required this.moviesRepository}) : super(InitialState()) {
    searchMoviesCommand = Command1(_searchMovies);
    searchMoviesCommand.addListener(() {
      if (searchMoviesCommand.isRunning) {
        emit(LoadingState());
      }
    });
  }

  Future<Result<List<MovieEntity>, String>> _searchMovies(String query) async {
    final result = await moviesRepository.searchMovies(query: query);
    result.fold((success) {
      emit(
        SearchSuccessState(
          state.copyWith(
            localizedFilms: success,
          ),
        ),
      );
    }, (error) {
      emit(
        SearchErrorState(
          errorMessage: error,
        ),
      );
    });

    return result;
  }
}
