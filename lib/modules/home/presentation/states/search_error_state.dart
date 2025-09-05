import '../utils/home_strings.dart';
import 'home_state.dart';

class SearchErrorState extends HomeState {
  SearchErrorState({this.errorMessage = HomeStrings.errorGeneric});

  final String? errorMessage;
}
