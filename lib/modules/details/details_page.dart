import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frame_found_app/modules/details/presentation/states/details_state.dart';
import 'package:lottie/lottie.dart';

import 'domain/repositories/movie_details_repository.dart';
import 'presentation/states/details_error_state.dart';
import 'presentation/states/details_success_state.dart';
import 'presentation/states/initial_details_state.dart';
import 'presentation/states/loading_details_state.dart';
import 'presentation/utils/details_strings.dart';
import 'presentation/viewmodels/details_viewmodel.dart';
import 'presentation/widgets/details_header_widget.dart';
import '../../shared/ui/widgets/loading_widget.dart';
import 'presentation/widgets/movie_details_info_widget.dart';

class DetailsPage extends StatefulWidget {
  final String imdbId;
  final String movieTitle;

  const DetailsPage({
    super.key,
    required this.imdbId,
    required this.movieTitle,
  });

  static Future newInstance(BuildContext context, {required String imdbId, required String movieTitle}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          imdbId: imdbId,
          movieTitle: movieTitle,
        ),
      ),
    );
  }

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsViewModel(
        repository: context.read<MovieDetailsRepository>(),
      )..detailsCommand.execute(widget.imdbId),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              DetailsHeaderWidget(
                title: widget.movieTitle,
                onTap: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: BlocConsumer<DetailsViewModel, DetailsState>(
                  listener: (context, state) {
                    if (state is DetailsErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is InitialDetailsState || state is LoadingDetailsState) {
                      return LoadingWidget(
                        text: DetailsStrings.loadingDetails,
                      );
                    }

                    if (state is DetailsSuccessState && state.movieDetails != null) {
                      return MovieDetailsInfoWidget(
                        movieDetails: state.movieDetails!,
                      );
                    }

                    return Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('lib/assets/lotties/404.json'),
                        Text(
                          DetailsStrings.movieNotFound,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(DetailsStrings.backToList),
                        ),
                      ],
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
