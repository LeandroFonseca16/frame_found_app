import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/core/command.dart';
import '../../../../shared/core/result.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/repositories/movie_details_repository.dart';
import '../states/details_error_state.dart';
import '../states/details_state.dart';
import '../states/details_success_state.dart';
import '../states/initial_details_state.dart';
import '../states/loading_details_state.dart';

class DetailsViewModel extends Cubit<DetailsState> {
  final MovieDetailsRepository repository;

  late final Command1<String, MovieDetailsEntity, String> detailsCommand;

  DetailsViewModel({required this.repository}) : super(InitialDetailsState()) {
    detailsCommand = Command1(_getMovieDetails);
    detailsCommand.addListener(() {
      if (detailsCommand.isRunning) {
        emit(LoadingDetailsState());
      }
    });
  }

  Future<Result<MovieDetailsEntity, String>> _getMovieDetails(String imdbId) async {
    final result = await repository.getMovieDetails(imdbId: imdbId);
    result.fold((success) {
      emit(
        DetailsSuccessState(
          state.copyWith(
            movieDetails: success,
          ),
        ),
      );
    }, (error) {
      emit(
        DetailsErrorState(
          errorMessage: error,
        ),
      );
    });

    return result;
  }
}
