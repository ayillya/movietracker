import 'package:flutter/material.dart';
import '../apistate_enums.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/movie_card.dart';
import '../widgets/retry_button.dart';

class GetMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: 'Movie List',
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == ApiState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
                strokeWidth: 5,
              ),
            );
          }

          if (provider.state == ApiState.error) {
            return RetryButton(
              error : provider.errorMessage ?? 'Something went wrong',
              onRetry : () => provider.fetchMovies(),
            );
          }

          return ListView.builder(
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              final movie = provider.movies[index];
              return MovieCard(movie: movie); 
            },
          );
        },
      ),
    );
  }
}
