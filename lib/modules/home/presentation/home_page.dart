import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frame_found_app/modules/home/presentation/states/home_state.dart';
import 'package:frame_found_app/modules/home/presentation/states/loading_state.dart';
import 'package:frame_found_app/modules/home/presentation/states/search_error_state.dart';
import 'package:frame_found_app/modules/home/presentation/utils/home_strings.dart';
import 'package:frame_found_app/modules/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:frame_found_app/modules/home/presentation/widgets/header_widget.dart';
import 'package:frame_found_app/modules/home/presentation/widgets/movie_card_widget.dart';
import 'package:frame_found_app/modules/details/details_page.dart';

import '../../../shared/ui/widgets/loading_widget.dart';
import '../domain/repositories/movies_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static newInstance(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(moviesRepository: context.read<MoviesRepository>()),
      child: Scaffold(
        body: BlocConsumer<HomeViewModel, HomeState>(
          listener: (context, state) {
            if (state is SearchErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const LoadingWidget(
                text: HomeStrings.loadingText,
              );
            }

            return SafeArea(
              child: Column(
                children: [
                  HeaderWidget(
                    placeholder: HomeStrings.searchHint,
                    onSearch: (value) {
                      context.read<HomeViewModel>().searchMoviesCommand.execute(value);
                    },
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...?state.localizedFilms?.map((item) => MovieCardWidget(
                                  movieEntity: item,
                                  onTap: () => DetailsPage.newInstance(
                                    context,
                                    imdbId: item.imdbId,
                                    movieTitle: item.title,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
