import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/home_page.dart';
import 'screens/get_movies_page.dart';
import 'screens/update_movie_page.dart';
import 'screens/delete_movie_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          '/get': (_) => GetMoviesPage(),
          '/update': (_) => UpdateMoviePage(),
          '/delete': (_) => DeleteMoviePage(),
        },
      ),
    ),
  );
}
