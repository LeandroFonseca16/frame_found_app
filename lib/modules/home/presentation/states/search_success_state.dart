import 'home_state.dart';

class SearchSuccessState extends HomeState {
  SearchSuccessState(HomeState state)
      : super(
          localizedFilms: state.localizedFilms,
        );
}
