import 'package:frame_found_app/modules/details/presentation/states/details_state.dart';

import '../utils/details_strings.dart';

class DetailsErrorState extends DetailsState {
  const DetailsErrorState({this.errorMessage = DetailsStrings.errorGeneric});

  final String errorMessage;
}
