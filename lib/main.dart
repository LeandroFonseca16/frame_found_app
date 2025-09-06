import 'package:flutter/material.dart';
import 'package:frame_found_app/modules/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'configs/dependencies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Dependencies.list,
      child: MaterialApp(
        title: 'FrameFound',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashPage(),
      ),
    );
  }
}