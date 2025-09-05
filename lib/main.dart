import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frame_found_app/modules/home/presentation/home_page.dart';
import 'package:frame_found_app/modules/home/domain/repositories/movies_repository.dart';
import 'package:frame_found_app/modules/home/data/repositories/movies_repository_impl.dart';
import 'package:frame_found_app/modules/home/data/services/remote/movies_service.dart';
import 'package:frame_found_app/modules/home/data/services/remote/movies_service_impl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MovieService>(
          create: (_) => MoviesServiceImpl(),
        ),
        Provider<MoviesRepository>(
          create: (context) => MoviesRepositoryImpl(
            movieService: context.read<MovieService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'FrameFound',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}