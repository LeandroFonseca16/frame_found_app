import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frame_found_app/modules/home/presentation/states/home_state.dart';
import 'package:frame_found_app/modules/home/presentation/states/loading_state.dart';
import 'package:frame_found_app/modules/home/presentation/states/search_error_state.dart';
import 'package:frame_found_app/modules/home/presentation/viewmodels/home_viewmodel.dart';

import '../domain/repositories/movies_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeViewModel(moviesRepository: context.read<MoviesRepository>()),
        child: BlocConsumer<HomeViewModel, HomeState>(
          listener: (context, state) {
            if (state is SearchErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Text('Home Page'),
                ...?state.localizedFilms?.map((e) => Text('${e.title}')),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeViewModel>().searchMoviesCommand.execute('matrix');
                  },
                  child: Text('TESTE'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
